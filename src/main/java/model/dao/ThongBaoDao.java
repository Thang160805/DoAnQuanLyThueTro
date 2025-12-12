package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.ThongBao;

public class ThongBaoDao {
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
	
	public ArrayList<ThongBao> getListThongBaoById(int Id_TaiKhoan){
		Connect();
		ArrayList<ThongBao> list = new ArrayList<ThongBao>();
		String sql = "select tb.*,tk.Role from ThongBao tb left join TaiKhoan tk on tb.sender_id=tk.id where tb.receiver_id=? order by tb.created_at desc";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, Id_TaiKhoan);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ThongBao tb = new ThongBao();
				tb.setId(rs.getInt("id"));
				tb.setReceiver_id(rs.getInt("receiver_id"));
				tb.setSender_id(rs.getInt("sender_id"));
				tb.setTitle(rs.getString("title"));
				tb.setContent(rs.getString("content"));
				tb.setType(rs.getString("type"));
				tb.setIs_read(rs.getInt("is_read"));
				tb.setCreate_at(rs.getTimestamp("created_at").toLocalDateTime());
				tb.setRole(rs.getInt("Role"));
				list.add(tb);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public void DocTatCa(int ID_TaiKhoan) {
		Connect();
		String sql = "update ThongBao set is_read=1 where receiver_id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_TaiKhoan);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ThongBao getThongBaoById(int id) {
		Connect();
		ThongBao  tb = null;
		String sql = "select tb.*,tk.Role from ThongBao tb left join TaiKhoan tk on tb.sender_id=tk.id where tb.id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				tb = new ThongBao();
				tb.setId(rs.getInt("id"));
				tb.setReceiver_id(rs.getInt("receiver_id"));
				tb.setSender_id(rs.getInt("sender_id"));
				tb.setTitle(rs.getString("title"));
				tb.setType(rs.getString("type"));
				tb.setFull_content(rs.getString("full_content"));
				tb.setCreate_at(rs.getTimestamp("created_at").toLocalDateTime());
				tb.setRole(rs.getInt("Role"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return tb;
	}
	
	public int getIsReadById(int id) {
		Connect();
		int is_read=0;
		String sql = "select is_read ThongBao where id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				is_read = rs.getInt("is_read");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return is_read;
	}
	
	public void DaDocById(int id) {
		Connect();
		String sql = "update ThongBao set is_read=1 where id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getCountThongBao(int TaiKhoan_id) {
		Connect();
		int totalCount = 1;
		String sql = "Select count(*) as cnt from ThongBao where receiver_id=? and is_read=0";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, TaiKhoan_id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("cnt");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}
	
	public ArrayList<ThongBao> getTop3TB(int id){
		Connect();
		ArrayList<ThongBao> list = new ArrayList<ThongBao>();
		String sql = "select Top 3 * from ThongBao tb left join TaiKhoan tk on tb.sender_id=tk.id where tb.receiver_id=? order by created_at desc";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ThongBao tb = new ThongBao();
				tb.setId(rs.getInt("id"));
				tb.setReceiver_id(rs.getInt("receiver_id"));
				tb.setSender_id(rs.getInt("sender_id"));
				tb.setTitle(rs.getString("title"));
				list.add(tb);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public void insertGuiThongBao(ThongBao tb) {
		Connect();
		String sql = "insert into ThongBao(receiver_id,sender_id,title,content,full_content) values(?,?,?,?,?)";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, tb.getReceiver_id());
			ps.setInt(2, tb.getSender_id());
			ps.setString(3, tb.getTitle());
			ps.setString(4, tb.getContent());
			ps.setString(5, tb.getFull_content());
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
