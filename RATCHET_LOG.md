# RATCHET LOG

Bu günlük yalnız gerçekleşen koşu kayıtlarına dayanır. A koşusunda Ruby kodu üretilmediği için yaşanmayan `> 3`, `method_missing` veya monkey patch hataları yaşanmış gibi yazılmamıştır.

| Tarih | Koşu | Karşılaşılan gerçek hata | Kalıcı karşılık | Katman | Doğrulama |
| --- | --- | --- | --- | --- | --- |
| 15.11.2026 | A | Ham prompt, Ruby programlama görevi yerine Excel/CSV veri analizi olarak yorumlandı; kod üretilmedi. | Ruby 3.4, dosyalar, sınıflar, çalışma komutu ve kapsam `AGENTS.md` içinde açıklandı. | Rehber | B koşusu iki Ruby dosyası üretti. |
| 15.11.2026 | A → B | `%30 sınırı` ifadesi toplam oturum, eşitlik ve kalma sınırını tanımlamıyordu. | `3/10` için `>= 3`, `4/10` için `>= 4` rehbere yazıldı; 2, 3 ve 4 sınır testleri eklendi. | Rehber + Sensör | 10 test, 26 assertion yeşil. |
| 15.11.2026 | A → B | Ham prompt metot üretim biçimini belirtmiyordu. | Sonlu durumlarda `define_method`; `method_missing` yasağı ve bilinmeyen metotta `NoMethodError` testi eklendi. | Rehber + Sensör | `aktif?`, `mezun?` görünür; `mezn?` hata verir. |
| 15.11.2026 | A → B | Ham prompt standart sınıflara müdahale sınırını belirtmiyordu. | Monkey patch yasağı, `Date#tatil?` negatif testi ve `bin/kontrol` statik taraması eklendi. | Rehber + Sensör | `Date.today` için `tatil?` yok; kontrol başarılı. |
| 15.11.2026 | B | İlk test çalıştırması `lib/ogrenci.rb` olmadığı için kırmızıydı. | Agent yalnız eksik iki uygulama dosyasını yazdı; testleri değiştirmedi. | Sensör | Son çalıştırma 10/10 yeşil. |

Mandal ilkesi: Aynı hata tekrar ederse yeni bir açıklama değil, rehber veya sensör güncellemesi gerekir.
