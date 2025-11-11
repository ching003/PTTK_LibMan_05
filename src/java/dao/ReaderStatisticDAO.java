/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Date;
import model.*;

/**
 *
 * @author Admin
 */
public class ReaderStatisticDAO extends DAO{

    public ReaderStatisticDAO() {
        super();
    }
    
    public ArrayList<ReaderStatistic> getReaderStatistic(Date startDay,Date endDate){
        ArrayList<ReaderStatistic> result = new ArrayList<>();
        String sql = "SELECT " +
                 "r.id AS readerId, " +
                 "r.cardId, " +
                 "u.name AS name, " +
                 "COUNT(DISTINCT bs.id) AS borrowCount, " +         // số lần mượn
                 "COUNT(bd.id) AS totalBorrowed " +                 // số tài liệu mượn
                 "FROM tblReaderLibraryCard r " +
                 "JOIN tblUser u ON r.id = u.id " +
                 "LEFT JOIN tblBorrowSlip bs ON r.id = bs.readerId " +
                 "AND bs.borrowDate BETWEEN ? AND ? " +
                 "LEFT JOIN tblBorrowDocument bd ON bs.id = bd.borrowSlipId " +
                 "GROUP BY r.id, r.studentCode, r.cardId, u.name " +
                 "HAVING COUNT(DISTINCT bs.id) > 0 " +              // chỉ những người có mượn
                 "ORDER BY borrowCount DESC";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, startDay);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ReaderStatistic readerStatistic = new ReaderStatistic();
                readerStatistic.setId(rs.getInt("readerId"));
                
                LibraryCard libraryCard = new LibraryCard();
                libraryCard.setId(rs.getInt("cardId"));
                
                readerStatistic.setLibraryCard(libraryCard);
                readerStatistic.setCount(rs.getInt("borrowCount"));
                readerStatistic.setTotalBorrowedDocuments(rs.getInt("totalBorrowed"));
                readerStatistic.setName(rs.getString("name"));
                
                result.add(readerStatistic);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
}
