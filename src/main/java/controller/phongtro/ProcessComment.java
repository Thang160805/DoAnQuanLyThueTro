package controller.phongtro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bo.PhongTroBO;

import java.io.IOException;

/**
 * Servlet implementation class ProcessComment
 */
@WebServlet(name = "Comment", urlPatterns = { "/Comment" })
public class ProcessComment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessComment() {
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
		PhongTroBO ptBO = new PhongTroBO();
		int Id_Phong = Integer.parseInt(request.getParameter("id_Phong"));
		int rating = Integer.parseInt(request.getParameter("rating"));
		String comment = request.getParameter("comment");
		
		ptBO.createComment(Id_Phong, user.getId(), comment, rating);
		response.sendRedirect(request.getContextPath() + "/ChiTietPhong_1?ID_Phong=" + Id_Phong);
	}

}
