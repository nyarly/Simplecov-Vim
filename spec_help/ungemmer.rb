class Ungemmer
  def self.ungem(*names)
    deps = names.map do |name|
      Gem::Dependency.new(name, nil)
    end

    deps.each do |dep|
      Gem.source_index.search(dep).each do |gemspec|
	puts " ** Ungemming #{gemspec.full_name}  **"
	Gem.source_index.remove_spec(gemspec.full_name)
      end
    end

    Gem.instance_eval do
      if defined? Gem::MUTEX
      Gem::MUTEX.synchronize do
          @searcher = nil
        end
      else
	@searcher = nil
      end
    end
  end

  def self.ungem_gemspec
    Dir[File::expand_path(__FILE__ + "../../../*.gemspec")].each do |gemspec_path|
      puts "Ungemming based on #{gemspec_path}"
      begin
        spec = Gem::Specification::load(gemspec_path)
        Ungemmer::ungem(spec)
      rescue LoadError
        puts "Couldn't load #{gemspec_path}"
      end
    end
  end
end
