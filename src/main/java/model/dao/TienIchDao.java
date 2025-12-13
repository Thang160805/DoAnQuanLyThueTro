package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.TienIch;

public class TienIchDao {
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
	
	public ArrayList<TienIch> getListTienIch(){
		Connect();
		ArrayList<TienIch> list = new ArrayList<TienIch>();
		String sql = "Select * from TienIch";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				TienIch ti = new TienIch();
				ti.setId(rs.getInt("id"));
				ti.setTenTienIch(rs.getString("TenTienIch"));
				list.add(ti);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<TienIch> getListTienIchByIDPhong(int ID_Phong){
		Connect();
		ArrayList<TienIch> list = new ArrayList<TienIch>();
		String sql = "select ti.TenTienIch from TienIch ti join PhongTro_TienIch pti on ti.id=pti.Id_Tienich where pti.Id_Phong=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_Phong);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				TienIch ti = new TienIch();
				ti.setTenTienIch(rs.getString("TenTienIch"));
				list.add(ti);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
		
	}
	
	 public void insertTienIchPhong(int idPhong, int idTienIch) {
		 Connect();
		 String sql = "INSERT INTO PhongTro_TienIch(Id_TienIch, Id_Phong) VALUES (?, ?)";
		 try {
			 PreparedStatement ps = connection.prepareStatement(sql);
			 ps.setInt(1, idTienIch);
			 ps.setInt(2, idPhong);
			 ps.executeUpdate();
			 
			 
		 }catch(Exception e) {
			 e.printStackTrace();
		 }
	 }
	 
	 
}
