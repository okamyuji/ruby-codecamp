# frozen_string_literal: true

require 'rake/testtask'
require 'fileutils'
require 'open3'
require 'shellwords'

$LOAD_PATH.unshift File.join(__dir__, 'lib')
require 'codecamp_docs/markdown_sync'
require 'codecamp_docs/arrow_check'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/*_test.rb'
end

# Default task
task default: %i[syntax_check]

# RuboCop task
desc 'Run RuboCop on all Ruby files'
task :rubocop do
  sh 'bundle exec rubocop solutions'
end

# RuboCop auto-correct task
desc 'Run RuboCop with auto-correct'
task :rubocop_auto do
  sh 'bundle exec rubocop -A solutions'
end

# Syntax check for all Ruby files
desc 'Check syntax of all Ruby files'
task :syntax_check do
  puts 'Checking syntax of all Ruby files...'
  errors = []

  Dir.glob('solutions/**/*.rb').each do |file|
    print "Checking #{file}... "
    if system("ruby -c #{Shellwords.escape(file)} > /dev/null 2>&1")
      puts '✓'
    else
      puts '✗'
      errors << file
    end
  end

  if errors.empty?
    puts 'Syntax check completed!'
  else
    puts "\nFiles with syntax errors:"
    errors.each { |f| puts "  - #{f}" }
    abort 'Syntax check failed!'
  end
end

# Execute all Ruby files to check for runtime errors
desc 'Execute all Ruby files to check for runtime errors'
task :execute_all do
  puts 'Executing all Ruby files...'
  errors = []

  Dir.glob('solutions/**/*.rb').each do |file|
    print "Executing #{file}... "
    # 各解答は自己テストの不一致を終了コードでなく出力の「✗ FAIL」で示す
    output, status = Open3.capture2e('ruby', file)
    if status.success? && !output.include?('✗ FAIL')
      puts '✓'
    else
      puts '✗'
      errors << file
    end
  end

  if errors.empty?
    puts "\nAll files executed successfully!"
  else
    puts "\nFiles with errors:"
    errors.each { |f| puts "  - #{f}" }
    abort 'Execution check failed!'
  end
end

# List all solution files
desc 'List all solution files'
task :list do
  puts 'Ruby solution files:'
  Dir.glob('solutions/**/*.rb').each do |file|
    puts "  - #{file}"
  end
end

# Count lines of code
desc 'Count lines of code in solutions'
task :loc do
  total = 0
  Dir.glob('solutions/**/*.rb').each do |file|
    total += File.readlines(file).size
  end
  puts "Total lines of code: #{total}"
end

namespace :docs do
  # 各 md を [パス, 現在の内容, 埋め込み後の内容] で渡す。目印の誤りは abort で止める
  sync_each = lambda do |&block|
    Dir.glob('[0-9]*.md', base: __dir__).each do |path|
      text = File.read(File.join(__dir__, path))
      block.call(path, text, CodecampDocs::MarkdownSync.sync(text, md_path: path, root: __dir__))
    end
  rescue CodecampDocs::Error => e
    abort e.message
  end

  desc 'Embed solution regions into markdown code blocks'
  task :sync do
    sync_each.call { |path, text, synced| File.write(File.join(__dir__, path), synced) unless text == synced }
  end

  desc 'Fail when a markdown code block differs from its solution region'
  task :verify do
    stale = []
    sync_each.call { |path, text, synced| stale << path unless text == synced }
    abort "解答ファイルとずれている md:\n#{stale.map { |p| "  - #{p}" }.join("\n")}\n`rake docs:sync` で直す" unless stale.empty?
    puts 'docs:verify OK'
  end
end

desc 'Check # => comments in markdown code blocks and solution regions against actual values'
task 'docs:check' do
  result = begin
    CodecampDocs::ArrowCheck.check_repo(__dir__)
  rescue CodecampDocs::Error => e
    abort e.message
  end
  summary = "照合 #{result.checked} 件、除外 #{result.skipped} 件"
  puts result.failures
  abort "docs:check 失敗 #{result.failures.size} 件（#{summary}）" unless result.failures.empty?
  puts "docs:check OK（#{summary}）"
end
