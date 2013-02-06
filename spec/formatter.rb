require 'simplecov'
require 'simplecov-vim/formatter'

describe SimpleCov::Formatter::VimFormatter do
  include FileSandbox

  let :files do
    sandbox.new :directory => "lib/nested"
    [sandbox.new(:file => "lib/pretend_file"), sandbox.new(:file => "lib/nested/pretend_file")]
  end

  let :original_result do
    files.each_with_object({}) do |file, hash|
      hash[file.path] = [1,1,1,1]
    end
  end

  let :result do
    SimpleCov::Result.new(original_result)
  end

  let :formatter do
    SimpleCov::Formatter::VimFormatter.new
  end

  let :options_formatter do
    SimpleCov::Formatter::VimFormatter.with_options(silent: true, output_path: "coverage_custom_path.vim").new
  end

  it "should have an original result with absolute paths" do
    original_result.keys.each do |path|
      path.should =~ %r{\A/}
    end
  end

  it "should produce a vimscript" do
    formatter.format(result)
    File::exists?("coverage.vim").should be_true


    File::open("coverage.vim") do |scriptfile|
      scriptfile.lines.grep(/(['"])pretend_file\1/).should_not == []
      scriptfile.rewind
      scriptfile.lines.grep(%r[(['"])nested/pretend_file\1]).should_not == []
    end
  end

  it "should honor options" do
    stdout_orig = $stdout

    $stdout = StringIO.new
    formatter.format(result)
    $stdout.string.should_not be_empty

    $stdout = StringIO.new
    options_formatter.format(result)
    $stdout.string.should be_empty

    File::exists?("coverage_custom_path.vim").should be_true

    $stdout = stdout_orig
  end

end
