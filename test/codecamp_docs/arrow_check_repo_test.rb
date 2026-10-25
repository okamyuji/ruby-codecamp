# frozen_string_literal: true

require 'test_helper'
require 'tmpdir'
require 'fileutils'
require 'codecamp_docs/arrow_check'

class ArrowCheckRepoTest < Minitest::Test
  def setup
    @root = Dir.mktmpdir
    FileUtils.mkdir_p(File.join(@root, 'solutions/sub'))
  end

  def teardown
    FileUtils.remove_entry(@root)
  end

  def write(path, text)
    File.write(File.join(@root, path), text)
  end

  def test_empty_repo_has_no_results
    result = CodecampDocs::ArrowCheck.check_repo(@root)

    assert_empty result.failures
    assert_equal [0, 0], [result.checked, result.skipped]
  end

  def test_combines_markdown_and_solution_regions_with_relative_labels
    write('01_a.md', "```ruby\np 1  # => 2\n```\n")
    write('solutions/sub/s.rb', "# docs:begin r\np 1  # => 3\n# docs:end\n")
    write('README.md', "```ruby\np 1  # => 9\n```\n")
    result = CodecampDocs::ArrowCheck.check_repo(@root)

    assert_equal ['01_a.md:2 expected=2 actual=1', 'solutions/sub/s.rb#r:2 expected=3 actual=1'],
                 result.failures.sort
    assert_equal 2, result.checked
  end

  def test_files_do_not_share_definitions
    write('01_a.md', "```ruby\ndef f = 1\n```\n")
    write('02_b.md', "```ruby\np f  # => 1\n```\n")

    assert_equal 1, CodecampDocs::ArrowCheck.check_repo(@root).failures.size
  end
end
