package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bo.TaiKhoanBO;
//import model.bo.TaiKhoanBO;
import utils.HashUtil;

import java.io.IOException;
import java.net.http.HttpRequest;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/DangNhapServlet")
public class LoginFilter extends HttpFilter implements Filter {

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public LoginFilter() {
		super();
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		String TenDangNhap = request.getParameter("username");
		String MatKhau = request.getParameter("password");
		TaiKhoanBO tkBO = new TaiKhoanBO();
		TaiKhoan user = tkBO.checkLogin(TenDangNhap, MatKhau);
		
		if (TenDangNhap == null || TenDangNhap.trim().isEmpty()) {
			res.getWriter().write("{\"status\":\"error\", \"message\":\"Tên đăng nhập không được để trống\"}");
            return;
        }
		
		if (MatKhau == null || MatKhau.trim().isEmpty()) {
			res.getWriter().write("{\"status\":\"error\", \"message\":\"Mật khẩu không được để trống\"}");
            return;
        }

		if (user != null) {
			request.setAttribute("user", user);
			request.setAttribute("Role", user.getRole());
			chain.doFilter(request, response);

		} else {
			res.setContentType("application/json;charset=UTF-8");
			res.getWriter().write("{\"status\":\"error\",\"message\":\"Sai tài khoản hoặc mật khẩu!\"}");
		}

	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
