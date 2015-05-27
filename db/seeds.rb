# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

companies = ['Monterail, Inc.', 'Ostrzy Entertainment', 'ACME', 'Company X', 'Big Company 1',
             'TT Internet', 'SB Komputery', 'BP Biznes', 'KT Koty', 'MS Szpadel', 'Microsoft',
             'Hugehard', 'Comcast']

companies.each do |company|
  Company.create(name: company)
end
