package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.bean.TaiKhoan;
import utils.HashUtil;

public class TaiKhoanDao {
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
	
	public TaiKhoan checkLogin(String TenDangNhap, String matKhauPlain) {
		Connect();
		TaiKhoan tk = null;
		String sql = "select * from TaiKhoan where TenDangNhap=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, TenDangNhap);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				String hashInDb = rs.getString("MatKhau");
				String hashInput = HashUtil.md5(matKhauPlain == null ? "" : matKhauPlain);
				if (hashInput.equalsIgnoreCase(hashInDb)) {
	                tk = new TaiKhoan();
	                tk.setId(rs.getInt("id"));
	                tk.setTenDangNhap(rs.getString("TenDangNhap"));
	                tk.setMatKhau(hashInDb);
	                tk.setRole(rs.getInt("Role"));
	                return tk;
	            }
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int insertTaiKhoanReturnID(TaiKhoan tk) {
	    int newId = -1;
	    try {
	        Connect();
	        String sql =
	        	    "INSERT INTO TaiKhoan(TenDangNhap, MatKhau, Role) VALUES (?, ?, ?); " +
	        	    "SELECT SCOPE_IDENTITY();";

	        	PreparedStatement ps = connection.prepareStatement(sql);
	        	ps.setString(1, tk.getTenDangNhap());
	        	ps.setString(2, tk.getMatKhau());
	        	ps.setInt(3, tk.getRole());

	        	ResultSet rs = ps.executeQuery();
	        	if (rs.next()) {
	        	    newId = rs.getInt(1);
	        	}
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return newId;
	}
	
	public boolean checkUserName(String username) {
		Connect();
		boolean f = false;
		String sql = "select * from TaiKhoan where TenDangNhap=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				f=true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
	public boolean checkPassword(int id, String passwordInput) {
	    Connect();
	    String sql = "select * from TaiKhoan where id=?";
	    try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				String hashInDb = rs.getString("MatKhau");
				String hashInput = HashUtil.md5(passwordInput == null ? "" : passwordInput);
				if (hashInput.equalsIgnoreCase(hashInDb)) {
	                return true;
	            }
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	    
	    return false;
	}
	
	public boolean ChangePass(int id,String newPass) {
		Connect();
		String sql = "update TaiKhoan set MatKhau=? where id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, HashUtil.md5(newPass));
			ps.setInt(2, id);
			int row = ps.executeUpdate();
			if(row>0) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public TaiKhoan getThongTinCaNhan(int id) {
		Connect();
		TaiKhoan tk = null;
		String sql = "select * from TaiKhoan tk join ThongTinNguoiDung tt on tk.id=tt.ID_TaiKhoan where tk.id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				tk = new TaiKhoan();
				tk.setId(rs.getInt("id"));
				tk.setHoTen(rs.getString("HoTen"));
				tk.setEmail(rs.getString("Email"));
				tk.setCCCD(rs.getString("CCCD"));
				tk.setDiaChi(rs.getString("DiaChi"));
				tk.setGioiTinh(rs.getInt("GioiTinh"));
				tk.setNgaySinh(rs.getDate("NgaySinh"));
				tk.setAvatar(rs.getString("Avatar"));
				tk.setSDT(rs.getString("SDT"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return tk;
	}
	
	public boolean updateThongTinCaNhan(TaiKhoan tk) {
		Connect();
		String sql = "update ThongTinNguoiDung set HoTen=?,SDT=?,CCCD=?,DiaChi=?,NgaySinh=?,GioiTinh=?,Email=? where ID_TaiKhoan=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, tk.getHoTen());
			ps.setString(2, tk.getSDT());
			ps.setString(3, tk.getCCCD());
			ps.setString(4, tk.getDiaChi());
			ps.setDate(5, tk.getNgaySinh());
			ps.setInt(6, tk.getGioiTinh());
			ps.setString(7, tk.getEmail());
			ps.setInt(8, tk.getId());
			int row = ps.executeUpdate();
			if(row>0) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean updateAvatar(int id, String imgURL) {
		Connect();
		String sql = "update ThongTinNguoiDung set Avatar=? where ID_TaiKhoan=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, imgURL);
			ps.setInt(2, id);
			int row = ps.executeUpdate();
			if(row > 0) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	

	
	public boolean DoiMatKhau(String TenDangNhap,String MatKhau) {
		Connect();
		String sql = "update TaiKhoan set MatKhau=? where TenDangNhap=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, HashUtil.md5(MatKhau));
			ps.setString(2, TenDangNhap);
			int row=ps.executeUpdate();
			if(row>0) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public TaiKhoan getThongTinByTenDN(String TenDangNhap) {
		Connect();
		TaiKhoan tk = null;
		String sql = "select tt.HoTen,tt.Email,tt.Avatar from TaiKhoan tk join ThongTinNguoiDung tt on tk.id=tt.ID_TaiKhoan where tk.TenDangNhap=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, TenDangNhap);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				tk = new TaiKhoan();
				tk.setHoTen(rs.getString("HoTen"));
				tk.setEmail(rs.getString("Email"));
				tk.setAvatar(rs.getString("Avatar"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return tk;
	}
	
	public boolean existsThongTinNguoiDungById(int id) {
	    Connect();
	    String sql = "select count(*) from ThongTinNguoiDung where ID_TaiKhoan=?";
	    try {
	        PreparedStatement ps = connection.prepareStatement(sql);
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();
	        if(rs.next()) {
	            int count = rs.getInt(1);
	            System.out.println("CHECK EXISTS ID = " + id + " → count = " + count);
	            return count > 0;
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public boolean insertThongTinNguoiDung(TaiKhoan tk) {
		Connect();
		String sql = "insert into ThongTinNguoiDung(ID_TaiKhoan,HoTen,SDT,CCCD,DiaChi,NgaySinh,GioiTinh,Avatar) values(?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, tk.getId());
			ps.setString(2, tk.getHoTen());
			ps.setString(3, tk.getSDT());
			ps.setString(4, tk.getCCCD());
			ps.setString(5, tk.getDiaChi());
			ps.setDate(6, tk.getNgaySinh());
			ps.setInt(7, tk.getGioiTinh());
			ps.setString(8, tk.getAvatar());
			int row = ps.executeUpdate();
			if(row>0) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean insertAnh(int id, String linkAnh) {
	    Connect();

	    String sql = "INSERT INTO ThongTinNguoiDung(ID_TaiKhoan, HoTen, SDT, CCCD, DiaChi, NgaySinh, GioiTinh, Avatar) VALUES (?, NULL, NULL, NULL, NULL, NULL, NULL, ?)";

	    try {
	        PreparedStatement ps = connection.prepareStatement(sql);
	        ps.setInt(1, id);
	        ps.setString(2, linkAnh);

	        int rows = ps.executeUpdate();

	        return rows > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public TaiKhoan getNgayThamGia(int ID_ChuTro) {
		Connect();
		TaiKhoan tk = null;
		String sql = "select NgayTao from TaiKhoan where id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_ChuTro);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				tk = new TaiKhoan();
				tk.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return tk;
	}
	
	
	
	public void insertThongTinNguoiDungMoi(int ID_TaiKhoan) {
		Connect();
		String sql = "insert into ThongTinNguoiDung(ID_TaiKhoan) values(?)";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_TaiKhoan);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<TaiKhoan> getListTaiKhoan(){
		Connect();
		ArrayList<TaiKhoan> list = new ArrayList<TaiKhoan>();
		String sql = "Select tk.id,tk.Role,tk.TrangThai,tk.NgayTao,tt.* from TaiKhoan tk join ThongTinNguoiDung tt on tk.id=tt.ID_TaiKhoan where tk.role in(1,2)";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				TaiKhoan tk = new TaiKhoan();
				tk.setId(rs.getInt("id"));
				tk.setRole(rs.getInt("Role"));
				tk.setTrangthai(rs.getInt("TrangThai"));
				tk.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
				tk.setHoTen(rs.getString("HoTen"));
				tk.setEmail(rs.getString("Email"));
				tk.setSDT(rs.getString("SDT"));
				tk.setAvatar(rs.getString("Avatar"));
				list.add(tk);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getCountTaiKhoan() {
		Connect();
		String sql = "select count(*) as cnt from TaiKhoan where TrangThai=1";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				return rs.getInt("cnt");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public ArrayList<Integer> getAllAdmins(){
		Connect();
		ArrayList<Integer> listID = new ArrayList<Integer>();
		String sql = "select id from TaiKhoan where Role=0 and TrangThai=1";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				listID.add(rs.getInt("id"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return listID;
	}

}
