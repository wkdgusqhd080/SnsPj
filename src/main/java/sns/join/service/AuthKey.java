package sns.join.service;

import java.util.Random;

public class AuthKey {
	
	static String getKey(int size) {
		StringBuffer sb = new StringBuffer();
		Random r = new Random();
		for (int i = 0; i<size; i++) {
			int rIdx = r.nextInt(3);
			switch (rIdx) {
				case 0: sb.append((char) ((int) (r.nextInt(26))+97)); break;
				case 1: sb.append((char) ((int) (r.nextInt(26))+65)); break; 
				case 2: sb.append((r.nextInt(10))); break;
			}
		}
		return sb.toString();
	}
}
