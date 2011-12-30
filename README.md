=== Vim coverage for Simplecov

This is a formatter for Simplecov that emits a vim script to mark up codefiles with coverage information.

=== Usage

In .simplecov (or where ever you do this)

  require 'simplecov-vim/formatter'
  Simplecov.start do
    formatter SimpleCov::Formatter::VimFormatter
  end

Run your tests 
  rspec -rsimplecov spec

You'll find a shiny new file called coverage.vim

Edit a file in your project with vim.  From Normal mode:

  :so coverage.vim

And you should see nice marks in the left column for coverage.  Green >> are covered lines, and red :( are uncovered.  
