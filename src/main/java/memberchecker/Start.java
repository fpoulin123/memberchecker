package memberchecker;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Scanner;

import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;

public class Start {

	public static void main(String[] args) throws SQLException, UnsupportedAudioFileException, IOException, LineUnavailableException {
		
		
		System.out.println("Member checker initialized and ready!");
		while(true) {
			Scanner scanner = new Scanner(System.in);
			String memberNum = scanner.nextLine();
			
			System.out.println("Member : " + memberNum);
			
			Checker checker = new Checker();
			String log = checker.checkMemberValidity(memberNum);
			AudioPlayer audioPlayer = new AudioPlayer();
			if(log!=null) {
				audioPlayer.play("./ok.wav");
				System.out.println(log);
			}else {
				audioPlayer.play("./not_ok.wav");
				System.out.println("Member not found or not valid for number " + memberNum);
			}
			
			if("exit".equals(memberNum))break;
		}
	}

}
