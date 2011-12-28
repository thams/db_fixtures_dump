# Original from http://snippets.dzone.com/posts/show/4468 by MichaelBoutros
#
# Fixed to check that models are ActiveRecord::Base models before
# trying to fetch them from database
namespace :db do
  namespace :fixtures do
    desc 'Dumps all models into fixtures.'
    task :dump => :environment do
      models = Dir.glob(RAILS_ROOT + '/app/models/**.rb').map do |s|
        Pathname.new(s).basename.to_s.gsub(/\.rb$/,'').camelize
      end

      puts "Found models: " + models.join(', ')

      models.each do |m|
        model = m.constantize
        next unless model.ancestors.include?(ActiveRecord::Base)

        puts "Dumping model: " + m
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

        model_file = RAILS_ROOT + '/test/fixtures/' + m.underscore.pluralize + '.yml'

        File.exists?(model_file) ? File.delete(model_file) : nil
        File.open(model_file, 'w') {|f| f << formatted}
      end
    end
  end
end