class DateConverter
  def self.convert(value)
    return Date.strptime(value, '%m/%d/%Y') if value =~ /\A(?:0?[1-9]|1[0-2])\/(?:0?[1-9]|[1-2]\d|3[01])\/\d{4}\Z/
    Date.parse(value)
  end
end
