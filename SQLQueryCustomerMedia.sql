create database CustomerMedia

go

use CustomerMedia

go

create table KHACHHANG(
	MK varchar(10) primary key ,
	TenK nvarchar(30) not null,
	DChi nvarchar(100),
	SoDT char(11)
)
go

create table BAOCHI(
	MB varchar(10) primary key,
	TenBao nvarchar(30),
	Gia int 
)


create table DATBAO(
	MK varchar(10),
	MB varchar(10),
	NgayDat date,
	SoLuong int,
	constraint PK_MK_MB primary key(MK,MB)
)

alter table DATBAO add constraint FK_MK foreign key (MK) references KHACHHANG(MK)
alter table DATBAO add constraint FK_MB foreign key (MB) references BAOCHI(MB)
alter table KHACHHANG
alter column SoDT nvarchar(15)
INSERT INTO KHACHHANG (MK, TenK, DChi, SoDT)
VALUES
  (1, N'Nguyễn Văn A', N'123 Đường ABC, HCM', '0123 456 789'),
  (2, N'Trần Thị B', N'456 Đường XYZ, Hanoi', '0987 654 321'),
  (3, N'Lê Văn C', N'789 Đường LMN, Da Nang', '0345 678 901'),
  (4, N'Phạm Văn D', N'567 Đường PQR, Binh Duong', '0765 432 109');

  INSERT INTO BAOCHI (MB, TenBao, Gia)
VALUES
  (1, 'Báo A', 5),
  (2, 'Báo B', 4),
  (3, 'Báo C', 6),
  (4, 'Báo D', 3);

  sp_helpconstraint DATBAO
  INSERT INTO DATBAO (MK, MB, NgayDat, SoLuong)
VALUES
  (1, 1, '2023-01-15', 2),
  (1, 2, '2023-01-16', 3),
  (2, 1, '2023-01-15', 1),
  (3, 3, '2023-01-17', 2),
  (4, 2, '2023-01-16', 2);
  /*
	1. cho biết tên và thành tiền đặt mua báo của khách hàng 
	tương ứng với từng ngày đặt

  */
  select KHACHHANG.TenK,(BAOCHI.Gia*DATBAO.SoLuong) as ThanhTien,DATBAO.NgayDat 
  from KHACHHANG,BAOCHI,DATBAO
  where KHACHHANG.MK = DATBAO.MK and BAOCHI.MB = DATBAO.MB 

  SELECT KHACHHANG.TenK, (BAOCHI.Gia * DATBAO.SoLuong) AS ThanhTien, DATBAO.NgayDat
FROM KHACHHANG
INNER JOIN DATBAO ON KHACHHANG.MK = DATBAO.MK
INNER JOIN BAOCHI ON BAOCHI.MB = DATBAO.MB;

  /*
	2. cho biết họ tên - địa chỉ của khách hàng 
	đặt mua báo có tên nhân dân trong năm 2023
  */
  select KHACHHANG.TenK, KHACHHANG.DChi
  from KHACHHANG,BAOCHI,DATBAO
  where KHACHHANG.MK = DATBAO.MK and BAOCHI.MB = DATBAO.MB and BAOCHI.TenBao like 'Báo A';


  SELECT KHACHHANG.TenK, KHACHHANG.DChi
FROM KHACHHANG
INNER JOIN DATBAO ON KHACHHANG.MK = DATBAO.MK
INNER JOIN BAOCHI ON BAOCHI.MB = DATBAO.MB
WHERE BAOCHI.TenBao = 'Báo A' AND DATBAO.NgayDat BETWEEN '2023-01-01' AND '2023-12-31';
    /*
	 3. Thông tin về các loại báo khách hàng đã đặt mua trong năm 2000
  */
 select KHACHHANG.TenK,KHACHHANG.DChi, BAOCHI.MB,BAOCHI.TenBao, DATBAO.SoLuong
  from KHACHHANG,BAOCHI,DATBAO
  where KHACHHANG.MK = DATBAO.MK and BAOCHI.MB = DATBAO.MB and DATBAO.NgayDat between '2023-01-16' and '2023-01-17';


  SELECT KHACHHANG.TenK, KHACHHANG.DChi, BAOCHI.MB, BAOCHI.TenBao, DATBAO.SoLuong
FROM KHACHHANG
INNER JOIN DATBAO ON KHACHHANG.MK = DATBAO.MK
INNER JOIN BAOCHI ON BAOCHI.MB = DATBAO.MB
WHERE DATBAO.NgayDat BETWEEN '2023-01-16' AND '2023-01-17';
  /*
	4. Thông tín của báo chí có giá đắt nhất 
  */
  select *
  from BAOCHI
  where BAOCHI.Gia = (select MAx(BAOCHI.Gia) from BAOCHI)

  select count(SoLuong) from KHACHHANG
 select DATBAO.MK, COUNT(DATBAO.SoLuong) as SoLuongDat
 from DATBAO
 group by DATBAO.MK
 having COUNT(DATBAO.SoLuong)>=2