require_relative '../feature_helper'

feature 'Upload csv file' do
  scenario 'User import file with operations' do
    visit operations_path

    first('input[type="file"]').set("#{Rails.root}/spec/support/fixtures/small_example.csv")

    click_on 'Save'

    expect(page.body).to have_content('Operations imported.')
  end

  scenario 'User click save without uploaded file' do
    visit operations_path
    click_on 'Save'

    expect(page.body).to have_content('Invalid csv file')
  end

  scenario 'User click save incorrect file' do
    visit operations_path

    first('input[type="file"]').set("#{Rails.root}/spec/support/fixtures/incorrect_file.csv")
    click_on 'Save'

    expect(page.body).to have_content('Invalid csv file')
  end

end