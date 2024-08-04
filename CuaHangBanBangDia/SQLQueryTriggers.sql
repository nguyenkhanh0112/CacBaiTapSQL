--1. **T?o m?t trigger ?? c?p nh?t t?ng s? l??ng ??a trong m?t th? lo?i khi c� ??a m?i ???c th�m v�o.**
use QuanLyCuaHangBanBangDia
-- T?o trigger ?? gi?m s? l??ng ??a khi ???c cho thu�
CREATE TRIGGER tr_GiamSoluongDiaChoThue
ON CTTHUEDIA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- C?p nh?t s? l??ng ??a trong b?ng DIA sau khi ???c cho thu�
    UPDATE DIA
    SET DIA.soluong = DIA.soluong - i.soluong
    FROM DIA
    INNER JOIN inserted i ON DIA.madia = i.madia;
END;


-- s? d?ng trigger ?? c?p nh?p s? l??ng ??a khi ???c tr? ??a 
CREATE TRIGGER tr_CapNhatSoluongDiaTra
ON CTTRADIA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- C?p nh?t s? l??ng ??a trong b?ng DIA sau khi ??a ???c tr?
    UPDATE DIA
    SET DIA.soluong = DIA.soluong + i.soluong
    FROM DIA
    INNER JOIN inserted i ON DIA.madia = i.madia
    WHERE i.soluong IS NOT NULL; -- Ki?m tra xem c� d? li?u ???c ch�n hay kh�ng
END;

-- s? d?ng trigger ?? c?p s? s? l??ng ??a khi b�n ??a 
-- T?o trigger ?? c?p nh?t s? l??ng ??a khi b�n ??a
CREATE TRIGGER tr_CapNhatSoLuongDiaKhiBanDia
ON CTBANDIA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- C?p nh?t s? l??ng ??a trong b?ng DIA sau khi b�n ??a
    UPDATE DIA
    SET DIA.soluong = DIA.soluong - i.soluong
    FROM DIA
    INNER JOIN inserted i ON DIA.madia = i.madia;
END;

-- s? d?ng trigger ?? c?p nh?p so l??ng dia khi ???c nh?p t? b?ng CTNHAPDIA
-- T?o trigger ?? c?p nh?t s? l??ng ??a khi nh?p ??a
CREATE TRIGGER tr_CapNhatSoLuongDiaKhiNhapDia
ON CTNHAPDIA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- C?p nh?t s? l??ng ??a trong b?ng DIA sau khi nh?p ??a
    UPDATE DIA
    SET DIA.soluong = DIA.soluong + i.soluong
    FROM DIA
    INNER JOIN inserted i ON DIA.madia = i.madia;
END;

-- X�a t?t c? c�c phi?u thu� v� chi ti?t phi?u thu� c?a m?t ??a khi n� ???c tr? l?i.

-- To trigger ?? x�a phi?u thu� khi ??a ???c tr? l?i
alter TRIGGER tr_XoaPhieuThueKhiTraDia
ON CTTRADIA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- X�a tat ca chi ti?t phi?u thu� t??ng ?ng khi ??a ???c tr? l?i
    DELETE FROM CTTHUEDIA
    WHERE CTTHUEDIA.sophieuthue IN (SELECT sophieuthue FROM inserted);

    -- X�a tat ca phi?u thu� sau khi ?� x�a chi ti?t phi?u thu�
    DELETE FROM PHIEUTHUE
    WHERE PHIEUTHUE.sophieuthue IN (SELECT sophieuthue FROM inserted);
END;


-- xoa phieu thue khi tra dia 
--161
select * from CTTHUEDIA
select * from phieuthue
select * from dia where madia='R9'
select *from CTTRADIA
select *from phieutra
delete CTTRADIA where sophieutra ='TR001'
delete PHIEUTRA where sophieutra = 'TR001'
insert into PHIEUTRA(sophieutra,sophieuthue,ngaytra,madia,makh) values ('TR001','PT001','2018-04-23','R9','KH022')
insert into CTTRADIA(sophieutra,madia,soluong,tiencoc) values('TR001','R9',1,1295200)


select * from dia
select * from CTNHAPDIA
select * from PHIEUNHAP where sophieunhap ='PN2022031';
insert into PHIEUNHAP(sophieunhap,ngaynhap,mancc,madia) values ('PN2022031',getdate(),'CC5','V8')
insert into CTNHAPDIA(sophieunhap,mancc,madia,soluong,dongia) values ('PN2022031','CC5','V8',14,1280000)



