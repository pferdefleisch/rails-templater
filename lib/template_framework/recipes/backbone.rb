if yes?("\n[Javascript] Do you want to add backbone.js? [y|n]: ", Thor::Shell::Color::BLUE)
  gem 'backbone-on-rails'
  templater.post_bundler do
    generate 'backbone:install'
  end
end
