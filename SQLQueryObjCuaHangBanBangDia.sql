create database QuanLyCuaHangBanBangDia

	go 

	use QuanLyCuaHangBanBangDia
	go


create table THELOAI(
	matheloai nvarchar(10) primary key,
	tentheloai nvarchar(30)
	)

	go 
create table DIA(
	madia nvarchar(10) primary key,
	tendia nvarchar(100),
	matheloai nvarchar(10),
	soluong int,
	giathue float,
	giaban float
	)
	go
create table KHACHHANG(
	makh nvarchar(10) primary key,
	tenkh nvarchar(30),
	gioitinh nvarchar(10),
	diachikh nvarchar(50),
	sdtkh varchar(20)
	)

	go

create table NHACUNGCAP(
	mancc nvarchar(10) primary key,
	tenncc nvarchar(50),
	diachincc nvarchar(50),
	sdtncc varchar(20)
	)

	go
create table PHIEUNHAP(
	sophieunhap nvarchar(10) primary key,
	ngaynhap date,
	mancc nvarchar(10),
	madia nvarchar(10),
	)

	go
create table CTNHAPDIA(
	sophieunhap nvarchar(10),
	mancc nvarchar(10),
	madia nvarchar(10),
	soluong int,
	dongia float,
	constraint PK_sophieunhap_mancc_madia primary key(sophieunhap,mancc,madia)
	)
	
	go
create table PHIEUTHUE(
	sophieuthue nvarchar(10) primary key,
	ngaythue date,
	madia nvarchar(10),
	makh nvarchar(10),
	)
	go 
create table CTTHUEDIA(
	sophieuthue nvarchar(10),
	madia nvarchar(10),
	soluong int,
	giathue float,
	constraint PK_sophieuthue_madia primary key(sophieuthue,madia)
	)
	go
create table PHIEUTRA(
	sophieutra nvarchar(10) primary key,
	sophieuthue nvarchar(10),
	ngaytra date,
	madia nvarchar(10),
	makh nvarchar(10)
	)
	go
	

create table CTTRADIA(
	sophieutra nvarchar(10),
	madia nvarchar(10),
	soluong int,
	tiencoc float,
	constraint PK_tradia_sophieutra_madia primary key(sophieutra,madia)
	)


	go 
create table PHIEUBAN(
	sophieuban nvarchar(10) primary key,
	ngayban date,
	madia nvarchar(10),
	makh nvarchar(10)
	)
	go 
create table CTBANDIA(
	sophieuban nvarchar(10),
	madia nvarchar(10),
	soluong int,
	giaban float,
	constraint PK_sophieuban_madia primary key(sophieuban,madia)
	)
	go

	-- KHÓA ngoại
alter table DIA add constraint FK_matheloai foreign key(matheloai) references THELOAI(matheloai);
alter table PHIEUNHAP add constraint FK_PHIEUNHAP_mancc foreign key(mancc) references NHACUNGCAP(mancc);
alter table PHIEUNHAP add constraint FK_PHIEUNHAP_madia foreign key (madia) references DIA(madia);
alter table CTNHAPDIA add constraint FK_NHAPDIA_sophieunhap foreign key (sophieunhap) references PHIEUNHAP(sophieunhap);
alter table CTNHAPDIA add constraint FK_NHAPDIA_mancc foreign key(mancc) references NHACUNGCAP(mancc);
alter table CTNHAPDIA add constraint FK_NHAPDIA_madia foreign key(madia) references DIA(madia);
alter table PHIEUTHUE add constraint FK_PHIEUTHUE_madia foreign key(madia)references DIA(madia);
alter table PHIEUTHUE add constraint FK_PHIEUTHUE_makh foreign key (makh) references KHACHHANG(makh);
alter table CTTHUEDIA add constraint FK_THUEDIA_sophieuthue foreign key(sophieuthue) references PHIEUTHUE(sophieuthue);
alter table CTTHUEDIA add constraint FK_THUEDIA_madia foreign key(madia) references DIA(madia);

alter table PHIEUTRA add constraint FK_PHIEUTRA_madia foreign key (madia)references DIA(madia);
alter table PHIEUTRA add constraint FK_PHIEUTRA_makh foreign key (makh) references KHACHHANG(makh);

alter table PHIEUTRA add constraint FK_PHIEUTRA_sophieuthue foreign key (sophieuthue) references PHIEUTHUE(sophieuthue)

alter table CTTRADIA add constraint FK_TRADIA_sophieutra foreign key(sophieutra) references PHIEUTRA(sophieutra);
alter table CTTRADIA add constraint FK_TRADIA_madia foreign key(madia) references DIA(madia);

alter table PHIEUBAN add constraint FK_PHIEUBAN_madia foreign key(madia) references DIA(madia);
alter table PHIEUBAN add constraint FK_PHIEUBAN_makh foreign key(makh) references KHACHHANG(makh);
alter table CTBANDIA add constraint FK_BANDIA_sophieuban foreign key(sophieuban) references PHIEUBAN(sophieuban);
alter table CTBANDIA add constraint FK_BANDIA_madia foreign key(madia) references DIA(madia);





-- Thêm dữ liệu vào bảng THELOAI
INSERT INTO THELOAI (matheloai, tentheloai)
VALUES
    ('BR', N'Băng reel-to-reel'),
    ('BC', N'Băng cassette'),
    ('BV', N'Băng đĩa video'),
    ('DVR',N'Đĩa than'),
    ('CD',N'Đĩa CD'),
    ('DVD',N'Đĩa DVD'),
    ('BLR',N'Đĩa Blu-ray');
-- Thêm dữ liệu vào bảng DIA

INSERT INTO DIA(MaDia, TenDia, MaTheloai, soluong, Giathue, Giaban)
VALUES
    ('R1', 'The Beatles Live at the Hollywood Bowl', 'BR', 132, 132500, 1325000),
    ('R2', 'Pink Floyd - Dark Side of the Moon', 'BR', 181, 181000, 1810000),
    ('R3', 'Woodstock Festival - 1969', 'BR', 156, 156400, 1564000),
    ('R4', 'Jazz Mix 1970s', 'BR', 119, 119900, 1199000),
    ('R5', 'Hội Thảo Về Jazz 1985', 'BR', 195, 194600, 1946000),
    ('R6', 'The Beatles - "Abbey Road"', 'BR', 140, 143300, 1433000),
    ('R7', 'Pink Floyd - "The Dark Side of the Moon"', 'BR', 175, 175500, 1755000),
    ('R8', 'Miles Davis - "Kind of Blue"', 'BR', 128, 128700, 1287000),
    ('R9', 'Led Zeppelin - "IV"', 'BR', 161, 161900, 1619000),
    ('R10', 'Fleetwood Mac - "Rumours"', 'BR', 145, 145900, 1459000),
    ('R11', 'Michael Jackson - "Thriller"', 'BR', 167, 167600, 1676000),
    ('R12', 'Bob Dylan - "Highway 61 Revisited"', 'BR', 135, 135300, 1353000),
    ('R13', 'The Rolling Stones - "Sticky Fingers"', 'BR', 187, 187700, 1877000),
    ('R14', 'Prince - "Purple Rain"', 'BR', 112, 112000, 1120000),
    ('R15', 'John Coltrane - "A Love Supreme"', 'BR', 119, 199300, 1993000),
    ('C1', 'Madonna - "Like a Virgin"', 'BC', 8, 8000, 80000),
    ('C2', 'Michael Jackson - "Bad"', 'BC', 15, 15000, 150000),
    ('C3', 'Beastie Boys - "Licensed to Ill"', 'BC', 27, 27000, 270000),
    ('C4', 'U2 - "The Joshua Tree"', 'BC', 12, 12000, 120000),
    ('C5', 'Nirvana - "Nevermind"', 'BC', 20, 20000, 200000),
    ('C6', 'TLC - "CrazySexyCool"', 'BC', 10, 10000, 100000),
    ('C7', 'Depeche Mode - "Violator"', 'BC', 25, 25000, 250000),
    ('C8', 'Run-D.M.C. - "Raising Hell"', 'BC', 6, 6000, 60000),
    ('C9', 'Janet Jackson - "Rhythm Nation 1814"', 'BC', 18, 18000, 180000),
    ('C10', 'Metallica - "Metallica" (The Black Album)', 'BC', 9, 9000, 90000),
    ('C11', 'Madonna - "True Blue"', 'BC', 13, 13000, 130000),
    ('C12', 'Michael Jackson - "Off the Wall"', 'BC', 22, 22000, 220000),
    ('C13', 'Beastie Boys - "Pauls Boutique"', 'BC', 17, 17000, 170000),
    ('C14', 'U2 - "Achtung Baby"', 'BC', 11, 11000, 110000),
    ('C15', 'Nirvana - "In Utero"', 'BC', 30, 30000, 300000),
    ('C16', 'TLC - "FanMail"', 'BC', 7, 7000, 70000),
    ('C17', 'Depeche Mode - "Music for the Masses"', 'BC', 24, 24000, 240000),
    ('C18', 'Run-D.M.C. - "King of Rock"', 'BC', 16, 16000, 160000),
    ('C19', 'Janet Jackson - "Control"', 'BC', 14, 14000, 140000),
    ('C20', 'Metallica - "Ride the Lightning"', 'BC', 19, 19000, 190000),
    ('V1', '"Star Wars: Episode IV - A New Hope" (1977)', 'BV', 4, 400000, 4000000),
    ('V2', '"Back to the Future" (1985)', 'BV', 3, 300000, 3000000),
    ('V3', '"E.T. the Extra-Terrestrial" (1982)', 'BV', 7, 700000, 7000000),
    ('V4', '"Jurassic Park" (1993)', 'BV', 5, 500000, 5000000),
    ('V5', '"Titanic" (1997)', 'BV', 20, 200000, 2000000),
    ('V6', '"The Lion King" (1994)', 'BV', 8, 800000, 8000000),
    ('V7', '"Ghostbusters" (1984)', 'BV', 6, 600000, 6000000),
    ('V8', '"Terminator 2: Judgment Day" (1991)', 'BV', 10, 100000, 1000000),
    ('V9', '"Indiana Jones and the Last Crusade" (1989)', 'BV', 9, 900000, 9000000),
    ('V10', '"The Shawshank Redemption" (1994)', 'BV', 4, 400000, 4000000),
    ('V11', '"Blade Runner" (1982)', 'BV', 5, 500000, 5000000),
    ('V12', '"The Empire Strikes Back" (1980)', 'BV', 7, 700000, 7000000),
    ('V13', '"Raiders of the Lost Ark" (1981)', 'BV', 3, 300000, 3000000),
    ('V14', '"Top Gun" (1986)', 'BV', 6, 600000, 6000000),
    ('V15', '"A Clockwork Orange" (1971)', 'BV', 8, 800000, 8000000),
    ('V16', '"The Little Mermaid" (1989)', 'BV', 5, 500000, 5000000),
    ('V17', '"The Silence of the Lambs" (1991)', 'BV', 10, 100000, 1000000),
    ('V18', '"Home Alone" (1990)', 'BV', 9, 900000, 9000000),
    ('V19', '"Beauty and the Beast" (1991)', 'BV', 4, 400000, 4000000),
    ('V20', '"Batman" (1989)', 'BV', 20, 200000, 2000000),
    ('V21', '"The Terminator" (1984)', 'BV', 7, 700000, 7000000),
    ('V22', '"Die Hard" (1988)', 'BV', 6, 600000, 6000000),
    ('V23', '"Lethal Weapon" (1987)', 'BV', 8, 300000, 3000000),
    ('V24', '"Raging Bull" (1980)', 'BV', 3, 800000, 8000000),
    ('V25', '"Do the Right Thing" (1989)', 'BV', 9, 900000, 9000000),
    ('VR1', 'The Beatles - "Sgt. Peppers Lonely Hearts Club Band" (1967)', 'DVR', 8, 19000000, 190000000),
    ('VR2', 'Pink Floyd - "The Wall" (1979)', 'DVR', 11, 8000000, 80000000),
    ('VR3', 'Led Zeppelin - "IV" (1971)', 'DVR', 5, 11000000, 110000000),
    ('VR4', 'Bob Dylan - "Highway 61 Revisited" (1965)', 'DVR', 7, 5000000, 50000000),
    ('VR5', 'Michael Jackson - "Thriller" (1982)', 'DVR', 3, 7000000, 70000000),
    ('VR6', 'David Bowie - "The Rise and Fall of Ziggy Stardust and the Spiders from Mars" (1972)', 'DVR', 15, 12000000, 120000000),
    ('VR7', 'Fleetwood Mac - "Rumours" (1977)', 'DVR', 18, 3000000, 30000000),
    ('VR8', 'Miles Davis - "Kind of Blue" (1959)', 'DVR', 10, 15000000, 150000000),
    ('VR9', 'Nirvana - "Nevermind" (1991)', 'DVR', 6, 18000000, 180000000),
    ('VR10', 'Prince - "Purple Rain" (1984)', 'DVR', 13, 10000000, 100000000),
    ('VR11', 'The Rolling Stones - "Sticky Fingers" (1971)', 'DVR', 14, 6000000, 60000000),
    ('VR12', 'Jimi Hendrix - "Are You Experienced" (1967)', 'DVR', 2, 13000000, 130000000),
    ('VR13', 'Radiohead - "OK Computer" (1997)', 'DVR', 17, 14000000, 140000000),
    ('VR14', 'Queen - "A Night at the Opera" (1975)', 'DVR', 10, 2000000, 20000000),
    ('VR15', 'The Velvet Underground - "The Velvet Underground & Nico" (1967)', 'DVR', 16, 4000000, 40000000),
    ('VR16', 'Bob Marley and the Wailers - "Legend" (1984)', 'DVR', 9, 17000000, 170000000),
    ('VR17', 'Bruce Springsteen - "Born to Run" (1975)', 'DVR', 20, 1000000, 10000000),
    ('VR18', 'The Clash - "London Calling" (1979)', 'DVR', 19, 16000000, 160000000),
    ('VR19', 'Amy Winehouse - "Back to Black" (2006)', 'DVR', 13, 9000000, 90000000),
    ('VR20', 'Frank Sinatra - "In the Wee Small Hours" (1955)', 'DVR', 16, 20000000, 200000000),
    ('CD1', 'Michael Jackson - "Thriller" (1982)', 'CD', 5, 190000, 1900000),
    ('CD2', 'Adele - "21" (2011)', 'CD', 17, 130000, 1300000),
    ('CD3', 'Nirvana - "Nevermind" (1991)', 'CD', 14, 160000, 1600000),
    ('CD4', 'Pink Floyd - "The Dark Side of the Moon" (1973)', 'CD', 11, 50000, 500000),
    ('CD5', 'Whitney Houston - "The Bodyguard: Original Soundtrack Album" (1992)', 'CD', 18, 170000, 1700000),
    ('CD6', 'U2 - "The Joshua Tree" (1987)', 'CD', 10, 80000, 800000),
    ('CD7', 'Madonna - "Like a Virgin" (1984)', 'CD', 7, 140000, 1400000),
    ('CD8', 'The Beatles - "Abbey Road" (1969)', 'CD', 12, 110000, 1100000),
    ('CD9', 'Bob Marley and the Wailers - "Exodus" (1977)', 'CD', 15, 180000, 1800000),
    ('CD10', 'Radiohead - "OK Computer" (1997)', 'CD', 6, 100000, 1000000),
    ('CD11', 'Taylor Swift - "Folklore" (2020)', 'CD', 9, 70000, 700000),
    ('CD12', 'BTS - "Map of the Soul: 7" (2020)', 'CD', 20, 120000, 1200000),
    ('CD13', 'Adele - "25" (2015)', 'CD', 11, 150000, 1500000),
    ('CD14', 'Billie Eilish - "When We All Fall Asleep, Where Do We Go?" (2019)', 'CD',8, 20000, 200000),
	('CD15', 'Ed Sheeran - "÷ (Divide)" (2017)', 'CD',17, 90000, 900000),
	('CD16', 'Dua Lipa - "Future Nostalgia" (2020)', 'CD',4, 100000, 1000000),
	('CD17', 'The Weeknd - "After Hours" (2020)', 'CD',3, 190000, 1900000),
	('CD18', 'Drake - "Scorpion" (2018)', 'CD', 7, 30000, 300000),
	('CD19', 'Ariana Grande - "Thank U, Next" (2019)', 'CD', 5, 160000, 1600000),
	('CD20', 'Coldplay - "Everyday Life" (2019)', 'CD', 2, 120000, 1200000),
	('DVD1', 'The Lord of the Rings Trilogy (2001-2003)', 'DVD', 8, 180000, 1800000),
	('DVD2', 'The Dark Knight (2008)', 'DVD', 6, 130000, 1300000),
	('DVD3', 'Inception (2010)', 'DVD', 10, 170000, 1700000),
	('DVD4', 'The Matrix (1999)', 'DVD', 9, 120000, 1200000),
	('DVD5', 'Titanic (1997)', 'DVD', 4, 150000, 1500000),
	('DVD6', 'Avatar (2009)', 'DVD', 5, 80000, 800000),
	('DVD7', 'Star Wars: Episode IV - A New Hope (1977)', 'DVD', 3, 140000, 1400000),
	('DVD8', 'Jurassic Park (1993)', 'DVD', 6, 110000, 1100000),
	('DVD9', 'Pulp Fiction (1994)', 'DVD',7, 190000, 1900000),
	('DVD10', 'The Shawshank Redemption (1994)', 'DVD', 8, 100000, 1000000),
	('DVD11', 'Avengers: Endgame (2019)', 'DVD',5, 60000, 600000),
	('DVD12', 'Joker (2019)', 'DVD', 10, 120000, 1200000),
	('DVD13', 'Frozen II (2019)', 'DVD', 9, 160000, 1600000),
	('DVD14', 'Parasite (2019)', 'DVD',4, 20000, 200000),
	('DVD15', 'Spider-Man: Into the Spider-Verse (2018)', 'DVD',2, 90000, 900000),
	('DVD16', 'The Mandalorian: Season 1 (2019)', 'DVD', 7, 100000, 1000000),
	('DVD17', 'Bohemian Rhapsody (2018)', 'DVD', 6, 180000, 1800000),
	('DVD18', 'Once Upon a Time in Hollywood (2019)', 'DVD', 3, 30000, 300000),
	('DVD19', 'Toy Story 4 (2019)', 'DVD', 8, 160000, 1600000),
	('DVD20', 'The Irishman (2019)', 'DVD', 9, 120000, 1200000),
	('BLR1', 'Casablanca (1942)', 'BLR',19, 90000, 900000),
	('BLR2', 'Gone with the Wind (1939)', 'BLR', 8, 60000, 600000),
	('BLR3', 'The Godfather Trilogy (1972-1990)', 'BLR', 11, 70000, 700000),
	('BLR4', 'Lawrence of Arabia (1962)', 'BLR', 5, 40000, 400000),
	('BLR5', 'The Wizard of Oz (1939)', 'BLR', 7, 80000, 800000),
	('BLR6', 'Citizen Kane (1941)', 'BLR', 12, 20000, 200000),
	('BLR7', 'The Sound of Music (1965)', 'BLR', 17, 50000, 500000),
	('BLR8', 'The Beatles - "A Hard Days Night" (1964)', 'BLR', 13, 30000, 300000),
	('BLR9', 'Alfred Hitchcock Classics Collection (Various)', 'BLR', 14, 90000, 900000),
	('BLR10', 'Frank Sinatra - "Sinatra at the Sands" (1966)', 'BLR', 15, 10000, 100000),
	('BLR11', 'Avengers: Endgame (2019)', 'BLR', 16, 60000, 600000),
	('BLR12', 'The Dark Knight (2008)', 'BLR', 17, 80000, 800000),
	('BLR13', 'Inception (2010)', 'BLR', 18, 30000, 300000),
	('BLR14', 'Interstellar (2014)', 'BLR', 8, 20000, 200000),
	('BLR15', 'Parasite (2019)', 'BLR', 9, 50000, 500000),
	('BLR16', 'Mad Max: Fury Road (2015)', 'BLR', 6, 80000, 800000),
	('BLR17', 'The Revenant (2015)', 'BLR', 4, 30000, 300000),
	('BLR18', 'Blade Runner 2049 (2017)', 'BLR', 3, 60000, 600000),
	('BLR19', 'Dunkirk (2017)', 'BLR', 8, 90000, 900000),
	('BLR20', 'Joker (2019)', 'BLR', 7, 70000, 700000);
select * from DIA


-- Thêm dữ liệu vào bảng KHACHHANG
INSERT INTO KhachHang (makh, tenkh,gioitinh,diachikh, sdtkh)
VALUES
    ('KH001', N'Lê Thanh Trúc', N'Nữ', N'Hà Nội', '0312345678'),
    ('KH002', N'Bùi Văn Đức', N'Nam', N'Hải Phòng', '0923456789'),
    ('KH003', N'Trương Văn Hùng', N'Nam', N'Thái Bình', '0345678901'),
    ('KH004', N'Võ Thị Thanh Hương', N'Nữ', N'Hòa Bình', '0934567890'),
    ('KH005', N'Phạm Đình Quân', N'Nam', N'Hà Nam', '0323456789'),
    ('KH006', N'Trần Văn Anh', N'Nam', N'Hải Dương', '0932123456'),
    ('KH007', N'Trương Minh Khánh', N'Nam', N'Vĩnh Phúc', '0398765432'),
    ('KH008', N'Phạm Thị Thùy Trang', N'Nữ', N'Nam Định', '0934567891'),
    ('KH009', N'Đặng Văn Quang', N'Nam', N'Quảng Ninh', '0321987654'),
    ('KH010', N'Lê Minh Tuấn', N'Nam', N'Bắc Giang', '0937654321'),
    ('KH011', N'Ngọc Anh Nguyễn', N'Nữ', N'Phú Thọ', '0312345679'),
    ('KH012', N'Trần Thị Thu Hiền', N'Nữ', N'Thành Hóa', '0923456781'),
    ('KH013', N'Trần Anh Tuấn', N'Nam', N'Ninh Bình', '0398765431'),
    ('KH014', N'Hoàng Minh Tuấn', N'Nam', N'Hà Giang', '0923456783'),
    ('KH015', N'Hoàng Văn Tiến', N'Nam', N'Hưng Yên', '0319876543'),
    ('KH016', N'Nguyễn Thị Hương', N'Nữ', N'Hà Tĩnh', '0934567892'),
    ('KH017', N'Vũ Đức Thành', N'Nam', N'Thái Nguyên', '0323456781'),
    ('KH018', N'Lê Thị Mai', N'Nữ', N'Hải Phòng', '0932123457'),
    ('KH019', N'Mai Thị Linh', N'Nữ', N'Thái Bình', '0345678902'),
    ('KH020', N'Hoàng Văn Nam', N'Nam', N'Hà Nam', '0938765432'),
    ('KH021', N'Nguyễn Hoàng Long', N'Nam', N'Hải Dương', '0345678903'),
    ('KH022', N'Nguyễn Quang Huy', N'Nam', N'Nam Định', '0934567893'),
    ('KH023', N'Đinh Văn Dũng', N'Nam', N'Vĩnh Phúc', '0323456782'),
    ('KH024', N'Nguyễn Thị Quỳnh Anh', N'Nữ', N'Thái Nguyên', '0932123458'),
    ('KH025', N'Trần Thị Ánh Ngọc', N'Nữ', N'Hà Giang', '0398765433'),
    ('KH026', N'Bùi Thị Thu Trang', N'Nữ', N'Hưng Yên', '0934567894'),
    ('KH027', N'Nguyễn Thị Bích Hà', N'Nữ', N'Hà Tĩnh', '0321987655'),
    ('KH028', N'Hoàng Minh Tuấn', N'Nam', N'Bắc Ninh', '0937654322'),
    ('KH029', N'Phan Thị Hồng', N'Nữ', N'Bắc Ninh', '0312345680'),
    ('KH030', N'Đặng Thị Thu Hà', N'Nữ', N'Bắc Ninh', '0923456784');
	select * from KHACHHANG
-- Thêm dữ liệu vào bảng NHACUNGCAP
INSERT INTO NHACUNGCAP (mancc, tenncc, diachincc, sdtncc)
VALUES
    ('CC1', 'Sony', N'Tokyo, Nhật Bản.', '+81 3 1234 5678'),
    ('CC2', 'Maxell', N'Osaka, Nhật Bản.', '+81 6 2345 6789'),
    ('CC3', 'TDK', N'Tokyo, Nhật Bản.', '+81 3 3456 7890'),
    ('CC4', 'Memorex', N'St. Louis, Hoa Kỳ.', '+1 314 456 7891'),
    ('CC5', 'JVC', N'Yokohama, Nhật Bản.', '+81 45 5678 9012'),
    ('CC6', 'Fuji Film', N'Tokyo, Nhật Bản.', '+81 3 6789 0123'),
    ('CC7', 'Panasonic', N'Osaka, Nhật Bản.', '+81 6 7890 1234'),
    ('CC8', 'Quantegy', N'Opelika, Hoa Kỳ.', '+1 334 901 2345'),
    ('CC9', 'Verbatim', N'Tokyo, Nhật Bản.', '+81 3 1234 5678'),
    ('CC10', 'Ritek', N'Taipei, Đài Loan.', '+886 2 2345 6789'),
    ('CC11', 'Imation', N'Oakdale, Hoa Kỳ.', '+1 651 345 6789');
	
-- Thêm dữ liệu vào bảng PHIEUNHAP
INSERT INTO PHIEUNHAP (sophieunhap, ngaynhap, mancc, madia)
VALUES
    ('PN2013001', '2013-05-06', 'CC7', 'V8'),
    ('PN2013002', '2013-09-05', 'CC4', 'CD5'),
    ('PN2013003', '2013-12-04', 'CC9', 'C14'),
    ('PN2014004', '2014-04-04', 'CC6', 'R2'),
    ('PN2014005', '2014-08-04', 'CC5', 'DVD19'),
    ('PN2015006', '2015-01-04', 'CC10', 'V20'),
    ('PN2015007', '2015-05-04', 'CC8', 'R10'),
    ('PN2015008', '2015-08-03', 'CC3', 'BLR4'),
    ('PN2016009', '2016-01-03', 'CC1', 'V7'),
    ('PN2016010', '2016-05-03', 'CC11', 'C1'),
    ('PN2016011', '2016-07-02', 'CC2', 'DVD11'),
    ('PN2016012', '2016-11-02', 'CC6', 'R12'),
    ('PN2017013', '2017-03-02', 'CC1', 'C8'),
    ('PN2017014', '2017-06-01', 'CC5', 'BLR18'),
    ('PN2017015', '2017-09-01', 'CC4', 'DVD16'),
    ('PN2017016', '2017-12-01', 'CC10', 'C10'),
    ('PN2018017', '2018-03-01', 'CC9', 'VR9'),
    ('PN2018018', '2018-05-31', 'CC11', 'DVD6'),
    ('PN2018019', '2018-08-30', 'CC8', 'V22'),
    ('PN2019020', '2019-01-30', 'CC2', 'CD3'),
    ('PN2019021', '2019-05-30', 'CC7', 'BLR8'),
    ('PN2019022', '2019-08-29', 'CC3', 'V12'),
    ('PN2020023', '2020-01-29', 'CC4', 'VR6'),
    ('PN2020024', '2020-05-29', 'CC5', 'V19'),
    ('PN2020025', '2020-08-28', 'CC9', 'BLR10'),
    ('PN2021026', '2021-01-28', 'CC1', 'R8'),
    ('PN2021027', '2021-05-28', 'CC10', 'C19'),
    ('PN2021028', '2021-08-27', 'CC8', 'V3'),
    ('PN2022029', '2022-01-27', 'CC6', 'R4'),
    ('PN2022030', '2022-05-27', 'CC2', 'CD10');

-- Thêm dữ liệu vào bảng CTNHAPDIA
INSERT INTO CTNHAPDIA (sophieunhap, mancc, madia, soluong, dongia)
VALUES
    ('PN2013001', 'CC7', 'V8', 28, 800000),
    ('PN2013002', 'CC4', 'CD5', 42, 1360000),
    ('PN2013003', 'CC9', 'C14', 19, 88000),
    ('PN2014004', 'CC6', 'R2', 36, 1448000),
    ('PN2014005', 'CC5', 'DVD19', 13, 1280000),
    ('PN2015006', 'CC10', 'V20', 44, 1600000),
    ('PN2015007', 'CC8', 'R10', 25, 1167200),
    ('PN2015008', 'CC3', 'BLR4', 14, 320000),
    ('PN2016009', 'CC1', 'V7', 37, 4800000),
    ('PN2016010', 'CC11', 'C1', 46, 64000),
    ('PN2016011', 'CC2', 'DVD11', 18, 480000),
    ('PN2016012', 'CC6', 'R12', 33, 1082400),
    ('PN2017013', 'CC1', 'C8', 48, 48000),
    ('PN2017014', 'CC5', 'BLR18', 21, 480000),
    ('PN2017015', 'CC4', 'DVD16', 38, 800000),
    ('PN2017016', 'CC10', 'C10', 12, 72000),
    ('PN2018017', 'CC9', 'VR9', 45, 144000000),
    ('PN2018018', 'CC11', 'DVD6', 27, 640000),
    ('PN2018019', 'CC8', 'V22', 17, 4800000),
    ('PN2019020', 'CC2', 'CD3', 40, 1280000),
    ('PN2019021', 'CC7', 'BLR8', 30, 240000),
    ('PN2019022', 'CC3', 'V12', 15, 5600000),
    ('PN2020023', 'CC4', 'VR6', 49, 96000000),
    ('PN2020024', 'CC5', 'V19', 23, 3200000),
    ('PN2020025', 'CC9', 'BLR10', 41, 80000),
    ('PN2021026', 'CC1', 'R8', 11, 1029600),
    ('PN2021027', 'CC10', 'C19', 29, 112000),
    ('PN2021028', 'CC8', 'V3', 16, 5600000),
    ('PN2022029', 'CC6', 'R4', 47, 959200),
    ('PN2022030', 'CC2', 'CD10', 20, 800000);

-- Thêm dữ liệu vào bảng PHIEUTHUE
INSERT INTO PHIEUTHUE (sophieuthue, ngaythue, madia, makh)
VALUES
    ('PT001', '4/3/2018', 'R9', 'KH022'),
    ('PT002', '7/12/2018', 'V13', 'KH012'),
    ('PT003', '9/26/2018', 'DVD14', 'KH007'),
    ('PT004', '12/14/2018', 'C3', 'KH028'),
    ('PT005', '3/28/2019', 'BLR5', 'KH016'),
    ('PT006', '7/14/2019', 'CD8', 'KH002'),
    ('PT007', '9/20/2019', 'VR18', 'KH023'),
    ('PT008', '12/5/2019', 'V25', 'KH008'),
    ('PT009', '1/22/2020', 'R12', 'KH011'),
    ('PT010', '5/19/2020', 'DVD7', 'KH001'),
    ('PT011', '11/2/2020', 'BLR20', 'KH025'),
    ('PT012', '4/17/2021', 'V16', 'KH030'),
    ('PT013', '8/23/2021', 'VR5', 'KH004'),
    ('PT014', '12/7/2021', 'C12', 'KH017'),
    ('PT015', '3/18/2022', 'CD16', 'KH026'),
    ('PT016', '7/9/2022', 'R14', 'KH006'),
    ('PT017', '9/10/2022', 'DVD6', 'KH015'),
    ('PT018', '1/30/2023', 'VR12', 'KH021'),
    ('PT019', '2/14/2023', 'V22', 'KH029'),
    ('PT020', '6/25/2023', 'BLR2', 'KH020');
	

-- Thêm dữ liệu vào bảng CTTHUEDIA
INSERT INTO CTTHUEDIA (sophieuthue, madia, soluong, giathue)
VALUES
    ('PT001', 'R9', 1, 1619000),
    ('PT002', 'V13', 3, 3000000),
    ('PT003', 'DVD14', 2, 200000),
    ('PT004', 'C3', 2, 270000),
    ('PT005', 'BLR5', 1, 800000),
    ('PT006', 'CD8', 2, 1100000),
    ('PT007', 'VR18',3, 160000000),
    ('PT008', 'V25', 5, 9000000),
    ('PT009', 'R12', 1, 1353000),
    ('PT010', 'DVD7', 1, 1400000),
    ('PT011', 'BLR20',1, 700000),
    ('PT012', 'V16',1, 5000000),
    ('PT013', 'VR5',1, 70000000),
    ('PT014', 'C12',1, 220000),
    ('PT015', 'CD16',2, 1000000),
    ('PT016', 'R14',1, 8960000),
    ('PT017', 'DVD6',1, 800000),
    ('PT018', 'VR12',2, 130000000),
    ('PT019', 'V22',1, 6000000),
    ('PT020', 'BLR2',1, 600000);
	

-- Thêm dữ liệu vào bảng PHIEUTRA
insert into PHIEUTRA (soPhieutra,sophieuthue,Ngaytra, Madia, Makh)
values
    ('TR001', 'PT001', '4/23/2018', 'R9', 'KH022'),
    ('TR002', 'PT002', '8/12/2018', 'V13', 'KH012'),
    ('TR003', 'PT003', '10/6/2018', 'DVD14', 'KH007'),
    ('TR004', 'PT004', '12/24/2018', 'C3', 'KH028'),
    ('TR005', 'PT005', '5/8/2019', 'BLR5', 'KH016'),
    ('TR006', 'PT006', '7/24/2019', 'CD8', 'KH002'),
    ('TR007', 'PT007', '9/28/2019', 'VR18', 'KH023'),
    ('TR008', 'PT008', '12/9/2019', 'V25', 'KH008'),
    ('TR009', 'PT009', '1/27/2020', 'R12', 'KH011'),
    ('TR010', 'PT010', '5/24/2020', 'DVD7', 'KH001'),
    ('TR011', 'PT011', '11/23/2020', 'BLR20', 'KH025'),
    ('TR012', 'PT012', '4/19/2021', 'V16', 'KH030'),
    ('TR013', 'PT013', '8/27/2021', 'VR5', 'KH004'),
    ('TR014', 'PT014', '12/17/2021', 'C12', 'KH017'),
    ('TR015', 'PT015', '3/22/2022', 'CD16', 'KH026'),
    ('TR016', 'PT016', '7/13/2022', 'R14', 'KH006'),
    ('TR017', 'PT017', '9/16/2022', 'DVD6', 'KH015'),
    ('TR018', 'PT018', '2/3/2023', 'VR12', 'KH021'),
    ('TR019', 'PT019', '2/19/2023', 'V22', 'KH029'),
    ('TR020', 'PT020', '6/29/2023', 'BLR2', 'KH020');
	


-- Thêm dữ liệu vào bảng CTTRADIA
INSERT INTO CTTRADIA(sophieutra, madia,soluong,tiencoc)
VALUES
    ('TR001', 'R9',1,1295200),
    ('TR002', 'V13',3,2400000),
    ('TR003', 'DVD14',2, 160000),
    ('TR004', 'C3',2, 216000),
    ('TR005', 'BLR5',1, 640000),
    ('TR006', 'CD8',2, 880000),
    ('TR007', 'VR18',3, 128000000),
    ('TR008', 'V25',5, 7200000),
    ('TR009', 'R12',1, 1082400),
    ('TR010', 'DVD7',1, 1120000),
    ('TR011', 'BLR20',1, 560000),
    ('TR012', 'V16',1, 4000000),
    ('TR013', 'VR5',1, 56000000),
    ('TR014', 'C12',1, 176000),
    ('TR015', 'CD16',2, 800000),
    ('TR016', 'R14',1, 896000),
    ('TR017', 'DVD6',1, 640000),
    ('TR018', 'VR12',2, 104000000),
    ('TR019', 'V22',1, 4800000),
    ('TR020', 'BLR2',1, 480000);
	



-- Thêm dữ liệu vào bảng PHIEUBAN
INSERT INTO PHIEUBAN (sophieuban, ngayban, madia, makh)
VALUES
('PB001', '3/11/2018', 'C8', 'KH005'),
('PB002', '8/30/2018', 'R5', 'KH019'),
('PB003', '10/13/2018', 'DVD9', 'KH025'),
('PB004', '12/17/2018', 'BLR13', 'KH009'),
('PB005', '2/14/2019', 'V10', 'KH021'),
('PB006', '6/4/2019', 'VR15', 'KH030'),
('PB007', '11/29/2019', 'CD19', 'KH001'),
('PB008', '2/23/2020', 'V21', 'KH018'),
('PB009', '7/5/2020', 'R3', 'KH010'),
('PB010', '10/27/2020', 'BLR7', 'KH004'),
('PB011', '4/1/2021', 'DVD12', 'KH020'),
('PB012', '7/10/2021', 'CD15', 'KH007'),
('PB013', '9/18/2021', 'R8', 'KH014'),
('PB014', '1/1/2022', 'V6', 'KH026'),
('PB015', '5/22/2022', 'VR11', 'KH011'),
('PB016', '8/14/2022', 'DVD16', 'KH028'),
('PB017', '12/29/2022', 'C7', 'KH008'),
('PB018', '1/16/2023', 'BLR16', 'KH016'),
('PB019', '4/6/2023', 'V17', 'KH002'),
('PB020', '5/31/2023', 'CD1', 'KH023');
		


-- Thêm dữ liệu vào bảng CTBANDIA
INSERT INTO CTBANDIA (sophieuban, madia,soluong, giaban)
VALUES
('PB001', 'C8',1, 60000),
('PB002', 'R5', 1,1946000),
('PB003', 'DVD9',1, 1900000),
('PB004', 'BLR13',1, 300000),
('PB005', 'V10',2, 4000000),
('PB006', 'VR15',1, 40000000),
('PB007', 'CD19',1, 1600000),
('PB008', 'V21',1, 7000000),
('PB009', 'R3',1, 1251200),
('PB010', 'BLR7',1, 500000),
('PB011', 'DVD12',1, 1200000),
('PB012', 'CD15',2, 900000),
('PB013', 'R8',1, 1029600),
('PB014', 'V6',1, 8000000),
('PB015', 'VR11',1, 60000000),
('PB016', 'DVD16',1, 1000000),
('PB017', 'C7',1, 250000),
('PB018', 'BLR16',1, 800000),
('PB019', 'V17',2, 1000000),
('PB020', 'CD1',2, 1900000);
	
select * from CTNHAPDIA
select * from NHACUNGCAP
select * from PHIEUNHAP
select * from DIA
insert into DIA(madia,tendia,matheloai,soluong,giathue,giaban) values ('BLRRR','sdaasdasdas','BLR',20,80000,100000)
insert into NHACUNGCAP(mancc,tenncc,diachincc,sdtncc) values ('CC12','ccc',N'hà nội 2345','555559889')
insert into PHIEUNHAP(sophieunhap,ngaynhap,mancc,madia) values ('PNSSSS123','2013-05-07','CC12','BLRRR')
update NHACUNGCAP set tenncc = N'HÀ lol' where mancc = 'CC12'
delete NHACUNGCAP where mancc = 'CC12'
delete PHIEUNHAP where sophieunhap ='PNSSSS123';



