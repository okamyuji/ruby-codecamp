# frozen_string_literal: true

require 'test_helper'
require 'codecamp_docs/regions'

class RegionsTest < Minitest::Test
  PATH = 'solutions/x.rb'

  def parse(text)
    CodecampDocs::Regions.parse(text, path: PATH)
  end

  def test_returns_region_body_without_markers
    text = "x\n# docs:begin a\ndef f; end\n# docs:end\n"
    assert_equal({ 'a' => "def f; end\n" }, parse(text))
  end

  def test_reads_multiple_regions
    text = "# docs:begin a\n1\n# docs:end\n# docs:begin b\n2\n# docs:end\n"
    result = parse(text)
    assert_equal %w[a b], result.keys
    assert_equal "2\n", result['b']
  end

  def test_raises_on_unclosed_region
    error = assert_raises(CodecampDocs::Error) { parse("x\n# docs:begin a\nbody\n") }
    assert_includes error.message, PATH
    assert_includes error.message, '2'
  end

  def test_raises_on_duplicate_name
    text = "# docs:begin a\n# docs:end\n# docs:begin a\n# docs:end\n"
    error = assert_raises(CodecampDocs::Error) { parse(text) }
    assert_includes error.message, ':3'
  end

  def test_raises_on_end_without_begin
    error = assert_raises(CodecampDocs::Error) { parse("# docs:end\n") }
    assert_includes error.message, "#{PATH}:1"
  end

  def test_raises_on_nested_begin
    error = assert_raises(CodecampDocs::Error) do
      parse("# docs:begin a\n# docs:begin b\n# docs:end\n# docs:end\n")
    end
    assert_includes error.message, "#{PATH}:2"
  end

  def test_raises_on_begin_without_name
    assert_raises(CodecampDocs::Error) { parse("# docs:begin\n# docs:end\n") }
  end

  def test_returns_empty_hash_for_empty_text
    assert_empty parse('')
  end

  def test_returns_empty_hash_without_markers
    assert_empty parse("puts 1\n")
  end

  def test_empty_region_has_empty_body
    assert_equal({ 'a' => '' }, parse("# docs:begin a\n# docs:end\n"))
  end

  def test_region_on_first_and_last_line_without_trailing_newline
    assert_equal({ 'a' => "1\n" }, parse("# docs:begin a\n1\n# docs:end"))
  end

  def test_keeps_indentation_and_blank_lines_in_body
    text = "  # docs:begin a\n  x = 1\n\n  # docs:end\n"
    assert_equal({ 'a' => "  x = 1\n\n" }, parse(text))
  end

  def test_ignores_markers_inside_longer_words
    assert_empty parse("# docs:beginning a\n# docs:endless\n")
  end

  def test_ignores_non_marker_text_after_hash
    assert_empty parse("x = 1 # docs:begin a\n")
  end
end
