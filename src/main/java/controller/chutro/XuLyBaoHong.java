
package controller.chutro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bean.ThongBao;
import model.bo.BaoHongBO;
import model.bo.ThongBaoBO;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class XuLyBaoHong
 */
@WebServlet("/XuLyBaoHong")
public class XuLyBaoHong extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XuLyBaoHong() {
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
		int idBaoHong = Integer.parseInt(request.getParameter("idBaoHong"));
		int idNguoiGui = Integer.parseInt(request.getParameter("idNguoiGui"));
		String title = "Tiếp nhận xử lý báo hỏng";

		String full_content = "Báo hỏng của bạn đã được tiếp nhận và đang được xử lý. "
		        + "Nhân viên kỹ thuật sẽ kiểm tra và khắc phục sự cố trong thời gian sớm nhất. "
		        + "Vui lòng theo dõi tiến độ xử lý trong hệ thống.";
		ThongBao tb = new ThongBao();
		tb.setSender_id(user.getId());
		tb.setReceiver_id(idNguoiGui);
		tb.setTitle(title);
		tb.setFull_content(full_content);
		BaoHongBO bhBO = new BaoHongBO();
		ThongBaoBO tbBO = new ThongBaoBO();
		boolean checked = bhBO.updateTrangThaiXuLy(idBaoHong);
		if(checked) {
			tbBO.insertGuiThongBao(tb);
			 out.print("{\"success\": true, \"message\": \"Đã tiếp nhận và bắt đầu xử lý báo hỏng\"}");
		}else {
			out.print("{\"success\": false, \"message\": \"Không thể cập nhật trạng thái báo hỏng\"}");
		}
	}

}
