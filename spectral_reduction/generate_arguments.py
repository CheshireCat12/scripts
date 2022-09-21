from itertools import product

GRAPH_DATASETS = '''Mutagenicity MUTAGENICITY
NCI1 NCI1
NCI109 NCI109
NCI-H23H NCI-H23H
DD DD
ENZYMES ENZYMES
PROTEINS_full PROTEINS
FIRSTMM_DB FIRSTMM_DB
MSRC_9 MSRC_9
MSRC_21 MSRC_21
COLLAB COLLAB
github_stargazers GITHUB_STARGAZERS
REDDIT-BINARY REDDIT-BINARY
REDDIT-MULTI-5K REDDIT-MULTI-5K
REDDIT-MULTI-12K REDDIT-MULTI-12K
COLORS-3 COLORS-3
SYNTHETIC SYNTHETIC'''


def main():
    filename_parameters = 'arguments_spectral_reduction_full.txt'
    
    datasets = GRAPH_DATASETS.split('\n')
    dimensions = ['2', '3', '4', '5', '8']
    reductions = ['2', '4', '8', '16']
    clustering_algos = ['kmeans', 'agglomerative']
    merging_methods = ['sum']

    parameters = product(datasets,
                         dimensions,
                         reductions,
                         clustering_algos,
                         merging_methods)
    counter = 0
    with open(filename_parameters, 'w') as file:
        for dataset, dim, red, clust_algo, merg_meth in parameters:
            file.write(' '.join([dataset, dim, red, clust_algo, merg_meth]) + '\n')
            counter += 1

    print(f'Total of parameters generated: {counter}')


if __name__ == '__main__':
    main()
