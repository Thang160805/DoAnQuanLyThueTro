package model.dao;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
}
