# YZM379 - Devamsızlık Kural Motoru ve Agent Harness

[![CI](https://github.com/mrtynk/yzm379-devamsizlik-harness/actions/workflows/ci.yml/badge.svg)](https://github.com/mrtynk/yzm379-devamsizlik-harness/actions/workflows/ci.yml)

Ruby 3.4 ve yalnız standart kütüphane/Minitest kullanılarak hazırlanmış öğrenci devamsızlık kural motorudur. Çalışmanın odağı yalnız kod değil; rehber, sensör, doğrulama kancası ve gerçek A/B ölçümünden oluşan harness'tır.

## Kurallar

- `riskli`: devamsızlık `>= 3` (10 oturumda tam %30 dahil).
- `kaldi`: devamsızlık `>= 4`.
- Özgün kural `onur_adayi`: öğrenci `aktif` ve devamsızlığı `0` ise.
- Durumlar: `:aktif`, `:donduruldu`, `:mezun`.
- Devamsızlık yalnız `0..10` aralığında Integer olabilir.
- Durum sorguları `define_method` ile gerçek ve aranabilir metotlardır.
- `method_missing`, `instance_eval` ve standart sınıflara monkey patch yasaktır.

## Çalıştırma

Gereksinim: Ruby 3.4.

```sh
ruby test/ogrenci_test.rb
bash bin/kontrol
```

Pre-commit doğrulama kancasını bir kez kurmak için:

```sh
bash bin/kur
```

Bundan sonra her commit öncesi `bin/kontrol` otomatik çalışır; test veya mimari yasak kontrolü başarısızsa commit durur.

## Proje yapısı

```text
lib/ogrenci.rb                 Açık veri sözleşmesi ve durum sorguları
lib/devamsizlik_kontrol.rb     Üç açık lambda kuralı
test/ogrenci_test.rb           Minitest sensörleri ve sınır vakaları
AGENTS.md                      Kısa, projeye özel agent anayasası
CLAUDE.md                      AGENTS.md yönlendirmesi
bin/kontrol                    Test + yasak yapı doğrulama kancası
bin/kur                        Git pre-commit kancasını etkinleştirir
RATCHET_LOG.md                 Gerçek hata → kalıcı kural/sensör günlüğü
KANITLAR/                      A/B koşu ve test kanıtları
```

## A/B Koşusu ve Ölçüm Raporu

Her iki koşu 15 Kasım 2026'da aynı Codex CLI ortamında yapıldı. Token değerleri CLI'nin `turn.completed.usage` olayından alınmıştır.

| Ölçüt | A: yalnız ham prompt | B: harness ile | Yorum |
| --- | ---: | ---: | --- |
| Agent turu | 1 | 1 | Tur sayısı düşmedi. |
| Girdi tokenı | 112.723 | 119.989 | Harness ve test bağlamı B girdisini artırdı. |
| Cache okuma tokenı | 91.136 | 111.616 | Ortamın sabit bağlamı iki koşuda da büyüktü. |
| Çıktı tokenı | 1.133 | 1.622 | B çalışan kod ve doğrulama raporu üretti. |
| Ruby uygulama dosyası | 0 | 2 | A kapsamı yanlış yorumladı; B uygulamayı tamamladı. |
| Test sonucu | Test yok | 10/10, 26 assertion | B sensörle doğrulandı. |
| Görev sonucu | Bloke, veri dosyası istedi | Tamamlandı | Harness başarı oranını değiştirdi. |

### Sayısal yorum

- Toplam `input + output` tokenı A'da `113.856`, B'de `121.611` oldu; B toplam tokenı yaklaşık `%6,8` artırdı.
- Bu deneyde harness tur sayısını azaltmadı. İki koşu da tek agent turunda bitti; ancak A hiçbir kod üretmeden yanlış girdiyi bekledi, B ise aynı tek turda çalışan kod ve yeşil test üretti.
- Dolar maliyeti ölçülmedi. Model fiyatı ve cache tarifesi koşu çıktısında bulunmadığından maliyet uydurulmadı.
- Tek A/B örneği istatistiksel genelleme için yeterli değildir. Kanıt yalnız bu iki koşuyu gösterir.

Ham koşu notları: [A_KOSUSU.md](KANITLAR/A_KOSUSU.md)  
Harness koşusu: [B_KOSUSU.md](KANITLAR/B_KOSUSU.md)  
Son test çıktısı: [TEST_SONUCU.txt](KANITLAR/TEST_SONUCU.txt)

## Yapamadıklarım

- Dolar cinsinden gerçek agent maliyeti ölçülemedi.
- A koşusu kod üretmediği için `> 3`, `method_missing` veya monkey patch hatalarını gerçekten yapmış gibi gösteren kayıt yoktur.
- İki koşuluk deney, farklı modeller veya çoklu tekrarlar arasında bilimsel performans karşılaştırması değildir.
- Windows ortamı yönetici yetkisi olmadan sembolik bağ oluşturmayı reddetti. Ders slaytında belirtilen taşınabilir yedek kullanıldı: `CLAUDE.md` içeriği tek satır `@AGENTS.md`.
