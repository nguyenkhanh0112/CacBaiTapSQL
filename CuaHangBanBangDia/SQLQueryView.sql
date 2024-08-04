use QuanLyCuaHangBanBangDia
update DIA set soluong = 3 where madia='DVD7'
update DIA set soluong = 2 where madia='DVD6'
select * from DIA
go 
    EXEC sp_rename 'THELOAI', 'NEW_THELOAI';
	exec sp_rename 'THUEDIA','CTTHUEDIA'
	exec sp_rename 'TRADIA','CTTRADIA'
	exec sp_rename 'BANDIA','CTBANDIA'
	EXEC sp_rename 'NHAPDIA', 'CTNHAPDIA';
	-- hien thi thong tin cua tat ca cac dia trong csdl
	create view ThonTinDia_view
	as
	select * from DIA
	select * from ThonTinDia_view

-- dem so luong dia thuoc moi the loai và sap xep tat ca ket qua theo so luong tang dan 
create view Soluongdiatheotheloai_view
as
select THELOAI.matheloai,THELOAI.tentheloai , COUNT(madia)as soluongdia
from THELOAI inner join DIA on THELOAI.matheloai = DIA.matheloai
group by THELOAI.matheloai,THELOAI.tentheloai




-- ??m s? l??ng ??a còn trong kho (ch?a ???c thuê).
CREATE VIEW SoLuongDiaConTrongKho 
	AS
	SELECT COUNT(*) AS SoLuongConTrongKho
	FROM DIA
	WHERE madia NOT IN (SELECT DISTINCT madia FROM PHIEUTHUE);
SELECT * FROM SoLuongDiaConTrongKho;

-- ??m s? l??ng ??a thuê theo tháng trong n?m 2022.
CREATE VIEW SoLuongThueTheoThang 
	AS
	SELECT MONTH(ngaythue)AS Thang, COUNT(madia) AS SoLuongThue
	FROM PHIEUTHUE
	WHERE YEAR(ngaythue) = 2022
	GROUP BY MONTH(NgayThue);
SELECT * FROM SoLuongThueTheoThang;

--??m s? l?n thuê,s? l?n bán c?a t?ng lo?i ??a.
CREATE VIEW THONGKE_DIA_VIEW AS
	SELECT madia,tendia,
    (SELECT COUNT(*) FROM PHIEUTHUE WHERE DIA.madia = PHIEUTHUE.madia) AS solanthue,
    (SELECT COUNT(*) FROM PHIEUBAN WHERE DIA.madia = PHIEUBAN.madia) AS solanban
	FROM DIA;
SELECT * FROM THONGKE_DIA_VIEW;

--??m s? l?n thuê c?a khách hàng.
CREATE VIEW DANHSACH_KHACHHANG_VIEW AS
	SELECT makh,tenkh,
    (SELECT COUNT(*) FROM PHIEUTHUE WHERE KHACHHANG.makh = PHIEUTHUE.makh) AS solanthue
	FROM KHACHHANG;
SELECT * FROM DANHSACH_KHACHHANG_VIEW;

--??a có giá bán l?n h?n 10 000 000.
CREATE VIEW DIA_GIABAN_HON_10M_VIEW AS
	SELECT DIA.madia,DIA.tendia,DIA.giaban
	FROM DIA
	WHERE DIA.giaban > 10000000;
SELECT * FROM DIA_GIABAN_HON_10M_VIEW;

--BÀI T?P TH?NG KÊ
SELECT 
    MONTH(ngayban) AS Thang,
    YEAR(ngayban) AS Nam,
    SUM(giaban * soluong) AS TongDoanhThu
FROM 
    PHIEUBAN pb
JOIN 
    CTBANDIA ctb ON pb.sophieuban = ctb.sophieuban
where YEAR(ngayban) = '2023'
GROUP BY 
    MONTH(ngayban), YEAR(ngayban)
ORDER BY 
    Nam, Thang;


--Tính t?ng giá tr? c?a các ??a có trong m?i lo?i:
SELECT THELOAI.tentheloai, SUM(DIA.giaban * DIA.soluong) AS TongGiaTri
FROM DIA
JOIN THELOAI ON DIA.matheloai = THELOAI.matheloai
GROUP BY THELOAI.tentheloai;
--Hi?n th? thông tin các ??a ???c thuê b?i m?t khách hàng c? th?:
SELECT PHIEUTHUE.*, THUEDIA.*, DIA.tendia
FROM PHIEUTHUE
JOIN THUEDIA ON PHIEUTHUE.sophieuthue = THUEDIA.sophieuthue
JOIN DIA ON THUEDIA.madia = DIA.madia
WHERE PHIEUTHUE.makh = 'KH001';
--Tính t?ng doanh thu t? vi?c cho thuê ??a trong m?t kho?ng th?i gian:
SELECT SUM(DIA.giathue) AS TongDoanhThu
FROM PHIEUTHUE
JOIN THUEDIA ON PHIEUTHUE.sophieuthue = THUEDIA.sophieuthue
JOIN DIA ON THUEDIA.madia = DIA.madia
WHERE PHIEUTHUE.ngaythue BETWEEN '2018-01-01' AND '2022-12-31';
--Tính t?ng s? ??a ???c bán theo t?ng th? lo?i:
SELECT THELOAI.tentheloai, SUM(BANDIA.soluong) AS TongSoLuongBan
FROM THELOAI
JOIN DIA ON THELOAI.matheloai = DIA.matheloai
JOIN BANDIA ON DIA.madia = BANDIA.madia
GROUP BY THELOAI.tentheloai;
--Li?t kê tên và giá thuê c?a các ??a có giá thuê d??i 1 tri?u.
SELECT TENDIA, GIATHUE
FROM DIA
WHERE GIATHUE < 1000000;
SELECT TOP 10 tendia, giathue
FROM DIA
ORDER BY giathue DESC;
--??m s? l??ng ??a thuê theo ngày trong tháng 5, 2023.
SELECT
  ngaythue,
  COUNT(*) AS S?_L??ng_??a_Thuê
FROM
  PHIEUTHUE
WHERE
  MONTH(ngaythue) = 8 AND YEAR(ngaythue) = 2021
GROUP BY
  ngaythue;

SELECT
  tentheloai,
  tendia,
  giaban
FROM (
  SELECT
    tentheloai,
	tendia,
	giaban,
    ROW_NUMBER() OVER (PARTITION BY tentheloai ORDER BY giaban DESC) AS rnk
  FROM
    DIA,THELOAI
) AS ranked
WHERE
  rnk = 1;
	-- câu h?i v? Srored procedures:

-- t?o m?t stored procedure ?? thêm m?t ??a m?i vào csdl 
create procedure sp_DIA_Insert 
	@madia nvarchar(10),@tendia nvarchar(100),
	@matheloai nvarchar(10),@soluong int,@giathue float,@giaban float
as
begin
	insert into DIA(madia,tendia,matheloai,soluong,giathue,giaban) 
	values (@madia,@tendia,@matheloai,@soluong,@giathue,@giaban)
end;

--t?o m?t stored procedure s?a môt dia trong csdl 
create procedure sp_DIA_Update
	@madia nvarchar(10),@tendia nvarchar(100),
	@matheloai nvarchar(10),@soluong int,@giathue float,@giaban float
as
begin
	update DIA 
	set madia = @madia,tendia = @tendia,matheloai = @matheloai,soluong = @soluong,giathue = @giathue,giaban = @giaban
end;

--t?o m?t stored procedure xóa môt dia trong csdl 
create procedure sp_DIA_Delete
	@madia nvarchar(10)
as
begin
	delete from DIA where madia = @madia
end;

-- t?o m?t stored procedure tim kiem 1 dia trong csdl
create procedure sp_DIA_SelectOne
	@madia nvarchar(10)
as
begin 
	select * from DIA where madia = @madia
end;

create procedure sp_DIA_SelectAll
as
begin 
	select * from DIA
end;
select * from PHIEUTHUE

-- T?o Stored Procedure ?? c?p nh?t s? l??ng c?a m?t ??a sau khi khách hàng thuê.
create procedure sp_Update_SoLuongDiaSauThue
	@sophieuthue nvarchar(10),
	@madiathue nvarchar(10),
	@soluongthue int,
	@makhthue nvarchar(10)
as
begin 
	-- c?p nh?p s? l??ng ??a sau khi khách hàng thue
	update DIA set soluong = soluong - @soluongthue where madia =@madiathue 
	-- thêm thông tin vào b?ng phi?u thuê
	insert into PHIEUTHUE(sophieuthue,ngaythue,madia,makh) values(@sophieuthue,GETDATE(),@madiathue,@makhthue)
	-- thêm thông tin vào  b?ng CTTHUEDIA
	insert into THUEDIA(sophieuthue,madia,soluong,giathue) values (@sophieuthue,@madiathue,@soluongthue,(select giathue from DIA where madia = @madiathue))
end;
select * from PHIEUTHUE

-- t?o stored procedure ?? tính t?ng s? l??ng ??a trong trong m?t th? lo?i 
create procedure sp_Sum_DiaTrongMotTheLoai
	@matheloai nvarchar(10)
as
begin
	select THELOAI.tentheloai,THELOAI.matheloai,SUM(soluong)
	from DIA inner join THELOAI on DIA.matheloai = THELOAI.matheloai
	where THELOAI.matheloai = @matheloai
	group by THELOAI.tentheloai,THELOAI.matheloai
end;

-- t?o stored procedure ?? l?y danh sách các ??a ???c thuê b?i m?t khách hàng 
create procedure sp_DanhSachDiaDuocThueBoiMotKH
	@makh nvarchar(10)
as
begin 
	select THUEDIA.sophieuthue, THUEDIA.madia, DIA.tendia, THUEDIA.soluong, THUEDIA.giathue
	from THUEDIA 
		inner join PHIEUTHUE on THUEDIA.sophieuthue = PHIEUTHUE.sophieuthue
		INNER join DIA on THUEDIA.madia = DIA.madia
		where PHIEUTHUE.makh = @makh
end;

