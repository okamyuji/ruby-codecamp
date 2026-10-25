# frozen_string_literal: true

require 'test_helper'
require 'codecamp_docs/arrow_check'

class ArrowCheckSessionTest < Minitest::Test
  AC = CodecampDocs::ArrowCheck

  def block(code, verify: true, label: 'b.md', line: 1)
    AC::Block.new(code:, label:, line:, verify:)
  end

  def run_check(*codes)
    AC.check(codes.map { |code| block(code) })
  end

  def test_carries_definitions_across_blocks
    assert_empty run_check("def f = 1\n", "p f  # => 1\n").failures
  end

  def test_continues_after_exception
    failures = run_check("raise 'x'\n", "p 1  # => 2\n").failures

    assert_equal 2, failures.size
    assert_match(/b\.md:1 RuntimeError: x/, failures.first)
    assert_match(/expected=2 actual=1/, failures.last)
  end

  def test_reports_syntax_error_in_block_once
    failures = run_check("def (\np 1  # => 1\n").failures

    assert_equal 1, failures.size
    assert_includes failures.first, 'SyntaxError'
  end

  def test_continues_after_exit
    failures = AC.check([block("exit 1\n"), block("p 1  # => 2\n", line: 2)]).failures

    assert_equal 2, failures.size
    assert_match(/b\.md:1 SystemExit/, failures.first)
    assert_match(/expected=2 actual=1/, failures.last)
  end

  def test_isolates_files
    AC.check([block("def f = 1\n")])

    assert_equal 1, run_check("p f  # => 1\n").failures.size
  end

  def test_restores_stdout_after_exception
    before = $stdout
    run_check("raise 'x'\n")

    assert_same before, $stdout
  end

  def test_does_not_leak_block_output
    out, = capture_io { run_check("puts 'noise'\n") }

    assert_empty out
  end

  def test_unparsable_target_reports_instrumentation_failure
    failures = run_check("p 1, 2  # => 1\n").failures

    assert_equal 1, failures.size
    assert_match(/b\.md:1 .*instrument/, failures.first)
  end

  def test_unverified_block_defines_but_is_not_checked
    result = AC.check([block("def g = 1\np g  # => 9\n", verify: false), block("p g  # => 1\n")])

    assert_empty result.failures
  end

  def test_mismatch_in_unverified_block_is_not_reported_but_exception_is
    result = AC.check([block("raise 'boom'\n", verify: false)])

    assert_equal 1, result.failures.size
  end

  def test_truncates_long_exception_message
    failure = run_check("raise 'x' * 300\n").failures.first

    assert_equal "b.md:1 RuntimeError: #{'x' * 150}", failure
  end
end
