package design;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
public class test {
    public static void main(String[] args) throws SQLException {
        String url = "jdbc:mysql://localhost/compliment_cascade?useSSL=false&serverTimezone=Japan";
        String user = "root";
        String password = "Shirokumakoguma3";
        
        // データベース接続を確立
        Connection conn = DriverManager.getConnection(url, user, password);
        
        // 学生テーブルの中身を取得
        String sql = "select * from compliment";
        Statement stat = conn.createStatement();
        ResultSet rs = stat.executeQuery(sql); 

        while(rs.next()) {
            String word = rs.getString(1);
            System.out.printf("%s%n", word);
        }
        // データベース接続を閉じる
        conn.close();
    }
}
