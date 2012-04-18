package algo;

import java.io.IOException;

public class Homework2 {
	
	private static enum PivotChoice {
		First,
		Last,
		Median_Of_First_Last_Middle
	}
	
	public static void main(String[] args) throws IOException {
		int[] input = Util.getArrayFromFile("/QuickSort.txt");
		
		Homework2 hw = new Homework2();
		int[] case1 = new int[input.length];
		System.arraycopy(input, 0, case1, 0, input.length);
		long compFirstPv = hw.quickSortAndCountCompare(case1, 0, input.length - 1, PivotChoice.First);
		verify(case1);
		
		int[] case2 = new int[input.length];
		System.arraycopy(input, 0, case2, 0, input.length);
		long compLastPv = hw.quickSortAndCountCompare(case2, 0, input.length - 1, PivotChoice.Last);
		verify(case2);
		
		long compMedianPv = hw.quickSortAndCountCompare(input, 0, input.length - 1, PivotChoice.Median_Of_First_Last_Middle);
		verify(input);
		
		System.out.println(compFirstPv);
		System.out.println(compLastPv);
		System.out.println(compMedianPv);
	}
	
	private static void verify(int[] data) {
		for (int i = 0; i < data.length; i++) {
			if (data[i] != i + 1) {
				System.out.println(false);
			}
		}
	}

	private long quickSortAndCountCompare(int[] input, int left, int right, PivotChoice pc) {
		if (left >= right) {
			return 0;
		}
		
		long comp = right - left;
		int part = partition(input, left, right, pc);
		comp += quickSortAndCountCompare(input, left, part - 1, pc);
		comp += quickSortAndCountCompare(input, part + 1, right, pc);
		
		return comp;
	}

	private int partition(int[] input, int left, int right, PivotChoice pc) {
		int pivot = choosePivot(input, left, right, pc);
		int i = left + 1;
		for (int j = left + 1; j <= right; j++) {
			if (input[j] < pivot) {
				int temp = input[i];
				input[i] = input[j];
				input[j] = temp;
				i++;
			}
		}
		int temp = input[left];
		input[left] = input[i - 1];
		input[i - 1] = temp;
		return i - 1;
	}

	private int choosePivot(int[] input, int left, int right, PivotChoice pc) {
		if (pc == PivotChoice.Last) {
			int temp = input[left];
			input[left] = input[right];
			input[right] = temp;
		} else if (pc == PivotChoice.Median_Of_First_Last_Middle) {
			int median = left;
			int middle = (left + right) / 2;
			if (input[left] > input[middle]) {
				if (input[middle] > input[right]) {
					median = middle;
				} else if (input[left] > input[right]){
					median = right;
				} else {
					median = left;
				}
			} else {
				if (input[right] > input[middle]) {
					median = middle;
				} else if (input[left] < input[right]) {
					median = right;
				} else {
					median = left;
				}
 			}
			int temp = input[left];
			input[left] = input[median];
			input[median] = temp;
		}
		return input[left];
	}
}
