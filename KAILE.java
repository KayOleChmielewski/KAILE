package demo;


import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class KAILE {

    static class Kmer {
        String sequence;
        int position;

        Kmer(String sequence, int position) {
            this.sequence = sequence;
            this.position = position;
        }
    }

    static class Result {
        String queryName;
        String refName;
        String kmerQuery;
        String kmerRef;
        int positionQuery;
        int positionRef;
        int hammingDistance;

        Result(String queryName, String refName, String kmerQuery, int positionQuery, String kmerRef, int positionRef, int hammingDistance) {
            this.queryName = queryName;
            this.refName = refName;
            this.kmerQuery = kmerQuery;
            this.positionQuery = positionQuery;
            this.kmerRef = kmerRef;
            this.positionRef = positionRef;
            this.hammingDistance = hammingDistance;
        }

        @Override
        public String toString() {
            return "Query Name: " + queryName + ", Ref Name: " + refName +
                   ", K-mer Query: " + kmerQuery + " (Start: " + positionQuery + ")" +
                   ", K-mer Ref: " + kmerRef + " (Start: " + positionRef + ")" +
                   ", Hamming Distance: " + hammingDistance;
        }
    }

    public static void main(String[] args) {
        String inputFile = "";
        int k = 5; // Default k-mer size
        int maxHammingDistance = Integer.MAX_VALUE; // Default max Hamming distance

        // Parse command-line arguments
        for (int i = 0; i < args.length; i++) {
            switch (args[i]) {
                case "-i":
                    inputFile = args[++i];
                    break;
                case "-k":
                    k = Integer.parseInt(args[++i]);
                    break;
                case "-h":
                    maxHammingDistance = Integer.parseInt(args[++i]);
                    break;
            }
        }

        if (inputFile.isEmpty() || k <= 0 || maxHammingDistance < 0) {
            System.out.println("Invalid arguments.");
            return;
        }

        processFile(inputFile, k, maxHammingDistance);
    }

    public static void processFile(String inputFile, int k, int maxHammingDistance) {
        try (BufferedReader br = new BufferedReader(new FileReader(inputFile))) {
            List<String> lines = br.lines().collect(Collectors.toList());
            lines.parallelStream().forEach(line -> {
                String[] columns = line.split(",");
                if (columns.length >= 4) {
                    String queryName = columns[0];
                    String querySequence = columns[1];
                    String refName = columns[2];
                    String refSequence = columns[3];
                    processSequences(queryName, querySequence, refName, refSequence, k, maxHammingDistance);
                }
            });
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void processSequences(String queryName, String querySequence, String refName, String refSequence, int k, int maxHammingDistance) {
        List<Kmer> kmerSeqQuery = generateKmers(querySequence, k);
        List<Kmer> kmerSeqRef = generateKmers(refSequence, k);

        kmerSeqQuery.parallelStream().forEach(kmerQuery -> {
            kmerSeqRef.stream().forEach(kmerRef -> {
                if(kmerQuery.sequence.length() == kmerRef.sequence.length()){
                    int hammingDistance = calculateHammingDistance(kmerQuery.sequence, kmerRef.sequence);
                    if (hammingDistance <= maxHammingDistance) {
                        System.out.println(new Result(queryName, refName, kmerQuery.sequence, kmerQuery.position, kmerRef.sequence, kmerRef.position, hammingDistance));
                    }
                }
            });
        });
    }

    public static List<Kmer> generateKmers(String sequence, int k) {
        List<Kmer> kmers = new ArrayList<>();
        for (int i = 0; i <= sequence.length() - k; i++) {
            kmers.add(new Kmer(sequence.substring(i, i + k), i));
        }
        return kmers;
    }

    public static int calculateHammingDistance(String s1, String s2) {
        int distance = 0;
        for (int i = 0; i < s1.length(); i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                distance++;
            }
        }
        return distance;
    }
}

