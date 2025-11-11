/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import  model.User;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import org.apache.tomcat.dbcp.dbcp2.PoolablePreparedStatement;
/**
 *
 * @author Admin
 */
public class UserDAO extends DAO{

    public UserDAO() {
        super();
    }
    
    public boolean checkLogin(User user){
        boolean result = false;
        String sql = "SELECT id, name, role FROM tblUser WHERE username = ? AND password = ?";
        try(PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1,user.getUsername());
            ps.setString(2,user.getPassword());
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                user.setId(rs.getInt("id"));
                user.setRole(rs.getString("role"));
                user.setName(rs.getString("name"));
                result =true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
