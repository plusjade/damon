class Ordinal
  PT = ActiveSupport::TimeZone["Pacific Time (US & Canada)"]
  ORDINAL_FORMAT = "%Y-%j".freeze
  DATE_FORMAT = "%a %_m/%d".freeze

  def self.from_time(time)
    time.in_time_zone(PT).strftime(ORDINAL_FORMAT)
  end

  def self.to_time(ordinal)
    Date.strptime(ordinal, ORDINAL_FORMAT).in_time_zone(PT)
  end

  def self.to_date(ordinal, date_format=DATE_FORMAT)
    to_time(ordinal).strftime(date_format)
  end
end
