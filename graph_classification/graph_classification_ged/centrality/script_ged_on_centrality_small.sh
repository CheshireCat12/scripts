#!/bin/bash

#SBATCH --mail-user=anthony.gillioz@inf.unibe.ch
#SBATCH --mail-type=end,fail

#SBATCH --mem-per-cpu=30G
#SBATCH --cpus-per-task=10
#SBATCH --partition=epyc2
#SBATCH --time=4-00:00:00
#SBATCH --output=/storage/homefs/ag21k209/neo_slurms/ged_on_centrality_small_%A_%a.out
#SBATCH --array=1-96

param_store=./arguments_ged_on_centrality_small.txt

# Get first argument
dataset_name=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
centrality_name=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')
rho=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $3}')

# Put your code below this line
module load Workspace_Home
module load Python/3.9.5-GCCcore-10.3.0.lua
cd $HOME/graph_library/graph_classification/graph-classification-ged/
source venv/bin/activate

srun python main.py --root-dataset $SCRATCH/data/$dataset_name/centrality/$centrality_name/$rho --graph-format pkl --n-trials 10 --n-outer-cv 10 --n-inner-cv 3 --n-cores 10 --save-gt-labels --save-predictions --folder-results $HOME/graph_library/results/ged_classification/$dataset_name/centrality/$centrality_name/$rho -v
