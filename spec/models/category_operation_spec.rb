require 'rails_helper'

RSpec.describe CategoryOperation, type: :model do
  it { is_expected.to belong_to :category }
  it { is_expected.to belong_to :operation }

  it { is_expected.to validate_presence_of :category }
  it { is_expected.to validate_presence_of :operation }
end
