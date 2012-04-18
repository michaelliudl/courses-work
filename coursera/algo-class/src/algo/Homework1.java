package algo;

import java.io.IOException;

public class Homework1 {
	
	public static void main(String[] args) throws IOException {
		int[] input = Util.getArrayFromFile("/IntegerArray.txt");
		
		Container con = new Homework1().countInv(input);
		System.out.println(input);
		System.out.println(con.invCount);
		System.out.println(con.subArray);
	}
	
	public Container countInv(int[] array) {
		if (array == null || array.length ==0) {
			return new Container(0, null);
		}
		
		if (array.length < 20) {
			int inv = 0;
			for (int i = 1; i < array.length; i++) {
				int current = array[i];
				int j = i - 1;
				for (; j >= 0; j--) {
					if (array[j] > current) {
						array[j + 1] = array[j];
						inv++;
					} else {
						break;
					}
				}
				if (j == 0 && array[j] > current) {
					array[j] = current;
				}else {
					array[j + 1] = current;
				}
			}
			return new Container(inv, array);
		}
		
		int middle = array.length / 2;
		int leftLen = middle;
		int rightLen = array.length - leftLen;
		int[] leftHalf = new int[leftLen];
		int[] rightHalf = new int[rightLen];
		System.arraycopy(array, 0, leftHalf, 0, leftLen);
		System.arraycopy(array, middle, rightHalf, 0, rightLen);
		
		Container leftCon = countInv(leftHalf);
		Container rightCon = countInv(rightHalf);
		Container allCon = mergeCountInv(leftCon.subArray, rightCon.subArray);
		
		allCon.invCount += leftCon.invCount;
		allCon.invCount += rightCon.invCount;
		return allCon;
	}
	
	private Container mergeCountInv(int[] firstArray, int[] secondArray) {
		if (firstArray == null) {
			firstArray = new int[0];
		}
		if (secondArray == null) {
			secondArray = new int[0];
		}
		
		int[] result = new int[firstArray.length + secondArray.length];
		long inv = 0;
		int first = 0;
		int second = 0;
		for (int i = 0; i < result.length; i++) {
			if (first >= firstArray.length) {
				result[i] = secondArray[second];
				second++;
				inv += firstArray.length - first;
				continue;
			}
			if (second >= secondArray.length) {
				result[i] = firstArray[first];
				first++;
				continue;
			}
			if (firstArray[first] <= secondArray[second]) {
				result[i] = firstArray[first];
				first++;
			} else {
				result[i] = secondArray[second];
				second++;
				inv += firstArray.length - first;
			}
		}
		return new Container(inv, result);
	}

	private class Container {
		long invCount;
		int[] subArray;
		
		Container(long invCount, int[] subArray) {
			this.invCount = invCount;
			this.subArray = subArray;
		}
	}

}
