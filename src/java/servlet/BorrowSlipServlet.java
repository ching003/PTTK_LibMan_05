/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.BorrowSlipDAO;
import model.BorrowSlip;

/**
 *
 * @author Admin
 */
@WebServlet(name = "BorrowSlipServlet", urlPatterns = {"/BorrowSlipServlet"})
public class BorrowSlipServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String readerIdStr = request.getParameter("readerId");
        String slipIdStr = request.getParameter("slipId");
        String contextPath = request.getContextPath();
        BorrowSlipDAO dao = new BorrowSlipDAO();
        
        try {
            if (slipIdStr != null && !slipIdStr.isEmpty()) {
                // View slip detail by slipId
                try {
                    int slipId = Integer.parseInt(slipIdStr);
                    BorrowSlip slip = dao.getBorrowSlipById(slipId);
                    
                    if (slip != null) {
                        request.setAttribute("borrowSlip", slip);
                        request.getRequestDispatcher("/manager/ViewSlipDetail.jsp").forward(request, response);
                    } else {
                        response.sendRedirect(contextPath + "/manager/ViewManagerPage.jsp?err=notfound");
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    response.sendRedirect(contextPath + "/manager/ViewManagerPage.jsp?err=invalid");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(contextPath + "/manager/ViewManagerPage.jsp?err=error");
                }
            } else if (readerIdStr != null && !readerIdStr.isEmpty()) {
                // View reader borrowing detail by cardId
                try {
                    int readerId = Integer.parseInt(readerIdStr);
                    ArrayList<BorrowSlip> list = dao.getBorrowSlipsByReaderId(readerId);
                    
                    request.setAttribute("borrowSlipList", list);
                    request.setAttribute("readerId", readerId);
                    request.getRequestDispatcher("/manager/ViewReaderBorrowingDetail.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    response.sendRedirect(contextPath + "/manager/ViewManagerPage.jsp?err=invalid");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(contextPath + "/manager/ViewManagerPage.jsp?err=error");
                }
            } else {
                response.sendRedirect(contextPath + "/manager/ViewManagerPage.jsp?err=missing");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(contextPath + "/manager/ViewManagerPage.jsp?err=error");
        }
    }
}
