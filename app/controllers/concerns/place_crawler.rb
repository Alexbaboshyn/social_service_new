module PlaceCrawler
  HOST = 'https://restcountries.eu/rest/v2/capital/'
  def get_data
    @data ||= URI("#{HOST}#{@city}").read
  end

  def get_place
    JSON.parse(get_data, symbolize_names: true)
  end
end
