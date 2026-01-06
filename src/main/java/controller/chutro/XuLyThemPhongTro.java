package controller.chutro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.bean.PhongTro;
import model.bean.TaiKhoan;
import model.bean.ThongBao;
import model.bo.PhongTroBO;
import model.bo.TaiKhoanBO;
import model.bo.ThongBaoBO;
import model.bo.TienIchBO;
import utils.ImagesHelper;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * Servlet implementation class XuLyThemPhongTro
 */
@WebServlet("/XuLyThemPhongTro")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,    
        maxFileSize = 1024 * 1024 * 20,         
        maxRequestSize = 1024 * 1024 * 50       
)
public class XuLyThemPhongTro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XuLyThemPhongTro() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		TaiKhoan user = (TaiKhoan) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String tenPhong = request.getParameter("tenPhong");
        String diaChi = request.getParameter("diaChi");
        String giaThueStr = request.getParameter("giaThue");
        String dienTichStr = request.getParameter("dienTich");
        String giaDienStr = request.getParameter("giaDien");
        String giaNuocStr = request.getParameter("giaNuoc");
        String moTa = request.getParameter("moTa");
        int idKhuVuc = Integer.parseInt(request.getParameter("khuVuc"));

       
        String[] tienIchList = request.getParameterValues("tienIchList[]");
        Part anhChinh = request.getPart("anhChinh");
        String anhChinhLink = ImagesHelper.saveRoomImage(anhChinh, getServletContext());
        
        ArrayList<String> anhPhuLinks = 
                ImagesHelper.saveMultipleRoomImages(request.getParts(), getServletContext());
        
        if (tenPhong == null || tenPhong.trim().isEmpty()) {
            out.write("{\"success\": false, \"message\": \"Tên phòng không được để trống!\"}");
            return;
        }
        
        if (diaChi == null || diaChi.trim().isEmpty()) {
            out.write("{\"success\": false, \"message\": \"Địa chỉ không được để trống!\"}");
            return;
        }
        
        if (giaThueStr == null || giaThueStr.isEmpty()) {
            out.write("{\"success\": false, \"message\": \"Giá thuê không được để trống!\"}");
            return;
        }
        
        if (!giaThueStr.matches("\\d+")) {
            out.write("{\"success\": false, \"message\": \"Giá thuê phải là số hợp lệ!\"}");
            return;
        }
        
        int giaThue = Integer.parseInt(giaThueStr);
        if (giaThue <= 0) {
            out.write("{\"success\": false, \"message\": \"Giá thuê phải lớn hơn 0!\"}");
            return;
        }
        
        if (dienTichStr == null || dienTichStr.isEmpty()) {
            out.write("{\"success\": false, \"message\": \"Diện tích không được để trống!\"}");
            return;
        }
        
        if (!dienTichStr.matches("\\d+(\\.\\d+)?")) {
            out.write("{\"success\": false, \"message\": \"Diện tích phải là số hợp lệ!\"}");
            return;
        }
        
        float dienTich = Float.parseFloat(dienTichStr);
        if (dienTich <= 14) {
            out.write("{\"success\": false, \"message\": \"Diện tích phải lớn hơn 14!\"}");
            return;
        }
        
        if (giaDienStr == null || giaDienStr.isEmpty()) {
            out.write("{\"success\": false, \"message\": \"Giá điện không được để trống!\"}");
            return;
        }
        
        if (!giaDienStr.matches("\\d+(\\.\\d+)?")) {
            out.write("{\"success\": false, \"message\": \"Giá điện phải là số hợp lệ!\"}");
            return;
        }
        
        int giaDien = Integer.parseInt(giaDienStr);
        if (giaDien <= 2999) {
            out.write("{\"success\": false, \"message\": \"Giá điện phải từ 3.000đ!\"}");
            return;
        }
        
        if (giaNuocStr == null || giaNuocStr.isEmpty()) {
            out.write("{\"success\": false, \"message\": \"Giá nước không được để trống!\"}");
            return;
        }
        
        if (!giaNuocStr.matches("\\d+(\\.\\d+)?")) {
            out.write("{\"success\": false, \"message\": \"Giá nước phải là số hợp lệ!\"}");
            return;
        }
        
        int giaNuoc = Integer.parseInt(giaNuocStr);
        if (giaNuoc <= 2399) {
            out.write("{\"success\": false, \"message\": \"Giá điện phải từ 2.400đ!\"}");
            return;
        }
        
        if (moTa == null || moTa.trim().isEmpty()) {
            out.write("{\"success\": false, \"message\": \"Mô tả chi tiết không được để trống!\"}");
            return;
        }
        
        if (anhChinh == null || anhChinh.getSize() == 0) {
            out.write("{\"success\": false, \"message\": \"Bạn phải chọn ảnh chính cho phòng trọ!\"}");
            return;
        }

        if (anhPhuLinks == null || anhPhuLinks.isEmpty()) {
            out.write("{\"success\": false, \"message\": \"Bạn phải chọn ít nhất 1 ảnh phụ!\"}");
            return;
        }
        
        
        PhongTro pt = new PhongTro();
        PhongTroBO ptBO = new PhongTroBO();
        TienIchBO tiBO = new TienIchBO();
        
        pt.setID_ChuTro(user.getId());
        pt.setID_KhuVuc(idKhuVuc);
        pt.setTenPhong(tenPhong);
        pt.setDiaChi(diaChi);
        pt.setGiaThue(giaThue);
        pt.setDienTich(dienTich);
        pt.setMoTa(moTa);
        pt.setAnhChinh(anhChinhLink);
        pt.setGiaDien(giaDien);
        pt.setGiaNuoc(giaNuoc);
        
        ThongBaoBO tbBO = new ThongBaoBO();
        TaiKhoanBO tkBO = new TaiKhoanBO();
        TaiKhoan tk1 = tkBO.getThongTinCaNhan(user.getId());
        ThongBao tb = new ThongBao();
        tb.setSender_id(user.getId());
        tb.setTitle("Phòng trọ mới chờ duyệt");
        tb.setFull_content(
            "Chủ trọ \"" + tk1.getHoTen() +
            "\" vừa đăng phòng \"" + tenPhong +
            "\" tại " + diaChi +
            ". Vui lòng kiểm tra và duyệt phòng."
        );
        boolean checked = ptBO.insertPhongTro(pt);
        if(checked) {
        	int id_Phong = ptBO.getNewId_Phong();
        	ptBO.insertAnhPhu(id_Phong, anhPhuLinks);
        	tiBO.insertTienIchForPhong(id_Phong, tienIchList);
        	response.getWriter().write("{\"success\": true}");
        	tbBO.sendThongBaoToAdmins(tb);
        }else {
            response.getWriter().write("{\"success\": false}");
        }
	}

}
