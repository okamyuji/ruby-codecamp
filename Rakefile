# frozen_string_literal: true

require 'rake/testtask'
require 'fileutils'
require 'shellwords'

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
    if system("ruby #{Shellwords.escape(file)} > /dev/null 2>&1")
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
