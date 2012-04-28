package algo;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.StringTokenizer;

public class Homework3 {

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		Homework3 hw = new Homework3();
//		Set<HashMap<Integer, Set<Map<Integer, Integer>>>> dataSet = hw.getData(10);
		int loopCount = 40 * 40 * (int)(Math.ceil(Math.log(40)));
//		Set<Container> dataSet = hw.getDataCon(40 * 40 * (int)(Math.ceil(Math.log(40))));
		int minCuts = Integer.MAX_VALUE;
//		for (HashMap<Integer, Set<Map<Integer, Integer>>> data : dataSet) {
		for (int i = 0; i < loopCount; i++) {
			int cuts = hw.calcCuts(hw.getCon());
//			System.out.println(cuts);
			if (cuts < minCuts) {
				minCuts = cuts;
			}
		}
//		Iterator<Container> iter = dataSet.iterator();
//		System.out.println(hw.calcCuts(iter.next()));
//		System.out.println(hw.calcCuts(iter.next()));
		System.out.println(minCuts);
	}
	
	private int calcCuts(Container con) {
		Set<Integer> vertices = con.vertices;
		ArrayList<Map<Integer, Integer>> edges = con.edges;
		while (vertices.size() > 2) {
			int randomEdge = (int)(Math.random() * edges.size());
			Map<Integer, Integer> edgeToContract = edges.remove(randomEdge);
			Entry<Integer, Integer> edge = edgeToContract.entrySet().iterator().next();
			Integer survived = edge.getKey();
			Integer contracted = edge.getValue();
//			System.out.println(">>>>>");
//			System.out.println("vertices=" + vertices.size());
//			System.out.println("edges=" + edges.size());
//			System.out.println("contract edge=" + edge);
			vertices.remove(contracted);
			for (int i = 0; i < edges.size(); i++) {
				Map<Integer, Integer> e = edges.get(i);
				Entry<Integer, Integer> edgeLeft = e.entrySet().iterator().next();
				Integer start = edgeLeft.getKey();
				Integer end = edgeLeft.getValue();
				
				if (start.equals(contracted)) {
//					System.out.println("edge start from contracted node");
//					System.out.println(e);
//					System.out.println("replace start node of contracted: " + start + " with survive node: " + survived);
					e.put(survived, end);
					e.remove(start);
//					System.out.println(e);
				}
				if (end.equals(contracted)) {
//					System.out.println("edge end with contracted node");
//					System.out.println(e);
//					System.out.println("replace end node of contracted: " + start + " with survive node: " + survived);
					e.put(start, survived);
//					System.out.println(e);
				}
			}
			Iterator<Map<Integer, Integer>> iter = edges.iterator();
			while (iter.hasNext()) {
				Map<Integer, Integer> next = iter.next();
				Entry<Integer, Integer> entry = next.entrySet().iterator().next();
				Integer start = entry.getKey();
				Integer end = entry.getValue();
				if (start.equals(end)) {
//					System.out.println("self loop found, removing:" + next);
					iter.remove();
				}
			}
//			System.out.println("<<<<<<<<");
		}
		return edges.size();
	}
	
	private Container getCon() throws IOException {
		String in = Util.class.getResource("/kargerAdj.txt").getFile();
		HashSet<Integer> vertices = new HashSet<Integer>();
		ArrayList<Map<Integer, Integer>> edges = new ArrayList<Map<Integer,Integer>>();
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new FileReader(new File(in)));
			String line = reader.readLine();
			while (line != null) {
				StringTokenizer st = new StringTokenizer(line);
				int vertex = Integer.valueOf(st.nextToken().trim());
				vertices.add(vertex);
				while (st.hasMoreTokens()) {
					int start = vertex;
					int end = Integer.parseInt(st.nextToken().trim());
					boolean reverseEdgeAdded = false;
					for (Map<Integer, Integer> existingEdge : edges) {
						Entry<Integer, Integer> entry = existingEdge.entrySet().iterator().next();
						if (entry.getKey() == end && entry.getValue() == start) {
							reverseEdgeAdded = true;
							break;
						}
					}
					if (reverseEdgeAdded) {
						continue;
					}
					Map<Integer, Integer> valueMap = new HashMap<Integer, Integer>();
					valueMap.put(start, end);
					edges.add(valueMap);
				}
				line = reader.readLine();
			}
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} finally {
			if (reader != null) {
				reader.close();
			}
		}
		return new Container(vertices, edges);
	}

	private static class Container {
		HashSet<Integer> vertices;
		ArrayList<Map<Integer, Integer>> edges;
		
		Container(HashSet<Integer> vertices, ArrayList<Map<Integer, Integer>> edges) {
			this.vertices = vertices;
			this.edges = edges;
		}
	}

}
