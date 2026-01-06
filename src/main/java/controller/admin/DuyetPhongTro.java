package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.PhongTro;
import model.bean.TaiKhoan;
import model.bean.ThongBao;
import model.bo.PhongTroBO;
import model.bo.ThongBaoBO;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class DuyetPhongTro
 */
@WebServlet("/DuyetPhongTro")
public class DuyetPhongTro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DuyetPhongTro() {
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
	    int idPhong = Integer.parseInt(request.getParameter("idPhong"));
	    PhongTroBO ptBO = new PhongTroBO();
	    boolean checked = ptBO.UpdateTrangThaiDuyet(idPhong);
	    ThongBaoBO tbBO = new ThongBaoBO();
	    PhongTro pt = ptBO.getPhongTroById(idPhong);
	    ThongBao tb = new ThongBao();
	    tb.setSender_id(user.getId());
	    tb.setReceiver_id(pt.getID_ChuTro());
	    tb.setTitle("Phòng đã được duyệt");
	    tb.setFull_content("Chúc mừng! Phòng \"" + pt.getTenPhong() + "\" tại " + pt.getDiaChi() + " đã được phê duyệt và hiển thị công khai.");
	    if(checked) {
	    	tbBO.insertGuiThongBao(tb);
	    	out.write("{\"success\":true}");
	    }else {
	    	out.write("{\"success\":false,\"message\":\"Duyệt thất bại\"}");
	    }
	}

}
