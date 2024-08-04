use qlsv

go

create table Sinhvien(
	Masv int primary key identity(1,1),
	Tensv nvarchar(50) not null,
	Gioitinh nvarchar(25) default('Nam'),
	Ngaysinh date check(Ngaysinh<getdate()),
	Que nvarchar not null,
	lop nvarchar 
	)

go 
create table Monhoc(
	Mamh int primary key identity(1,1),
	Tenmh nvarchar(50) unique,
	DVHT int check (DVHT>=2 and DVHT<=9)
	)

create table Ketqua(
	Masv int,
	Mamh int,
	Diem float check(Diem between 0 and 10),
	constraint RB_Khoa primary key (Masv,Mamh)-- ??nh ngh?a khóa có hai thu?c tính
	)
-- chèn thêm 1 c?t
alter table Sinhvien add Dienthoai nvarchar(11),
			CMTND nvarchar(40)
-- thay ??i ki?u d? li?u c?a c?t 
alter table Sinhvien 
alter column CMTND int not null

-- thêm rang bu?c 
alter table Monhoc add constraint RB_TenMH unique(Tenmh)

-- xóa c?t 
alter table Sinhvien
drop column CMTND, Dienthoai

-- xóa ràng bu?c 
alter table Monhoc
drop constraint RB_Tenmh

-- b?t ràng bu?c 
alter table Monhoc
nocheck constraint all --ten_constraint,
-- t?t ràng bu?c 
alter table Monhoc check constraint  all -- ten_constraint
-- t?o liên k?t gi?a các b?ng ( t?o ràng bu?c khóa ngo?i)
--canh 2: hay dùng nen s? d?ng

alter table Ketqua add constraint FK_Masv foreign key (Masv) references Sinhvien(Masv)
alter table Ketqua add constraint FK_Mamh foreign key (Mamh) references Monhoc(Mamh)

-- chú ý: sau khi t?o liên k?t khóa ngo?i , mu?n xóa các b?ng có trong liên k?t ta ph?i th?c hi?n l?nh xóa 
-- khóa ngoaij tr??c. 
alter table Ketqua drop constraint FK_Masv,FK_Mamh
-- t?o ch? m?c index:
		-- index là ch? m?c quan tr?ng trong csdl ??c bi?t v?i csdl l?n 
		-- index có th? thi?t l?p cho 1 ho?c nhi?u c?t c?a b?ng
		-- index ???c s?p x?p nh?m h? tr? vi?c tìm ki?m , truy v?n d? li?u m?t cách nhanh chóng.
create index ID_MASV on Sinhvien (Masv)
select * from Sinhvien
-- xóa index
drop index ID_MASV;

--Hàm kết hợp 
/*
	+ được sử dụng để tính giá trị thống kê trên toàn bảng hoặc trên mỗi nhóm dữ liệu
	+ các hàm cơ bản:
		- sum([all|distinct] biểu thức),Avg( [All | Distinct] biểu-thức)
		- Count( [All | Distinct] biểu-thức) : đếm số dòng khác Null
			trong cột, biểu thức.
		- Count(*) : đếm số dòng được chọn trong bảng, kể cả Null
		- Max( biểu-thức ), Min( biểu-thức )
	+ các hàm thực hiện tính toán trên toàn bộ dữ liệu, bỏ bớt giá trị trùng nhau thêm từ distinct
	*/

-- mệnh đề group by
/*
	Nhận xét 
	 Thứ tự thực hiện câu truy vấn có mệnh đề GROUP
BY và HAVING
- (1) Chọn ra những dòng thỏa điều kiện trong
mệnh đề WHERE
- (2) Những dòng này sẽ được gom thành nhiều
nhóm tương ứng với mệnh đề GROUP BY
- (3) Áp dụng các hàm kết hợp cho mỗi nhóm
- (4) Bỏ qua những nhóm không thỏa điều kiện
trong mệnh đề HAVING
- (5) Rút trích các giá trị của các cột và hàm kết hợp
trong mệnh đề SELEC
*/




-- mệnh đề order by
-- hiển thị kết quả câu truy vấn theo một thứ tự nào đso trên các cột 
-- cú pháp order by <thuốc tính sắp xếp> [Asc|Desc]
/*	- ASC (ASCending): tăng (mặc định)
	- DESC (DESCending): giảm */

/*Nối bảng với INNER|LEFT|RIGHT|FULL JOIN 
	 INNER JOIN/JOIN: trả về các dòng của hai bảng thỏa
	mãn điều kiện nối
	 LEFT JOIN: trả về các dòng của bảng thứ nhất dù ở
	bảng 2 không thỏa mãn điều kiện nối. Nếu dữ liệu có ở
	bảng 1 không có ở bảng 2 vẫn hiển thị
	 RIGHT JOIN: trả về các dòng của bảng2 dù ở bảng 1
	không thỏa mãn điều kiện nối. Nếu dữ liệu có ở bảng 2
	không có ở bảng 1 vẫn hiển thị.
	 FULL JOIN: trả về các dòng của hai bảng, nếu không có
	dữ liệu thỏa mãn điều kiện thì gán bằng NULL.

	Cú Pháp :	SELECT columns
				FROM table1
				INNER JOIN table2 ON table1.column = table2.column;
*/

	-- Truy vấn trên nhiều bảng 
	/*
		- là thực hiện lồng ghép nhiều câu lệnh select với nhau 
		- câu truy vấn con thường trả về một tập các giá trị 
		- các câu truy vấn con trong cùng một mệnh đề where được kết hợp bằng ghép nối logics 
			với mệnh đề where của câu truy vấn cha:
			- <Biểu thức> <so sách tập hợp> <truy vấn con>
			- so sách tập hợp thường đi cùng với một số toán tử 
				- in ,not in
				- all
				- any, some
			- Kiểm tra sự tồn tại 
				- exists
				- not exists
	*/


	-- Phép toán tập hợp 
	/*
		- Gồm 
			+ union (Hợp)
			+ intersect (giao)
			+ except (trừ)
	*/


	-- Một số hàm trong SQL

/*
	+ các hàm tập hợp 
	+ hàm chuyển đổi kiểu dữ liệu
	+ hàm ngày tháng
	+ hàm toán học
	+ hàm sử lý chuỗi
*/


-- Hàm tính gộp
/*
	+ SUM(col_name)
	+ AVG(col_name)
	+ COUNT(col_name)|COUNT(*)
	+ MAX(col_name)
	+ MIN(col_name)
*/
-- Hàm toán học
/*
	+ ABS(num_expr)// tính trị tuyệt đối
	+ power(num_expr,y) // hàm tính số mũ
	+ round(num_expr,length) // hàm làm tròn
	+ sqrt(float_expr) // hàm tính căn
*/

-- Hàm ngày tháng
/*
	Được dùng để thao tác giá trị ngày tháng
	gồm:
		- GeTDATE() // trả về ngày và giờ hiện tại theo mũi h của hệ thống hoạt động
		- Day(date),Month(date),Year(date)// 
		- DateDiff(datepart,number,date) //tính toán sự khác biệt giữa hai giá trị ngày thời gian và trả về kết quả dưới dạng số nguyên
		- DateADD(datepart,number,date) // Hàm DATEADD(datepart, number, date) thực hiện phép cộng số lượng cụ thể (number) vào một giá trị ngày (date) dựa trên datepart 
		- Datename(datepart,date)//Hàm DATENAME(datepart, date) trả về tên của một phần cụ thể của giá trị ngày thời gian (date).
		- Datepart(datepart,date)//trả về giá trị số nguyên của một phần cụ thể của giá trị ngày thời gian (date).

		Đơn vị thời gian	Ký hiệu		Values
		Hour				hh			0-23
		Minute				Mi, n		0-59
		Second				Ss, s		0-59
		Day of Year			Dy, y		1-366
		Day					Dd, d		1-31
		Week				Wk, www		1-53
		Month				Mm, m		1-12
		Quarter				Qq, q		1-4
		Year				Yy, yyyy	1753-9999
*/

-- Hàm xử lý chuỗi

/*
	- Dùng để tách, thay thế và tương tác với chuỗi ký tự
	- Gồm: 
		+ LEFT(String,number),RIGHT(String,number)
		+ lower(String),UPPER(string)
		+ LTRIM(string),RTRIM(string)
		+ LEN(String)
*/