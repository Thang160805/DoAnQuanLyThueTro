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
 * Servlet implementation class TuChoiPhongTro
 */
@WebServlet("/TuChoiPhongTro")
public class TuChoiPhongTro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TuChoiPhongTro() {
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
	    String idPhongStr = request.getParameter("idPhong");
        String lyDo = request.getParameter("lyDo");

        if (idPhongStr == null || idPhongStr.isEmpty()) {
            out.write("{\"success\":false,\"message\":\"Thiếu ID phòng\"}");
            return;
        }

        if (lyDo == null || lyDo.trim().isEmpty()) {
            out.write("{\"success\":false,\"message\":\"Vui lòng nhập lý do từ chối\"}");
            return;
        }

        int idPhong = Integer.parseInt(idPhongStr);
	    PhongTroBO ptBO = new PhongTroBO();
	    ThongBaoBO tbBO = new ThongBaoBO();
	    PhongTro pt = ptBO.getPhongTroById(idPhong);
	    ThongBao tb = new ThongBao();
	    tb.setSender_id(user.getId());
	    tb.setReceiver_id(pt.getID_ChuTro());
	    tb.setTitle("Bài đăng phòng bị từ chối");
	    tb.setFull_content("Bài đăng phòng \"" + pt.getTenPhong() + "\" tại " + pt.getDiaChi()
	          + " bị từ chối.\nLý do: " + lyDo + "\nVui lòng chỉnh sửa và gửi lại.");
	    ptBO.deletePhongTro_TienIch(idPhong);
		ptBO.deleteHinhAnhPhong(idPhong);
		ptBO.deleteYeuCauThueTro(idPhong);
		boolean checked = ptBO.deletePhongTro(idPhong);
		if(checked) {
			tbBO.insertGuiThongBao(tb);
	    	out.write("{\"success\":true}");
		}else {
			out.write("{\"success\":false,\"message\":\"Không thể xoá phòng\"}");
            return;
		}
	}

}
