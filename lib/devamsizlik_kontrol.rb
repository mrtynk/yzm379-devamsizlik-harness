module DevamsizlikKontrol
  KURALLAR = {
    riskli: ->(ogrenci) { ogrenci.devamsizlik >= 3 },
    kaldi: ->(ogrenci) { ogrenci.devamsizlik >= 4 },
    onur_adayi: ->(ogrenci) { ogrenci.aktif? && ogrenci.devamsizlik.zero? }
  }.freeze

  def self.durum(ogrenci)
    KURALLAR.filter_map do |ad, kural|
      ad if kural.call(ogrenci)
    end
  end
end
