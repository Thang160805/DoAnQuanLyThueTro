package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.CuocTroChuyen;

public class CuocTroChuyenDao {
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
	
	public int getIDOrInsert(int user1, int user2) {
	    Connect();
	    String findSql = "SELECT ID_CuocTroChuyen FROM CuocTroChuyen WHERE (User1 = ? AND User2 = ?) OR (User1 = ? AND User2 = ?)";


	    try {
	    	PreparedStatement ps = connection.prepareStatement(findSql);
	        ps.setInt(1, user1);
	        ps.setInt(2, user2);
	        ps.setInt(3, user2);
	        ps.setInt(4, user1);

	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            return rs.getInt("ID_CuocTroChuyen");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    String insertSql = "INSERT INTO CuocTroChuyen (User1, User2) OUTPUT INSERTED.ID_CuocTroChuyen VALUES (?, ?)";

	    try (PreparedStatement ps = connection.prepareStatement(insertSql)) {
	        ps.setInt(1, user1);
	        ps.setInt(2, user2);

	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return -1;
	}

	
	public void insertCuocTroChuyen(int User1,int User2) {
		Connect();
		String sql = "INSERT INTO CuocTroChuyen (User1, User2) VALUES (?, ?)";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, User1);
			ps.setInt(2, User2);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<CuocTroChuyen> getListNguoiTroChuyenByID(int ID_ChuTro) {
	    Connect();
	    ArrayList<CuocTroChuyen> list = new ArrayList<>();

	    String sql =
	        "SELECT ct.ID_CuocTroChuyen, " +
	        "CASE WHEN ct.User1 = ? THEN ct.User2 ELSE ct.User1 END AS ID_NguoiNhan, " +
	        "tt.HoTen, tt.Avatar " +
	        "FROM CuocTroChuyen ct " +
	        "JOIN TaiKhoan tk ON tk.id = CASE WHEN ct.User1 = ? THEN ct.User2 ELSE ct.User1 END " +
	        "JOIN ThongTinNguoiDung tt ON tt.ID_TaiKhoan = tk.id " +
	        "WHERE ct.User1 = ? OR ct.User2 = ?";

	    try {
	        PreparedStatement ps = connection.prepareStatement(sql);
	        ps.setInt(1, ID_ChuTro);
	        ps.setInt(2, ID_ChuTro);
	        ps.setInt(3, ID_ChuTro);
	        ps.setInt(4, ID_ChuTro);

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            CuocTroChuyen ctc = new CuocTroChuyen();
	            ctc.setID_CuocTroChuyen(rs.getInt("ID_CuocTroChuyen"));
	            ctc.setID_NguoiNhan(rs.getInt("ID_NguoiNhan"));
	            ctc.setTenNguoiNhan(rs.getString("HoTen"));
	            ctc.setAvatar(rs.getString("Avatar"));
	            list.add(ctc);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

}
