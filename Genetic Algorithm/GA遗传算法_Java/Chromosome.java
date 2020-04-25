import javax.print.DocFlavor;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Chromosome {
    private boolean[] gene;
    private double score;

    public Chromosome() {
    }

    public Chromosome(int size) {
        if (size <= 0)
            return;
        gene = new boolean[size];
        for (int i = 0; i < size; i++)
            gene[i] = Math.random() >= 0.5;
    }

    public static Chromosome clone(Chromosome chromosome) {
        if (chromosome == null || chromosome.gene == null)
            return null;
        Chromosome copy = new Chromosome();
        copy.gene = new boolean[chromosome.gene.length];
        copy.score = chromosome.score;
        System.arraycopy(chromosome.gene, 0, copy.gene, 0, chromosome.gene.length);
        return copy;
    }

    /**
     * 交叉操作
     * @param p1:交叉对象1
     * @param p2:交叉对象2
     * @return 交叉后的对象
     */
    public static List<Chromosome> genetic(Chromosome p1, Chromosome p2, double crossRate) {
        if (p1 == null ||p2 == null)
            return null;
        if (p1.gene == null || p2.gene == null) {
            return null;
        }
        if (p1.gene.length != p2.gene.length) {
            return null;
        }

        Chromosome c1 = clone(p1);
        Chromosome c2 = clone(p2);
        if (Math.random() < crossRate) {
            int size = c1.gene.length;
            int roundA = (int)(Math.random() * size);
            int roundB = (int)(Math.random() * size);

            int max = Math.max(roundA, roundB);
            int min = Math.min(roundA, roundB);

            for (int i = min; i <= max; i++) {
                boolean temp = c1.gene[i];
                c1.gene[i] = c2.gene[i];
                c2.gene[i] = temp;
            }
        }
        List<Chromosome> chromosomes = new ArrayList<>();
        chromosomes.add(c1);
        chromosomes.add(c2);
        return chromosomes;
    }

    public void mutation(int num) {
        if (num == 0)
            return;
        int size = gene.length;
        for (int i = 0; i < num; i++) {
            int at = (int)(Math.random() * size) % size;
            gene[at] = !gene[at];
        }

    }

    public int binary2dec() {
        if (gene == null)
            return 0;
        int num = 0;
        for (boolean b : gene) {
            num <<= 1;
            if (b)
                num++;
        }
        return num;
    }

    public boolean[] getGene() {
        return gene;
    }

    public void setGene(boolean[] gene) {
        this.gene = gene;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    @Override
    public String toString() {
        return "Chromosome{" +
                "gene=" + Arrays.toString(gene) +
                ", score=" + score +
                '}';
    }

    public static void main(String[] args) {
        Chromosome chromosome = new Chromosome();
        chromosome.gene = new boolean[]{false, true, false, false};
        System.out.println(chromosome.binary2dec());
    }
}
