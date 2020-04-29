from GA遗传算法.Population import Population
import numpy as np

cross_rate = 0.6
mutation_rate = 0.001
pop_size = 100
chromosome_size = 10
population = Population(100, 10)

for i in range(100):
    population.cal_obj_value()
    population.select_chromosome()
    population.cross_chromosome(cross_rate)
    population.mutation_chromosome(mutation_rate)
    best_individual, best_fit = population.best()
    best_individual = np.expand_dims(best_individual, 0)
    x = population.binary2decimal(best_individual)
    print("X：", x, "\t Y: ", best_fit)
