require 'rails_helper'

describe CsvImporter do
  let(:csv_file) { File.new(File.join(Rails.root, 'spec', 'fixtures', 'ShortExample.csv')) }

  subject { described_class.call(csv_file) }

  it { expect { subject }.to change { Operation.count }.by 2 }
  it { expect { subject }.to change { Category.count }.by 3 }
  it { expect { subject }.to_not change { Company.count } }
end