package model.dao;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.PhongTro;
import model.bean.TaiKhoan;
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
				+ "join ThongTinNguoiDung tt on tk.id=tt.ID_TaiKhoan where yc.TrangThai = N'Chờ duyệt' order by yc.create_at desc";
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
		int count = 0;
		String sql = "select count(*) as cnt from YeuCauThueTro where TrangThai = N'Chờ duyệt'";
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
	
	public TaiKhoan getThongTinTaiKhoanByIDYeuCau(int ID_YeuCau) {
		Connect();
		TaiKhoan tk = null;
		String sql = "select tk.id,tt.HoTen,tt.SDT,tt.Email,tt.CCCD,tt.GioiTinh,tt.DiaChi,tt.Avatar from TaiKhoan tk join YeuCauThueTro yc on tk.id=ID_TaiKhoan join ThongTinNguoiDung tt on tk.id=tt.ID_TaiKhoan where yc.id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_YeuCau);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				tk = new TaiKhoan();
				tk.setId(rs.getInt("id"));
				tk.setHoTen(rs.getString("HoTen"));
				tk.setSDT(rs.getString("SDT"));
				tk.setEmail(rs.getString("Email"));
				tk.setCCCD(rs.getString("CCCD"));
				tk.setGioiTinh(rs.getInt("GioiTinh"));
				tk.setDiaChi(rs.getString("DiaChi"));
				tk.setAvatar(rs.getString("Avatar"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return tk;
	}
	
	public PhongTro getThongTinPhongByIDYeuCau(int ID_YeuCau) {
		Connect();
		PhongTro pt = null;
		String sql = "select pt.ID_Phong,pt.TenPhong,pt.DiaChi,pt.GiaThue,pt.AnhChinh,pt.GiaDien,pt.GiaNuoc from PhongTro pt join YeuCauThueTro yc on pt.ID_Phong=yc.ID_Phong where yc.id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_YeuCau);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				pt = new PhongTro();
				pt.setID_Phong(rs.getInt("ID_Phong"));
				pt.setTenPhong(rs.getString("TenPhong"));
				pt.setDiaChi(rs.getString("DiaChi"));
				pt.setGiaThue(rs.getInt("GiaThue"));
				pt.setAnhChinh(rs.getString("AnhChinh"));
				pt.setGiaDien(rs.getInt("GiaDien"));
				pt.setGiaNuoc(rs.getInt("GiaNuoc"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return pt;
	}
	
	public YeuCauThueTro getChiTietYeuCauThueByID(int ID_YeuCau) {
		Connect();
		YeuCauThueTro yc = null;
		String sql = "select * from YeuCauThueTro where id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, ID_YeuCau);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				yc = new YeuCauThueTro();
				yc.setId(rs.getInt("id"));
				yc.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
				yc.setNgayDonVao(rs.getDate("NgayDonVao"));
				yc.setThoiHanThue(rs.getString("ThoiHanThue"));
				yc.setLoiNhan(rs.getString("LoiNhan"));
				yc.setTrangThai(rs.getString("TrangThai"));
				yc.setLienHe(rs.getString("LienHe"));
				TaiKhoan tk = getThongTinTaiKhoanByIDYeuCau(ID_YeuCau);
				yc.setTaiKhoan(tk);
				PhongTro pt = getThongTinPhongByIDYeuCau(ID_YeuCau);
				yc.setPhongTro(pt);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return yc;
	}
	
	public boolean UpdateTrangThaiYeuCauThue(int ID_YeuCau,String TrangThai) {
		Connect();
		String sql = "update YeuCauThueTro set TrangThai=? where id=?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, TrangThai);
			ps.setInt(2, ID_YeuCau);
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
