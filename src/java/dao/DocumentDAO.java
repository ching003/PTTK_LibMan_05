/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Document;

/**
 *
 * @author Admin
 */
public class DocumentDAO extends DAO{

    public DocumentDAO() {
        super();
    }
    public ArrayList<Document> searchDocumentByName(String name) {
        ArrayList<Document> list = new ArrayList<>();
        String sql = "SELECT * FROM tblDocument WHERE name LIKE ?";

        try {
            PreparedStatement ps = (PreparedStatement) con.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Document d = new Document();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setAuthor(rs.getString("author"));
                d.setGenre(rs.getString("genre"));
                d.setCoverPrice(rs.getFloat("coverPrice"));
                list.add(d);
          
            }
        } catch (Exception e) {
         
            e.printStackTrace();
        }
        return list;
    }
    public Document getDocumentById(int id) {
        Document d = null;
        String sql = "SELECT * FROM tblDocument WHERE id = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                d = new Document(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("author"),
                        rs.getString("genre"),
                        rs.getFloat("coverPrice")
                );
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return d;
    }
}
