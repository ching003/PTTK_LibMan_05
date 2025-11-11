/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.DocumentDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Document;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DocumentServlet", urlPatterns = {"/DocumentServlet"})
public class DocumentServlet extends HttpServlet {
    private DocumentDAO dao = new DocumentDAO();

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
        
        String action = request.getParameter("action");
        if(action == null || action.isEmpty()){
            action = "search";
        }
        
        if(action.equals("detail")){
            String idSt = request.getParameter("id");
            if(idSt == null || idSt.isEmpty()){
                response.sendRedirect(request.getContextPath()+"/DocumentServlet");
                return;
            }
            
            try{
                int id = Integer.parseInt(idSt);
                Document doc = dao.getDocumentById(id);
                
                if (doc == null) {
                   request.setAttribute("error", "Không tìm thấy tài liệu có mã: " + id);
                   RequestDispatcher rd = request.getRequestDispatcher("/reader/ViewSearchDocument.jsp");
                   rd.forward(request, response);
                   return;
                }

                request.setAttribute("document", doc);
                RequestDispatcher rd = request.getRequestDispatcher("/reader/ViewDetailDocument.jsp");
                rd.forward(request, response);
                return;
            }
            catch(NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/DocumentServlet");
                return;
            }
        }
        
        String key = (String)request.getParameter("docName");
        if (key == null) key = "";
        
        //Lấy danh sách document có tên chứa key
        ArrayList<Document> listDocuments = (new DocumentDAO().searchDocumentByName(key));  
        request.setAttribute("listDocuments", listDocuments);
        request.setAttribute("searchKey", key);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/reader/ViewSearchDocument.jsp");
        dispatcher.forward(request, response);
    }
}

    
    