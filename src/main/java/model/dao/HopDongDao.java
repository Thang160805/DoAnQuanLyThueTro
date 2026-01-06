package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.HopDong;

public class HopDongDao {
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
	
	
	
	public boolean taoHopDongVaCapNhatPhong(HopDong hd) {
	    Connect();
	    try {
	        connection.setAutoCommit(false);

	
	        String sqlHD = "update HopDong set NgayBatDau=?,NgayKetThuc=?,ThoiHanThue=?,TienCoc=?,NgayThanhToanHangThang=?,TongThuBanDau=?,DieuKhoan=?,TrangThai=N'Đang hiệu lực' where id=?";
	        PreparedStatement ps = connection.prepareStatement(sqlHD);
			ps.setDate(1, hd.getNgayBatDau());
			ps.setDate(2, hd.getNgayKetThuc());
			ps.setString(3, hd.getThoiHanThue());
			ps.setInt(4, hd.getTienCoc());
			ps.setString(5, hd.getNgayThanhToanHangThang());
			ps.setInt(6, hd.getTongThuBanDau());
			ps.setString(7, hd.getDieuKhoan());
			ps.setInt(8, hd.getId());
	        ps.executeUpdate();

	
	        String sqlPhong = "UPDATE PhongTro SET TrangThai = N'Đã thuê' WHERE ID_Phong = ?";
	        PreparedStatement ps2 = connection.prepareStatement(sqlPhong);
	        ps2.setInt(1, hd.getID_Phong());
	        ps2.executeUpdate();

	        connection.commit();
	        return true;

	    } catch (Exception e) {
	        try {
	            connection.rollback();
	        } catch (Exception ex) {
	            ex.printStackTrace();
	        }
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public boolean phongDaCoHopDong(int idPhong) {
	    Connect();
	    String sql = "SELECT COUNT(*) FROM HopDong WHERE ID_Phong = ? AND TrangThai = N'Đang hiệu lực'";
	    try {
	        PreparedStatement ps = connection.prepareStatement(sql);
	        ps.setInt(1, idPhong);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1) > 0;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public ArrayList<HopDong> getListHopDong() {
		Connect();
		ArrayList<HopDong> list = new ArrayList<HopDong>();
		String sql = "Select hd.*,tt.HoTen,pt.TenPhong from HopDong hd join ThongTinNguoiDung tt on hd.ID_NguoiThue=tt.ID_TaiKhoan join PhongTro pt on hd.ID_Phong=pt.ID_Phong order by created_at desc";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				HopDong hd = new HopDong();
				hd.setId(rs.getInt("id"));
				hd.setID_YeuCau(rs.getInt("ID_YeuCau"));
				hd.setID_NguoiThue(rs.getInt("ID_NguoiThue"));
				hd.setID_ChuTro(rs.getInt("ID_ChuTro"));
				hd.setID_Phong(rs.getInt("ID_Phong"));
				hd.setNgayBatDau(rs.getDate("NgayBatDau"));
				hd.setNgayKetThuc(rs.getDate("NgayKetThuc"));
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
	
	public HopDong getHopDongByID(int id) {
		Connect();
		HopDong hd = null;
		String sql = "select * from HopDong where id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				hd = new HopDong();
				hd.setId(rs.getInt("id"));
				hd.setID_YeuCau(rs.getInt("ID_YeuCau"));
				hd.setID_NguoiThue(rs.getInt("ID_NguoiThue"));
				hd.setID_ChuTro(rs.getInt("ID_ChuTro"));
				hd.setID_Phong(rs.getInt("ID_Phong"));
				hd.setNgayBatDau(rs.getDate("NgayBatDau"));
				hd.setNgayKetThuc(rs.getDate("NgayKetThuc"));
				hd.setThoiHanThue(rs.getString("ThoiHanThue"));
				hd.setTienCoc(rs.getInt("TienCoc"));
				hd.setNgayThanhToanHangThang(rs.getString("NgayThanhToanHangThang"));
				hd.setTongThuBanDau(rs.getInt("TongThuBanDau"));
				hd.setDieuKhoan(rs.getString("DieuKhoan"));
				hd.setTrangThai(rs.getString("TrangThai"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return hd;
	}
	
	public boolean CapNhatTrangThaiHD(int id) {
		Connect();
		String sql = "update HopDong set TrangThai = N'Đã kết thúc' where id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			int row = ps.executeUpdate();
			if(row > 0) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public void insertHopDong(int ID_YeuCau,int ID_NguoiThue,int ID_ChuTro,int ID_Phong) {
		Connect();
		String sql = "insert into HopDong(ID_YeuCau,ID_NguoiThue,ID_ChuTro,ID_Phong) values(?,?,?,?)";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_YeuCau);
			ps.setInt(2, ID_NguoiThue);
			ps.setInt(3, ID_ChuTro);
			ps.setInt(4, ID_Phong);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteHopDongKoDuocDuyet(int ID_Phong, int idHopDong) {
		Connect();
		String sql = "delete from HopDong where ID_Phong=? and id!=? and TrangThai=N'Chờ tạo hợp đồng'";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_Phong);
			ps.setInt(2, idHopDong);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getTotalCountListHDById(int ID_NguoiThue) {
		Connect();
		int totalCount = 1;
		String sql = "select count(*) as cnt from HopDong where ID_NguoiThue=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_NguoiThue);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("cnt");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}
	
	public ArrayList<HopDong> getListHopDongByIDNguoiThue(int ID_NguoiThue,int page){
		Connect();
		int pageSize = 6; 
		int start = (page - 1) * pageSize;
		ArrayList<HopDong> list = new ArrayList<HopDong>();
		String sql = "select hd.*,pt.TenPhong,pt.AnhChinh from HopDong hd join PhongTro pt on hd.ID_Phong=pt.ID_Phong where hd.ID_NguoiThue=? and hd.TrangThai in(N'Đang hiệu lực',N'Đã kết thúc') order by hd.created_at desc "
				+ "OFFSET " + start + " ROWS FETCH NEXT " + pageSize + " ROWS ONLY";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_NguoiThue);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				HopDong hd = new HopDong();
				hd.setId(rs.getInt("id"));
				hd.setID_ChuTro(rs.getInt("ID_ChuTro"));
				hd.setID_NguoiThue(rs.getInt("ID_NguoiThue"));
				hd.setID_Phong(rs.getInt("ID_Phong"));
				hd.setID_YeuCau(rs.getInt("ID_YeuCau"));
				hd.setNgayBatDau(rs.getDate("NgayBatDau"));
				hd.setNgayKetThuc(rs.getDate("NgayKetThuc"));
				hd.setThoiHanThue(rs.getString("ThoiHanThue"));
				hd.setTongThuBanDau(rs.getInt("TongThuBanDau"));
				hd.setTrangThai(rs.getString("TrangThai"));
				hd.setTenPhong(rs.getString("TenPhong"));
				hd.setAnhPhong(rs.getString("AnhChinh"));
				list.add(hd);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<HopDong> getListPhongDaThueById(int ID_NguoiThue){
		Connect();
		ArrayList<HopDong> list = new ArrayList<HopDong>();
		String sql = "select pt.ID_Phong,pt.TenPhong,pt.DiaChi,pt.AnhChinh from HopDong hd join PhongTro pt on hd.ID_Phong=pt.ID_Phong where ID_NguoiThue=? group by pt.ID_Phong,pt.TenPhong,pt.DiaChi,pt.AnhChinh";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_NguoiThue);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				HopDong hd = new HopDong();
				hd.setID_Phong(rs.getInt("ID_Phong"));
				hd.setTenPhong(rs.getString("TenPhong"));
				hd.setDiaChi(rs.getString("DiaChi"));
				hd.setAnhPhong(rs.getString("AnhChinh"));
				list.add(hd);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<HopDong> getListNguoiThue(){
		Connect();
		ArrayList<HopDong> listNT = new ArrayList<HopDong>();
		String sql = "select hd.ID_NguoiThue,tt.HoTen from HopDong hd join ThongTinNguoiDung tt on hd.ID_NguoiThue=tt.ID_TaiKhoan where hd.TrangThai = N'Đang hiệu lực'";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				HopDong hd = new HopDong();
				hd.setID_NguoiThue(rs.getInt("ID_NguoiThue"));
				hd.setTenNguoiThue(rs.getString("HoTen"));
				listNT.add(hd);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return listNT;
	}
	
	public ArrayList<Integer> listID_NguoiThue(){
		Connect();
		ArrayList<Integer> listID = new ArrayList<Integer>();
		String sql = "select ID_NguoiThue from HopDong where TrangThai = N'Đang hiệu lực'";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				listID.add(rs.getInt("ID_NguoiThue"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return listID;
	}
	
}
