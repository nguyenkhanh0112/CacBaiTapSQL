--1. **T?o m?t trigger ?? c?p nh?t t?ng s? l??ng ??a trong m?t th? lo?i khi có ??a m?i ???c thêm vào.**
use QuanLyCuaHangBanBangDia
-- T?o trigger ?? gi?m s? l??ng ??a khi ???c cho thuê
CREATE TRIGGER tr_GiamSoluongDiaChoThue
ON CTTHUEDIA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- C?p nh?t s? l??ng ??a trong b?ng DIA sau khi ???c cho thuê
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
    WHERE i.soluong IS NOT NULL; -- Ki?m tra xem có d? li?u ???c chèn hay không
END;

-- s? d?ng trigger ?? c?p s? s? l??ng ??a khi bán ??a 
-- T?o trigger ?? c?p nh?t s? l??ng ??a khi bán ??a
CREATE TRIGGER tr_CapNhatSoLuongDiaKhiBanDia
ON CTBANDIA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- C?p nh?t s? l??ng ??a trong b?ng DIA sau khi bán ??a
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

-- Xóa t?t c? các phi?u thuê và chi ti?t phi?u thuê c?a m?t ??a khi nó ???c tr? l?i.

-- To trigger ?? xóa phi?u thuê khi ??a ???c tr? l?i
alter TRIGGER tr_XoaPhieuThueKhiTraDia
ON CTTRADIA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Xóa tat ca chi ti?t phi?u thuê t??ng ?ng khi ??a ???c tr? l?i
    DELETE FROM CTTHUEDIA
    WHERE CTTHUEDIA.sophieuthue IN (SELECT sophieuthue FROM inserted);

    -- Xóa tat ca phi?u thuê sau khi ?ã xóa chi ti?t phi?u thuê
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



