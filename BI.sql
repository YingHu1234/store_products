create database ProductSales;
use ProductSales;


CREATE TABLE t_Product(
	ProductKey INT not null,
	ProductSubKey Int,	
	ProductCost float,
	ProductPrice float
CONSTRAINT ProductKey_PK PRIMARY KEY (ProductKey)
);

CREATE TABLE t_Sales(
	SalesID INT not null,
    ProductKey    INT,
	OrderQuantity	INT
CONSTRAINT SalesID_PK PRIMARY KEY (SalesID),
constraint ProductKey_FK foreign key (ProductKey) references t_Product(ProductKey)
);


select* from t_Sales;



CREATE TABLE t_ProductCate(
	ProductCate_Key INT not null,
	CategoryName 	VARCHAR(100)
CONSTRAINT ProductCate_Key_PK PRIMARY KEY (ProductCate_Key)
);



CREATE TABLE t_ProductSub(
	ProductSub_Key INT not null,
	ProductSub_Name VARCHAR(100),	
	ProductCate_Key INT

CONSTRAINT ProductSub_Key_PK PRIMARY KEY (ProductSub_Key),
constraint ProductCate_Key_FK foreign key (ProductCate_Key) references t_Product(ProductKey)
);







BULK
INSERT t_Product
FROM 'C:\Users\wingy\Desktop\Product_new.csv'
WITH
(
fieldterminator=',',
rowterminator='\n'
)
go

select* from t_Product;



BULK
INSERT t_Sales
FROM 'C:\Users\wingy\Desktop\Sales2017_1.csv'
WITH
(FIRSTROW = 2,
fieldterminator=',',
rowterminator='\n'
)
go

select* from t_Sales;



BULK
INSERT t_ProductCate
FROM 'C:\Users\wingy\Desktop\ProductCate.csv'
WITH
(
fieldterminator=',',
rowterminator='\n'
)
go

select* from t_ProductCate;



BULK
INSERT t_ProductSub
FROM 'C:\Users\wingy\Desktop\ProductSub.csv'
WITH
(
fieldterminator=',',
rowterminator='\n'
)
go

select* from t_ProductSub;


--join table and caculate the total sales, total cost and revenue


select s.ProductKey, s.OrderQuantity,Cate.ProductCate_Key,Cate.CategoryName, round(p.ProductCost,2) as cost,
round(p.ProductPrice,2) as price, round((p.ProductPrice*s.OrderQuantity),2) as total_price, 
round((p.ProductCost*s.OrderQuantity),2) as total_cost,  
round((p.ProductPrice*s.OrderQuantity-p.ProductCost*s.OrderQuantity),2) as revenue
from t_Sales s 
join t_Product p on p.ProductKey=s.ProductKey
join t_ProductSub sub on p.ProductSubKey=sub.ProductSub_Key
join t_ProductCate Cate on sub.ProductCate_Key=Cate.ProductCate_Key;




