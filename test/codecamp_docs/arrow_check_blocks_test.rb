# frozen_string_literal: true

require 'test_helper'
require 'codecamp_docs/arrow_check'

class ArrowCheckBlocksTest < Minitest::Test
  AC = CodecampDocs::ArrowCheck

  def test_blocks_from_markdown_returns_ruby_blocks_with_lines
    md = "text\n```ruby\np 1\n```\n```sh\nls\n```\n```ruby\np 2\n```\n"
    blocks = AC.blocks_from_markdown(md, md_path: 'x.md')

    assert_equal([["p 1\n", 3], ["p 2\n", 9]], blocks.map { |b| [b.code, b.line] })
    assert(blocks.all? { |b| b.label == 'x.md' && b.verify })
  end

  def test_blocks_from_markdown_drops_skip_marked_block
    md = "<!-- docs:skip -->\n```ruby\np 1\n```\n```ruby\np 2\n```\n"
    blocks = AC.blocks_from_markdown(md, md_path: 'x.md')

    assert_equal ["p 2\n"], blocks.map(&:code)
  end

  def test_blocks_from_markdown_marks_source_block_unverified
    md = "<!-- source: solutions/a.rb#r -->\n```ruby\np 1\n```\n```ruby\np 2\n```\n"
    blocks = AC.blocks_from_markdown(md, md_path: 'x.md')

    assert_equal [false, true], blocks.map(&:verify)
  end

  def test_blocks_from_markdown_with_empty_text
    assert_empty AC.blocks_from_markdown('', md_path: 'x.md')
  end

  def test_blocks_from_markdown_rejects_unclosed_block
    error = assert_raises(CodecampDocs::Error) { AC.blocks_from_markdown("```ruby\np 1\n", md_path: 'x.md') }
    assert_match(/x\.md:1/, error.message)
  end

  def test_blocks_from_regions_returns_region_blocks
    rb = "x = 0\n# docs:begin a\np 1\n# docs:end\n# docs:begin b\np 2\n# docs:end\n"
    blocks = AC.blocks_from_regions(rb, path: 's.rb')

    assert_equal([['s.rb#a', 3, "p 1\n"], ['s.rb#b', 6, "p 2\n"]], blocks.map { |b| [b.label, b.line, b.code] })
    assert(blocks.all?(&:verify))
  end
end
