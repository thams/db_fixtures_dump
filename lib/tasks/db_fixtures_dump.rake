# Original from http://snippets.dzone.com/posts/show/4468 by MichaelBoutros
#
# Optimized version which uses to_yaml for content creation and checks
# that models are ActiveRecord::Base models before trying to fetch
# them from database.

# Then forked from https://gist.github.com/iiska/1527911
#
# fixed obsolete use of RAILS_ROOT, glob
# allow to specify output directory by FIXTURES_PATH

namespace :db do
  namespace :fixtures do
    desc 'Dumps all models into fixtures.'
    task :dump => :environment do
      models = Dir.glob(Rails.root + 'app/models/**.rb').map do |s|
        Pathname.new(s).basename.to_s.gsub(/\.rb$/,'').camelize
      end
      # specify FIXTURES_PATH to test/fixtures if you do test:unit
      dump_dir = ENV['FIXTURES_PATH'] || "spec/fixtures"
      puts "Found models: " + models.join(', ')
      puts "Dumping to: " + dump_dir

      models.each do |m|
        model = m.constantize
        next unless model.ancestors.include?(ActiveRecord::Base)

        entries = model.all.order('id ASC')
        puts "Dumping model: #{m} (#{entries.length} entries)"

        increment = 1

        model_file = Rails.root + (dump_dir + "/" + m.underscore.pluralize + '.yml')
        File.open(model_file, 'w') do |f|
          entries.each do |a|
            attrs = a.attributes
            attrs.delete_if{|k,v| v.nil?}

            output = {m + '_' + increment.to_s => attrs}
            f << output.to_yaml.gsub(/^---\s?\n/,'') + "\n"

            increment += 1
          end
        end
      end
    end
  end
end
