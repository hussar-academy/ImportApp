# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

companies = ['ACME',
             'Big Company 1',
             'BP Biznes',
             'Comcast',
             'Company X',
             'Hugehard',
             'KT Koty',
             'Microsoft',
             'Monterail, Inc.',
             'MS Szpadel',
             'Ostrzy Entertainment',
             'SB Komputery',
             'TT Internet']

companies.each do |company|
  Company.create(name: company)
end
