 
DROP SCHEMA IF EXISTS `database` ;

CREATE SCHEMA IF NOT EXISTS `database` DEFAULT CHARACTER SET utf8 ;
USE `database` ;
DROP TABLE IF EXISTS `database`.`ViTri` ;

CREATE TABLE IF NOT EXISTS `database`.`ViTri` (
  `idViTri` INT NOT NULL,
  `TenViTri` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idViTri`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `database`.`TrinhDo` ;

CREATE TABLE IF NOT EXISTS `database`.`TrinhDo` (
  `idTrinhDo` INT NOT NULL,
  `TrinhDo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTrinhDo`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `database`.`BoPhan` ;

CREATE TABLE IF NOT EXISTS `database`.`BoPhan` (
  `idBoPhan` INT NOT NULL,
  `BoPhan` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBoPhan`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `database`.`NhanVien` ;

CREATE TABLE IF NOT EXISTS `database`.`NhanVien` (
  `idNhanVien` INT NOT NULL,
  `HoTen` VARCHAR(255) NOT NULL,
  `NgaySinh` DATE NOT NULL,
  `soCMND` INT NOT NULL,
  `Luong` VARCHAR(45) NOT NULL,
  `SDT` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `DiaChi` VARCHAR(45) NOT NULL,
  `ViTri_idViTri` INT NOT NULL,
  `TrinhDo_idTrinhDo` INT NOT NULL,
  `BoPhan_idBoPhan` INT NOT NULL,
  PRIMARY KEY (`idNhanVien`))
ENGINE = InnoDB;

CREATE INDEX `fk_NhanVien_ViTri_idx` ON `database`.`NhanVien` (`ViTri_idViTri` ASC) VISIBLE;

CREATE INDEX `fk_NhanVien_TrinhDo1_idx` ON `database`.`NhanVien` (`TrinhDo_idTrinhDo` ASC) VISIBLE;

CREATE INDEX `fk_NhanVien_BoPhan1_idx` ON `database`.`NhanVien` (`BoPhan_idBoPhan` ASC) VISIBLE;


DROP TABLE IF EXISTS `database`.`LoaiKhach` ;

CREATE TABLE IF NOT EXISTS `database`.`LoaiKhach` (
  `idLoaiKhach` INT NOT NULL,
  `TenLoaiKhach` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idLoaiKhach`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `database`.`KhachHang` ;

CREATE TABLE IF NOT EXISTS `database`.`KhachHang` (
  `idKhachHang` INT NOT NULL,
  `Họ Tên` VARCHAR(45) NOT NULL,
  `Ngay Sinh` DATE NOT NULL,
  `soCMND` VARCHAR(45) NOT NULL,
  `SDT` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `DiaChi` VARCHAR(45) NOT NULL,
  `LoaiKhach_idLoaiKhach` INT NOT NULL,
  PRIMARY KEY (`idKhachHang`))
ENGINE = InnoDB;

CREATE INDEX `fk_KhachHang_LoaiKhach1_idx` ON `database`.`KhachHang` (`LoaiKhach_idLoaiKhach` ASC) VISIBLE;

DROP TABLE IF EXISTS `database`.`KieuThue` ;

CREATE TABLE IF NOT EXISTS `database`.`KieuThue` (
  `idKieuThue` INT NOT NULL,
  `TenKieuThue` VARCHAR(45) NOT NULL,
  `Gia` INT NOT NULL,
  PRIMARY KEY (`idKieuThue`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `database`.`LoaiDichVu` ;

CREATE TABLE IF NOT EXISTS `database`.`LoaiDichVu` (
  `idLoaiDichVu` INT NOT NULL,
  `TenDichVu` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idLoaiDichVu`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `database`.`DichVu` ;

CREATE TABLE IF NOT EXISTS `database`.`DichVu` (
  `idDichVu` INT NOT NULL,
  `TenDichVu` VARCHAR(45) NOT NULL,
  `DienTich` INT NOT NULL,
  `SoTang` INT NOT NULL,
  `SoNguoiToiDa` INT NOT NULL,
  `TrangThai` VARCHAR(45) NOT NULL,
  `KieuThue_idKieuThue` INT NOT NULL,
  `LoaiDichVu_idLoaiDichVu` INT NOT NULL,
  PRIMARY KEY (`idDichVu`))
ENGINE = InnoDB;

CREATE INDEX `fk_DichVu_KieuThue1_idx` ON `database`.`DichVu` (`KieuThue_idKieuThue` ASC) VISIBLE;

CREATE INDEX `fk_DichVu_LoaiDichVu1_idx` ON `database`.`DichVu` (`LoaiDichVu_idLoaiDichVu` ASC) VISIBLE;

DROP TABLE IF EXISTS `database`.`HopDong` ;

CREATE TABLE IF NOT EXISTS `database`.`HopDong` (
  `idHopDong` INT NOT NULL,
  `NgayLamHopDong` DATE NOT NULL,
  `NgayKetThuc` DATE NOT NULL,
  `TienDatCoc` INT NOT NULL,
  `TongTien` INT NOT NULL,
  `DichVu_idDichVu` INT NOT NULL,
  `KhachHang_idKhachHang` INT NOT NULL,
  `NhanVien_idNhanVien` INT NOT NULL,
  PRIMARY KEY (`idHopDong`))
ENGINE = InnoDB;

CREATE INDEX `fk_HopDong_DichVu1_idx` ON `database`.`HopDong` (`DichVu_idDichVu` ASC) VISIBLE;

CREATE INDEX `fk_HopDong_KhachHang1_idx` ON `database`.`HopDong` (`KhachHang_idKhachHang` ASC) VISIBLE;

CREATE INDEX `fk_HopDong_NhanVien1_idx` ON `database`.`HopDong` (`NhanVien_idNhanVien` ASC) VISIBLE;

DROP TABLE IF EXISTS `database`.`DichVuDiKem` ;

CREATE TABLE IF NOT EXISTS `database`.`DichVuDiKem` (
  `idDichVuDiKem` INT NOT NULL,
  `TenDichVuDiKem` VARCHAR(45) NOT NULL,
  `Gia` VARCHAR(45) NOT NULL,
  `DonVi` VARCHAR(45) NOT NULL,
  `TrangThaiKhaDung` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDichVuDiKem`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `database`.`HopDongChiTiet` ;

CREATE TABLE IF NOT EXISTS `database`.`HopDongChiTiet` (
  `idHopDongChiTiet` INT NOT NULL,
  `SoLuong` VARCHAR(45) NOT NULL,
  `HopDong_idHopDong` INT NOT NULL,
  `DichVuDiKem_idDichVuDiKem` INT NOT NULL,
  PRIMARY KEY (`idHopDongChiTiet`))
ENGINE = InnoDB;

CREATE INDEX `fk_HopDongChiTiet_HopDong1_idx` ON `database`.`HopDongChiTiet` (`HopDong_idHopDong` ASC) VISIBLE;

CREATE INDEX `fk_HopDongChiTiet_DichVuDiKem1_idx` ON `database`.`HopDongChiTiet` (`DichVuDiKem_idDichVuDiKem` ASC) VISIBLE;



