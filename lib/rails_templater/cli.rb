require 'thor/group'

module RailsTemplater
  class Cli < Thor::Group
    argument :application_name, :type => :string, :desc => "The name of the rails application"
    desc "Generates a new Rails application with templater'"

    def run_templater
      rails_new = "rails new #{application_name} -O --skip-bundle -m #{RailsTemplater::template_runner}"
      system(rails_new)
    end
  end
end
