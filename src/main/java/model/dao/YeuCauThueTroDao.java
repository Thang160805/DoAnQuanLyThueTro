package model.dao;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.YeuCauThueTro;

public class YeuCauThueTroDao {
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
	
	public boolean insertYeuCauThueTro(YeuCauThueTro yctt) {
		Connect();
		String sql = "insert into YeuCauThueTro(ID_Phong,ID_TaiKhoan,NgayDonVao,ThoiHanThue,LoiNhan,LienHe) values(?,?,?,?,?,?)";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, yctt.getID_Phong());
			ps.setInt(2, yctt.getID_TaiKhoan());
			ps.setDate(3, yctt.getNgayDonVao());
			ps.setString(4, yctt.getThoiHanThue());
			ps.setString(5, yctt.getLoiNhan());
			ps.setString(6, yctt.getLienHe());
			int row = ps.executeUpdate();
			if(row>0) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public ArrayList<YeuCauThueTro> getListYeuCau(){
		Connect();
		ArrayList<YeuCauThueTro> list = new ArrayList<YeuCauThueTro>();
		String sql = "select yc.*,pt.TenPhong,tt.HoTen,tt.SDT,tt.Avatar from YeuCauThueTro yc join PhongTro pt on yc.ID_Phong=pt.ID_Phong join TaiKhoan tk on yc.ID_TaiKhoan=tk.id "
				+ "join ThongTinNguoiDung tt on tk.id=tt.ID_TaiKhoan order by yc.create_at desc";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				YeuCauThueTro yc = new YeuCauThueTro();
				yc.setId(rs.getInt("id"));
				yc.setID_Phong(rs.getInt("ID_Phong"));
				yc.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
				yc.setTrangThai(rs.getString("TrangThai"));
				yc.setTenPhong(rs.getString("TenPhong"));
				yc.setHoTen(rs.getString("HoTen"));
				yc.setAvatar(rs.getString("Avatar"));
				yc.setSDT(rs.getString("SDT"));
				
				yc.setCreate_at(rs.getTimestamp("create_at").toLocalDateTime());
				list.add(yc);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getCountYeuCau() {
		Connect();
		int count = -1;
		String sql = "select count(*) as cnt from YeuCauThueTro";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("cnt");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
}
