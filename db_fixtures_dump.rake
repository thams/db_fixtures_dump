# From http://snippets.dzone.com/posts/show/4468
require 'find'

namespace :db do
  namespace :fixtures do
    desc 'Dumps all models into fixtures.'
    task :dump => :environment do
      models = []
      Find.find(RAILS_ROOT + '/app/models') do |path|
        unless File.directory?(path) then models << path.match(/(\w+).rb/)[1] end
      end
  
      puts "Found models: " + models.join(', ')
      
      models.each do |m|
        puts "Dumping model: " + m
        model = m.capitalize.constantize
        entries = model.find(:all, :order => 'id ASC')
        
        formatted, increment, tab = '', 1, '  '
        entries.each do |a|
          formatted += m + '_' + increment.to_s + ':' + "\n"
          increment += 1
          
          a.attributes.each do |column, value|
            formatted += tab
            
            match = value.to_s.match(/\n/)
            if match
              formatted += column + ': |' + "\n"
              
              value.to_a.each do |v|
                formatted += tab + tab + v
              end
            else
              formatted += column + ': ' + value.to_s
            end
            
            formatted += "\n"
          end
                    
          formatted += "\n"
        end
      
        model_file = RAILS_ROOT + '/test/fixtures/' + m.pluralize + '.yml'
        
        File.exists?(model_file) ? File.delete(model_file) : nil
        File.open(model_file, 'w') {|f| f << formatted}
      end
    end
  end
end