module SimpleCov::Formatter
  class VimFormatter
    def format(result)
      results = {}
      dir_re = /^#{common_directory(result.filenames)}\//
      result.filenames.zip(result.original_result.values_at(*result.filenames)).each do |name, lines|
        results[name.sub(dir_re, "")] = file_results = {hits: [], misses: []}
        lines.each_with_index do |hits, line|
          case hits
          when nil
          when 0
            file_results[:misses] << line + 1
          else
            file_results[:hits] << line + 1
          end
        end
      end

      coverage_output = "coverage.vim"
      write_file(template("coverage.vim"), coverage_output, binding)

      puts "Wrote vim coverage script to #{coverage_output}"
    end

    def common_directory(files)
      File::join(files.map{|file| file.split(File::Separator)}.inject do |dir, path|
        dir.zip(path).take_while{|l,r| l == r}.map{|l,_| l}
      end)
    end

    def write_file(template, output_filename, binding)
      content = template.result( binding )

      File.open( output_filename, "w" ) do |file_result|
        file_result.write content
      end
    end

    def template(name)
      ERB.new(File.read(File.join(File.dirname(__FILE__), "#{name}.erb")), nil, '-')
    end
  end
end
