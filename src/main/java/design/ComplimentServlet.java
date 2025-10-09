package design;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * DBからComplimentテーブルを取得するためのサーブレット
 */
// @WebServletでこのサーブレットにアクセスするURLパターンを指定する
@WebServlet("/ComplimentServlet")
public class ComplimentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// HTTPのGETリクエストが来たときに実行されるメソッド
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// データベースから取得した褒め言葉を格納するリストを初期化
		List<String> compliments = new ArrayList<>();
		
		try {
			// JDBCドライバーをロード
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// データベースの接続情報を設定
			String url = "jdbc:mysql://localhost/compliment_cascade?useSSL=false&serverTimezone=Japan&allowPublicKeyRetrieval=true";
			String user = "root";
			String password = "Shirokumakoguma3";

			// try-with-resources文で、Connection, Statement, ResultSetを自動で閉じます
			try (Connection conn = DriverManager.getConnection(url, user, password);
				 Statement stat = conn.createStatement();
				 ResultSet rs = stat.executeQuery("SELECT word FROM compliment")) {	// Complimentテーブルのword列を取得
				
				// 取得した結果セットの各行をループ
				while (rs.next()) {
					// "word"列のデータを文字列としてリストに追加
					compliments.add(rs.getString("word"));
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			// データベース接続やドライバーが見つからない場合のエラー処理
			e.printStackTrace();
		}

		// 取得した褒め言葉のリストをリクエスト属性に設定
		// "compliments"という名前でJSPにデータを渡す
		request.setAttribute("compliments", compliments);

		// 処理をJSPファイルに転送
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}
}
