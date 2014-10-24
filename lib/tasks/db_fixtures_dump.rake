# Original from http://snippets.dzone.com/posts/show/4468 by MichaelBoutros
#
# Optimized version which uses to_yaml for content creation and checks
# that models are ActiveRecord::Base models before trying to fetch
# them from database.

# Then forked from https://gist.github.com/iiska/1527911
#
# fixed obsolete use of RAILS_ROOT, glob
# put output in the spec/fixtures directory instead of test/fixtures
# honour FIXTURES_PATH just like db:fixtures:load

namespace :db do
  namespace :fixtures do
    desc 'Dumps all models into fixtures. Use FIXTURES_PATH as base dir'
    task :dump => :environment do
      models = Dir.glob(Rails.root + 'app/models/**.rb').map do |s|
        Pathname.new(s).basename.to_s.gsub(/\.rb$/,'').camelize
      end
      dump_dir = ENV['FIXTURES_PATH'] || "spec/fixtures"

      puts "Found models: " + models.join(', ')
      puts "Dumping to: " + dump_dir

      models.each do |m|
        model = m.constantize
        next unless model.ancestors.include?(ActiveRecord::Base)

        entries = model.unscoped.find(:all, :order => 'id ASC')
        puts "Dumping model: #{m} (#{entries.length} entries)"

        output = {}
        entries.each_with_index do |entry , index|
          attrs = entry.attributes
          attrs.delete_if{|k,v| v.nil?}
          output[m + '_' + (index + 1).to_s] = attrs
        end
        model_file = Rails.root + (dump_dir + "/" + m.underscore.pluralize + '.yml')
        file = File.open(model_file, 'w')
        file << output.to_yaml
        file.close #better than relying on gc
      end
    end
  end
end
