require 'csv'

class CompaniesWithStatisticsAsJson < BaseService

  SQL_QUERY = "SELECT company_id,
      AVG(operations.amount) AS average_amount_of_operations,
      COUNT(CASE WHEN status = 'accepted' THEN 1 END) AS accepted_operations_count,
      MAX(amount)
        filter (where date_part('month', operation_date) = date_part('month', CURRENT_DATE)
          AND date_part('year', operation_date) = date_part('year', CURRENT_DATE))
        AS highest_operation_from_the_current_month
      FROM operations
      GROUP BY company_id".freeze

  def call
    attach_statistics(serialized_companies)
  end

  def initialize
    self.companies = Company.includes(operations: :categories)
      .where('operations_count > ?', 0)
  end

  private

  attr_accessor :companies

  def serialized_companies
    @serialized_companies ||= ActiveModel::Serializer::CollectionSerializer.new(
      companies,each_serializer: CompanySerializer).as_json
  end

  def attach_statistics(serializered_companies)
    ActiveRecord::Base.connection.execute(SQL_QUERY).each do |result|
      index = serializered_companies.find_index{ |company| company[:id].to_s == result['company_id']}
      serializered_companies[index].merge! result
    end
    serializered_companies
  end

end