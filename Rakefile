# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :import do
  task :customers => :environment do
    ruby "./lib/tasks/import_customers.rb"
  end
  task :merchants => :environment do
    ruby "./lib/tasks/import_merchants.rb"
  end
  task :items => :environment do
    ruby "./lib/tasks/import_items.rb"
  end
  task :invoices => :environment do
    ruby "./lib/tasks/import_invoices.rb"
  end
  task :invoice_items => :environment do
    ruby "./lib/tasks/import_invoice_items.rb"
  end
  task :transactions => :environment do
    ruby "./lib/tasks/import_transactions.rb"
  end
  task :clean_invoice_status do
    ruby "./lib/tasks/clean_invoice_status.rb"
  end
  task :all => :environment do
    Rake::Task["import:merchants"].invoke
    Rake::Task["import:customers"].invoke
    Rake::Task["import:items"].invoke
    Rake::Task["import:invoices"].invoke
    Rake::Task["import:invoice_items"].invoke
    Rake::Task["import:transactions"].invoke
  end
end
