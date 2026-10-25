# frozen_string_literal: true

require 'test_helper'
require 'tmpdir'
require 'fileutils'
require 'codecamp_docs/markdown_sync'

class MarkdownSyncPathTest < Minitest::Test
  MD = 'docs.md'
  REGION = "# docs:begin a\nsecret\n# docs:end\n"

  def setup
    @root = Dir.mktmpdir
  end

  def teardown
    FileUtils.remove_entry(@root)
  end

  def sync_marker(path)
    CodecampDocs::MarkdownSync.sync("<!-- source: #{path}#a -->\n```ruby\n```\n", md_path: MD, root: @root)
  end

  def test_raises_when_path_escapes_root
    outside = File.join(File.dirname(@root), "outside-#{File.basename(@root)}.rb")
    File.write(outside, REGION)
    error = assert_raises(CodecampDocs::Error) { sync_marker("../#{File.basename(outside)}") }
    assert_includes error.message, "#{MD}:1"
    assert_includes error.message, 'リポジトリの外'
  ensure
    FileUtils.rm_f(outside)
  end

  # root と名前が前方一致する隣のファイルも外として扱う
  def test_raises_for_sibling_sharing_root_prefix
    sibling = "#{@root}x.rb"
    File.write(sibling, REGION)
    error = assert_raises(CodecampDocs::Error) { sync_marker("../#{File.basename(sibling)}") }
    assert_includes error.message, 'リポジトリの外'
  ensure
    FileUtils.rm_f(sibling)
  end

  def test_allows_path_that_returns_inside_root
    FileUtils.mkdir_p(File.join(@root, 'solutions'))
    File.write(File.join(@root, 'solutions/s.rb'), REGION)
    assert_includes sync_marker('solutions/../solutions/s.rb'), "secret\n"
  end

  def test_accepts_relative_root
    File.write(File.join(@root, 's.rb'), REGION)
    synced = Dir.chdir(@root) do
      CodecampDocs::MarkdownSync.sync("<!-- source: s.rb#a -->\n```ruby\n```\n", md_path: MD, root: '.')
    end
    assert_includes synced, "secret\n"
  end
end
