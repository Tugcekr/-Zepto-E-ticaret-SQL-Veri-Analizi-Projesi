# -Zepto-E-ticaret-SQL-Veri-Analizi-Projesi
Bu çalışma; Hindistan'ın en hızlı büyüyen hızlı ticaret (quick-commerce) girişimlerinden biri olan Zepto'dan kazınmış (scraped) bir e-ticaret envanter veri setine dayanan, eksiksiz ve gerçek dünya senaryolarına uygun bir veri analisti portfolyo projesidir.

Sütun Adı
sku_id,Her ürün için benzersiz kimlik (Primary Key).

name,Uygulamada görünen ürün adı.

category,"Ürün kategorisi (Meyve, İçecek, Atıştırmalık vb.)."

mrp,Maksimum perakende satış fiyatı (Rupi - ₹).

discountPercent,Uygulanan indirim oranı (%).

discountedSellingPrice,İndirim sonrası nihai satış fiyatı (Rupi - ₹).

availableQuantity,Envanterdeki mevcut birim miktarı.

weightInGms,Gram cinsinden ürün ağırlığı.

outOfStock,Stok durumunu belirten boolean bayrağı (True/False).

quantity,Paket başına birim sayısı.


Veri Temizleme ve Hazırlık Süreci
Veri setini analize uygun hale getirmek için aşağıdaki adımlar uygulanmıştır:

Birim Dönüşümü: Orijinal veride paise (kuruş) cinsinden olan fiyatlar, 100'e bölünerek standart Rupi (₹) birimine çevrilmiştir.

Hatalı Veri Temizliği: Perakende fiyatı (mrp) 0 olan hatalı kayıtlar tespit edilerek veri setinden çıkarılmıştır.

Null Kontrolü: Tüm sütunlar üzerinde IS NULL kontrolü yapılmış ve eksik veri olmadığı doğrulanmıştır.

Şema Yönetimi: PostgreSQL search_path ayarları yapılarak public şeması varsayılan hale getirilmiştir.


Proje kapsamında aşağıdaki kritik iş sorularına yanıt aranmıştır:

Gelir Analizi: Her kategori için beklenen tahmini toplam gelir hesaplanmıştır.

Stok Yönetimi: Stokta olmayan (outOfStock = TRUE) ancak yüksek fiyatlı veya çok talep gören ürünler listelenerek tedarik zinciri iyileştirmesi hedeflenmiştir.

Birim Fiyat Analizi: 100 gramın üzerindeki ürünlerde "gram başına fiyat" hesaplanarak en ekonomik seçenekler belirlenmiştir.

Dinamik Segmentasyon: Ürün ağırlıkları, tüm verinin ortalama ağırlığına (AVG) göre dinamik olarak 'az', 'orta' ve 'toplu' miktar olarak kategorize edilmiştir.

İstatistiksel Not: Ağırlık kategorizasyonu yapılırken sabit eşikler yerine verinin genel ortalaması (AVG) kullanılarak dinamik bir yapı kurulmuştur.

Teknik Yetkinlikler
Veritabanı: PostgreSQL
Yetenekler: Subqueries, Case When Logic, Aggregate Functions (Sum, Avg, Count), Group By/Having, Data Type Casting.
