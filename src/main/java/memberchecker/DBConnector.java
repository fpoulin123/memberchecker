package memberchecker;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnector {
	
	public Connection getConnection() {
		
		
		Connection c = null;
	      try {
	         Class.forName("org.postgresql.Driver");
	         c = DriverManager
	            .getConnection("jdbc:postgresql://localhost:5433/businessmgr",
	            "postgres", "postgres");
	      } catch (Exception e) {
	         e.printStackTrace();
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	         System.exit(0);
	      }
	      return c;
	}

}
