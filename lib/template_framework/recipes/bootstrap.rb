if yes?("\n[CSS] Do you want to add Twitter Bootstrap? [y|n]: ", Thor::Shell::Color::BLUE)
  gem 'bootstrap-sass'
  gem 'rails_bootstrap_helpers'

  templater.post_bundler do
    if options[:compass_installed]
      run 'bundle exec compass install bootstrap'
    else
      create_file File.join('app', 'assets', 'stylesheets', 'bootstrap.scss') do
        "@import 'bootstrap';"
      end
      append_to_file File.join('app', 'assets', 'stylesheets', 'application.css'),
                     '//= require bootstrap'
    end
  end
end

