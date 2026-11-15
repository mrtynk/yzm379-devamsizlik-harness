class Ogrenci
  DURUMLAR = %i[aktif donduruldu mezun].freeze

  attr_reader :ad, :durum, :devamsizlik

  def initialize(ad:, durum:, devamsizlik:)
    raise ArgumentError, "ad gecersiz" unless ad.is_a?(String) && !ad.empty?
    raise ArgumentError, "durum gecersiz" unless DURUMLAR.include?(durum)
    unless devamsizlik.is_a?(Integer) && (0..10).cover?(devamsizlik)
      raise ArgumentError, "devamsizlik gecersiz"
    end

    @ad = ad
    @durum = durum
    @devamsizlik = devamsizlik
  end

  DURUMLAR.each do |durum_adi|
    define_method("#{durum_adi}?") do
      durum == durum_adi
    end
  end
end
