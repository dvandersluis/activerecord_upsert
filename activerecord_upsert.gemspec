lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record_upsert/version'

Gem::Specification.new do |spec|
  spec.name          = 'activerecord_upsert'
  spec.version       = ActiveRecordUpsert::VERSION
  spec.authors       = ['Daniel Vandersluis']
  spec.email         = ['daniel.vandersluis@gmail.com']

  spec.summary       = %|Support MySQL's INSERT ... ON DUPLICATE KEY UPDATE in ActiveRecord|
  spec.homepage      = 'https://github.com/dvandersluis/activerecord_upsert'

  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['changelog_uri'] = "https://github.com/dvandersluis/activerecord_upsert/CHANGELOG.md"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'mysql2'
  spec.add_dependency 'activerecord', '>= 5.2', '< 6'

  spec.add_development_dependency('bundler', '~> 2.0')
  spec.add_development_dependency('database_cleaner', '~> 1.7.0')
  spec.add_development_dependency('pry', '~> 0.12.0')
  spec.add_development_dependency('rake', '>= 12.3.3')
  spec.add_development_dependency('rspec', '~> 3.0')
  spec.add_development_dependency('rubocop', '~> 0.75.0')
  spec.add_development_dependency('rubocop-rspec', '~> 1.36.0')
  spec.add_development_dependency('rubocop-performance', '~> 1.5.0')
end
