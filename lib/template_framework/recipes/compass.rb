if yes?("\n[Stylesheets] Would you like to use Compass? [y|n]: ", Thor::Shell::Color::BLUE)
  design_options = {
    'Option' => 'Design Framework',
    '1' => 'Compass',
    '2' => 'Compass with blueprint semantic',
    '3' => 'Compass with blueprint basic',
    '4' => 'Compass with 960.gs'
  }

  RailsTemplater.config[:compass_installed] = true

  print_table design_options.to_a, :ident => 4
  design_selection = ask("\nOption: ", Thor::Shell::Color::BLUE)

  design_framework = case design_selection
  when "1"
    :compass
  when "2"
    :compass_blueprint_semantic
  when "3"
    :compass_blueprint
  when "4"
    :compass_960
  else
    :none
  end

  unless design_framework == :none
    app_css_file = File.join('app', 'assets', 'stylesheets', 'application.css')

    insert_into_file app_css_file,
                     "\n *= require screen",
                     :after => "*= require_tree ."

    gsub_file app_css_file, /^.*?require_tree.*$/, ''

    gem 'compass-rails', group: :assets

    framework_option = case design_framework
    when :compass_blueprint
      "--using blueprint/basic"
    when :compass_blueprint_semantic
      "--using blueprint/semantic"
    when :compass_960
      gem 'compass-960-plugin'
      "-r ninesixty --using 960"
    end

    templater.post_bundler do
      run "bundle exec compass init rails . #{framework_option}"
    end
  end
end
