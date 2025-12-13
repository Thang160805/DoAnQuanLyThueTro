package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.Comment;
import model.bean.PhongTro;

public class PhongTroDao {
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
	
	public ArrayList<PhongTro> getListPhongTroTrong(){
		Connect();
		ArrayList<PhongTro> list = new ArrayList<PhongTro>();
		String sql = "SELECT TOP 4 * FROM PhongTro WHERE TrangThai = N'Còn trống'";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				PhongTro pt = new PhongTro();
				pt.setID_Phong(rs.getInt("ID_Phong"));
				pt.setTenPhong(rs.getString("TenPhong"));
				pt.setDiaChi(rs.getString("DiaChi"));
				pt.setGiaThue(rs.getInt("GiaThue"));
				pt.setDienTich(rs.getFloat("DienTich"));
				pt.setTrangThai(rs.getString("TrangThai"));
				pt.setAnhChinh(rs.getString("AnhChinh"));
				list.add(pt);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<PhongTro> getListNewPhongTro(){
		Connect();
		ArrayList<PhongTro> list = new ArrayList<PhongTro>();
		String sql = "SELECT * FROM PhongTro where TrangThai=N'Còn trống' and NgayDang >= DATEADD(DAY, -20, GETDATE()) ORDER BY NgayDang DESC";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				PhongTro pt = new PhongTro();
				pt.setID_Phong(rs.getInt("ID_Phong"));
				pt.setTenPhong(rs.getString("TenPhong"));
				pt.setDiaChi(rs.getString("DiaChi"));
				pt.setGiaThue(rs.getInt("GiaThue"));
				pt.setDienTich(rs.getFloat("DienTich"));
				pt.setTrangThai(rs.getString("TrangThai"));
				pt.setAnhChinh(rs.getString("AnhChinh"));
				list.add(pt);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getTotalCountsPhongTrong(String filter) {
		Connect();
		String sql = "SELECT COUNT(*) as cnt FROM PhongTro pt WHERE pt.TrangThai = N'Còn trống' "
	               + (filter == null || filter.isEmpty() ? "" : " " + filter);
		int totalCount=1;
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("cnt");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}
	
	public ArrayList<PhongTro> getListPhongTroTrong(String filter, int page){
		Connect();
		ArrayList<PhongTro> list = new ArrayList<PhongTro>();
		int pageSize = 12; 
		int start = (page - 1) * pageSize;
		String sql = "SELECT * FROM PhongTro WHERE TrangThai = N'Còn trống' "+(filter.isEmpty() ? "" : " " + filter + " ")
				+"Order by ID_Phong "
				+ "OFFSET " + start + " ROWS FETCH NEXT " + pageSize + " ROWS ONLY";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				PhongTro pt = new PhongTro();
				pt.setID_Phong(rs.getInt("ID_Phong"));
				pt.setTenPhong(rs.getString("TenPhong"));
				pt.setDiaChi(rs.getString("DiaChi"));
				pt.setGiaThue(rs.getInt("GiaThue"));
				pt.setDienTich(rs.getFloat("DienTich"));
				pt.setTrangThai(rs.getString("TrangThai"));
				pt.setAnhChinh(rs.getString("AnhChinh"));
				list.add(pt);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getToTalCountKV() {
		Connect();
		String sql = "Select count(*) as cnt from PhongTro WHERE TrangThai = N'Còn trống' and ID_KhuVuc is not null";
		int totalCount=1;
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("cnt");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}
	
	
	public ArrayList<PhongTro> getListPhongTro(String orderBy,String order, String filter,int page){
		Connect();
		ArrayList<PhongTro> list = new ArrayList<PhongTro>();
		if(orderBy == null) {
			orderBy = "ID_Phong";
		}
		if(order == null) {
			order = "asc";
		}
		if(filter == null) {
			filter = "";
		}
		int pageSize = 12; 
		int start = (page - 1) * pageSize;
		String sql = "SELECT pt.* FROM PhongTro pt "
				+ "WHERE pt.TrangThai = N'Còn trống' "+(filter.isEmpty() ? "" : " " + filter + " ")
				+"ORDER BY pt." + orderBy + " " + order +" "
				+ "OFFSET " + start + " ROWS FETCH NEXT " + pageSize + " ROWS ONLY";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				PhongTro pt = new PhongTro();
				pt.setID_Phong(rs.getInt("ID_Phong"));
				pt.setTenPhong(rs.getString("TenPhong"));
				pt.setDiaChi(rs.getString("DiaChi"));
				pt.setGiaThue(rs.getInt("GiaThue"));
				pt.setDienTich(rs.getFloat("DienTich"));
				pt.setAnhChinh(rs.getString("AnhChinh"));
				list.add(pt);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<String> getListHinhAnhByIDPhong(int ID_Phong){
		Connect();
		ArrayList<String> list = new ArrayList<String>();
		String sql = "select linkAnh from HinhAnhPhong where ID_Phong=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_Phong);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				list.add(rs.getString("linkAnh"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Comment> getListCommentByIDPhong(int PhongTro_Id){
		Connect();
		ArrayList<Comment> list = new ArrayList<Comment>();
		String sql = "Select cm.id,tt.HoTen,tt.Avatar,cm.create_at,cm.comment,cm.rating from comments cm join TaiKhoan tk on cm.ID_TaiKhoan=tk.id join ThongTinNguoiDung tt on tk.id=tt.ID_TaiKhoan where cm.ID_Phong=? order by cm.create_at desc";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, PhongTro_Id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Comment cm = new Comment();
				cm.setId(rs.getInt("id"));
				cm.setTenNguoiDung(rs.getString("HoTen"));
				cm.setAvatar(rs.getString("Avatar"));
				cm.setCreate_at(rs.getTimestamp("create_at").toLocalDateTime());
				cm.setComment(rs.getString("comment"));
				cm.setRating(rs.getInt("rating"));
				list.add(cm);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	
	public PhongTro getPhongTroById(int ID_Phong) {
		Connect();
		PhongTro pt = null;
		String sql = "select pt.*,tt.HoTen,tt.SDT,tt.Avatar from PhongTro pt join TaiKhoan tk on pt.ID_ChuTro=tk.id join ThongTinNguoiDung tt on tk.id=tt.ID_TaiKhoan where pt.ID_Phong=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_Phong);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				pt = new PhongTro();
				pt.setID_Phong(rs.getInt("ID_Phong"));
				pt.setTenPhong(rs.getString("TenPhong"));
				pt.setDiaChi(rs.getString("DiaChi"));
				pt.setTrangThai(rs.getString("TrangThai"));
				pt.setDienTich(rs.getFloat("DienTich"));
				pt.setGiaThue(rs.getInt("GiaThue"));
				pt.setGiaDien(rs.getInt("GiaDien"));
				pt.setGiaNuoc(rs.getInt("GiaNuoc"));
				pt.setMoTa(rs.getString("MoTa"));
				pt.setAnhChinh(rs.getString("AnhChinh"));
				pt.setTenCT(rs.getString("HoTen"));
				pt.setPhone(rs.getString("SDT"));
				pt.setAvatar(rs.getString("Avatar"));
				ArrayList<Comment> cm = getListCommentByIDPhong(ID_Phong);
				pt.setComment(cm);
				ArrayList<String> img = getListHinhAnhByIDPhong(ID_Phong);
				pt.setHinhAnh(img);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return pt;
	}
	
	public void createComment(int Id_Phong,int id_TaiKhoan,String comment,int rating) {
		Connect();
		String sql = "insert into comments(ID_Phong,ID_TaiKhoan,comment,rating) values(?,?,?,?)";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, Id_Phong);
			ps.setInt(2, id_TaiKhoan);
			ps.setString(3, comment);
			ps.setInt(4, rating);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public int getCountComment(int Id_Phong) {
		Connect();
		int count = 0;
		String sql = "select Count(*) as cnt from comments where ID_Phong =?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, Id_Phong);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("cnt");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public int getAvgStarComment(int ID_Phong) {
		Connect();
		int avg = 0;
		String sql = "select avg(rating) as avg from comments where ID_Phong=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_Phong);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				avg = rs.getInt("avg");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return avg;
	}
	
	public ArrayList<PhongTro> getListPhongByIDChuTro(int ID_TaiKhoan){
		Connect();
		ArrayList<PhongTro> list = new ArrayList<PhongTro>();
		String sql = "select pt.ID_Phong,pt.AnhChinh,pt.TenPhong,pt.GiaThue,tt.HoTen,tt.SDT,pt.TrangThai from PhongTro pt join TaiKhoan tk on pt.ID_ChuTro=tk.id "
				+ "join ThongTinNguoiDung tt on tk.id=tt.ID_TaiKhoan where pt.ID_ChuTro=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_TaiKhoan);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				PhongTro pt = new PhongTro();
				pt.setID_Phong(rs.getInt("ID_Phong"));
				pt.setAnhChinh(rs.getString("AnhChinh"));
				pt.setTenPhong(rs.getString("TenPhong"));
				pt.setGiaThue(rs.getInt("GiaThue"));
				pt.setTenCT(rs.getString("HoTen"));
				pt.setPhone(rs.getString("SDT"));
				pt.setTrangThai(rs.getString("TrangThai"));
				list.add(pt);
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getCountSoPhongByIDChutro(int ID_ChuTro) {
		Connect();
		int count=0;
		String sql = "select count(*) as rc from PhongTro where ID_ChuTro=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_ChuTro);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("rc");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public int getCountSoPhongTrongByIDCT(int ID_ChuTro) {
		Connect();
		int count=0;
		String sql = "select count(*) as rc from PhongTro where ID_ChuTro=? and TrangThai=N'Còn Trống'";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_ChuTro);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("rc");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	
	public int getCountSoPhongDaThueByIDCT(int ID_ChuTro) {
		Connect();
		int count=0;
		String sql = "select count(*) as rc from PhongTro where ID_ChuTro=? and TrangThai=N'Đã thuê'";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_ChuTro);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("rc");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public void insertAnhPhu(int idPhong, ArrayList<String> dsAnh) {
		Connect();
		 String sql = "INSERT INTO HinhAnhPhong(ID_Phong, linkAnh) VALUES (?, ?)";
		 try {
			 PreparedStatement ps = connection.prepareStatement(sql);
			 for (String link : dsAnh) {
	                ps.setInt(1, idPhong);
	                ps.setString(2, link);
	                ps.executeUpdate();
	            }
		 }catch(Exception e) {
			 e.printStackTrace();
		 }
		
	}
	
	public boolean insertPhongTro(PhongTro pt) {
		Connect();
		String sql = "insert into PhongTro(ID_ChuTro,ID_KhuVuc,TenPhong,DiaChi,GiaThue,DienTich,MoTa,AnhChinh,GiaDien,GiaNuoc) "
				+ "values(?,?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, pt.getID_ChuTro());
			ps.setInt(2, pt.getID_KhuVuc());
			ps.setString(3, pt.getTenPhong());
			ps.setString(4, pt.getDiaChi());
			ps.setInt(5, pt.getGiaThue());
			ps.setFloat(6, pt.getDienTich());
			ps.setString(7, pt.getMoTa());
			ps.setString(8, pt.getAnhChinh());
			ps.setInt(9, pt.getGiaDien());
			ps.setInt(10, pt.getGiaNuoc());
			int row = ps.executeUpdate();
			if(row > 0) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public int getNewId_Phong() {
		Connect();
		int ID_Phong=0;
		String sql = "select max(ID_Phong) as cnt from PhongTro";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				ID_Phong = rs.getInt("cnt");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ID_Phong;
	}
	
	public void deletePhongTro_TienIch(int ID_Phong) {
		Connect();
		String sql = "delete from PhongTro_TienIch where ID_Phong=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_Phong);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteHinhAnhPhong(int ID_Phong) {
		Connect();
		String sql = "delete from HinhAnhPhong where ID_Phong=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_Phong);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteYeuCauThueTro(int ID_Phong) {
		Connect();
		String sql = "delete from YeuCauThueTro where ID_Phong=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_Phong);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean deletePhongTro(int ID_Phong) {
		Connect();
		String sql = "delete from PhongTro where ID_Phong=? and TrangThai = N'Còn trống'";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_Phong);
			int row = ps.executeUpdate();
			if(row > 0) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean UpdatePhongTro(PhongTro pt) {
		Connect();
		String sql = "update PhongTro set ID_KhuVuc=?,TenPhong=?,DiaChi=?,GiaThue=?,DienTich=?,MoTa=?,AnhChinh=?,GiaDien=?,GiaNuoc=? where ID_Phong=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, pt.getID_KhuVuc());
			ps.setString(2, pt.getTenPhong());
			ps.setString(3, pt.getDiaChi());
			ps.setInt(4, pt.getGiaThue());
			ps.setFloat(5, pt.getDienTich());
			ps.setString(6, pt.getMoTa());
			ps.setString(7, pt.getAnhChinh());
			ps.setInt(8, pt.getGiaDien());
			ps.setInt(9, pt.getGiaNuoc());
			ps.setInt(10, pt.getID_Phong());
			int row = ps.executeUpdate();
			if(row > 0) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean CapNhatTrangThaiPhong(int ID_Phong) {
		Connect();
		String sql = "update PhongTro set TrangThai = N'Còn trống' where ID_Phong=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_Phong);
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
