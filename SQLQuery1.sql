create database BookStore
go
use BookStore
go
-- b?ng sách
create table Books(
	book_id int primary key identity,
	title nvarchar(255),
	author nvarchar(50),
	genre_id int,
	publisher_id int,
	price decimal(10,2),
	quantity int, -- s? l??ng trong kho 
	discount_id int
	)
go
-- b?ng th? lo?i
create table Genres(
	genre_id int primary key identity,
	genre_name nvarchar(255)
	)
go

-- b?ng nhà xu?t b?n
create table Publishers(
	publisher_id int primary key identity,
	publisher_name nvarchar(255)
	)
go

--b?ng khách hàng
create table Customers(
	customer_id int primary key identity,
	customer_name nvarchar(255),
	email nvarchar(255),
	phone nvarchar(20)
	)
go
--b?ng nhân viên
create table Employees(
	employee_id int primary key identity,
	employee_name nvarchar(255),
	position nvarchar(50)
	)
go
-- b?ng ??n hàng 
create table Orders(
	order_id int primary key identity,
	customer_id int,
	employee_id int,
	order_date datetime,
	payment_method nvarchar(255) not null ,-- phương thcuws thanh toán
	order_status bit-- trạng thái của đơn hàng
	)
go



-- b?ng chi ti?t ??n hàng 
create table OrderDetails(
	order_detail_id int primary key identity,
	order_id int,
	book_id int,
	price decimal(10,2),
	quantity int, 
    subtotal decimal(10,2),-- tổng tiền của mỗi mặt hàng trong đơn hàng
    Notes nvarchar(255)
	)

go
-- b?ng nhà cung c?p
create table Suppliers(
	supplier_id int primary key identity,
	supplier_name nvarchar(255),
	contact_name nvarchar(255),
	contact_email nvarchar(255),
	contact_phone nvarchar(20)
	)
	
go
-- b?ng gi?m giá 
create table Discounts(
	discount_id int primary key identity,
	discount_name nvarchar(255),
	discount_percentage decimal(5,2) -- t? l? gi?m giá 
	)
go
-- bảng phiếu nhập
create table SupplyOrders(
	supplyOrder_id int primary key identity,
	supplier_id int,
	purchase_date datetime,
	total_quantity int,-- tổng số lượng các mặt hàng trong phiếu nhập
	total_amount decimal(10,2),-- tổng số tiền cho toàn bộ phiếu nhập
	notes nvarchar(255) -- ghi chú thông tin bổ sung về phiếu nhập
	)
go
-- bảng chi tiết phiếu nhập
create table SupplyOrderDetails(
	supplyOrder_detail_id int identity primary key,
	supplyOrder_id int,
	book_id int,
	book_quantity int, -- số lượng sản phẩm được nhập
	book_price int, -- giá tiền mỗi quyển sách 
	total_amount decimal, -- tổng số tiền của mỗi quyển sách = số lượng * giá tiền mỗi quyển sách 
	)
go

-- bảng mượn trả sách 
create table Borrowings(
	borrowing_id int primary key identity,
	customer_id int,
	borrow_date date,
	return_date_expected date, -- ngày dự kiến trả sách
	return_date_actual date, -- ngày thực tế khi trả sách 
	statsus nvarchar(50), -- trạng thái 
	notes nvarchar(255),
	employee_id int
	)
go 
-- bảng chi tiết mượn trả sách
create table BorrowingDetails(
	borrowing_detali_id int primary key identity,
	borrowing_id int,
	book_id int,
	quantity int, -- số lượng sách được mượn trong mỗi bản ghi
	)


-- foreign key 
alter table Borrowings add constraint FK_Borrowings_customer_id foreign key(customer_id) references Customers(customer_id);
alter table Borrowings add constraint FK_Borrowings_employee_id foreign key(employee_id) references Employees(employee_id);
alter table BorrowingDetails add constraint FK_BorrowingDetails_book_id foreign key(book_id) references Books(book_id);
alter table BorrowingDetails add constraint FK_BorrowingDetails_borrowing_id foreign key(borrowing_id) references Borrowings(borrowing_id);


alter table SupplyOrders add constraint FK_SupplyOrders_supplier_id foreign key (supplier_id) references Suppliers(supplier_id);
alter table SupplyOrderDetails add constraint FK_SupplyOrderDetails_SuppluOrder_id foreign key(supplyOrder_id) references SupplyOrders(supplyOrder_id);
alter table SupplyOrderDetails add constraint FK_SupplyOrderDetails_book_id foreign key(book_id) references Books(book_id);

alter table Books add constraint FK_Book_genre_id foreign key(genre_id) references Genres (genre_id);
alter table Books add constraint FK_Book_publisher_id foreign key(publisher_id) references Publishers(publisher_id);
alter table Books add constraint FK_Book_discount_id foreign key(discount_id) references Discounts (discount_id);


alter table Orders add constraint FK_Orders_customer_id foreign key(customer_id) references Customers(customer_id);
alter table Orders add constraint FK_Orders_employee_id foreign key(employee_id) references Employees(employee_id);

alter table OrderDetails add constraint FK_OrderDetails_order_id foreign key(order_id) references Orders(order_id);
alter table OrderDetails add constraint FK_OrderDetails_book_id foreign key(book_id) references Books(book_id);

-- insert into bảng books

INSERT INTO Books (title, author, genre_id, publisher_id, price, quantity, discount_id)
VALUES
    (N'Harry Potter và Hòn đá Phù Thủy', N'J.K. Rowling', 1, 1, 25000, 100, 1),
    (N'Nhật ký Anne Frank', N'Anne Frank', 2, 2, 18000, 150, 2),
    (N'Vượt Qua Nỗi Sợ Hãi', N'Susan Jeffers', 3, 3, 15000, 200, 1),
    (N'Người Đua Thuyền', N'Loạt sách Percy Jackson', 1, 2, 20000, 120, 3),
    (N'Bí mật tư duy triệu phú', N'T. Harv Eker', 2, 3, 22000, 180, 2),
    (N'1984', N'George Orwell', 4, 4, 19000, 90, 1),
    (N'To Kill a Mockingbird', N'Harper Lee', 5, 5, 21000, 110, 3),
    (N'The Great Gatsby', N'F. Scott Fitzgerald', 6, 6, 24000, 130, 2),
    (N'Pride and Prejudice', N'Jane Austen', 7, 7, 17000, 100, 1),
    (N'The Catcher in the Rye', N'J.D. Salinger', 8, 8, 20000, 120, 2),
    (N'Lord of the Flies', N'William Golding', 9, 9, 18000, 110, 3),
    (N'Brave New World', N'Aldous Huxley', 10, 10, 21000, 150, 1),
    (N'The Hobbit', N'J.R.R. Tolkien', 11, 11, 23000, 140, 2),
    (N'Jane Eyre', N'Charlotte Brontë', 12, 12, 19000, 120, 3),
    (N'The Lord of the Rings', N'J.R.R. Tolkien', 11, 11, 25000, 160, 1),
    (N'Moby-Dick', N'Herman Melville', 13, 13, 22000, 100, 2),
    (N'War and Peace', N'Leo Tolstoy', 14, 14, 27000, 180, 3),
    (N'Crime and Punishment', N'Fyodor Dostoevsky', 15, 15, 20000, 110, 1),
    (N'Pride and Prejudice', N'Jane Austen', 7, 7, 23000, 130, 2),
    (N'To Kill a Mockingbird', N'Harper Lee', 5, 5, 24000, 140, 3);
	

	
	-- insert into bảng Genres
	INSERT INTO Genres (genre_name)
VALUES
    (N'Tiểu thuyết'),
    (N'Phiêu lưu'),
    (N'Tâm lý'),
    (N'Khoa học viễn tưởng'),
    (N'Kinh dị'),
    (N'Huyền bí'),
    (N'Lịch sử'),
    (N'Tiểu sử'),
    (N'Kỳ ảo'),
    (N'Hài hước'),
    (N'Lãng mạn'),
    (N'Khoa học'),
    (N'Thần thoại'),
    (N'Tôn giáo'),
    (N'Học thuật');
-- insert into publisher
INSERT INTO Publishers (publisher_name)
VALUES
    (N'Bloomsbury Publishing'),
    (N'Scholastic Corporation'),
    (N'Hachette Livre'),
    (N'Cambridge University Press'),
    (N'HarperCollins'),
    (N'Penguin Random House'),
    (N'Simon & Schuster'),
    (N'Houghton Mifflin Harcourt'),
    (N'Farrar, Straus and Giroux'),
    (N'Cengage Learning'),
    (N'John Wiley & Sons'),
    (N'Wiley'),
    (N'Macmillan Publishers'),
    (N'Oxford University Press'),
    (N'Pearson Education');
--insert into Discounts 
INSERT INTO Discounts (discount_name, discount_percentage)
VALUES
    (N'Giảm giá mùa hè', 10.00),
    (N'Khuyến mãi Black Friday', 15.00),
    (N'Ưu đãi sinh nhật', 20.00);
-- inset into bảng Customers
INSERT INTO Customers (customer_name, email, phone)
VALUES
    (N'Nguyễn Văn A', N'nguyenvana@example.com', N'1234567890'),
    (N'Trần Thị B', N'tranthib@example.com', N'0987654321'),
    (N'Lê Văn C', N'levanc@example.com', N'0123456789'),
    (N'Phạm Thị D', N'phamthid@example.com', N'0909090909'),
    (N'Hoàng Văn E', N'hoangvane@example.com', N'0999888777'),
    (N'Đặng Thị F', N'dangthif@example.com', N'0808080808'),
    (N'Nguyễn Thanh G', N'nguyenthanhg@example.com', N'0777888999'),
    (N'Lê Thị H', N'lethih@example.com', N'0666777888'),
    (N'Trần Văn I', N'tranvani@example.com', N'0555666777'),
    (N'Phạm Văn K', N'phamvank@example.com', N'0444555666');
-- insert into bảng employees
INSERT INTO Employees (employee_name, position)
VALUES
    (N'Nguyễn Văn A', N'Quản lý'),
    (N'Trần Thị B', N'Nhân viên'),
    (N'Lê Văn C', N'Quản lý'),
    (N'Phạm Thị D', N'Nhân viên'),
    (N'Hoàng Văn E', N'Quản lý');
-- insert into bảng Orders
INSERT INTO Orders (customer_id, employee_id, order_date, payment_method, order_status)
VALUES
    (1, 1, '2024-04-01', N'Thanh toán bằng thẻ', 1),
    (2, 2, '2024-04-02', N'Thanh toán tiền mặt', 1),
    (3, 1, '2024-04-03', N'Thanh toán bằng chuyển khoản', 0),
    (4, 3, '2024-04-04', N'Thanh toán tiền mặt', 0),
    (5, 2, '2024-04-05', N'Thanh toán bằng thẻ',1),
    (6, 1, '2024-04-06', N'Thanh toán tiền mặt', 0),
    (7, 3, '2024-04-07', N'Thanh toán bằng chuyển khoản',1),
    (8, 1, '2024-04-08', N'Thanh toán bằng thẻ', 1),
    (9, 2, '2024-04-09', N'Thanh toán bằng thẻ', 0),
    (10, 3, '2024-04-10', N'Thanh toán bằng chuyển khoản',1);
-- insert into bảng OrderDetails
-- Dữ liệu cho bảng OrderDetails
INSERT INTO OrderDetails (order_id, book_id, price, quantity, subtotal, Notes)
VALUES
    (1, 1, 250000, 2, 500000, N''),
    (2, 3, 150000, 1, 150000, N''),
    (3, 5, 220000, 3, 660000, N''),
    (4, 7, 210000, 1, 210000, N''),
    (5, 9, 170000, 2, 340000, N''),
    (6, 11, 180000, 1, 180000, N''),
    (7, 13, 230000, 2, 460000, N''),
    (8, 15, 250000, 3, 750000, N''),
    (9, 17, 270000, 1, 270000, N''),
    (10, 19, 230000, 2, 460000, N'');
	
	-- insert into bảng Borrowings
INSERT INTO Borrowings (customer_id, borrow_date, return_date_expected, return_date_actual, statsus, notes, employee_id)
VALUES
    (1, '2024-05-01', '2024-05-08', '2024-05-08', N'Đã trả', N'Ghi chú', 2),
    (2, '2024-05-02', '2024-05-09', '2024-05-09', N'Đã trả', N'Ghi chú 2', 3),
    (3, '2024-05-03', '2024-05-10', NULL, N'Đã mượn', N'Ghi chú 3', 1),
    (4, '2024-05-04', '2024-05-11', NULL, N'Đã mượn', N'Ghi chú 4', 2),
    (5, '2024-05-05', '2024-05-12', NULL, N'Đã mượn', N'Ghi chú 5', 3),
    (6, '2024-05-06', '2024-05-13', NULL, N'Đã mượn', N'Ghi chú 6', 1),
    (7, '2024-05-07', '2024-05-14', NULL, N'Đã mượn', N'Ghi chú 7', 2),
    (8, '2024-05-08', '2024-05-15', NULL, N'Đã mượn', N'Ghi chú 8', 3),
    (9, '2024-05-09', '2024-05-16', NULL, N'Đã mượn', N'Ghi chú 9', 1),
    (10, '2024-05-10', '2024-05-17', NULL, N'Đã mượn', N'Ghi chú 10', 2);
-- insert into BorrowingDetails
INSERT INTO BorrowingDetails (borrowing_id, book_id, quantity)
VALUES
    (31, 1, 2),
    (32, 3, 1),
    (33, 5, 3),
    (34, 7, 2),
    (35, 9, 1),
    (36, 11, 2),
    (37, 13, 3), 
    (38, 15, 1),
    (39, 17, 2),
    (40, 19, 1);
	-- insert into nhập bảng suppliers 
	INSERT INTO Suppliers (supplier_name, contact_name, contact_email, contact_phone)
VALUES
    (N'Công ty ABC', N'Nguyễn Văn A', N'nguyenvana@example.com', N'1234567890'),
    (N'Công ty XYZ', N'Trần Thị B', N'tranthib@example.com', N'0987654321'),
    (N'Công ty DEF', N'Lê Văn C', N'levanc@example.com', N'0123456789'),
    (N'Công ty GHI', N'Phạm Thị D', N'phamthid@example.com', N'0909090909'),
    (N'Công ty JKL', N'Hoàng Văn E', N'hoangvane@example.com', N'0999888777'),
    (N'Công ty MNO', N'Đặng Thị F', N'dangthif@example.com', N'0808080808'),
    (N'Công ty PQR', N'Nguyễn Thanh G', N'nguyenthanhg@example.com', N'0777888999'),
    (N'Công ty STU', N'Lê Thị H', N'lethih@example.com', N'0666777888'),
    (N'Công ty VWX', N'Trần Văn I', N'tranvani@example.com', N'0555666777'),
    (N'Công ty YZ', N'Phạm Văn K', N'phamvank@example.com', N'0444555666');
	--insert into nhập bảng SupplierOrders
	INSERT INTO SupplyOrders (supplier_id, purchase_date, total_quantity, total_amount, notes)
VALUES
    (1, '2024-04-01 08:30:00', 100, 5000000.00, N'Phiếu nhập số 1'),
    (2, '2024-04-02 09:15:00', 150, 7000000.00, N'Phiếu nhập số 2'),
    (3, '2024-04-03 10:20:00', 200, 8500000.00, N'Phiếu nhập số 3'),
    (4, '2024-04-04 11:45:00', 120, 6000000.00, N'Phiếu nhập số 4'),
    (5, '2024-04-05 13:00:00', 180, 9000000.00, N'Phiếu nhập số 5'),
    (6, '2024-04-06 14:30:00', 130, 6500000.00, N'Phiếu nhập số 6'),
    (7, '2024-04-07 15:45:00', 160, 8000000.00, N'Phiếu nhập số 7'),
    (8, '2024-04-08 16:20:00', 140, 7200000.00, N'Phiếu nhập số 8'),
    (9, '2024-04-09 17:10:00', 190, 9500000.00, N'Phiếu nhập số 9'),
    (10, '2024-04-10 18:00:00', 170, 8500000.00, N'Phiếu nhập số 10');
	-- insert into nhập bảng SupplierOrderDetails
	INSERT INTO SupplyOrderDetails (supplyOrder_id, book_id, book_quantity, book_price, total_amount)
VALUES
    (1, 1, 50, 25000, 1250000),
    (1, 2, 30, 18000, 750000),
    (2, 3, 40, 15000, 720000),
    (2, 4, 20, 20000, 400000),
    (3, 5, 60, 22000, 1320000),
    (3, 6, 25, 19000, 475000),
    (4, 7, 35, 21000, 735000),
    (4, 8, 45, 24000, 1080000),
    (5, 9, 55, 17000, 935000),
    (5, 10, 15, 20000, 300000);
