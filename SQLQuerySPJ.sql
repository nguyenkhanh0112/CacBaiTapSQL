create database SPJ
go 
use SPJ
go 

create table NCC(
	MaNCC char(5) primary key ,
	Ten varchar(40) ,
	Heso int default(0) check(Heso between 0 and 100),
	ThPho varchar(20),
	)
	go

create table VATTU(
	MaVT char(5) primary key,
	Ten varchar(40) not null,
	Mau varchar(15) unique,
	TrLuong float check(TrLuong <= 2.0)
	)

	go

create table DUAN(
	MaDA char(5) primary key,
	Ten varchar(40) not null,
	ThPho varchar(20) not null
	)
	go
create table CC(
	MaNCC char(5),
	MaVT char(5),
	MaDA char(5),
	SoLuong int,
	constraint PK_Khoa primary key (MaNCC,MAVT,MaDA)
	)
	go 
	alter table CC add constraint FK_MaNCC foreign key (MaNCC) references NCC(MaNCC)
	alter table CC add constraint FK_MaNCC foreign key (MaVT)  references VATTU(MaVT)
	alter table CC add constraint FK_MaDA foreign key (MaDA) references DUAN(MaDA)

	go 
	create index id_MaNCC on NCC(MaNCC)
	create index id_MaVT on VATTU(MaVT)
	create index id_MaDA on DUAN(MaDA)
	create index id_CC_MaNCC_MaVT_MaDA on CC(MaNCC,MaVT,MaDA)

	go 
	-- xem thông tin các bảng 
	sp_help NCC
	sp_help VATTU
	sp_help DUAN
	sp_help CC

	go
	-- đổi tên bảng 
	exec sp_rename "NCC", "NhaCC"
	exec sp_rename "CC", "CungCap"
	go
	-- thêm cột 
	alter table VATTU add  ThPho nvarchar(20) default (N'Hà Nội') not null
	alter table DUAN  add  DiaDiem nText default(N'Hà Nội')

	-- bổ sung ràng buộc 
	alter table VATTU add constraint RB_Mau check(Mau IN ('Xanh', 'Đỏ', 'Tím', 'Vàng', 'Trắng', 'Đen'))
	alter table VATTU add constraint RB_ThPho unique(ThPho)

	-- đổi tên 
	exec sp_rename 'DUAN.DiaDiem', 'DD', 'column'
	
	-- hủy bỏ rnagf buộc 
	sp_helpconstraint VATTU
	alter table VATTU
	drop constraint DF__VATTU__ThPho__59063A47
	select * from DUAN

	sp_helpconstraint VATTU
	alter table VATTU
	drop constraint UQ__VATTU__C7977BC2A50D9A40
	alter table VATTU
	drop constraint RB_ThPho
	-- xóa cột 
	sp_helpconstraint DUAN
	alter table DUAN drop constraint DF__DUAN__DiaDiem__59FA5E80
	alter table DUAN
	drop column DD

select * from NhaCC
select * from DUAN
sp_rename 'NhaCC','NCC'
sp_rename 'CungCap','CC'


insert into NCC (MaNCC,Ten,Heso,ThPho) values 
	('S1','Son',20,'TpHCM'),
	('S2','Tran',10,'Ha Noi'),
	('S3','Bach',30,'Ha Noi'),
	('S4','Lap',20,'TpHCM'),
	('S5','Anh',30,'Da Nang');
insert into DUAN (MaDA,Ten,ThPho) values ('J1','May phan loai','Ha Noi'),
										 ('J2','Man Hinh','Viet Tri'),
										 ('J3','OCR','Da Nang'),
										 ('J4','Bang dieu khien','Da Nang'),
										 ('J5','RAID','TpHCM'),
										 ('J6','EDS','Hai Phong'),
										 ('J7','Bang tu','TpHCM');
insert into VATTU (MaVT,Ten,Mau,TrLuong,ThPho) values 
										('P1','Dai oc','Do',12.0,'TpHCM'),
										('P2','Bu long','Xanh la',17.0,'TpHCM'),
										('P3','Dinh vit','Xanh duong',17.0,'Hai Phong'),
										('P4','Dinh vit','Do',14.0,'TpHCM'),
										('P5','Cam','Xanh duong',12.0,'TpHCM'),
										('P6','Banh rang','Do',19.0,'TpHCM');
										

select * from VATTU
sp_help VATTU

insert into CC (MaNCC,MaVT,MaDA,SoLuong) values 
												('S1','P1','J1',200),('S1','P1','J4',700),('S2','P3','J1',400),
												('S2','P3','J2',200),('S2','P3','J3',200),('S2','P3','J4',500),
												('S2','P3','J5',600),('S2','P3','J6',400),('S2','P3','J7',800),
												('S2','P5','J2',100),('S3','P3','J1',200),('S3','P4','J2',500),
												('S4','P6','J3',300),('S4','P6','J7',300),('S5','P2','J2',200),
												('S5','P2','J4',100),('S5','P5','J5',500),('S5','P5','J7',100),
												('S5','P6','J2',200),('S5','P1','J4',100),('S5','P3','J4',200),
												('S5','P4','J4',800),('S5','P5','J4',400),('S5','P6','J4',500);
-- 1 cho biết màu và thành phố của các vật tư không được lưu trữ tại hà nội và có trong lượng lớn hơn 10
use SPJ
go
select * from VATTU

select Mau,ThPho from VATTU
where ThPho not like 'Ha Noi' and TrLuong>10


update VATTU set ThPho = 'Ha Noi'
where MaVT = 'P5' or MaVT ='P2'

--2 cho biết thông tin chi tiết về các dự án  ở TPHCM

select * from DUAN 
where ThPho like '%TpHCM%'

-- 3. cho biết tên nhà cung cấp vật tư cho dự án j1
select NCC.Ten 
from NCC
where MaNCC in (select CC.MaNCC 
				from CC
				where CC.MaDA = 'J1');

-- 4 cho biết tên nhà CC , Ten VT , Ten DA , mà số lượng vật tư được cung cấp cho dự án 
-- bởi nhà cung cấp lớn hơn 300 và nhỏ hơn 750
select NCC.Ten,VATTU.Ten,DUAN.Ten
from NCC,VATTU,DUAN,CC
where NCC.MaNCC=CC.MaNCC and VATTU.MaVT = CC.MaVT and DUAN.MaDA = CC.MaDA and CC.SoLuong between 300 and 750

-- 5 cho biết mã số các vật tư được cung cấp cho các dự án tại TPHCM bởi các nhà cung cấp TpHCM
select * from VATTU
select * from DUAN

select VATTU.MaVT,DUAN.ThPho,NCC.ThPho from VATTU,DUAN,CC,NCC
where VATTU.MaVT = CC.MaVT and DUAN.MaDA = CC.MaDA and DUAN.ThPho ='TpHCM' and NCC.ThPho='TpHCM';

-- 6 liệt kê các cặp tên thành phố mà: 
-- nhà cung cấp ở thành phố thứ nhất
-- nhà cung cấp cung cấp vật tư được lưu trữ tại thành phố thứ 2 

select  NCC1.ThPho as ThanhPhoNCC1, NCC2.ThPho as ThanhPhoNCC2 
from NCC as NCC1, NCC as NCC2,CC,VATTU,DUAN
where	NCC1.MaNCC = CC.MaNCC
		and VATTU.MaVT = CC.MaVT
		and DUAN.MaDA = CC.MaDA
		and NCC2.ThPho = VATTU.ThPho
		and NCC1.ThPho <> NCC2.ThPho 

--7. Liệt kê các cặp mã số nhà cung cấp ở cùng một thành phố 

select	NCC1.MaNCC as MASONCC1, NCC2.MaNCC as MASONCC2
from	NCC as NCC1,NCC as NCC2
where	NCC1.ThPho = NCC2.ThPho
		and NCC1.MaNCC <= NCC2.MaNCC
	
-- 8 cho biết mã số và tên các vật tư được cung cấp cho dự án cùng thành phố với nhà cung cấp
select VATTU.MaVT , VATTU.Ten
from NCC,CC,DUAN,VATTU
where NCC.MaNCC = CC.MaNCC and CC.MaDA = DUAN.MaDA and VATTU.MaVT = CC.MaVT and NCC.ThPho = DUAN.ThPho


-- 9. cho biết mã số và tên các vật tư được cung cấp vật tư bởi ít nhất một nhà cung cấp không cùng thành phố 

select MaVT,Ten,ThPho from VATTU
where VATTU.MaVT in 
				(select MaVT 
				 from CC,NCC
				 where NCC.MaNCC = CC.MaNCC 
				 and NCC.ThPho <>	(select DUAN.ThPho
														from DUAN 
														where DUAN.MaDA = CC.MaDA));
-- 10.Cho biết mã số nhà cung cấp và cặp mã số vật tư được cung cấp bởi nhà cung
-- cấp này.
select NCC.MaNCC,COUNT(CC.MaVT) as CacCapMaVT
from NCC,CC
where NCC.MaNCC = CC.MaNCC
group by NCC.MaNCC



SELECT NCC.MaNCC, STRING_AGG(CC.MaVT, ',') AS CacCapMaVT
FROM NCC
INNER JOIN CC ON NCC.MaNCC = CC.MaNCC
GROUP BY NCC.MaNCC;
select * from CC
