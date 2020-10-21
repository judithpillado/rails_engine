desc 'Clear database and seed with CSV fixture data.'
task import: :environment do
  require 'csv'

  models = [Transaction, InvoiceItem, Item, Invoice, Merchant, Customer]

  puts 'Clearing database...'

  models.each do |model|
    model.destroy_all
  end

  puts 'Successful! Now importing CSV fixture data...'

  models.reverse.each do |model|
    puts "Importing #{model} data..."
    CSV.foreach("./data/#{model}s.csv",
                headers: true,
                header_converters: :symbol) do |row|
      model.create!(row.to_h)
    end
    puts "Successful! #{model} data imported."
  end
  puts 'Awesome! Thank you for your patience.'
end
