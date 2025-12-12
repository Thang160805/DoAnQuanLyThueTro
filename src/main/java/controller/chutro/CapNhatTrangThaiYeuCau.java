package controller.chutro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bean.ThongBao;
import model.bo.ThongBaoBO;
import model.bo.YeuCauThueTroBO;

import java.io.IOException;

/**
 * Servlet implementation class CapNhatTrangThaiYeuCau
 */
@WebServlet("/CapNhatTrangThaiYeuCau")
public class CapNhatTrangThaiYeuCau extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CapNhatTrangThaiYeuCau() {
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
		int idYeuCau = Integer.parseInt(request.getParameter("idYeuCau"));
		int idNguoi = Integer.parseInt(request.getParameter("idTaiKhoan"));
		String trangThai = request.getParameter("trangThai");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String full_content = request.getParameter("fullcontent");
		ThongBao tb = new ThongBao();
		tb.setReceiver_id(idNguoi);
		tb.setSender_id(user.getId());
		tb.setTitle(title);
		tb.setContent(content);
		tb.setFull_content(full_content);
		YeuCauThueTroBO ycBO = new YeuCauThueTroBO();
		ThongBaoBO tbBO = new ThongBaoBO();
		boolean checked = ycBO.UpdateTrangThaiYeuCauThue(idYeuCau, trangThai);
		if (checked) {
			tbBO.insertGuiThongBao(tb);
            response.getWriter().write("{\"success\": true}");
        } else {
            response.getWriter().write("{\"success\": false}");
        }

	}

}
