# frozen_string_literal: true

require 'test_helper'
require 'codecamp_docs/arrow_check'

class ArrowCheckTest < Minitest::Test
  AC = CodecampDocs::ArrowCheck

  def block(code, verify: true, label: 'b.md', line: 1)
    AC::Block.new(code:, label:, line:, verify:)
  end

  def run_check(*codes)
    AC.check(codes.map { |code| block(code) })
  end

  def test_passes_matching_inline_arrow
    assert_empty run_check("p 1 + 1  # => 2\n").failures
  end

  def test_reports_mismatch_with_label_and_line
    result = AC.check([block("x = 1\np 1 + 1  # => 3\n", label: 'a.md', line: 10)])

    assert_equal ['a.md:11 expected=3 actual=2'], result.failures
  end

  def test_checks_own_line_arrow_against_previous_expression
    assert_empty run_check("p [1, 2]\n# => [1, 2]\n").failures
    assert_equal 1, run_check("p [1, 2]\n# => [1, 3]\n").failures.size
  end

  def test_own_line_arrow_skips_blank_and_comment_lines
    assert_empty run_check("p 5\n\n# memo\n# => 5\n").failures
  end

  def test_ignores_fullwidth_note
    assert_empty run_check("p 2  # => 2（補足）\n").failures
  end

  def test_skips_nondeterministic
    ['1 または 2', 'a など', '1 or 2'].each do |expected|
      result = run_check("p 1  # => #{expected}\n")

      assert_empty result.failures
      assert_equal 1, result.skipped
    end
  end

  def test_skipped_is_zero_when_all_checked
    assert_equal 0, run_check("p 1  # => 1\n").skipped
  end

  def test_puts_compares_output
    assert_empty run_check("puts 'ab'  # => ab\n").failures
    assert_equal 1, run_check("puts 'ab'  # => \"ab\"\n").failures.size
  end

  def test_p_compares_inspect
    assert_empty run_check("p 'ab'  # => \"ab\"\n").failures
  end

  def test_bare_expression_compares_inspect
    assert_empty run_check("[1, 2].sum  # => 3\n").failures
  end

  def test_arrow_inside_string_is_not_checked
    assert_empty run_check("p '# => 9'\n").failures
  end

  def test_block_without_arrows_is_only_evaluated
    result = run_check("x = 1\n")

    assert_empty result.failures
    assert_equal 0, result.skipped
  end

  def test_empty_input
    result = AC.check([])

    assert_empty result.failures
    assert_equal 0, result.skipped
  end

  def test_arrow_on_first_line_without_expression_is_ignored
    assert_empty run_check("# => 1\np 2\n").failures
  end

  def test_multibyte_text_before_arrow_on_same_line
    assert_empty run_check("p '日本語'  # => \"日本語\"\n").failures
    assert_equal 1, run_check("p 'あい'  # => \"あう\"\n").failures.size
  end

  def test_arrow_after_structural_line_is_ignored
    assert_empty run_check("[1].each do |x|\n  x\nend\n# => 9\n").failures
  end

  def test_counts_checked_arrows
    result = run_check("p 1  # => 1\np 2  # => 3\np 4  # => 4 または 5\nx = 1\n")

    assert_equal 2, result.checked
    assert_equal 1, result.skipped
  end

  def test_puts_of_array_flattens_elements
    assert_empty run_check("puts ['a']  # => a\n").failures
    assert_empty run_check("puts [['a']]  # => a\n").failures
  end

  def test_inline_arrow_keeps_following_lines
    assert_equal ['b.md:2 expected=3 actual=2'], run_check("p 1  # => 1\np 2  # => 3\np 3\n").failures
  end

  def test_own_line_arrow_after_inline_arrow_line_is_ignored
    assert_empty run_check("p 1  # => 1\n# => 2\n").failures
  end

  def test_own_line_arrow_ignores_trailing_comment_on_target
    assert_empty run_check("p 1 # note\n# => 1\n").failures
    assert_equal ['b.md:2 expected=2 actual=1'], run_check("p 1 # note\n# => 2\n").failures
  end

  def test_hash_inside_string_on_target_line_is_kept
    assert_empty run_check("p '# x'\n# => \"# x\"\n").failures
  end

  def test_parenthesized_puts_and_print_compare_output
    assert_empty run_check("puts('ab')  # => ab\n").failures
    assert_equal 1, run_check("puts('ab')  # => \"ab\"\n").failures.size
    assert_empty run_check("print('ab')  # => ab\n").failures
    assert_empty run_check("print 'ab'  # => ab\n").failures
  end

  def test_puts_with_call_argument_keeps_closing_paren
    assert_empty run_check("puts [1, 2].first(1).inspect  # => [1]\n").failures
    assert_empty run_check("puts [1, 2].first(1).inspect.length  # => 3\n").failures
  end
end
