package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.bean.BaoHong;

public class BaoHongDao {
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
	
	public void insertAnhBaoHong(int ID_BaoHong, ArrayList<String> dsAnhBaoHong) {
		Connect();
		String sql = "insert into AnhBaoHong(ID_BaoHong,linkAnh) values(?,?)";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			for (String link : dsAnhBaoHong) {
                ps.setInt(1, ID_BaoHong);
                ps.setString(2, link);
                ps.executeUpdate();
            }
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int insertBaoHong(BaoHong bh) {
		Connect();
		String sql = "insert into BaoHong(ID_Phong,ID_NguoiGui,TieuDe,LoaiHuHong,MucDoUuTien,MoTa) values(?,?,?,?,?,?)";
		try {
			PreparedStatement ps = connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, bh.getID_Phong());
	        ps.setInt(2, bh.getID_NguoiGui());
	        ps.setString(3, bh.getTieuDe());
	        ps.setString(4, bh.getLoaiHuHong());
	        ps.setString(5, bh.getMucDoUuTien());
	        ps.setString(6, bh.getMoTa());
	        int affectedRows = ps.executeUpdate();

	        if (affectedRows == 0) {
	            return -1;
	        }
	        ResultSet rs = ps.getGeneratedKeys();
	        if (rs.next()) {
	            return rs.getInt(1);
	        }
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<BaoHong> getTOP3BaoHongByID_NguoiGui(int ID_NguoiGui){
		Connect();
		ArrayList<BaoHong> list = new ArrayList<BaoHong>();
		String sql = "select TOP 3 * from BaoHong where ID_NguoiGui=? order by ThoiGianGui desc";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_NguoiGui);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				BaoHong bh = new BaoHong();
				bh.setId(rs.getInt("id"));
				bh.setTieuDe(rs.getString("TieuDe"));
				bh.setLoaiHuHong(rs.getString("LoaiHuHong"));
				bh.setTrangThai(rs.getString("TrangThai"));
				bh.setThoiGianGui(rs.getTimestamp("ThoiGianGui").toLocalDateTime());
				list.add(bh);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public ArrayList<BaoHong> listBaoHong(){
		Connect();
		ArrayList<BaoHong> list = new ArrayList<BaoHong>();
		String sql = "select bh.*,tt.HoTen,tt.Avatar,pt.TenPhong from BaoHong bh "
				+ "join ThongTinNguoiDung tt on bh.ID_NguoiGui=tt.ID_TaiKhoan "
				+ "join PhongTro pt on bh.ID_Phong=pt.ID_Phong where bh.TrangThai in(N'Chờ xử lý',N'Đang xử lý')";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				BaoHong bh = new BaoHong();
				bh.setId(rs.getInt("id"));
				bh.setTieuDe(rs.getString("TieuDe"));
				bh.setLoaiHuHong(rs.getString("LoaiHuHong"));
				bh.setMucDoUuTien(rs.getString("MucDoUuTien"));
				bh.setTrangThai(rs.getString("TrangThai"));
				bh.setThoiGianGui(rs.getTimestamp("ThoiGianGui").toLocalDateTime());
				bh.setTenPhong(rs.getString("TenPhong"));
				bh.setTenNguoiGui(rs.getString("HoTen"));
				bh.setAvatar(rs.getString("Avatar"));
				list.add(bh);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
