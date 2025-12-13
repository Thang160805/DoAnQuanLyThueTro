package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.HopDong;

public class HopDongDao {
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
	
	
	
	public boolean taoHopDongVaCapNhatPhong(HopDong hd) {
	    Connect();
	    try {
	        connection.setAutoCommit(false);

	
	        String sqlHD = "insert into HopDong(ID_NguoiThue,ID_ChuTro,ID_Phong,NgayBatDau,NgayKetThuc,ThoiHanThue,TienCoc,NgayThanhToanHangThang,TongThuBanDau,DieuKhoan)"
					+ " values(?,?,?,?,?,?,?,?,?,?)";
	        PreparedStatement ps = connection.prepareStatement(sqlHD);
	        ps.setInt(1, hd.getID_NguoiThue());
			ps.setInt(2, hd.getID_ChuTro());
			ps.setInt(3, hd.getID_Phong());
			ps.setDate(4, hd.getNgayBatDau());
			ps.setDate(5, hd.getNgayKetThuc());
			ps.setString(6, hd.getThoiHanThue());
			ps.setInt(7, hd.getTienCoc());
			ps.setString(8, hd.getNgayThanhToanHangThang());
			ps.setInt(9, hd.getTongThuBanDau());
			ps.setString(10, hd.getDieuKhoan());
	        ps.executeUpdate();

	
	        String sqlPhong = "UPDATE PhongTro SET TrangThai = N'Đã thuê' WHERE ID_Phong = ?";
	        PreparedStatement ps2 = connection.prepareStatement(sqlPhong);
	        ps2.setInt(1, hd.getID_Phong());
	        ps2.executeUpdate();

	        connection.commit();
	        return true;

	    } catch (Exception e) {
	        try {
	            connection.rollback();
	        } catch (Exception ex) {
	            ex.printStackTrace();
	        }
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public boolean phongDaCoHopDong(int idPhong) {
	    Connect();
	    String sql = "SELECT COUNT(*) FROM HopDong WHERE ID_Phong = ? AND TrangThai = N'Đang hiệu lực'";
	    try {
	        PreparedStatement ps = connection.prepareStatement(sql);
	        ps.setInt(1, idPhong);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1) > 0;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public ArrayList<HopDong> getListHopDong() {
		Connect();
		ArrayList<HopDong> list = new ArrayList<HopDong>();
		String sql = "Select hd.*,tt.HoTen,pt.TenPhong from HopDong hd join ThongTinNguoiDung tt on hd.ID_NguoiThue=tt.ID_TaiKhoan join PhongTro pt on hd.ID_Phong=pt.ID_Phong order by created_at desc";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				HopDong hd = new HopDong();
				hd.setId(rs.getInt("id"));
				hd.setID_NguoiThue(rs.getInt("ID_NguoiThue"));
				hd.setID_ChuTro(rs.getInt("ID_ChuTro"));
				hd.setID_Phong(rs.getInt("ID_Phong"));
				hd.setNgayBatDau(rs.getDate("NgayBatDau"));
				hd.setNgayKetThuc(rs.getDate("NgayKetThuc"));
				hd.setTrangThai(rs.getString("TrangThai"));
				hd.setTenNguoiThue(rs.getString("HoTen"));
				hd.setTenPhong(rs.getString("TenPhong"));
				list.add(hd);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public HopDong getHopDongByID(int id) {
		Connect();
		HopDong hd = null;
		String sql = "select * from HopDong where id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				hd = new HopDong();
				hd.setId(rs.getInt("id"));
				hd.setNgayBatDau(rs.getDate("NgayBatDau"));
				hd.setNgayKetThuc(rs.getDate("NgayKetThuc"));
				hd.setThoiHanThue(rs.getString("ThoiHanThue"));
				hd.setTienCoc(rs.getInt("TienCoc"));
				hd.setNgayThanhToanHangThang(rs.getString("NgayThanhToanHangThang"));
				hd.setTongThuBanDau(rs.getInt("TongThuBanDau"));
				hd.setDieuKhoan(rs.getString("DieuKhoan"));
				hd.setTrangThai(rs.getString("TrangThai"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return hd;
	}
	
	public boolean CapNhatTrangThaiHD(int id) {
		Connect();
		String sql = "update HopDong set TrangThai = N'Đã kết thúc' where id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
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
