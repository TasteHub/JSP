package mvc.database;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBConnection {
	
	public static Connection getConnection() throws NamingException {
		Connection conn = null;
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/mysql");
			conn = ds.getConnection();
			conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
		} catch (SQLException e) {
			System.out.println("커넥션 연결 실패");
			System.out.println(e.getMessage());
		}
		return conn;
	}
}
