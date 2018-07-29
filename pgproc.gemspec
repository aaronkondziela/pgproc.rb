
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pgproc/version"

Gem::Specification.new do |spec|
  spec.name          = "pgproc"
  spec.version       = Pgproc::VERSION
  spec.authors       = ["Dave Goehrig", "Aaron Kondziela"]
  spec.email         = ["dave@dloh.org", "aaron@aaronkondziela.com"]

  spec.summary       = %q{Automatically binds methods to stored procedures}
  spec.description   = %q{Creates an object that binds stored procedures in a schema to a class}
  spec.homepage      = "https://github.com/cthulhuology/pgproc.rb"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://github.com/cthulhuology/pgproc.rb"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "pg"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
