db_options = {
  'Option' => 'Database Options',
  '1' => 'posgresql',
  '2' => 'sqlite3'
}

print_table db_options.to_a, :ident => 4
selection = ask("\nOption: ", Thor::Shell::Color::BLUE)

if selection == '1'
  @application_name = $app
  @username = ask("\nDatabase username?", Thor::Shell::Color::BLUE)
  gem 'pg'
  create_file 'config/database.yml', templater.load_template('config/database_postgres.yml', 'active_record')
else
  gem 'sqlite3'
  create_file 'config/database.yml', templater.load_template('config/database.yml', 'active_record')
end

gsub_file 'config/application.rb', '# require "active_record/railtie"', 'require "active_record/railtie"'
run 'cp config/database.yml config/database.yml.example'
