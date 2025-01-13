package memberchecker;

import java.sql.SQLException;
import java.util.Scanner;

public class Start {

	public static void main(String[] args) throws SQLException {
		while(true) {
			Scanner scanner = new Scanner(System.in);
			String memberNum = scanner.nextLine();
			
			System.out.println("Member : " + memberNum);
			
			Checker checker = new Checker();
			String log = checker.checkMemberValidity(memberNum);
			if(log!=null) {
				System.out.println(log);
			}else {
				System.out.println("Member not found or not valid for number " + memberNum);
			}
			
			if("exit".equals(memberNum))break;
		}
	}

}
