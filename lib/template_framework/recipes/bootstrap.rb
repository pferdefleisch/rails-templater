if yes?("\n[CSS] Do you want to add Twitter Bootstrap? [y|n]: ", Thor::Shell::Color::BLUE)
  gem 'bootstrap-sass'
  gem 'rails_bootstrap_helpers'

  templater.post_bundler do
    if RailsTemplater.config[:compass_installed]
      run 'bundle exec compass install bootstrap'
    else
      create_file File.join('app', 'assets', 'stylesheets', 'twitter.scss') do
        "@import 'bootstrap';"
      end
      insert_into_file File.join('app', 'assets', 'stylesheets', 'application.css'),
                     "\n *= require twitter",
                     :after => "*= require_tree ."
    end
  end
end

