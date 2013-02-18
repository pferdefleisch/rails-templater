if yes?("\n[Javascript] Would you like to add a javascript MVC framework? [y|n]: ", Thor::Shell::Color::BLUE)
  auth_options = {
    'Option' => 'Javascript Frameworks',
    '1' => 'backbone',
    '2' => 'angular'
  }
  print_table auth_options.to_a, :ident => 4
  selection = ask("\nOption: ", Thor::Shell::Color::BLUE)
  case selection
  when "1"
    gem 'backbone-on-rails'
    templater.post_bundler do
      generate 'backbone:install'
    end
  when "2"
    gem 'angularjs-rails'
    insert_into_file(
      "app/assets/javascripts/application.js",
      "//= require angular\n//= require angular-resource\n",
      :before => "//= require_tree .")
  end
end
