# AGENTS.md - Devamsizlik Kural Motoru

- Ruby 3.4 kullan; yalnızca stdlib ve Minitest kullan.
- Test komutu: `ruby test/ogrenci_test.rb`.
- `Ogrenci`: `ad`, `durum` (`:aktif`, `:donduruldu`, `:mezun`) ve `devamsizlik` (0..10 Integer) alanlarını doğrular.
- Durum sorgularını sonlu durum listesi üzerinden `define_method` ile gerçek metot olarak üret.
- `method_missing` ve standart sınıflara monkey patch kesinlikle yasaktır.
- Tam 3 devamsızlık `riskli` sayılır: koşul `>= 3` olmalıdır.
- 4 ve üzeri devamsızlık `kaldi` sayılır: koşul `>= 4` olmalıdır.
- Özgün kural: aktif ve devamsızlığı 0 olan öğrenci `onur_adayi` sayılır.
- Kuralları `DevamsizlikKontrol::KURALLAR` içinde açık lambda bloklarıyla tut; `instance_eval` kullanma.
- Bilmediğin gereksinimi varsayma. Önce testleri çalıştır, sonra en küçük açık çözümü yaz, sonda `bin/kontrol` çalıştır.
