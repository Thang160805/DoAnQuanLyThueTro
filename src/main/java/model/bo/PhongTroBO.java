package model.bo;

import java.util.ArrayList;

import model.bean.Comment;
import model.bean.PhongTro;
import model.dao.PhongTroDao;

public class PhongTroBO {
	PhongTroDao ptDao =  new PhongTroDao();
	
	public ArrayList<PhongTro> getListPhongTroTrong(){
		return ptDao.getListPhongTroTrong();
	}
	
	public ArrayList<PhongTro> getListNewPhongTro(){
		return ptDao.getListNewPhongTro();
	}
	
	public int getTotalCountsPhongTrong(String filter) {
		return ptDao.getTotalCountsPhongTrong(filter);
	}
	
	public ArrayList<PhongTro> getListPhongTroTrong(String filter,int page){
		return ptDao.getListPhongTroTrong(filter,page);
	}
	
	public ArrayList<PhongTro> getListPhongTro(String orderBy,String order, String filter,int page){
		return ptDao.getListPhongTro(orderBy, order, filter, page);
	}
	
	public int getToTalCountKV() {
		return ptDao.getToTalCountKV();
	}
	
	public ArrayList<String> getListHinhAnhByIDPhong(int ID_Phong){
		return ptDao.getListHinhAnhByIDPhong(ID_Phong);
	}
	
	public ArrayList<Comment> getListCommentByIDPhong(int PhongTro_Id){
		return ptDao.getListCommentByIDPhong(PhongTro_Id);
	}
	
	public PhongTro getPhongTroById(int ID_Phong) {
		return ptDao.getPhongTroById(ID_Phong);
	}
	
	public void createComment(int Id_Phong,int id_TaiKhoan,String comment,int rating) {
		ptDao.createComment(Id_Phong, id_TaiKhoan, comment, rating);
	}
	
	public int getCountComment(int Id_Phong) {
		return ptDao.getCountComment(Id_Phong);
	}
	
	public int getAvgStarComment(int ID_Phong) {
		return ptDao.getAvgStarComment(ID_Phong);
	}
	
	public ArrayList<PhongTro> getListPhongByIDChuTro(int ID_TaiKhoan){
		return ptDao.getListPhongByIDChuTro(ID_TaiKhoan);
	}
	
	public int getCountSoPhongByIDChutro(int ID_ChuTro) {
		return ptDao.getCountSoPhongByIDChutro(ID_ChuTro);
	}
	
	public int getCountSoPhongTrongByIDCT(int ID_ChuTro) {
		return ptDao.getCountSoPhongTrongByIDCT(ID_ChuTro);
	}
	
	public int getCountSoPhongDaThueByIDCT(int ID_ChuTro) {
		return ptDao.getCountSoPhongDaThueByIDCT(ID_ChuTro);
	}
	

}
