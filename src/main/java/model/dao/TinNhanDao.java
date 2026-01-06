package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.TinNhan;

public class TinNhanDao {
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
	
	public TinNhan insertAndReturnTinNhan(int idCTC, int idNguoiGui, String noiDung) {
	    Connect();

	    String sql =
	        "INSERT INTO TinNhan (ID_CuocTroChuyen, ID_NguoiGui, NoiDung) " +
	        "OUTPUT INSERTED.ID_TinNhan, INSERTED.ID_NguoiGui, INSERTED.NoiDung, INSERTED.ThoiGian " +
	        "VALUES (?, ?, ?)";

	    try (PreparedStatement ps = connection.prepareStatement(sql)) {
	        ps.setInt(1, idCTC);
	        ps.setInt(2, idNguoiGui);
	        ps.setString(3, noiDung);

	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            TinNhan tn = new TinNhan();
	            tn.setID_TinNhan(rs.getInt("ID_TinNhan"));
	            tn.setID_NguoiGui(rs.getInt("ID_NguoiGui"));
	            tn.setNoiDung(rs.getString("NoiDung"));
	            tn.setThoiGian(rs.getTimestamp("ThoiGian").toLocalDateTime());
	            return tn;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	
	public ArrayList<TinNhan> getTinNhanByID(int ID_CuocTroChuyen){
		Connect();
		ArrayList<TinNhan> list = new ArrayList<TinNhan>();
		String sql = "select * from TinNhan where ID_CuocTroChuyen=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_CuocTroChuyen);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				TinNhan tn = new TinNhan();
	            tn.setID_TinNhan(rs.getInt("ID_TinNhan"));
	            tn.setID_NguoiGui(rs.getInt("ID_NguoiGui"));
	            tn.setNoiDung(rs.getString("NoiDung"));
	            tn.setThoiGian(rs.getTimestamp("ThoiGian").toLocalDateTime());
	            list.add(tn);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public TinNhan getNewTinNhan(int ID_CuocTroChuyen) {
		Connect();
		TinNhan tn = null;
		String sql = "SELECT TOP 1 * FROM TinNhan WHERE ID_CuocTroChuyen = ? ORDER BY ThoiGian DESC;";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_CuocTroChuyen);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				tn = new TinNhan();
				tn.setID_NguoiGui(rs.getInt("ID_NguoiGui"));
				tn.setNoiDung(rs.getString("NoiDung"));
				tn.setThoiGian(rs.getTimestamp("ThoiGian").toLocalDateTime());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return tn;
	}
}
