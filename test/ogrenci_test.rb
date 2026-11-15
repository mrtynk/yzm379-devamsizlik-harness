require "minitest/autorun"
require "date"
require_relative "../lib/ogrenci"
require_relative "../lib/devamsizlik_kontrol"

class OgrenciTest < Minitest::Test
  def test_durum_sorgulari_gercek_metotlardir
    ogrenci = Ogrenci.new(ad: "Ayse", durum: :aktif, devamsizlik: 0)

    assert ogrenci.aktif?
    refute ogrenci.donduruldu?
    refute ogrenci.mezun?
    assert_respond_to ogrenci, :aktif?
    assert_includes Ogrenci.instance_methods(false), :mezun?
  end

  def test_bilinmeyen_durum_metodu_sessizce_false_donmez
    ogrenci = Ogrenci.new(ad: "Ayse", durum: :aktif, devamsizlik: 0)

    assert_raises(NoMethodError) { ogrenci.mezn? }
  end

  def test_devamsizlik_2_iken_riskli_degil
    refute_includes durumlar(devamsizlik: 2), :riskli
  end

  def test_devamsizlik_tam_3_iken_riskli
    assert_includes durumlar(devamsizlik: 3), :riskli
    refute_includes durumlar(devamsizlik: 3), :kaldi
  end

  def test_devamsizlik_4_iken_riskli_ve_kaldi
    sonuc = durumlar(devamsizlik: 4)

    assert_includes sonuc, :riskli
    assert_includes sonuc, :kaldi
  end

  def test_aktif_ve_devamsizligi_sifir_olan_onur_adayi
    assert_includes durumlar(devamsizlik: 0), :onur_adayi
  end

  def test_dondurulan_ogrenci_onur_adayi_degil
    refute_includes durumlar(devamsizlik: 0, durum: :donduruldu), :onur_adayi
  end

  def test_devamsizlik_araligi_dogrulanir
    assert_raises(ArgumentError) { ogrenci(devamsizlik: -1) }
    assert_raises(ArgumentError) { ogrenci(devamsizlik: 11) }
    assert_raises(ArgumentError) { ogrenci(devamsizlik: 3.0) }
  end

  def test_durum_dogrulanir
    assert_raises(ArgumentError) { ogrenci(durum: :beklemede) }
  end

  def test_standart_date_sinifina_monkey_patch_yapilmamistir
    refute_respond_to Date.today, :tatil?
  end

  private

  def ogrenci(devamsizlik:, durum: :aktif)
    Ogrenci.new(ad: "Ayse", durum:, devamsizlik:)
  end

  def durumlar(devamsizlik:, durum: :aktif)
    DevamsizlikKontrol.durum(ogrenci(devamsizlik:, durum:))
  end
end
