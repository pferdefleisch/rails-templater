if yes?("\n[Authentication] Do you want authentication? [y|n]: ", Thor::Shell::Color::BLUE)
  auth_options = {
    'Option' => 'Authentication Systems',
    '1' => 'Sorcery',
    '2' => 'Devise'
  }

  print_table auth_options.to_a, :ident => 4
  selection = ask("\nOption: ", Thor::Shell::Color::BLUE)

  case selection
  when "1"
    gem 'sorcery'

    plugin_options = {
      'Option' => 'Sorcery Plugins - comma separated please :)',
      'remember_me' => 'Remember Me',
      'reset_password' => 'Reset Password',
      'http_basic_auth' => 'HTTP Basic Auth',
      'external' => 'External',
      'user_activation' => 'User Activation',
      'activity_logging' => 'Activity Logging',
      'brute_force_protection' => 'Brute Force Protection',
    }

    print_table plugin_options.to_a, :ident => 4
    selection = ask("\nOptions: ", Thor::Shell::Color::BLUE)

    if no?("\n[Sorcery] Are you OK with User as your base authentication model? [y|n]: ", Thor::Shell::Color::BLUE)
      auth_model = ask "\nWhich class name would you like to use? ex. Admin", Thor::Shell::Color::Blue
    end

    sorcery_path        = '../../templates/sorcery'
    sorcery_controllers = "#{sorcery_path}/controllers"
    sorcery_views       = "#{sorcery_path}/views"

    template File.expand_path("#{sorcery_controllers}/sessions_controller.rb", __FILE__), 'app/controllers/sessions_controller.rb'
    template File.expand_path("#{sorcery_views}/sessions/new.html.erb", __FILE__), 'app/views/sessions/new.html.erb'

    insert_into_file File.join('config', 'routes.rb'), :after => "Application.routes.draw do\n" do
      "\nresources :sessions, :only => [:new, :create, :destroy]\n"
    end

    templater.post_bundler do
      install_options = selection.split(',').map { |option| option.strip }.join(' ')
      if auth_model.present?
        install_options = "#{install_options} --model #{auth_model}"
      end
      generate "sorcery:install #{install_options}"
      gsub_file 'config/sorcery.rb', '# user.username_attribute_names =', 'user.username_attribute_names = [:username, :email]'
      run "bundle exec rake db:create:all"
      run "bundle exec rake db:migrate"
    end

  when "2"
    gem 'devise'
    templater.post_bundler do
    end
  end
end
