from itertools import product


def main():
    filename_parameters = 'arguments_centrality_reduction.txt'

    datasets = [
        'COLLAB', 'IMDB-BINARY', 'IMDB-MULTI', 'REDDIT-BINARY', 'REDDIT-MULTI-5K', 'REDDIT-MULTI-12K',
        'AIDS', 'BZR', 'DHFR',
        'Mutagenicity', 'NCI1', 'NCI109',
        'DD', 'ENZYMES', 'PROTEINS_full',
    ]
    centrality_measures = ['pagerank', 'betweenness']
    rhos = [0.8, 0.6, 0.4, 0.2]

    parameters = product(datasets,
                         centrality_measures,
                         rhos)
    counter = 0
    with open(filename_parameters, 'w') as file:
        for dataset, centrality, rho in parameters:
            file.write(' '.join([dataset, centrality, str(rho)]) + '\n')
            counter += 1

    print(f'Total of parameters generated: {counter}')


if __name__ == '__main__':
    main()
