package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.KhuVuc;

public class KhuVucDao {
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
	
	public ArrayList<KhuVuc> getListKhuVuc(){
		Connect();
		ArrayList<KhuVuc> list = new ArrayList<KhuVuc>();
		String sql = "Select * from KhuVuc";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				KhuVuc kv = new KhuVuc();
				kv.setId(rs.getInt("id"));
				kv.setTenKhuVuc(rs.getString("TenKhuVuc"));
				list.add(kv);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public ArrayList<KhuVuc> getListKhuVucSoPhong(){
		Connect();
		ArrayList<KhuVuc> list = new ArrayList<KhuVuc>();
		String sql = "select kv.id,kv.TenKhuVuc,count(pt.ID_Phong) as SoPhong from KhuVuc kv "
				+ "left join PhongTro pt on kv.id = pt.ID_KhuVuc GROUP BY kv.id, kv.TenKhuVuc ORDER BY kv.TenKhuVuc";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				KhuVuc kv = new KhuVuc();
				kv.setId(rs.getInt("id"));
				kv.setTenKhuVuc(rs.getString("TenKhuVuc"));
				kv.setSoPhong(rs.getInt("SoPhong"));
				list.add(kv);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
}
