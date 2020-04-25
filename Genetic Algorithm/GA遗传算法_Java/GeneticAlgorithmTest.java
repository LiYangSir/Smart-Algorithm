public class GeneticAlgorithmTest extends GeneticAlgorithm {

    private static final int NUM = 1 << 24;

    public GeneticAlgorithmTest() {
        super(24);
    }

    /**
     * 函数值
     * @param x
     * @return
     */
    @Override
    public double calculateY(double x) {  // "10*sin(5*x)+7*abs(x-5)+10"
        return 10.0 * Math.sin(5.0 * x) + 7.0 * Math.abs(x - 5) + 10;
    }

    /**
     * 根据基因序列转换成x轴得值
     * @param chromosome 基因序列
     * @return x轴的值
     */
    @Override
    public double changeX(Chromosome chromosome) {
        return ((1.0 * chromosome.binary2dec() / NUM) * 10);
    }

    public static void main(String[] args) {
        GeneticAlgorithmTest test = new GeneticAlgorithmTest();
        test.calculate();
    }
}
