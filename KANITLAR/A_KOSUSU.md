# A Koşusu - Ham Prompt

## Prompt

> Öğrenci devamsızlık kontrolü yap, devamsızlık sınırı %30'dur.

## Gerçek sonuç

Codex CLI, görevde Ruby uygulaması istendiğini çıkaramadı. Devamsızlık verilerini içeren Excel/CSV dosyasını istedi; hiçbir Ruby dosyası veya test üretmedi.

Son mesaj:

> Kontrolü yapabilmem için öğrenci devamsızlık verisini içeren Excel/CSV dosyasını yükleyin. Toplam ders saati ve her öğrencinin devamsızlık saati bulunmalı; ardından %30 ve üzerindekileri listeleyeceğim.

## Ölçüm

| Ölçüt | Gerçek değer |
| --- | ---: |
| Agent turu | 1 |
| Araç/komut adımı | Ölçülmedi |
| Girdi tokenı | 112.723 |
| Cache okuma tokenı | 91.136 |
| Çıktı tokenı | 1.133 |
| Kod dosyası | 0 |
| Test | 0 |
| Sonuç | Görev yanlış yorumlandı; kullanıcı girdisi beklendi |

Not: Token sayıları Codex CLI `turn.completed.usage` olayından alınmıştır. Girdi tokenının büyük bölümü çalışma ortamının sabit bağlamıdır; bu yüzden yalnız proje promptunun uzunluğu gibi yorumlanamaz.
