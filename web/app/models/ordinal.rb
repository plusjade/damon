class Ordinal
  ORDINAL_FORMAT = "%Y-%j".freeze
  DATE_FORMAT = "%A %m/%d".freeze

  def self.from_time(time)
    time.strftime(ORDINAL_FORMAT)
  end

  def self.to_time(ordinal)
    Date.strptime(ordinal, ORDINAL_FORMAT)
  end

  def self.to_date(ordinal)
    to_time(ordinal).strftime(DATE_FORMAT)
  end
end
