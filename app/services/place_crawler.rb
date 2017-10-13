module PlaceCrawler
  HOST = 'https://restcountries.eu/rest/v2/capital/'
  class << self
    def get_data city
      @data ||= URI("#{HOST}#{city}").read
    end

    def get_place city
      JSON.parse(get_data(city), symbolize_names: true)
    end
  end
end
