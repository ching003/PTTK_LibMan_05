/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.*;
/**
 *
 * @author Admin
 */
public class BorrowSlipDAO extends DAO{

    public BorrowSlipDAO() {
        super();
    }
    
    public ArrayList<BorrowSlip> getBorrowSlipsByReaderId(int readerId){
        ArrayList<BorrowSlip> list = new ArrayList<>();
        PreparedStatement psSlip = null;
        ResultSet rsSlip = null;
        try {
            String sqlSlip = "SELECT bs.id, bs.borrowDate, bs.dueDate, r.cardId, u.name " +
                         "FROM tblBorrowSlip bs " +
                         "JOIN tblReaderLibraryCard r ON bs.readerId = r.id " +
                         "JOIN tblUser u ON r.id = u.id " +
                         "WHERE r.id = ? " +
                         "ORDER BY bs.borrowDate DESC";
            psSlip = con.prepareStatement(sqlSlip);
            psSlip.setInt(1, readerId);
            rsSlip = psSlip.executeQuery();
            
            while(rsSlip.next()){
                BorrowSlip slip = new BorrowSlip();
                slip.setId(rsSlip.getInt("id"));
                slip.setBorrowDate(rsSlip.getDate("borrowDate"));
                slip.setDueDate(rsSlip.getDate("dueDate"));
                
                LibraryCard libraryCard = new LibraryCard();
                libraryCard.setId(rsSlip.getInt("cardId"));
                
                Reader reader = new Reader();
                reader.setLibraryCard(libraryCard);
                reader.setId(readerId);
                reader.setName(rsSlip.getString("name"));
                
                slip.setReader(reader);
                
                String sqlDocs = "SELECT d.id, d.name, d.author, d.genre, d.coverPrice " +
                             "FROM tblBorrowDocument bd " +
                             "JOIN tblDocument d ON bd.documentId = d.id " +
                             "WHERE bd.borrowSlipId = ?";
                PreparedStatement psDocs = null;
                ResultSet rsDocs = null;
                try {
                    psDocs = con.prepareStatement(sqlDocs);
                    psDocs.setInt(1, slip.getId());
                    rsDocs = psDocs.executeQuery();

                    ArrayList<BorrowDocument> borrowDocuments = new ArrayList<>();
                    while (rsDocs.next()) {
                        Document doc = new Document();
                        doc.setId(rsDocs.getInt("id"));
                        doc.setName(rsDocs.getString("name"));
                        doc.setAuthor(rsDocs.getString("author"));
                        doc.setGenre(rsDocs.getString("genre"));
                        doc.setCoverPrice(rsDocs.getFloat("coverPrice"));

                        BorrowDocument bd = new BorrowDocument();
                        bd.setDocument(doc);

                        borrowDocuments.add(bd);
                    }
                    slip.setListBorrowDocuments(borrowDocuments.toArray(new BorrowDocument[0]));
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rsDocs != null) {
                        try { rsDocs.close(); } catch (Exception e) {}
                    }
                    if (psDocs != null) {
                        try { psDocs.close(); } catch (Exception e) {}
                    }
                }
                
                list.add(slip);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } 
        return list;
    }
    
    
    public BorrowSlip getBorrowSlipById(int borrowSlipId){
        BorrowSlip slip = null;
        PreparedStatement psSlip = null;
        ResultSet rsSlip = null;
        try {
            String sqlSlip = "SELECT bs.id, bs.borrowDate, bs.dueDate, bs.readerId, r.cardId, u.name " +
                         "FROM tblBorrowSlip bs " +
                         "JOIN tblReaderLibraryCard r ON bs.readerId = r.id " +
                         "JOIN tblUser u ON r.id = u.id " +
                         "WHERE bs.id = ?";
            psSlip = con.prepareStatement(sqlSlip);
            psSlip.setInt(1, borrowSlipId);
            rsSlip = psSlip.executeQuery();
            
            if(rsSlip.next()){
                slip = new BorrowSlip();
                slip.setId(rsSlip.getInt("id"));
                slip.setBorrowDate(rsSlip.getDate("borrowDate"));
                slip.setDueDate(rsSlip.getDate("dueDate"));
                
                LibraryCard libraryCard = new LibraryCard();
                libraryCard.setId(rsSlip.getInt("cardId"));
                
                Reader reader = new Reader();
                reader.setLibraryCard(libraryCard);
                reader.setId(rsSlip.getInt("readerId"));
                reader.setName(rsSlip.getString("name"));
                
                slip.setReader(reader);
                
                String sqlDocs = "SELECT d.id, d.name, d.author, d.genre, d.coverPrice " +
                             "FROM tblBorrowDocument bd " +
                             "JOIN tblDocument d ON bd.documentId = d.id " +
                             "WHERE bd.borrowSlipId = ?";
                PreparedStatement psDocs = null;
                ResultSet rsDocs = null;
                try {
                    psDocs = con.prepareStatement(sqlDocs);
                    psDocs.setInt(1, slip.getId());
                    rsDocs = psDocs.executeQuery();

                    ArrayList<BorrowDocument> borrowDocuments = new ArrayList<>();
                    while (rsDocs.next()) {
                        Document doc = new Document();
                        doc.setId(rsDocs.getInt("id"));
                        doc.setName(rsDocs.getString("name"));
                        doc.setAuthor(rsDocs.getString("author"));
                        doc.setGenre(rsDocs.getString("genre"));
                        doc.setCoverPrice(rsDocs.getFloat("coverPrice"));

                        BorrowDocument bd = new BorrowDocument();
                        bd.setDocument(doc);

                        borrowDocuments.add(bd);
                    }
                    slip.setListBorrowDocuments(borrowDocuments.toArray(new BorrowDocument[0]));
                } catch (Exception e) {
                    e.printStackTrace();
                } 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return slip;
    }
}
