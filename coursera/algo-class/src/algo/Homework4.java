package algo;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.TreeMap;
import java.util.TreeSet;

public class Homework4 {
	
	Map<Integer, Set<Integer>> normGraph = new HashMap<Integer, Set<Integer>>();
	
	TreeMap<Integer, Set<Integer>> revGraph = new TreeMap<Integer, Set<Integer>>(
			new Comparator<Integer>() {

				@Override
				public int compare(Integer o1, Integer o2) {
					return -(o1.compareTo(o2));
				}
			});
	
	TreeMap<Integer, Integer> finishTimeOfNodes = new TreeMap<Integer, Integer>(
			new Comparator<Integer>() {

				@Override
				public int compare(Integer o1, Integer o2) {
					return -(o1.compareTo(o2));
				}
			});
	
	Map<Integer, Set<Integer>> leaderOfNodes = new HashMap<Integer, Set<Integer>>();
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Homework4 hw = new Homework4();
		hw.readGraph();
		System.out.println("done read graph");
		hw.dfsLoopOnRev();
		System.out.println("done dfs loop on rev");
		hw.revGraph = null;
		hw.dfsLoopOnNorm();
		System.out.println("done dfs loop on norm");
		hw.normGraph = null;
		hw.finishTimeOfNodes = null;
		
		TreeSet<Integer> fccSizes = hw.getSccSizes();
		System.out.println(fccSizes);
	}
	
	private TreeSet<Integer> getSccSizes() {
		TreeSet<Integer> sizes = new TreeSet<Integer>(
				new Comparator<Integer>() {

					@Override
					public int compare(Integer o1, Integer o2) {
						return -(o1.compareTo(o2));
					}
				});
		Iterator<Entry<Integer, Set<Integer>>> iter = leaderOfNodes.entrySet().iterator();
		while (iter.hasNext()) {
			sizes.add(iter.next().getValue().size());
		}
		return sizes;
	}
	
	private void dfsLoopOnNorm() {
		Integer s = null;
		Iterator<Entry<Integer, Integer>> iter = finishTimeOfNodes.entrySet().iterator();
		Set<Integer> exploredNodes = new HashSet<Integer>();
		while (iter.hasNext()) {
			Integer node = iter.next().getValue();
			if (exploredNodes.contains(node)) {
				continue;
			}
			s = node;
			dfsOnNorm(node, s, exploredNodes);
		}
	}
	
	private void dfsOnNorm(Integer node, Integer s, Set<Integer> exploredNodes) {
		exploredNodes.add(node);
		if (leaderOfNodes.containsKey(s)) {
			leaderOfNodes.get(s).add(node);
		} else {
			Set<Integer> children = new HashSet<Integer>();
			children.add(node);
			leaderOfNodes.put(s, children);
		}

		Iterator<Integer> iter = normGraph.get(node).iterator();
		while (iter.hasNext()) {
			Integer head = iter.next();
			if (exploredNodes.contains(head)) {
				continue;
			}
			dfsOnNorm(head, s, exploredNodes);
		}
	}
	
	private void dfsLoopOnRev() {
		int t = 0;
		Iterator<Integer> iter = revGraph.keySet().iterator();
		Set<Integer> exploredNodes = new HashSet<Integer>();
		while (iter.hasNext()) {
			Integer node = iter.next();
			if (exploredNodes.contains(node)) {
				continue;
			}
			t = dfsOnRev(node, t, exploredNodes);
		}
	}
	
	private int dfsOnRev(Integer node, int t, Set<Integer> exploredNodes) {
		exploredNodes.add(node);

		if (revGraph.get(node) != null) {
			Iterator<Integer> iter = revGraph.get(node).iterator();
			while (iter.hasNext()) {
				Integer head = iter.next();
				if (exploredNodes.contains(head)) {
					continue;
				}
				t = dfsOnRev(head, t, exploredNodes);
			}
		}
		t++;
		finishTimeOfNodes.put(t, node);
		return t;
	}
	
	private void readGraph() {
		BufferedReader reader = null;
		try {
			String in = Util.class.getResource("/SCC.txt").getFile();
			reader = new BufferedReader(new FileReader(new File(in)));
			String line = reader.readLine();

			while (line != null) {
				StringTokenizer st = new StringTokenizer(line);
				Integer tail = Integer.valueOf(st.nextToken().trim());
				Integer head = Integer.valueOf(st.nextToken().trim());
				
				addToGraph(normGraph, tail, head);
				addToGraph(revGraph, head, tail);

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
	}
	
	private void addToGraph(Map<Integer, Set<Integer>> graph,
			Integer tail, Integer head) {
		if (graph.containsKey(tail)) {
			graph.get(tail).add(head);
		} else {
			Set<Integer> heads = new HashSet<Integer>();
			heads.add(head);
			graph.put(tail, heads);
		}
		if (!graph.containsKey(head)) {
			Set<Integer> placeholder = new HashSet<Integer>();
			graph.put(head, placeholder);
		}
	}


}
