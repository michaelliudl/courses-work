package algo;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;
import java.util.Map.Entry;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.TreeMap;

public class Homework4 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Homework4 hw = new Homework4();
		/*build reversed graph tree map, sorted by finishing time=original index
		first DFS-loop, build tree map sorted by finishing time
		second DFS-loop for leaders
		iterate for top 5 leadres and count*/
		List<TreeMap<Node, Set<Node>>> graphs = hw.getReversedGraph();
		TreeMap<Node, Set<Node>> normGraph = graphs.get(0);
		TreeMap<Node, Set<Node>> revGraph = graphs.get(1);
		hw.dfsLoop(normGraph, revGraph);
		hw.dfsLoop(normGraph);
		Map<Integer, Set<Integer>> scc = hw.findScc(normGraph);
		TreeSet<Integer> sccSize = hw.getSccSize(scc);
		System.out.println(sccSize);
	}
	
	private TreeSet<Integer> getSccSize(Map<Integer, Set<Integer>> scc) {
		TreeSet<Integer> sizes = new TreeSet<Integer>();
		Iterator<Entry<Integer, Set<Integer>>> iter = scc.entrySet().iterator();
		while (iter.hasNext()) {
			sizes.add(iter.next().getValue().size());
		}
		return sizes;
	}

	private Map<Integer, Set<Integer>> findScc(TreeMap<Node, Set<Node>> normGraph) {
		Iterator<Entry<Node, Set<Node>>> iter = normGraph.entrySet().iterator();
		Map<Integer, Set<Integer>> result = new HashMap<Integer, Set<Integer>>();
		while (iter.hasNext()) {
			Node node = iter.next().getKey();
			if (result.containsKey(node.leader)) {
				result.get(node.leader).add(node.nodeIndex);
			} else {
				Set<Integer> nodes = new HashSet<Integer>();
				nodes.add(node.nodeIndex);
				result.put(node.leader, nodes);
			}
		}
		return result;
	}

	private void dfsLoop(TreeMap<Node, Set<Node>> normGraph) {
		Integer s = null;
		//System.out.println(normGraph);
		Iterator<Node> iter = normGraph.descendingKeySet().iterator();
		Set<Integer> exploredNodes = new HashSet<Integer>();
		while (iter.hasNext()) {
			Node node = iter.next();
			if (exploredNodes.contains(node.nodeIndex)) {
				continue;
			}
			s = node.nodeIndex;
			dfs(normGraph, node, s, exploredNodes);
		}
	}
	
	private void dfs(TreeMap<Node, Set<Node>> normGraph, Node node, Integer s, Set<Integer> exploredNodes) {
		exploredNodes.add(node.nodeIndex);
		node.leader = s;
		if (normGraph.get(node) == null) {
			System.out.println(node);
			System.out.println();
		}
		Iterator<Node> iter = normGraph.get(node).iterator();
		while (iter.hasNext()) {
			Node head = iter.next();
			if (exploredNodes.contains(head.nodeIndex)) {
				continue;
			}
			dfs(normGraph, head, s, exploredNodes);
		}
	}
	
	private void dfsLoop(TreeMap<Node, Set<Node>> normGraph, TreeMap<Node, Set<Node>> revGraph) {
		int t = 0;
		//Integer s = null;
		//Iterator<Entry<Node, Set<Node>>> iter = revGraph.descendingMap().entrySet().iterator();
		Iterator<Node> iter = revGraph.descendingKeySet().iterator();
		Set<Integer> exploredNodes = new HashSet<Integer>();
		while (iter.hasNext()) {
			//Entry<Node, Set<Node>> entry = iter.next();
			//Node node = entry.getKey();
			Node node = iter.next();
			if (exploredNodes.contains(node.nodeIndex)) {
				continue;
			}
			//s = node.nodeIndex;
			t = dfs(normGraph, revGraph, node, t, exploredNodes);
		}
	}
	
	private int dfs(TreeMap<Node, Set<Node>> normGraph, TreeMap<Node, Set<Node>> revGraph, Node node, int t, Set<Integer> exploredNodes) {
		exploredNodes.add(node.nodeIndex);
		//node.leader = s;
		/*if (revGraph.get(node) == null) {
			return t;
		}*/
		
		/*if (node.nodeIndex == 875709) {
			System.out.println(node);
			System.out.println(revGraph.get(node));
			System.out.println(revGraph.lastKey());
			System.out.println(revGraph.lastKey().compareTo(node));
			System.out.println();
		}*/
		if (revGraph.get(node) != null) {
			Iterator<Node> iter = revGraph.get(node).iterator();
			while (iter.hasNext()) {
				Node head = iter.next();
				if (exploredNodes.contains(head.nodeIndex)) {
					continue;
				}
				dfs(normGraph, revGraph, head, t, exploredNodes);
			}
		}
		t++;
		/*if (node.nodeIndex == 875707) {
			System.out.println(normGraph.ceilingEntry(node));
			System.out.println(normGraph.ceilingEntry(node).getKey());
			System.out.println();
		}*/
		if (normGraph.ceilingEntry(node) != null && normGraph.ceilingEntry(node).getKey() != null) {
			normGraph.ceilingEntry(node).getKey().finishTime = t;
		} else {
			Node nodeInNorm = new Node(node.nodeIndex, t, node.nodeIndex);
			normGraph.put(nodeInNorm, Collections.EMPTY_SET);
		}
		return t;
	}
	
	private List<TreeMap<Node, Set<Node>>> getReversedGraph() {
		/*BufferedReader reader = null;
		try {
			ZipFile zf = new ZipFile(Util.class.getResource("/SCC.zip").getFile());
			reader = new BufferedReader(new FileReader(zf.getInputStream(zf.getEntry("SCC.txt").)));
			
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} finally {
			if (reader != null) {
				reader.close();
			}
		}*/
		TreeMap<Node, Set<Node>> normGraph = new TreeMap<Homework4.Node, Set<Node>>();
		TreeMap<Node, Set<Node>> revGraph = new TreeMap<Homework4.Node, Set<Node>>();
		BufferedReader reader = null;
		try {
			String in = Util.class.getResource("/SCC.txt").getFile();
			reader = new BufferedReader(new FileReader(new File(in)));
			String line = reader.readLine();

			while (line != null) {
				StringTokenizer st = new StringTokenizer(line);
				int tail = Integer.parseInt(st.nextToken().trim());
				int head = Integer.parseInt(st.nextToken().trim());
				
				Node tailNode = new Node(tail, tail, null);
				Node headNode = new Node(head, head, null);
				if (normGraph.containsKey(tailNode)) {
					normGraph.get(tailNode).add(headNode);
				} else {
					Set<Node> heads = new HashSet<Homework4.Node>();
					heads.add(headNode);
					normGraph.put(tailNode, heads);
				}
				
				Node revHead = new Node(tail, tail, null);
				Node revTail = new Node(head, head, null);
				if (revGraph.containsKey(revTail)) {
					revGraph.get(revTail).add(revHead);
				} else {
					Set<Node> heads = new HashSet<Homework4.Node>();
					heads.add(revHead);
					revGraph.put(revTail, heads);
				}
				/*if (head==875709) {
					System.out.println(revGraph.get(revTail));
				}*/
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
		List<TreeMap<Node, Set<Node>>> graphs = new ArrayList<TreeMap<Node,Set<Node>>>();
		graphs.add(normGraph);
		graphs.add(revGraph);
		/*System.out.println(normGraph.size());
		System.out.println(revGraph.size());*/
		return graphs;
	}
	
	private static class Node implements Comparable<Node> {
		private Integer nodeIndex;
		private Integer finishTime;
		private Integer leader;
		
		Node(Integer nodeIndex, Integer finishTime, Integer leader) {
			this.nodeIndex = nodeIndex;
			this.finishTime = finishTime;
			this.leader = leader;
		}
		
		@Override
		public int compareTo(Node o) {
			if (o != null && o.finishTime != null && this.finishTime != null) {
				return this.finishTime.compareTo(o.finishTime);
			}
			throw new IllegalArgumentException();
		}
		
		@Override
		public String toString() {
			return "nodeIndex=" + nodeIndex + "; finishTime=" + finishTime + ", leader=" + leader;
		}
		
		@Override
		public boolean equals(Object o) {
			if (o != null && o instanceof Node) {
				if (this.finishTime != null) {
					return this.finishTime.equals(((Node)o).finishTime);
				}
			}
			return false;
		}
		
		@Override
		public int hashCode() {
			return 31 * 31 * nodeIndex.hashCode() + 31 * finishTime.hashCode() + (leader != null ? leader.hashCode() : 0);
		}
		
	}

}
