/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ReaderStatisticDAO;
import model.ReaderStatistic;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ReaderStatisticServlet", urlPatterns = {"/ReaderStatisticServlet"})
public class ReaderStatisticServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String startDayStr = request.getParameter("startDay");
        String endDayStr = request.getParameter("endDay");
        
        ArrayList<ReaderStatistic> list = new ArrayList<>();
        
        if (startDayStr != null && !startDayStr.isEmpty() && 
            endDayStr != null && !endDayStr.isEmpty()) {
            try {
                // Parse date from dd/MM/yyyy format
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                java.util.Date startDate = sdf.parse(startDayStr);
                java.util.Date endDate = sdf.parse(endDayStr);
                
                Date startDay = new Date(startDate.getTime());
                Date endDay = new Date(endDate.getTime());
                
                ReaderStatisticDAO dao = new ReaderStatisticDAO();
                list = dao.getReaderStatistic(startDay, endDay);
                
                request.setAttribute("startDay", startDayStr);
                request.setAttribute("endDay", endDayStr);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        
        request.setAttribute("readerStatisticList", list);
        request.getRequestDispatcher("/manager/ViewReaderBorrowingStatistic.jsp").forward(request, response);
    }
 
}
