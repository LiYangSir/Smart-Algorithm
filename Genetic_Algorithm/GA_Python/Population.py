import numpy as np


class Population:

    def __init__(self, pop_size, chromosome_size):
        self.pop_size = pop_size
        self.chromosome_size = chromosome_size
        self.population = np.round(np.random.rand(pop_size, chromosome_size)).astype(np.int)
        self.fit_value = np.zeros((pop_size, 1))

    def select_chromosome(self):
        total_fitness_value = self.fit_value.sum()
        p_fit_value = self.fit_value/total_fitness_value
        p_fit_value = np.cumsum(p_fit_value)
        point = np.sort(np.random.rand(self.pop_size, 1), 0)
        fit_in = 0
        new_in = 0
        new_population = np.zeros_like(self.population)
        while new_in < self.pop_size:
            if point[new_in] < p_fit_value[fit_in]:
                new_population[new_in, :] = self.population[fit_in, :]
                new_in += 1
            else:
                fit_in += 1
        self.population = new_population

    def cross_chromosome(self, cross_rate):
        x = self.pop_size
        y = self.chromosome_size
        new_population = np.zeros_like(self.population)
        for i in range(0, x-1, 2):
            if np.random.rand(1) < cross_rate:
                insert_point = int(np.round(np.random.rand(1) * y).item())
                new_population[i, :] = np.concatenate([self.population[i, 0:insert_point], self.population[i+1, insert_point:y]], 0)
                new_population[i+1, :] = np.concatenate([self.population[i+1, 0:insert_point], self.population[i, insert_point:y]], 0)
            else:
                new_population[i, :] = self.population[i, :]
                new_population[i + 1, :] = self.population[i + 1, :]
        self.population = new_population

    def best(self):
        best_individual = self.population[0, :]
        best_fit = self.fit_value[0]
        for i in range(1, self.pop_size):
            if self.fit_value[i] > best_fit:
                best_individual = self.population[i, :]
                best_fit = self.fit_value[i]
        return best_individual, best_fit

    def mutation_chromosome(self, mutation_rate):
        x = self.pop_size
        for i in range(x):
            if np.random.rand(1) < mutation_rate:
                m_point = int(np.round(np.random.rand(1) * self.chromosome_size).item())
                if self.population[i, m_point] == 1:
                    self.population[i, m_point] = 0
                else:
                    self.population[i, m_point] = 1

    def binary2decimal(self, population):
        pop1 = np.zeros_like(population)
        y = self.chromosome_size
        for i in range(y):
            pop1[:, i] = 2 ** (y - i - 1) * population[:, i]
        pop = np.sum(pop1, 1)
        pop2 = pop * 10/(1 << y)
        return pop2

    def cal_obj_value(self):
        x = self.binary2decimal(self.population)
        self.fit_value = 10 * np.sin(5 * x) + 7 * np.abs(x - 5) + 10


if __name__ == "__main__":
    pop = Population(10, 3)
    a = np.random.rand(1, 1)
    b = np.random.rand(1, 2)
    c = np.concatenate([a, b], 1)
    print(c)
    point = np.random.rand(10, 1)
    point = np.sort(point, 0)
    print(point)