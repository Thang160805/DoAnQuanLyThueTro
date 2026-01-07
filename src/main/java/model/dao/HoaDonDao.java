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
	
	public ArrayList<HoaDon> getListHoaDonByIdCT(int ID_ChuTro,String filter){
		Connect();
		ArrayList<HoaDon> list = new ArrayList<HoaDon>();
		String sql = "select hd.*,tt.HoTen,pt.TenPhong from HoaDon hd "
				+ "join ThongTinNguoiDung tt on hd.ID_NguoiThue=tt.ID_TaiKhoan "
				+ "join PhongTro pt on hd.ID_Phong=pt.ID_Phong where hd.ID_ChuTro=?"
				+(filter.isEmpty() ? "" : " " + filter + " ")
				+"order by hd.id desc";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_ChuTro);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
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
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
