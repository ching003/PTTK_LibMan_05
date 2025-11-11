/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.UserDAO;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UserServlet", urlPatterns = {"/UserServlet"})
public class UserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        
        UserDAO userDAO =  new UserDAO();
        boolean valid = userDAO.checkLogin(user);
        
        if(valid){
            HttpSession oldSession = request.getSession(false);
            if(oldSession != null){
                oldSession.invalidate();
            }
            HttpSession session = request.getSession();
    
            if(user.getRole().equalsIgnoreCase("reader")){
                session.setAttribute("reader", user);
                response.sendRedirect("reader/ViewReaderPage.jsp");
            }
            else if(user.getRole().equalsIgnoreCase("manager")){
                session.setAttribute("manager", user);
                response.sendRedirect("manager/ViewManagerPage.jsp");
            }
        }
        else{
            response.sendRedirect("user/Login.jsp?err=fail");
            }    
        }
}
