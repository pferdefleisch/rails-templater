db_options = {
  'Option' => 'Database Options',
  '1' => 'Posgresql',
  '2' => 'Mysql',
  '3' => 'Sqlite3'
}

print_table db_options.to_a, :ident => 4
selection = ask("\nOption: ", Thor::Shell::Color::BLUE)

case selection
when '1'
  @username = ask("\nDatabase username?", Thor::Shell::Color::BLUE)
  gem 'pg'
  template File.expand_path("../../templates/active_record/config/database_postgres.yml.erb", __FILE__), 'config/database.yml'
when '2'
  @username = ask("\nDatabase username?", Thor::Shell::Color::BLUE)
  gem 'mysql2'
  template File.expand_path("../../templates/active_record/config/database_mysql.yml.erb", __FILE__), 'config/database.yml'
else
  gem 'sqlite3'
  create_file 'config/database.yml', templater.load_template('config/database.yml', 'active_record')
end

gsub_file 'config/application.rb', '# require "active_record/railtie"', 'require "active_record/railtie"'
run 'cp config/database.yml config/database.yml.example'
