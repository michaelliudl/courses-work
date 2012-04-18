package algo;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Util {
	public static int[] getArrayFromFile(String fileName) throws IOException {
		List<Integer> list = new ArrayList<Integer>();
		BufferedReader reader = null;
		try {
			String in = Util.class.getResource(fileName).getFile();
			reader = new BufferedReader(new FileReader(new File(in)));
			String line = reader.readLine();

			while (line != null) {
				list.add(Integer.parseInt(line));
				line = reader.readLine();
			}
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} finally {
			if (reader != null) {
				reader.close();
			}
		}
		
		int[] input = new int[list.size()];
		for (int i = 0; i < input.length; i++) {
			input[i] = list.get(i);
		}
		return input;
	}
}
