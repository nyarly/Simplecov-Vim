## Vim coverage for Simplecov

This is a formatter for Simplecov that emits a Vim script to mark up code files with coverage information.

## Installing

Add to Gemfile:

    gem 'simplecov'
    gem 'simplecov-vim'

and

    bundle install

Or 

    gem install simplecov simplecov-vim

(If you already have simplecov installed, these commands have some redundancy

## Usage

In .simplecov (or where ever you do this)

    require 'simplecov-vim/formatter'
    Simplecov.start do
      formatter SimpleCov::Formatter::VimFormatter
    end

Run your tests 

    rspec -rsimplecov spec

You'll find a shiny new file called coverage.vim in your project root.

Edit a file in your project with Vim.  From Normal mode:

    :so coverage.vim

And you should see nice marks in the left column for coverage.  Green >> are covered lines, and red :( are uncovered.  

## Notes

The coverage.vim file is a self contained Vim script - feel free to examine it's contents.  It'll be rewritten every time you run coverage, though, so editing is probably futile.

coverage.vim can be re-sourced safely between coverage runs - it'll clean up the old coverage signs before placing new ones.

coverage.vim adds two user commands: :Cov and :Uncov which can be used to toggle the state of coverage signs.


A slightly more advanced .simplecov configuration file that produces both simplecov.vim and SimpleCov's normal HTML output:

    require 'simplecov-vim/formatter'

    module SimpleCov::Formatter
      class MergedFormatter
        def initialize
          @formatters = [HTMLFormatter, VimFormatter].map{|frmt| frmt.new}
        end

        def format(result)
          @formatters.each{|frmt| frmt.format(result)}
        end
      end
    end

    SimpleCov.start 'rails' do
      formatter SimpleCov::Formatter::MergedFormatter
    end

