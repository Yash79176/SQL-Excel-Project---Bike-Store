-- Dataset Available: The Given SQL Analysis is on BikeStores data set containing 9 different datasets
--					  such as Production_Brands, Production_categories, Production_products, Production_stocks,
--					  Sales-customers, Sales_Order_items, Sales_orders, Sales_staffs, Sales_stores.

-- Objective: The objective of the analysis is to write SQL Queries that generates a datasets which consists fields
--			  such as Order_id; Customer Names, City and state; Order Date; Sales Volume; Revenue; Product Name;
--			  Product Category; Store Name And Sales Rep.

-- Key SQL Command to be used - JOIN (Direct and Indirect Table Joints to relate different datasets).

-- Let's Begin >>>
USE BikeStores
SELECT @@SERVERNAME;

SELECT
	ord.order_id,
	CONCAT(cus.first_name,' ', cus.last_name) As 'Customers',
	cus.city,
	cus.state,
	ord.order_date,

	-- Adding Number of units sold and the total revenue generated
	SUM(ite.quantity) AS 'total_units',  
	SUM(ite.quantity * ite.list_price) AS 'revenue',

	-- Adding the name of the product that were purchased
	pro.product_name,

	-- Adding category of the products that were purchased and the store where it was purchased
	cat.category_name,
	st.store_name,

	-- Adding Brand Name of the product
	br.brand_name,

	-- Adding the information of sales representatives who made the sale
	CONCAT(staff.first_name,' ', staff.last_name) As 'Sales_Rep'
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items ite
ON ord.order_id = ite.order_id
JOIN production.products pro
ON ite.product_id = pro.product_id
JOIN production.categories cat
ON pro.category_id = cat.category_id
JOIN sales.stores st
ON ord.store_id = st.store_id
JOIN production.brands br
ON pro.brand_id = br.brand_id
JOIN sales.staffs staff
ON ord.staff_id = staff.staff_id
GROUP BY 
	ord.order_id,
	CONCAT(cus.first_name,' ', cus.last_name),
	cus.city,
	cus.state,
	ord.order_date,
	pro.product_name,
	cat.category_name,
	st.store_name,
	br.brand_name,
	CONCAT(staff.first_name,' ', staff.last_name)
