-- b2
select * from nhanvien
where (left(HoTen,1) in ('H' , 'K' , 'T')) and (length(HoTen)  < 15);

-- b3
select * from khachhang
where (year(curdate()) - year(NgaySinh) between 23 and  50 ) and  DiaChi in ('Đà nẵng' , 'Quảng Trị');


-- b4
SELECt  kh.idKhachHang,count(*)as solandatphong
FROM hopdong hd
inner join khachhang kh 
ON kh.idKhachHang=hd.idKhachHang
inner join loaikhach lk
ON kh.LoaiKhach_idLoaiKhach=lk.idLoaiKhach
WHERE lk.idLoaiKhach=1
group by idKhachHang
order by solandatphong asc;


-- 5
with hd_cte as (
select kh.idKhachHang ,
kh.HoTen,
lk.TenLoaiKhach,
hd.idHopDong,
dv.TenDichVu,
hd.NgayLamHopDong,
hd.NgayKetThuc,
(dv.ChiPhiThue + dvdk.DonVi * dvdk.Gia) as TongTien
FROM hopdong as hd
INNER JOIN khachhang as kh
on hd.KhachHang_idKhachHang=kh.idKhachHang
inner join loaikhach as lk
on kh.LoaiKhach_idLoaiKhach=lk.idLoaiKhach
inner join dichvu as dv
on hd.DichVu_idDichVu=dv.idDichVu
inner join dichvudikem as dvdk
on dv.LoaiDichVu_idLoaiDichVu=dvdk.idDichVuDiKem 
group by kh.idKhachHang
)
select kh.idKhachHang,kh.HoTen,cte.TongTien
from hd_cte cte
right join khachhang kh
on cte.idKhachHang = kh.idKhachHang;

-- 6


with dichvu_cte as(
select distinct ldv.idLoaiDichVu ,
dv.idDichVu,
dv.TenDichVu,
dv.DienTich,dv.ChiPhiThue
FROM dichvu as dv
INNER JOIN loaidichvu as ldv
on dv.LoaiDichVu_idLoaiDichVu=ldv.idLoaiDichVu
inner join hopdong as hd
on hd.DichVu_idDichVu=dv.idDichVu
where year(hd.NgayLamHopDong) between '1998-01-01' and '1998-03-31'
)
select ldv.idLoaiDichVu ,
ldv.TenLoaiDichVu,cte.idDichVu,
cte.TenDichVu,cte.DienTich,
cte.ChiPhiThue
from dichvu_cte cte
right join loaidichvu ldv
on ldv.idLoaiDichVu = cte.idLoaiDichVu
where cte.idLoaiDichVu is null or ldv.idLoaiDichVu is null;


-- 7

with datphong_cte as (
select dv.idDichVu,
dv.TenDichVu,
dv.DienTich,
dv.SoNguoiToiDa,
dv.ChiPhiThue,
ldv.TenLoaiDichVu,
hd.NgayLamHopDong,
ldv.idLoaiDichVu
FROM dichvu as dv
INNER JOIN loaidichvu as ldv
on dv.LoaiDichVu_idLoaiDichVu = ldv.idLoaiDichVu
inner join hopdong as hd
on hd.DichVu_idDichVu = dv.idDichVu
where year(hd.NgayLamHopDong)=1998 and year(hd.NgayLamHopDong)<1999
)
select *
from datphong_cte cte
right join loaidichvu ldv
on cte.idLoaiDichVu = ldv.idLoaiDichVu 
where ldv.idLoaiDichVu is null or cte.idLoaiDichVu is null;

-- 8

-- C2: 
select HoTen from khachhang
group by HoTen
having count(*)<2;

-- 9

select month(hd.NgayLamHopDong) as thang, 
sum(TongTien),
extract(year from hd.NgayLamHopDong) as NamTinhTong
from hopdong hd
where year(hd.NgayLamHopDong) = 1998
group by month(hd.NgayLamHopDong);

-- 10

select  count(hd.idHopDong) as SoLuongDichVuDiKem,
hd.idHopDong,
group_concat(concat(dvdk.TenDichVuDiKem,' : ',dvdk.DonVi)separator ' , ') CacDichVuDiKem,
hd.NgayLamHopDong,
hd.NgayKetThuc,
hd.TienDatCoc
from dichvudikem dvdk
inner join hopdongchitiet hdct
on dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
inner join hopdong hd
on hdct.HopDong_idHopDong = hd.idHopDong
group by hd.idHopDong
;
-- 11

select kh.idKhachHang,
kh.HoTen,group_concat(dvdk.TenDichVuDiKem separator ' , ') DichVuDiKem,
sum(dvdk.Gia) as 'Giá :$',
dvdk.DonVi,lk.TenLoaiKhach
from dichvudikem dvdk
inner join hopdongchitiet hdct
	on dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
inner join hopdong hd
	on hdct.HopDong_idHopDong = hd.idHopDong
inner join khachhang kh
	on hd.KhachHang_idKhachHang = kh.idKhachHang
inner join loaikhach lk
	on kh.LoaiKhach_idLoaiKhach = lk.idLoaiKhach
where lk.TenLoaiKhach='Diamond' and kh.DiaChi in ('Vinh' ,'Quãng Ngãi')
group by kh.idKhachHang;

-- 12
with dv_cte as(
select * 
from hopdong hd
join khachhang kh
	on kh.idKhachHang = hd.KhachHang_idKhachHang
join dichvu dv
	on dv.idDichVu = hd.DichVu_idDichVu
join hopdongchitiet hdct
	on hdct.HopDong_idHopDong = hd.idHopDong
join dichvudikem dvdk
	on dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
where hd.NgayLamHopDong between '1998-09-01' and '1998-12-31'
)
select hd.idHopDong,
kh.HoTen,dv.TenDichVu,
hd.NgayLamHopDong,
group_concat(concat(dvdk.TenDichVuDiKem ,' : ',dvdk.DonVi) separator ',') as 'DichVuDiKem : SoLuong'
from hopdong hd
join khachhang kh
	on kh.idKhachHang = hd.KhachHang_idKhachHang
join dichvu dv
	on dv.idDichVu = hd.DichVu_idDichVu
join hopdongchitiet hdct
	on hdct.HopDong_idHopDong = hd.idHopDong
join dichvudikem dvdk
	on dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
left join dv_cte cte
	on cte.HopDong_idHopDong = hd.idHopDong
where dv.idDichVu is null or cte.idDichVu is null and hd.NgayLamHopDong between '1998-01-01' and '1998-5-31'
group by idHopDong;


-- 13
 select dvdk.idDichVuDiKem,dvdk.TenDichVuDiKem,count(dvdk.idDichVuDiKem) as SoLanSuDung
 from hopdong hd
 join hopdongchitiet hdct
 on hd.idHopDong = hdct.HopDong_idHopDong
 join dichvudikem dvdk
 on dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
 group by idDichVuDiKem;
 
 
 
 -- 14

	select hd.idHopDong,
	dvdk.TenDichVuDiKem,
	ldv.TenLoaiDichVu,
	count(hdct.DichVuDiKem_idDichVuDiKem) as SoLanSuDung
	from hopdong hd
	join hopdongchitiet hdct
	on hd.idHopDong = hdct.HopDong_idHopDong
	join dichvudikem dvdk
	on dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
	join dichvu dv
	on dv.idDichVu = hd.DichVu_idDichVu
	join loaidichvu ldv
	on ldv.idLoaiDichVu = dv.LoaiDichVu_idLoaiDichVu
	group by hdct.DichVuDiKem_idDichVuDiKem
	having count(*)<2;


-- 15
select nv.idNhanVien,
nv.HoTen,
td.TrinhDo,
bp.TenBoPhan,
nv.SDT,
nv.Email,
count(hd.NhanVien_idNhanVien) as SoHopDongDaLap 
from nhanvien nv
join hopdong hd
on hd.NhanVien_idNhanVien = nv.idNhanVien
join trinhdo td
on nv.TrinhDo_idTrinhDo = td.idTrinhDo
join bophan bp
on nv.BoPhan_idBoPhan = bp.idBoPhan
where year(hd.NgayLamHopDong) between 1998 and 2019
group by hd.NhanVien_idNhanVien
having count(*)=3
;

-- 16

SET SQL_SAFE_UPDATES = 0;

delete
from nhanvien 
where idNhanVien not in 
(
select id from 
(select idNhanVien id
from hopdong
join nhanvien
on idNhanVien = NhanVien_idNhanVien
where  year(NgayLamHopDong) between 1998 and 1999)  tb2
);

SET SQL_SAFE_UPDATES = 1;

-- 17

SET SQL_SAFE_UPDATES = 0;

update khachhang kh
join hopdong hd
on hd.KhachHang_idKhachHang = kh.idKhachHang
join loaikhach lk
on lk.idLoaiKhach = kh.LoaiKhach_idLoaiKhach
set kh.LoaiKhach_idLoaiKhach = 1
where lk.TenLoaiKhach = 'Platinium' 
and year(hd.NgayLamHopDong) = 2019 and hd.TongTien >7000;

SET SQL_SAFE_UPDATES = 1;


-- 18

SET FOREIGN_KEY_CHECKS=0;

delete
from khachhang 
where idKhachHang in 
(
select id from 
(select idKhachHang id
from hopdong
join khachhang
on idKhachHang = KhachHang_idKhachHang
where  year(NgayLamHopDong) < 1999)  tb2
);

SET FOREIGN_KEY_CHECKS=1;

-- 19

SET SQL_SAFE_UPDATES = 0;

update dichvudikem dvdk
join hopdongchitiet hdct
on  dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
join hopdong hd
on hd.idHopDong = hdct.HopDong_idHopDong 
set dvdk.Gia = dvdk.Gia *10
where dvdk.idDichVuDiKem in (
	select id from

(

select dvdk.idDichVuDiKem id
from dichvudikem dvdk
join hopdongchitiet hdct
on  dvdk.idDichVuDiKem = hdct.DichVuDiKem_idDichVuDiKem
join hopdong hd
on hd.idHopDong = hdct.HopDong_idHopDong 
group by dvdk.idDichVuDiKem
having count(dvdk.idDichVuDiKem) >=2) dv
)

;
SET SQL_SAFE_UPDATES = 1;


-- 20
select idNhanVien,HoTen,Email,SDT,NgaySinh,DiaChi
from nhanvien












