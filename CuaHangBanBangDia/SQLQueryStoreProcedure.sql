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
	insert into CTTHUEDIA(sophieuthue,madia,soluong,giathue) values (@sophieuthue,@madiathue,@soluongthue,(select giathue from DIA where madia = @madiathue))
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
	select CTTHUEDIA.sophieuthue, CTTHUEDIA.madia, DIA.tendia, CTTHUEDIA.soluong, CTTHUEDIA.giathue
	from CTTHUEDIA 
		inner join PHIEUTHUE on CTTHUEDIA.sophieuthue = PHIEUTHUE.sophieuthue
		INNER join DIA on CTTHUEDIA.madia = DIA.madia
		where PHIEUTHUE.makh = @makh
end;

-- Viết Stored Procedure để lấy thông tin của tất cả các đĩa có giá thuê dưới một giá cụ thể
create procedure sp_LayTongTinCuaTatCaCacDia
	@giathue float
as
begin 
	select CTTHUEDIA.sophieuthue,CTTHUEDIA.madia,DIA.tendia,CTTHUEDIA.soluong, CTTHUEDIA.giathue
	from CTTHUEDIA inner join PHIEUTHUE on CTTHUEDIA.sophieuthue = PHIEUTHUE.sophieuthue
		inner join DIA on DIA.madia = CTTHUEDIA.madia
		where CTTHUEDIA.giathue < @giathue
end;
