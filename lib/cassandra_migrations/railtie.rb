# encoding : utf-8

class CassandraMigrations::Railtie < ::Rails::Railtie
  
  rake_tasks do
    Dir[File.expand_path("railtie/**/*.rake", File.dirname(__FILE__))].each do |file| 
      # 'load' is used because 'require' is only for .rb files
      load file
    end
  end
  
  generators do
    Dir[File.expand_path("railtie/**/*_generator.rb", File.dirname(__FILE__))].each do |file| 
      require file
    end
  end
  
end
