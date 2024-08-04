create database TMB

go 

use TMB

go 

create table CHUYENBAY(
	MaCB char(5) primary key,
	GaDi varchar(50) not null,
	GaDen varchar(50) not null,
	DoDai int,
	GioDi time,
	GioDen time,
	ChiPhi int
	)
go
sp_help CHUYENBAY
create table MAYBAY(
	MaMB int primary key,
	Hieu varchar(50),
	TamBay int
	)
go 
create table NHANVIEN(
	MaNV char(9) primary key,
	Ten varchar(50) not null,
	Luong int 
	)
go
create table CHUNGNHAN(
	MaNV char(9),
	MaMB int
	constraint FK_KHOA primary key(MaNV,MaMB)
	)

alter table CHUNGNHAN add constraint FK_MaNV foreign key (MaNV) references NHANVIEN(MaNV)
alter table CHUNGNHAN add constraint FK_MaMB foreign key (MaMB) references MAYBAY(MaMB)
select * from CHUYENBAY
insert into CHUYENBAY (MaCB,GaDi,GaDen,DoDai,GioDi,GioDen,ChiPhi) values('VN431','SGN','CAH',3693,'05:55','06:55',236),
																		('VN320','SGN','DAD',2798,'06:00','07:10',221),
																		('VN464','SGN','DLI',2002,'07:20','08:05',225),
																		('VN216','SGN','DIN',4170,'10:30','14:20',262),
																		('VN280','SGN','HPH',11979,'06:00','08:00',1279),
																		('VN254','SGN','HUI',8765,'18:40','20:00',781),
																		('VN338','SGN','BMV',4081,'15:25','16:25',375),
																		('VN440','SGN','BMV',4081,'18:30','19:30',426),
																		('VN651','BAD','SGN',2798,'19:30','08:00',221),
																		('VN276','BAD','CXR',1283,'09:00','12:00',203),
																		('VN374','HAN','VII',510,'11:40','13:25',120),
																		('VN375','VII','CXR',752,'14:15','16:00',181),
																		('VN269','HAN','CXR',1262,'14:10','15:50',202),
																		('VN315','HAN','DAD',134,'11:45','13:00',112),
																		('VN317','HAN','UIH',827,'15:00','16:15',190),
																		('VN741','HAN','PXU',395,'06:30','08:30',120),
																		('VN474','PXU','PQC',1586,'08:40','11:20',102),
																		('VN476','UIH','PQC',485,'09:15','11:55',117);
exec sp_rename 'MAYBAY.Hieu','Loai','column'

insert into MAYBAY (MaMB,Loai,TamBay) values(747,'Boeing 747-400',13488),
											(737,'Boeing 737-800',5413),
											(340,'Airbus A340-300',11392),
											(757,'Boeing 757-300',6416),
											(777,'Boeing 777-300',10306),
											(767,'Boeing 767-400ER',10306),
											(320,'Airbus A320',4168),
											(319,'Airbus A319',2888),
											(727,'Boeing 727',2406),
											(154,'Tupolev 154',6565);
											select * from CHUNGNHAN
insert into NHANVIEN(MaNV,Ten,Luong) values ('242518965','Tran Van Son',120433),
											('141582651','Doan Thi Mai',178345),
											('011564812','Ton Van Quy',153972),
											('567354612','Quan Cam Ly',256481),
											('552455318','La Que',101745),
											('550156548','Nguyen Thi Cam',205187),
											('390487451','Le Van Luat',212156),
											('274878974','Mai Quoc Minh',99890),
											('254099823','Nguyen Thi Quynh',24450),
											('356187925','Nguyen Vinh Bao',44740),
											('355548984','Tran Thi Hoai An',212156),
											('310454876','Ta Van Do',212156),
											('489456522','Nguyen Thi Quy Linh',127986),
											('489221823','Bui Quoc Chinh',23980),
											('548977562','Le Van Quy ',84476),
											('310454877','Tran Van Hao',33546),
											('142519864','Nguyen Thi Xuan Dao',227489),
											('269734834','Truong Tuan Anh',289950),
											('287321212','Duong Van Minh',48090),
											('552455348','Bui Thi Dung',92013),
											('248965255','Tran Thi Ba',43723),
											('159542516','Le Van Ky',48250),
											('348121549','Nguyen Van Thanh',32899),
											('574489457','Bui Van Lap',20);

	insert into CHUNGNHAN(MaNV,MaMB) values ('567354612',747),
											('567354612',737),
											('567354612',757),
											('567354612',777),
											('567354612',767),
											('567354612',727),
											('567354612',340),
											('552455318',737),
											('552455318',319),
											('552455318',747),
											('552455318',767),
											('390487451',340),('390487451',320),('390487451',319),
											('274878974',757),('274878974',767),
											('355548984',154),
											('310454876',154),
											('142519864',747),('142519864',757),('142519864',777),
											('142519864',767),('142519864',737),('142519864',340),('142519864',320),
											('269734834',747),('269734834',737),('269734834',340),('269734834',757),
											('269734834',777),('269734834',767),('269734834',320),('269734834',319),
											('269734834',727),('269734834',154),
											('242518965',737),('242518965',757),
											('141582651',737),('141582651',757),('141582651',767),
											('011564812',737),('011564812',757),
											('574489457',154);
-- Truy vẫn dữ liệu
-- Bài 1 Mở CSDL QLMB, Thực hiện các truy vấn sau bằng SQL
-- 1 cho biết thông tin về các chuyến bay đi Đà Lạt (DAD)
go 

select * 
from CHUYENBAY
where GaDen like 'DAD'

-- 2 cho biết thông tin về các loại máy bay có tầm bay lớn hơn 10.000 km
select * 
from MAYBAY
where TamBay > 10000

-- 3 cho biết thông tin về các nhân viên có lương nhỏ hơn 10000
select * 
from NHANVIEN
where Luong < 10000

-- 4 cho biết thông tin về các chuyến bay có độ dài đường bay nhỏ hơn 10.000km và lớn hơn 8.000km
select *
from CHUYENBAY
where DoDai between 8000 and 10000

-- 5 cho biết thông tin về các chuyến bay xuất phát từ sài gòn (SGN) đi Buôn Mê Thuột (BMV)

select * 
from CHUYENBAY
where GaDi like 'SGN' and GaDen like 'BMV'

-- 6 có bao nhiêu chuyến bay xuất phát từ sài gòn (SGN)
select count(*) as SoChuyenBayXuatPhatTuSaiGon
from CHUYENBAY
where GaDi like 'SGN'

-- 7 có bao nhiêu loại máy bay boeing
select count(*) as SoLoaiMayBayBoeing
from MAYBAY
where Loai like 'Boeing%'

-- 8 cho biết tổng số lương phải trả cho nhân viên 
select SUM(Luong) as TongSoLuongPhaiTraChoNV
from NHANVIEN

-- 9 cho biết mã số và tên của các phi công lái máy bay boeing
select distinct NHANVIEN.MaNV , Ten
from MAYBAY,NHANVIEN,CHUNGNHAN
where NHANVIEN.MaNV = CHUNGNHAN.MaNV
	and MAYBAY.MaMB =CHUNGNHAN.MaMB
	and MAYBAY.Loai like 'Boeing%'


-- 10 cho biết mã số và tên của các phi công có thể lái được máy bay có mã số là 747 
select NHANVIEN.MaNV,Ten
from CHUNGNHAN,NHANVIEN
where CHUNGNHAN.MaNV = NHANVIEN.MaNV
	and CHUNGNHAN.MaMB = 747


-- 11 cho biết mã số và tên của các loại máy bay mà nhân viên có họ Nguyễn có thể lái
select MAYBAY.MaMB,MAYBAY.Loai
from CHUNGNHAN,NHANVIEN,MAYBAY
where NHANVIEN.MaNV = CHUNGNHAN.MaNV
	and MAYBAY.MaMB = CHUNGNHAN.MaMB
	and NHANVIEN.Ten like 'Nguyen %'
-- 12 cho biết mã sỗ của các phi công vừa lái được Boeing vừa lái được Airbus A320
select NHANVIEN.MaNV as MaSoCacPhiCong , Ten
from NHANVIEN,CHUNGNHAN,MAYBAY
where NHANVIEN.MaNV = CHUNGNHAN.MaNV
	and MAYBAY.MaMB = CHUNGNHAN.MaMB
	and MAYBAY.Loai in ('Boeing %','Airbus A320')

