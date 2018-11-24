/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Dao;

import Controller.ConnectionManager;
import Model.Entity.User;
import java.io.IOException;
import java.io.InputStream;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Part;

/**
 *
 *
 */
public class UserDAO {

    /* Database sequence
    #1: userEmail (varchar 50)
    #2: userFirstName (varchar 50)
    #3: userLastName (varchar 50)
    #4: userPhone (int 15)
    #5: userGender (varchar 1)
    #6: userCitizenship (varchar 100)
    #7: userDOB (year 4)
    #8: userInterest (varchar 1000)
    #9: userPassword (blob) - not in entity
    #10: userSalt (varchar 6) - not in entity
    #11: userOccupation (varchar 100)
    #12: userResume (mediumblob)
    #13: userIsEmailConfirm (varchar 10)
    #14: userHighestEducation (varchar 100)
    #15: userFieldOfStudy (varchar 100)
    #16: userDescription (varchar 500)
    #17: userSchool (varchar 50)
     */
    // Get user and their details with userid and password
    public static User getUserByLogin(String userid, String password) {

        User user = null;
        String sql = "SELECT userEmail, userFirstName, userLastName, userPhone, userGender, userCitizenship, userDOB, userInterest, userOccupation, userResume, userIsEmailConfirm, userHighestEducation, userFieldOfStudy, userDescription, userSchool FROM user WHERE userEmail=? AND userPassword=AES_ENCRYPT(?,userSalt)";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, userid);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                if (user == null) {
                    user = new User(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getString(8), rs.getString(9), rs.getBlob(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Unable to retrieve userid = '" + userid + "'.", ex);
        }

        return user;
    }
    
    // Get user and their details with userid
    public static User getUserByID(String userid) {

        User user = null;
        String sql = "SELECT userEmail, userFirstName, userLastName, userPhone, userGender, userCitizenship, userDOB, userInterest, userOccupation, userResume, userIsEmailConfirm, userHighestEducation, userFieldOfStudy, userDescription, userSchool FROM user WHERE userEmail=?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, userid);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                if (user == null) {
                    user = new User(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getString(8), rs.getString(9), rs.getBlob(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Unable to retrieve userid = '" + userid + "'.", ex);
        }

        return user;
    }

    // Add existing users/bulk new users
    public static boolean addUser(String userEmail, String userFirstName, String userLastName, int userPhone, String userGender, String userCitizenship, int userDOB, String userInterest, String userPassword, String userOccupation, Part userResume, String userIsEmailConfirm, String userHighestEducation, String userFieldOfStudy, String userDescription, String userSchool) {

        String sql = "INSERT INTO user VALUES (?,?,?,?,?,?,?,?,AES_ENCRYPT(?,?),?,?,?,?,?,?,?,?)";

        try (Connection conn = ConnectionManager.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userEmail);
            stmt.setString(2, userFirstName);
            stmt.setString(3, userLastName);
            stmt.setInt(4, userPhone);
            stmt.setString(5, userGender);
            stmt.setString(6, userCitizenship);
            stmt.setInt(7, userDOB);
            
            stmt.setString(8, userInterest);
            stmt.setString(9, userPassword);//
            
            //generate the salt
            SecureRandom test = new SecureRandom();
            int testresult = test.nextInt(1000000);
            String resultStr = testresult + "";
            if (resultStr.length() != 6) 
                for (int x = resultStr.length(); x < 6; x++) resultStr = "0" + resultStr;
            
            stmt.setString(10, resultStr);
            stmt.setString(11, resultStr);//generate the salt
            stmt.setString(12, userOccupation);

            stmt.setString(14, userIsEmailConfirm);
            stmt.setString(15, userHighestEducation);
            stmt.setString(16, userFieldOfStudy);
            stmt.setString(17, userDescription);
            stmt.setString(18, userSchool);

            //resume upload
            InputStream resumeInputStream = null;
            if (userResume != null){
                System.out.println(userResume.getName());
                System.out.println(userResume.getSize());
                System.out.println(userResume.getContentType());

                try{
                    resumeInputStream = userResume.getInputStream();
                }catch(IOException e){
                    Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to upload resume into database", e);
                }
            }
            
            if(resumeInputStream!= null){
                stmt.setBinaryStream(13, resumeInputStream, (int) userResume.getSize());
            }else{
                stmt.setNull(13, java.sql.Types.BLOB);
            }

            int result = stmt.executeUpdate();
 
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Email is already registered!", ex);
        }
        return true;
    }

    // get all users
    public static ArrayList<User> getAllUsers() {
        ArrayList<User> result = new ArrayList<>();
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement("select userEmail, userFirstName, userLastName, userPhone, userGender, userCitizenship, userDOB, userInterest, userOccupation, userResume, userIsEmailConfirm, userHighestEducation, userFieldOfStudy, userDescription, userSchool from user");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(new User(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getString(8), rs.getString(9), rs.getBlob(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15)));
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    //delete user a particular user row
    public static boolean deleteUser(String userEmail) {

        String sql1 = "DELETE FROM user WHERE userEmail=?";

        try (
                Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql1);) {
            stmt.setString(1, userEmail);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Unable to delete user, userEmail = '" + userEmail, ex);
            return false;
        }
        return true;
    }

    //update a particular user based on the user email confirmation
    public static boolean updateUser(String userEmail) {

        String sql = "UPDATE user SET userIsEmailConfirm=? WHERE userEmail=?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, "confirmed");
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    }

    //update a particular user based on the profile update details
    public static boolean updateUser(String userEmail, String userFirstName, String userLastName, int userPhone, String userGender, String userCitizenship, int userDOB, String userInterest, String userPassword, String userOccupation, String userHighestEducation, String userFieldOfStudy, String userDescription, String userSchool){

        String sql = "UPDATE user SET userFirstName=?, userLastName=?, userPhone=?, userGender=?, userCitizenship=?, userDOB=?, userInterest=?,userPassword=?,userOccupation=?,userHighestEducation=?,userFieldOfStudy=?,userDescription=?,userSchool=?  WHERE userEmail = ?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, userFirstName);
            stmt.setString(2, userLastName);
            stmt.setInt(3, userPhone);
            stmt.setString(4, userGender);
            stmt.setString(5, userCitizenship);
            stmt.setInt(6, userDOB);
            stmt.setString(7, userInterest);
            stmt.setString(8, userPassword);
            stmt.setString(9, userOccupation);
            stmt.setString(10, userHighestEducation);
            stmt.setString(11, userFieldOfStudy);
            stmt.setString(12, userDescription);
            stmt.setString(13, userSchool);
            stmt.setString(14, userEmail);
             
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    }
    
    //update user firstname
    public static boolean updateUserFirstName(String userEmail, String userFirstName) {

        String sql = "UPDATE user SET userFirstName=? WHERE userEmail=?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, userFirstName);
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    }
    
    //update user lastname
    public static boolean updateUserLastName(String userEmail, String userLastName) {

        String sql = "UPDATE user SET userLastName=? WHERE userEmail=?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, userLastName);
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    }
    
    //update user phone number
    public static boolean updateUserPhone(String userEmail, int userPhone) {

        String sql = "UPDATE user SET userPhone=? WHERE userEmail=?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setInt(1, userPhone);
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    }

 //update user gender
    public static boolean updateUserGender(String userEmail, String userGender) {

        String sql = "UPDATE user SET userGender=? WHERE userEmail = ?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, userGender);
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    }   
    
    //update user citizenship
    public static boolean updateUserCitizenship(String userEmail, String userCitizenship) {

        String sql = "UPDATE user SET userCitizenship=? WHERE userEmail = ?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, userCitizenship);
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    } 
    
     //update user year of birth
    public static boolean updateUserYob(String userEmail, int userDob) {

        String sql = "UPDATE user SET userDOB=? WHERE userEmail = ?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setInt(1, userDob);
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    } 
    
    //update user interest
    public static boolean updateUserInterest(String userEmail, String userInterest) {

        String sql = "UPDATE user SET userInterest=? WHERE userEmail = ?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, userInterest);
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    } 
    
    //update user occupation
    public static boolean updateUserOccupation(String userEmail, String userOccupation) {

        String sql = "UPDATE user SET userOccupation=? WHERE userEmail = ?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, userOccupation);
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    } 
    
    //update user field of study
    public static boolean updateUserFieldOfStudy(String userEmail, String userFieldOfStudy) {

        String sql = "UPDATE user SET userFieldOfStudy=? WHERE userEmail = ?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, userFieldOfStudy);
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    } 
    
    //update user highest education
    public static boolean updateUserHighestEducation(String userEmail, String userHighestEducation) {

        String sql = "UPDATE user SET userHighestEducation=? WHERE userEmail = ?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, userHighestEducation);
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    } 
    
    
    //update user description
    public static boolean updateUserDescription(String userEmail, String userDescription) {

        String sql = "UPDATE user SET userDescription=? WHERE userEmail = ?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, userDescription);
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    } 
    
     //update user description
    public static boolean updateUserSchool(String userEmail, String userSchool) {

        String sql = "UPDATE user SET userSchool=? WHERE userEmail = ?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, userSchool);
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    } 
    
    //update a particular user based on the internship details
    public static boolean updateUser(String userEmail, String userFirstName, String userLastName, int userPhone, String userCitizenship, String userHighestEducation, String userFieldOfStudy, String userSchool, Part userResume){

        String sql = "UPDATE user SET userFirstName=?, userLastName=?, userPhone=?, userCitizenship=?,userHighestEducation=?,userFieldOfStudy=?,userSchool=?,userResume=?  WHERE userEmail = ?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, userFirstName);
            stmt.setString(2, userLastName);
            stmt.setInt(3, userPhone);
            stmt.setString(4, userCitizenship);
            stmt.setString(5, userHighestEducation);
            stmt.setString(6, userFieldOfStudy);
            stmt.setString(7, userSchool);
            stmt.setString(9, userEmail);
            
            //resume upload
            InputStream resumeInputStream = null;
            if (userResume != null){
                System.out.println(userResume.getName());
                System.out.println(userResume.getSize());
                System.out.println(userResume.getContentType());

                try{
                    resumeInputStream = userResume.getInputStream();
                }catch(IOException e){
                    Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to upload resume into database", e);
                }
            }
            
            if(resumeInputStream!= null){
                stmt.setBinaryStream(8, resumeInputStream, (int) userResume.getSize());
            }else{
                stmt.setNull(8, java.sql.Types.BLOB);
            }
            
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    }

    //update user email confirmation
    public static boolean updateUserConfirmation(String userEmail) {

        String sql = "UPDATE user SET userIsEmailConfirm=? WHERE userEmail = ?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, "confirmed");
            stmt.setString(2, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    }

    public static User getUser(String userEmail) {
        User user = null;
        String sql = "SELECT userEmail, userFirstName, userLastName, userPhone, userGender, userCitizenship, userDOB, userInterest, userOccupation, userResume, userIsEmailConfirm, userHighestEducation, userFieldOfStudy, userDescription, userSchool FROM user WHERE userEmail = ?";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, userEmail);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                user = new User(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getString(8), rs.getString(9), rs.getBlob(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Cannot get user with userEmail: " + userEmail, ex);
        }
        return user;

    }

    //update user email confirmation
    public static boolean updateUserPassword(String userEmail, String userPassword) {

        String sql = "UPDATE user SET userPassword=AES_ENCRYPT(?,?), userSalt=? WHERE userEmail=?";
        //UPDATE user SET passwd=AES_ENCRYPT('blahraw','123456'),salt='123456' WHERE username ='test1';

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            
            //generate the salt
            SecureRandom test = new SecureRandom();
            int testresult = test.nextInt(1000000);
            String resultStr = testresult + "";
            if (resultStr.length() != 6) 
                for (int x = resultStr.length(); x < 6; x++) resultStr = "0" + resultStr;
            
            stmt.setString(1, userPassword);
            stmt.setString(2, resultStr);
            stmt.setString(3, resultStr);
            stmt.setString(4, userEmail);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to update user: " + userEmail + ".", ex);
        }
        return true;
    }

}
