package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.HoaDon;

public class HoaDonDao {
	public Connection connection;
	void Connect() {
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			connection = DriverManager.getConnection(DBConnect.url,DBConnect.user,DBConnect.pass);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<HoaDon> getListHoaDonByIdCT(int idChuTro, String thangNam) {
	    Connect();
	    ArrayList<HoaDon> list = new ArrayList<>();

	    String sql = "SELECT hd.*, tt.HoTen, pt.TenPhong " +
	                 "FROM HoaDon hd " +
	                 "JOIN ThongTinNguoiDung tt ON hd.ID_NguoiThue = tt.ID_TaiKhoan " +
	                 "JOIN PhongTro pt ON hd.ID_Phong = pt.ID_Phong " +
	                 "WHERE hd.ID_ChuTro = ? ";

	    if (thangNam != null && !thangNam.isEmpty()) {
	        sql += " AND hd.ThangNam = ? ";
	    }

	    sql += " ORDER BY hd.id DESC";

	    try {
	        PreparedStatement ps = connection.prepareStatement(sql);
	        ps.setInt(1, idChuTro);

	        if (thangNam != null && !thangNam.isEmpty()) {
	            ps.setString(2, thangNam);
	        }

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            HoaDon hd = new HoaDon();
	            hd.setId(rs.getInt("id"));
	            hd.setID_HopDong(rs.getInt("ID_HopDong"));
	            hd.setID_NguoiThue(rs.getInt("ID_NguoiThue"));
	            hd.setID_ChuTro(rs.getInt("ID_ChuTro"));
	            hd.setID_Phong(rs.getInt("ID_Phong"));
	            hd.setThangNam(rs.getString("ThangNam"));
	            hd.setTongTien(rs.getInt("TongTien"));
	            hd.setTrangThai(rs.getString("TrangThai"));
	            hd.setTenNguoiThue(rs.getString("HoTen"));
	            hd.setTenPhong(rs.getString("TenPhong"));
	            list.add(hd);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	
	public boolean themHoaDonThanhToan(HoaDon hd) {
		Connect();
		String sql = "insert into HoaDon(ID_HopDong,ID_NguoiThue,ID_ChuTro,ID_Phong,ThangNam,TienPhong,TienDien,TienNuoc,TongTien,HanThanhToan,GhiChu)"
				+ " values(?,?,?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, hd.getID_HopDong());
			ps.setInt(2, hd.getID_NguoiThue());
			ps.setInt(3, hd.getID_ChuTro());
			ps.setInt(4, hd.getID_Phong());
			ps.setString(5, hd.getThangNam());
			ps.setInt(6, hd.getTienPhong());
			ps.setInt(7, hd.getTienDien());
			ps.setInt(8, hd.getTienNuoc());
			ps.setInt(9, hd.getTongTien());
			ps.setDate(10, hd.getHanThanhToan());
			String ghiChu = hd.getGhiChu();

			if (ghiChu == null || ghiChu.trim().isEmpty()) {
			    ps.setNull(11, java.sql.Types.NVARCHAR);
			} else {
			    ps.setString(11, ghiChu);
			}
			int row = ps.executeUpdate();
			if(row > 0) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public HoaDon getChiTietHoaDonById(int idHoaDon) {
		Connect();
		HoaDon hd = null;
		String sql = "select hd.*,tt.HoTen,pt.TenPhong,pt.DiaChi,pt.GiaDien,pt.GiaNuoc from HoaDon hd "
				+ "join ThongTinNguoiDung tt on hd.ID_NguoiThue=tt.ID_TaiKhoan "
				+ "join PhongTro pt on hd.ID_Phong=pt.ID_Phong where hd.id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, idHoaDon);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				hd = new HoaDon();
				hd.setId(rs.getInt("id"));
				hd.setID_NguoiThue(rs.getInt("ID_NguoiThue"));
				hd.setID_ChuTro(rs.getInt("ID_ChuTro"));
				hd.setID_Phong(rs.getInt("ID_Phong"));
				hd.setThangNam(rs.getString("ThangNam"));
				hd.setTienPhong(rs.getInt("TienPhong"));
				hd.setTienDien(rs.getInt("TienDien"));
				hd.setTienNuoc(rs.getInt("TienNuoc"));
				hd.setTongTien(rs.getInt("TongTien"));
				hd.setHanThanhToan(rs.getDate("HanThanhToan"));
				hd.setTrangThai(rs.getString("TrangThai"));
				hd.setGhiChu(rs.getString("GhiChu"));
				hd.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
				hd.setTenNguoiThue(rs.getString("HoTen"));
				hd.setTenPhong(rs.getString("TenPhong"));
				hd.setDiaChiPhong(rs.getString("DiaChi"));
				hd.setGiaDien(rs.getInt("GiaDien"));
				hd.setGiaNuoc(rs.getInt("GiaNuoc"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return hd;
	}
	
	public int getTotalCountListHDById(int ID_NguoiThue) {
		Connect();
		int totalCount = 1;
		String sql = "select count(*) as cnt from HoaDon where ID_NguoiThue=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_NguoiThue);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("cnt");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}
	
	public ArrayList<HoaDon> getHoaDonByID_NguoiThue(int idNguoiThue,int page) {
		Connect();
		int pageSize = 4; 
		int start = (page - 1) * pageSize;
		ArrayList<HoaDon> list = new ArrayList<HoaDon>();
		String sql = "select hd.*,tt.HoTen,pt.TenPhong,pt.DiaChi,pt.AnhChinh from HoaDon hd "
				+ "join ThongTinNguoiDung tt on hd.ID_ChuTro=tt.ID_TaiKhoan "
				+ "join PhongTro pt on hd.ID_Phong=pt.ID_Phong "
				+ "where hd.ID_NguoiThue=? "
				+ "order by hd.created_at desc "
				+ "OFFSET " + start + " ROWS FETCH NEXT " + pageSize + " ROWS ONLY";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, idNguoiThue);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				HoaDon hd = new HoaDon();
				hd.setId(rs.getInt("id"));
				hd.setThangNam(rs.getString("ThangNam"));
				hd.setHanThanhToan(rs.getDate("HanThanhToan"));
				hd.setTrangThai(rs.getString("TrangThai"));
				hd.setTenChuTro(rs.getString("HoTen"));
				hd.setTenPhong(rs.getString("TenPhong"));
				hd.setDiaChiPhong(rs.getString("DiaChi"));
				hd.setAnhPhong(rs.getString("AnhChinh"));
				list.add(hd);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public void capNhatHoaDonTreHan() {
	    Connect();
	    String sql = "UPDATE HoaDon SET TrangThai = N'Trễ hạn' WHERE TrangThai = N'Chưa thanh toán' AND HanThanhToan < CAST(GETDATE() AS DATE)";
	    try {
	        PreparedStatement ps = connection.prepareStatement(sql);
	        ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	public HoaDon getHoaDonThanhToanById(int idHoaDon) {
		Connect();
		HoaDon hd = null;
		String sql = "select hd.*,tt.HoTen,pt.TenPhong,pt.DiaChi,pt.GiaDien,pt.GiaNuoc,qr.QR from HoaDon hd "
				+ "join ThongTinNguoiDung tt on hd.ID_ChuTro=tt.ID_TaiKhoan "
				+ "join QRThanhToan qr on hd.ID_ChuTro=qr.ID_ChuTro "
				+ "join PhongTro pt on hd.ID_Phong=pt.ID_Phong where hd.id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, idHoaDon);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				hd = new HoaDon();
				hd.setId(rs.getInt("id"));
				hd.setID_NguoiThue(rs.getInt("ID_NguoiThue"));
				hd.setID_ChuTro(rs.getInt("ID_ChuTro"));
				hd.setID_Phong(rs.getInt("ID_Phong"));
				hd.setThangNam(rs.getString("ThangNam"));
				hd.setTienPhong(rs.getInt("TienPhong"));
				hd.setTienDien(rs.getInt("TienDien"));
				hd.setTienNuoc(rs.getInt("TienNuoc"));
				hd.setTongTien(rs.getInt("TongTien"));
				hd.setHanThanhToan(rs.getDate("HanThanhToan"));
				hd.setTrangThai(rs.getString("TrangThai"));
				hd.setGhiChu(rs.getString("GhiChu"));
				hd.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
				hd.setTenChuTro(rs.getString("HoTen"));
				hd.setTenPhong(rs.getString("TenPhong"));
				hd.setDiaChiPhong(rs.getString("DiaChi"));
				hd.setGiaDien(rs.getInt("GiaDien"));
				hd.setGiaNuoc(rs.getInt("GiaNuoc"));
				hd.setQRThanhToan(rs.getString("QR"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return hd;
	}
	
	public boolean updateTrangThaiHoaDon(int idHoaDon) {
		Connect();
		String sql = "update HoaDon set TrangThai = N'Đã thanh toán' where id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, idHoaDon);
			int row = ps.executeUpdate();
			if(row > 0) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}


}
