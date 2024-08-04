use qlsv

go
alter table Sinhvien
alter column Lop nvarchar(50)

ALTER TABLE Sinhvien
ALTER COLUMN Masv INT IDENTITY(1,1);
select * from Sinhvien


insert into Sinhvien(Tensv,Gioitinh,Ngaysinh,Que,lop) values
	(N'Lê Thùy Dương',N'Nữ','1997-05-12',N'Hà Nội','L03'),
	(N'Trần Phương Thảo',N'Nam','1996-03-30',N'Quảng Ninh','L01'),
	(N'Lê Trường An',N'Nam','1995-11-20',N'Ninh Bình','L04'),
	(N'Phạm Thị Hương Giang',N'Nữ','1999-02-21',N'Hòa Bình','L02'),
	(N'Trần Anh Bảo',N'Nam','1995-12-14',N'Hà Giang','L02'),
	(N'Lê Thùy Dung',N'Nữ','1997-05-12',N'Hà Nội','L03'),
	(N'Phạm Trung Tính',N'Nam','1996-03-30',N'Quảng Ninh','L01'),
	(N'Lê An Hải',N'Nam','1995-11-20',N'Ninh Bình','L04'),
	(N'Phạm Thị Giang Hương',N'Nữ','1999-02-21',N'Hòa Bình','L02'),
	(N'Đoàn Duy Thức',N'Nam','1994-04-12',N'Hà Nội','L01'),
	(N'Dương Tuấn Thông',N'Nam','1991-04-12',N'Nam Định','L03'),
	(N'Lê Thành Đạt',N'Nam','1993-04-15',N'Phú Thọ','L04'),
	(N'Nguyễn Hằng Nga',N'Nữ','1993-05-25',N'Hà Nội','L01'),
	(N'Trần Thanh Nga',N'Nữ','1994-06-20',N'Phú Thọ','L03'),
	(N'Trần Trọng Hoàng',N'Nam','1995-12-14',N'Hà Giang','L02'),
	(N'Nguyễn Mai Hoa',N'Nữ','1997-05-12',N'Hà Nội','L03'),
	(N'Lê Thúy An',N'Nam','1998-03-23',N'Hà Nội','L01');

insert into Monhoc(Tenmh,DVHT) values (N'Toán Cao Cấp',3),
										(N'Mạng Máy Tính',3),
										(N'Tin Đại Cương',4);

insert into Ketqua(Masv,Mamh,Diem) values	(1,1,8),(1,2,5),(1,3,7),(2,1,9),(2,2,5),(2,3,2),(3,1,4),(3,2,2),(4,1,1),(4,2,3),(5,1,4),
											(6,1,2),(6,2,7),(6,3,9),(7,1,4),(7,2,5),(7,3,8),(8,1,9),(8,2,8),(9,1,7),
											(9,2,7),(9,3,5),(10,1,3),(10,3,6),(11,1,6),(12,1,8),(12,2,7),(12,3,5),(13,1,6),
											(13,2,5),(13,3,5),(14,1,8),(14,2,9),(14,3,7),(15,1,3),(15,2,6),(15,3,4),(16,1,null);


select * from Sinhvien

select * from Ketqua
select * from Monhoc


-- 1 cho biết mã môn học , tên môn học , điểm thi tất cả các môn của sinh viên tên thức
select Monhoc.Mamh,Monhoc.Tenmh,Ketqua.Diem
from Sinhvien,Monhoc,Ketqua
where Sinhvien.Masv = Ketqua.Masv and Monhoc.Mamh = Ketqua.Mamh and Sinhvien.Tensv like N'%Thức%'

-- 2 cho biết mã môn học, tên môn học và điểm thi ở những môn mà sinh viên tên dung 
--phải thi lại(diem <5)

select Monhoc.Mamh,Monhoc.Tenmh,Ketqua.Diem
from Sinhvien,Monhoc,Ketqua
where Sinhvien.Masv = Ketqua.Masv and Monhoc.Mamh = Ketqua.Mamh and Sinhvien.Tensv like N'%Dung%' 
and Ketqua.Diem < 5;

-- 3 cho biết mã sinh viên, tên những sinh viên đã thi ít nhất là 1 trong 3 môn lý thuyết 
-- cơ sở dữ liệu , tin học địa cương,mạng máy tính

select distinct Sinhvien.Masv,Sinhvien.Tensv
from Sinhvien,Ketqua 
where Sinhvien.Masv = Ketqua.Masv
	and Ketqua.Mamh in (1,2,3)


-- 4 cho biết mã môn học, tên môn  mà sinh viên có mã số 1 chưa có điểm 
select Monhoc.Mamh,Monhoc.Tenmh 
from Monhoc,Sinhvien,Ketqua
where  Sinhvien.Masv = Ketqua.Masv and Monhoc.Mamh = Ketqua.Mamh and Sinhvien.Masv = 1 and Ketqua.Diem is null 

-- 5 cho biết điểm cao nhất môn 1 mà các sinh viên đạt được 
select Ketqua.Diem
from Monhoc,Ketqua
where   Monhoc.Mamh = Ketqua.Mamh and Monhoc.Mamh = 1 

-- 6 cho biết mã sinh viên và tên những sinh viên có điểm thi môn 2 
-- không thấp nhất khóa
select distinct Sinhvien.Masv,Sinhvien.Tensv
from Sinhvien,Ketqua
where Sinhvien.Masv = Ketqua.Masv
	and Ketqua.Mamh = 2
	and Ketqua.Diem > (select MIN(Diem) from Ketqua where Mamh = 2 )


--7 Cho biết mã sinh viên và tên những sinh viên có điểm thi môn 1 lớn hơn điểm thi môn 1 của sinh 
-- viên có mã số 3
select * from Ketqua
select Sinhvien.Masv,Sinhvien.Tensv
from Sinhvien,Ketqua
where Sinhvien.Masv = Ketqua.Masv 
	and Ketqua.Mamh = 1 
	and Ketqua.Diem > (select Ketqua.Diem from Ketqua where Masv =3 and Mamh =1) 
-- 8 cho biết số sinh viên phải thi lại môn toán cao cấp
select COUNT(Ketqua.Masv) as SoSinhVien 
from ketqua,Monhoc
where Monhoc.Mamh = Ketqua.Mamh
		and Ketqua.Diem < 5
		and Monhoc.Tenmh = N'Toán Cao Cấp'
-- 9 đối với mỗi môn cho biết tên môn và số sinh viên phải thi lại môn đó mà số sinh viên thi lại 
-- >=2
select Monhoc.Tenmh,COUNT(Sinhvien.Masv)
from Monhoc,Sinhvien,Ketqua
where Sinhvien.Masv = Ketqua.Masv and Monhoc.Mamh = Ketqua.Mamh and Ketqua.Diem <5
group by Monhoc.Tenmh
having COUNT(Sinhvien.Masv) >=2

-- 10 Cho biết mã sinh viên, tên và lớp của sinh viên đạt điểm cao nhất môn Tin đại cương
select Sinhvien.Masv,Sinhvien.Tensv,Sinhvien.lop
from Sinhvien,Monhoc,Ketqua
where Sinhvien.Masv = Ketqua.Masv and Monhoc.Mamh = Ketqua.Mamh
		and Monhoc.Tenmh like N'Tin%'
		and Ketqua.Diem = (
		select MAX(Ketqua.Diem) 
		from Ketqua
		where Ketqua.Mamh = Monhoc.Mamh and Monhoc.Tenmh like N'Tin%'
		)
select * from Ketqua	
-- 11 đối với mỗi lớp, lập bảng điểm gồm mã sinh viên, 
-- tên sinh viên và điểm trun bình chung, học tập
SELECT * from Sinhvien
select Sinhvien.lop,Sinhvien.Masv,Sinhvien.Tensv,AVG(Ketqua.Diem) as DiemtrungBinh
from Sinhvien,Ketqua
where Sinhvien.Masv = Ketqua.Masv
group by Sinhvien.Masv,Sinhvien.Tensv,Sinhvien.lop

-- 12 đối với mỗi lớp , cho biết mã sinh viên và tên những sinh viên phải thi lại 
-- từ 2 môn trở lên
select Sinhvien.lop, Sinhvien.Masv , Sinhvien.Tensv as SinhvienThiLai,COUNT(Monhoc.Mamh) as SoMonThiLai
from Sinhvien,Ketqua,Monhoc
Where Sinhvien.Masv = Ketqua.Masv 
	and Monhoc.Mamh = Ketqua.Mamh	
	and Ketqua.Diem < 5
group by Sinhvien.lop,Sinhvien.Masv,Sinhvien.Tensv
having COUNT(Monhoc.Mamh) >=2
--13 cho biết mã số và tên của những sinh viên tham gia thi tất cả các môn 
select Sinhvien.Masv, Sinhvien.Tensv
from Sinhvien
	where not exists(select Mamh
				from Monhoc 
				where not exists(select * 
							from Ketqua 
							where Ketqua.Mamh = Monhoc.Mamh 
							and Sinhvien.Masv = Ketqua.Masv
							) 
				);
-- 14 Cho biết mã sinh viên và tên của sinh viên có điểm trung bình chung học tập >=6
select Sinhvien.Masv,Sinhvien.Tensv,AVG(Ketqua.Diem)
from Sinhvien,Ketqua
where Sinhvien.Masv = Ketqua.Masv
group by Sinhvien.Masv,Sinhvien.Tensv
having	AVG(ketqua.Diem)>= 6
-- 15. Cho biết mã sinh viên và tên những sinh viên phải thi lại ở ít nhất là những môn có 
-- mã số 3 phải thi lại
select Sinhvien.Masv,Sinhvien.Tensv
from Sinhvien
where exists (select 1 
				from Ketqua
				where Sinhvien.Masv = Ketqua.Masv
				and Ketqua.Mamh = 3 
				and Ketqua.Masv < 5)
-- 16 Cho mã sv và tên của những sinh viên có hơn nửa số điểm >=5.
SELECT Sinhvien.Masv, Sinhvien.Tensv
FROM Sinhvien
WHERE (
    SELECT COUNT(*) 
    FROM Ketqua 
    WHERE Sinhvien.Masv = Ketqua.Masv AND Ketqua.Diem >= 5
) > (
    SELECT COUNT(*) / 2 
    FROM Ketqua 
    WHERE Sinhvien.Masv = Ketqua.Masv
);

-- 17. Cho danh sách tên và mã sinh viên có điểm trung bình chung lớn hơn 
-- điểm trung bình của toàn khóa.
select Sinhvien.Masv,Sinhvien.Tensv
from Sinhvien
where  (select AVG(Ketqua.Diem)
			from ketqua
			where ketqua.Masv = Sinhvien.Masv
			) 
			>
			(select AVG(ketqua.Diem)
			from Ketqua
			)
-- 18 cho biết danh sách mã sinh viên , tên sinh viên có điểm cao nhất mỗi lớp 
WITH AvgRankedResults AS (
    SELECT
        Sinhvien.Masv,
        Sinhvien.Tensv,
        Sinhvien.lop,
        AVG(Ketqua.Diem) AS DiemTrungBinh,
        ROW_NUMBER() OVER (PARTITION BY Sinhvien.lop ORDER BY AVG(Ketqua.Diem) DESC) AS RowNum
    FROM
        Sinhvien
    JOIN
        Ketqua ON Sinhvien.Masv = Ketqua.Masv
    GROUP BY
        Sinhvien.Masv, Sinhvien.Tensv, Sinhvien.lop
)
SELECT
    Masv,
    Tensv,
    lop,
    DiemTrungBinh
FROM
    AvgRankedResults
WHERE
    RowNum = 1;

-- 19 Cho danh sách tên và mã sinh viên có điểm trung bình chung lớn hơn điểm trung bình của lớp 
-- sinh viên đó theo học

WITH AvgScores AS (
    SELECT
        Sinhvien.Masv,
        Sinhvien.Tensv,
        Sinhvien.lop,
        AVG(Ketqua.Diem) AS DiemTrungBinhSinhVien
    FROM
        Sinhvien
    JOIN
        Ketqua ON Sinhvien.Masv = Ketqua.Masv
    GROUP BY
        Sinhvien.Masv, Sinhvien.Tensv, Sinhvien.lop
)

SELECT
    AvgScores.Masv,
    AvgScores.Tensv
FROM
    AvgScores
JOIN (
    SELECT
        lop,
        AVG(Ketqua.Diem) AS DiemTrungBinhLop
    FROM
        Ketqua
    JOIN
        Sinhvien ON Sinhvien.Masv = Ketqua.Masv
    GROUP BY
        lop
) AS AvgClassScores ON AvgScores.lop = AvgClassScores.lop
WHERE
    AvgScores.DiemTrungBinhSinhVien > AvgClassScores.DiemTrungBinhLop;
