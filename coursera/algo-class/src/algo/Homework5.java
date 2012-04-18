package algo;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Homework5 {
	
	private static int[] sums = new int[] {231552, 234756, 596873, 648219, 726312, 981237, 988331, 1277361, 1283379};
	private static int[] result = new int[] {0, 0, 0, 0, 0, 0, 0, 0, 0};
	private static final int max = 1000000;

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Homework5 hw = new Homework5();
		int[] input = hw.getInput();
		for (int i = 0; i < input.length; i++) {
			if (input[i] > 0) {
				for (int j = 0; j < sums.length; j++) {
					int another = sums[j] - input[i];
					if (another>=0 && another < input.length && input[another] == another) {
						result[j] = 1;
					}
				}
			}
		}
		for (int i = 0; i < result.length; i++) {
			System.out.print(result[i]);
		}
	}

	private int[] getInput() {
		int[] input = new int[max + 1];
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new FileReader(Homework5.class.getResource("/HashInt.txt").getFile()));
			String line = reader.readLine();
			while (line != null) {
				int number = Integer.parseInt(line.trim());
				input[number] = number;
				line = reader.readLine();
			}
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException ioe) {
					ioe.printStackTrace();
				}
			}
		}
		return input;
	}
	
	

}
