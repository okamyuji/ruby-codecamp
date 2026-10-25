# frozen_string_literal: true

require 'test_helper'
require 'tmpdir'
require 'fileutils'
require 'codecamp_docs/markdown_sync'

class MarkdownSyncTest < Minitest::Test
  MD = 'docs.md'
  SOLUTION = "x = 0\n# docs:begin a\ndef f = 1\n# docs:end\n# docs:begin b\ndef g = 2\n# docs:end\n"

  def setup
    @root = Dir.mktmpdir
    FileUtils.mkdir_p(File.join(@root, 'solutions'))
    File.write(File.join(@root, 'solutions/s.rb'), SOLUTION)
  end

  def teardown
    FileUtils.remove_entry(@root)
  end

  def sync(text)
    CodecampDocs::MarkdownSync.sync(text, md_path: MD, root: @root)
  end

  def block(name, body = "old\n", fence: '```ruby')
    "<!-- source: solutions/s.rb##{name} -->\n#{fence}\n#{body}```\n"
  end

  def test_replaces_block_with_region
    assert_equal block('a', "def f = 1\n"), sync(block('a'))
  end

  def test_replaces_multiple_markers_in_one_md
    result = sync("intro\n#{block('a')}middle\n#{block('b')}end\n")
    assert_equal "intro\n#{block('a', "def f = 1\n")}middle\n#{block('b', "def g = 2\n")}end\n", result
  end

  def test_leaves_unmarked_blocks
    text = "```ruby\nputs 1\n```\n```text\nout\n```\n"
    assert_equal text, sync(text)
  end

  def test_is_idempotent
    once = sync("#{block('a')}text\n#{block('b')}")
    assert_equal once, sync(once)
  end

  def test_raises_on_missing_file
    text = "a\n<!-- source: solutions/none.rb#a -->\n```ruby\n```\n"
    error = assert_raises(CodecampDocs::Error) { sync(text) }
    assert_includes error.message, "#{MD}:2"
    assert_includes error.message, 'solutions/none.rb#a'
  end

  def test_raises_on_missing_region
    error = assert_raises(CodecampDocs::Error) { sync(block('zzz')) }
    assert_includes error.message, "#{MD}:1"
    assert_includes error.message, 'solutions/s.rb#zzz'
  end

  def test_raises_when_marker_not_followed_by_ruby_block
    ["<!-- source: solutions/s.rb#a -->\ntext\n", block('a', fence: '```text')].each do |text|
      error = assert_raises(CodecampDocs::Error) { sync(text) }
      assert_includes error.message, "#{MD}:1"
    end
  end

  def test_raises_when_fence_has_characters_after_ruby
    error = assert_raises(CodecampDocs::Error) { sync(block('a', fence: '```rubyx')) }
    assert_includes error.message, "#{MD}:1"
  end

  def test_raises_when_marker_is_on_last_line_without_newline
    assert_raises(CodecampDocs::Error) { sync('<!-- source: solutions/s.rb#a -->') }
  end

  def test_raises_when_block_is_not_closed
    text = "<!-- source: solutions/s.rb#a -->\n```ruby\nold\n"
    error = assert_raises(CodecampDocs::Error) { sync(text) }
    assert_includes error.message, "#{MD}:1"
  end

  def test_ignores_skip_marker
    text = "<!-- docs:skip -->\n```ruby\nold\n```\n"
    assert_equal text, sync(text)
  end

  def test_keeps_closing_fence_without_trailing_newline
    text = "<!-- source: solutions/s.rb#a -->\n```ruby\nold\n```"
    assert_equal "<!-- source: solutions/s.rb#a -->\n```ruby\ndef f = 1\n```", sync(text)
  end

  def test_empty_region_empties_block
    File.write(File.join(@root, 'solutions/e.rb'), "# docs:begin e\n# docs:end\n")
    text = "<!-- source: solutions/e.rb#e -->\n```ruby\nold\n```\n"
    assert_equal "<!-- source: solutions/e.rb#e -->\n```ruby\n```\n", sync(text)
  end

  def test_ignores_markers_not_in_exact_format
    text = "<!-- source: solutions/s.rb#a extra -->\n```ruby\nold\n```\n"
    assert_equal text, sync(text)
  end

  def test_ignores_marker_with_surrounding_text
    ['see <!-- source: solutions/s.rb#a -->', '<!-- source: solutions/s.rb#a --> note'].each do |marker|
      text = "#{marker}\n```ruby\nold\n```\n"
      assert_equal text, sync(text)
    end
  end

  def test_closes_block_only_at_bare_fence
    text = "<!-- source: solutions/s.rb#a -->\n```ruby\nold\n```text\nmore\n```\nafter\n"
    assert_equal "<!-- source: solutions/s.rb#a -->\n```ruby\ndef f = 1\n```\nafter\n", sync(text)
  end

  def test_returns_empty_text_unchanged
    assert_equal '', sync('')
  end

  def test_raises_on_malformed_solution_markers
    File.write(File.join(@root, 'solutions/bad.rb'), "# docs:begin a\n")
    error = assert_raises(CodecampDocs::Error) { sync(block('a').sub('s.rb', 'bad.rb')) }
    assert_includes error.message, 'solutions/bad.rb'
  end
end
