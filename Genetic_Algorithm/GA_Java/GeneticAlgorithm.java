import java.util.ArrayList;
import java.util.List;

public abstract class GeneticAlgorithm {
    private List<Chromosome> population = new ArrayList<>();
    private int popSize = 100;//种群数量
    private int geneSize;//基因最大长度
    private int maxIterNum = 500;//最大迭代次数
    private double crossRate = 0.6;
    private double mutationRate = 0.01;//基因变异的概率
    private int maxMutationNum = 3;//最大变异次数

    private int generation = 1;//当前遗传到第几代

    private double bestScore;//最好得分  局部
    private double worstScore;//最坏得分  局部
    private double totalScore;//总得分  局部
    private double averageScore;//平均得分

    private double x; //记录历史种群中最好的X值
    private double y; //记录历史种群中最好的Y值
    private int geneI;//x y所在代数

    public GeneticAlgorithm(int geneSize) {
        this.geneSize = geneSize;
    }

    public void calculate(){
        generation = 1;
        init();
        while (generation < maxIterNum) {  //迭代maxIterNum
            evolve();   // （选择 -> 交叉)+ -> 变异 -> 计算得分
            print();    // 打印
            generation++;  // 代数
        }
    }

    private void evolve() {
        List<Chromosome> childPopulation = new ArrayList<>();
        while (childPopulation.size() < popSize) {
            Chromosome p1 = getParentChromosome();
            Chromosome p2 = getParentChromosome();
            List<Chromosome> chromosomes = Chromosome.genetic(p1, p2, crossRate);
            if (chromosomes != null)
                childPopulation.addAll(chromosomes);
        }
        List<Chromosome> t = population;
        population = childPopulation;
        t.clear();
        t = null;
        mutation();
        calculateScore();
    }

    private void init(){
        population = new ArrayList<>();
        for (int i = 0; i < popSize; i++) {
            Chromosome chromosome = new Chromosome(geneSize);
            population.add(chromosome);
        }
        calculateScore();
    }

    /**
     * 选择过程:轮盘赌法
     * @return
     */
    private Chromosome getParentChromosome() {
        double slide = Math.random() * totalScore;
        double sum = 0;
        for (Chromosome chromosome : population) {
            sum += chromosome.getScore();
            if (slide < sum && chromosome.getScore() >= averageScore)
                return chromosome;
        }
        return null;
    }

    private void calculateScore() {
        setChromosomeScore(population.get(0));
        bestScore = population.get(0).getScore();
        worstScore = population.get(0).getScore();
        totalScore = 0;
        for (Chromosome chromosome : population) {
            setChromosomeScore(chromosome);
            if (chromosome.getScore() > bestScore) {
                bestScore = chromosome.getScore();
                if (y < bestScore) {
                    x = changeX(chromosome);
                    y = bestScore;
                    geneI = geneSize;
                }
            }
            if (chromosome.getScore() < worstScore)
                worstScore = chromosome.getScore();
            totalScore += chromosome.getScore();
        }
        averageScore = totalScore / popSize;
        averageScore = Math.min(averageScore, bestScore);
    }

    private void mutation() {
        for (Chromosome chromosome : population) {
            if (Math.random() < mutationRate)
                chromosome.mutation((int) (Math.random() * maxMutationNum));   //变异次数

        }
    }

    private void setChromosomeScore(Chromosome chromosome) {
        if (chromosome == null) {
            return;
        }
        double x = changeX(chromosome);
        double y = calculateY(x);
        chromosome.setScore(y);
    }

    private void print() {
        System.out.println("--------------------------------");
        System.out.println("the generation is:" + generation);
        System.out.println("the best y is:" + bestScore);
        System.out.println("the worst fitness is:" + worstScore);
        System.out.println("the average fitness is:" + averageScore);
        System.out.println("the total fitness is:" + totalScore);
        System.out.println("geneI:" + geneI + "\tx:" + x + "\ty:" + y);
    }

    public abstract double calculateY(double x);

    public abstract double changeX(Chromosome chromosome);

    public List<Chromosome> getPopulation() {
        return population;
    }

    public void setPopulation(List<Chromosome> population) {
        this.population = population;
    }

    public int getPopSize() {
        return popSize;
    }

    public void setPopSize(int popSize) {
        this.popSize = popSize;
    }

    public int getGeneSize() {
        return geneSize;
    }

    public void setGeneSize(int geneSize) {
        this.geneSize = geneSize;
    }

    public int getMaxIterNum() {
        return maxIterNum;
    }

    public void setMaxIterNum(int maxIterNum) {
        this.maxIterNum = maxIterNum;
    }

    public double getMutationRate() {
        return mutationRate;
    }

    public void setMutationRate(double mutationRate) {
        this.mutationRate = mutationRate;
    }

    public int getMaxMutationNum() {
        return maxMutationNum;
    }

    public void setMaxMutationNum(int maxMutationNum) {
        this.maxMutationNum = maxMutationNum;
    }

    public int getGeneration() {
        return generation;
    }

    public void setGeneration(int generation) {
        this.generation = generation;
    }

    public double getBestScore() {
        return bestScore;
    }

    public void setBestScore(double bestScore) {
        this.bestScore = bestScore;
    }

    public double getWorstScore() {
        return worstScore;
    }

    public void setWorstScore(double worstScore) {
        this.worstScore = worstScore;
    }

    public double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(double totalScore) {
        this.totalScore = totalScore;
    }

    public double getAverageScore() {
        return averageScore;
    }

    public void setAverageScore(double averageScore) {
        this.averageScore = averageScore;
    }

    public double getX() {
        return x;
    }

    public void setX(double x) {
        this.x = x;
    }

    public double getY() {
        return y;
    }

    public void setY(double y) {
        this.y = y;
    }

    public int getGeneI() {
        return geneI;
    }

    public void setGeneI(int geneI) {
        this.geneI = geneI;
    }
}
