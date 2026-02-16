

drop table if exists zepto;

create table zepto (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,	
quantity INTEGER
);




SELECT * FROM public.zepto
ORDER BY sku_id ASC 

--veri sayısı
select count(*) from public.zepto;

--veriyi görelim
SELECT * FROM public.zepto
LIMIT 10;

SHOW search_path;

-- Mevcut oturum için public şemasını varsayılan yapıyorum zepto yazınca gelecek.
SET search_path TO public;
SELECT * FROM zepto;

--null varmı
SELECT * FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
availableQuantity IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL; --null yok

--kaç benzersiz kategori var?
select distinct category from zepto; -- 14 kategori var
-- stok dışı olanlar KAÇ TANESİ : eli boş dönen müşteri demektir
select outOfStock ,COUNT(sku_id) from zepto group by outOfStock;

-- stokta olmayanlardan birden fazla adı geçen ürünler nelerdir 
select outOfStock , count(sku_id), zepto.name from zepto 
where outOfStock=TRUE group by outOfStock, name
having count(sku_id) > 1 
order by count(sku_id) desc
limit 50;


--stokta olarak etiketlenen aranan ürünlere bakalım
select name ,count(sku_id) from zepto
where outOfStock=FALSE group by outOfStock, name
having count(sku_id)>1
order by count(sku_id) desc;

--veri temizleme
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

DELETE FROM zepto
WHERE mrp = 0;

--para birimi çevirme rupiye çevirelim
UPDATE zepto
SET mrp = mrp / 100,
discountedSellingPrice = discountedSellingPrice /100.0;

SELECT mrp, discountedSellingPrice FROM zepto;

--1- İndirim yüzdesine göre en uygun fiyatlı 10 ürünü bulun.
select  name, sku_id, discountpercent, discountedSellingPrice  from zepto
order by zepto.discountpercent desc limit 10;

--2-Yüksek perakende satış fiyatına (mrp) sahip olup stokta olmayan ürünler nelerdir?
select name, outOfStock, mrp from zepto
where outOfStock= TRUE  and mrp > (select avg(mrp) from zepto) 
order by mrp desc;

--3-Her kategori için tahmini geliri hesaplayın.
select category, sum( discountedSellingPrice * quantity) as total_kazanc from zepto
group by category order by total_kazanc;

--4-Perakende satış fiyatı 500 ₹'den yüksek ve indirim oranı %10'dan düşük olan tüm ürünleri bulun.
select distinct name, category, mrp from zepto
where mrp >500 and discountpercent <10
order by mrp desc;

--5- Ortalama indirim yüzdesi en yüksek olan ilk 5 kategoriyi belirleyin.
select distinct category, avg(discountpercent) as avg_yuzde from zepto
group by category 
order by avg_yuzde desc 
limit 5;

--6-100 gramın üzerindeki ürünlerin gram başına fiyatını bulun ve en uygun fiyata göre sıralayın.
select distinct name, weightInGms, discountedSellingPrice ,round(discountedSellingPrice/weightInGms,2) as fiyat_gram
from zepto where weightInGms> 100 order by fiyat_gram asc;

--7-Ürünleri Az Miktar, Orta Miktar, Toplu Miktar gibi kategorilere ayırın.
select weightingms, name,
    case when weightingms < (select avg(weightingms) from zepto) then 'az miktar'
        when weightingms >= (select avg(weightingms) from zepto) 
             and weightingms < (select avg(weightingms) * 2 from zepto) then 'orta miktar'
        else 'toplu miktar'
    end as miktar_kategorisi
from zepto;

--8-Kategori başına toplam stok ağırlığı nedir?
select category, sum(weightingms * availablequantity) as total_weight from zepto
group by category order by total_weight desc;


