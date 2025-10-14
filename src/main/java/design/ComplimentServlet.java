package design;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.net.URI;
import java.net.URISyntaxException;

/**
 * DBからComplimentテーブルを取得するためのサーブレット
 */
@WebServlet({"/ComplimentServlet", ""})
public class ComplimentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// HTTPのGETリクエストが来たときに実行されるメソッド
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// データベースから取得した褒め言葉を格納するリストを初期化
		List<String> compliments = new ArrayList<>();
		
		try {
			// JDBCドライバーをロード
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Class.forName("org.postgresql.Driver");
			
			// データベースの接続情報を設定(local)
			String url = "jdbc:mysql://localhost/compliment_cascade?useSSL=false&serverTimezone=Japan&allowPublicKeyRetrieval=true";
			String user = "root";
			String password = "Shirokumakoguma3";
			
			/*
			// データベースの接続情報を設定(Railway)
			// Railwayの環境変数からURLを取得
			String dbUrl = System.getenv("MYSQL_PUBLIC_URL");
			if (dbUrl == null || dbUrl.isEmpty()) {
				// 環境変数が設定されていない場合の処理
				System.err.println("MYSQL_PUBLIC_URL environment cariable is not set.");
				return;
			}
			
			URI dbUri;
			try {
				dbUri = new URI(dbUrl);
			} catch (URISyntaxException e) {
				// 無効なURL形式の場合の処理
				e.printStackTrace();
				return;
			}

			// URLから接続情報を抽出
			String user = dbUri.getUserInfo().split(":")[0];
			String password = dbUri.getUserInfo().split(":")[1];
			String hostname = dbUri.getHost();
			int port = dbUri.getPort();
			String databaseName = dbUri.getPath().substring(1);

			// 接続URLを再構築
			String url = "jdbc:mysql://" + hostname + ":" + port + "/" + databaseName + "?serverTimezone=Japan&useSSL=false&allowPublicKeyRetrieval=true";
			*/
			
			// 以降取得した url, user, passwordを使う
			// try-with-resources文で、Connection, Statement, ResultSetを自動で閉じます
			try (Connection conn = DriverManager.getConnection(url, user, password);
				 Statement stat = conn.createStatement();
				 ResultSet rs = stat.executeQuery("SELECT word FROM compliments")) {	// Complimentテーブルのword列を取得
				
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
		
		/*
		// test
		compliments.add("素晴らしい！");
		compliments.add("最高だね");
		compliments.add("がんばった");
		compliments.add("優しいね");
		compliments.add("頼りになる");
		*/
		
	    // ここでセッションからメッセージを取得し、リクエスト属性に設定し直す
	    String message = (String) request.getSession().getAttribute("message");
	    if (message != null) {
	        request.setAttribute("message", message);
	        request.getSession().removeAttribute("message");
	    }

		// 取得した褒め言葉のリストをリクエスト属性に設定
		// "compliments"という名前でJSPにデータを渡す
		request.setAttribute("compliments", compliments);

		System.out.println("DEBUG: Forwarding to index.jsp");
		System.out.println("compliments: " + compliments.size());
		
		// 処理をJSPファイルに転送
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// フォームから送信された褒め言葉を取得
		String compliment = request.getParameter("compliment");
		
		// データベースに挿入する
		if (compliment != null && !compliment.trim().isEmpty()) {
			try {
				// データベースに接続
				Class.forName("com.mysql.cj.jdbc.Driver");
				String url = "jdbc:mysql://localhost/compliment_cascade?useSSL=false&serverTimezone=Japan&allowPublicKeyRetrieval=true";
				String user = "root";
				String password = "Shirokumakoguma3";
				
				try (Connection conn = DriverManager.getConnection(url, user, password)) {
					// 重複チェックのSQL
					String checkSql = "SELECT COUNT(*) FROM compliments WHERE word = ?";
					try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
						checkStmt.setString(1, compliment);
						ResultSet rs = checkStmt.executeQuery();
						rs.next();
						int count = rs.getInt(1);
						
						if (count > 0) {
							// 重複している場合（挿入失敗）
							request.getSession().setAttribute("message", "その褒め言葉はだれかが使ってくれていました。別の言葉を試してみてください。");
						} else {
							// 重複していない場合（挿入成功）
							String insertSql = "INSERT INTO compliments (word) VALUES (?)";
							try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
								insertStmt.setString(1, compliment);
								insertStmt.executeUpdate();
							}
							request.getSession().setAttribute("message", "「だれかをほめる」に成功しました！");
						}
					}
				}
			} catch (SQLException | ClassNotFoundException e) {
				e.printStackTrace();
			}
		} else {
			// 入力値が空だった場合
			request.getSession().setAttribute("message", "褒め言葉を入力してください");
		}
		System.out.println("enterd: " + compliment);
		// GETリクエストにリダイレクトする
		response.sendRedirect(request.getContextPath() + "/");
	}
}
