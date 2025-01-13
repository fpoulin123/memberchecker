package memberchecker;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

public class Checker {

	public String checkMemberValidity(String memberNum) throws SQLException {
		
		DBConnector dbconnector = new DBConnector();
		
		Connection c = dbconnector.getConnection();
		Statement stmt = c.createStatement();
		
		ResultSet rs = stmt.executeQuery(String.format("select * from customer where barcodevalue='%s' and customer.id in (select customer_id from subscription as s where isvalidsubscription(s.subscription_date, s.duration) IS TRUE);", memberNum));
		
		c.close();
		while(rs.next()) {
			Long memberId = rs.getLong("id");
			if(memberId!=null) {
				String nom = rs.getString("firstname") + " " + rs.getString("lastname");
				
				return String.format("NOM : %s, NUMERO : %s,DATE : %s", nom, memberNum, new Date().toString());
				
			}
		}
		
		
		
		return null;
	}
}
