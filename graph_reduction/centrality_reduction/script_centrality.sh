#!/bin/bash

#SBATCH --mail-user=anthony.gillioz@inf.unibe.ch
#SBATCH --mail-type=end,fail

#SBATCH --mem-per-cpu=80G
#SBATCH --cpus-per-task=1
#SBATCH --time=1-10:00:00
#SBATCH --output=/storage/homefs/ag21k209/neo_slurms/centrality_full_%A_%a.out
#SBATCH --array=1-120

param_store=./arguments_centrality_reduction.txt

# Get first argument
dataset_name=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
centrality_name=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')
rho=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $3}')

# Put your code below this line
module load Workspace_Home
module load Python/3.9.5-GCCcore-10.3.0.lua
cd $HOME/graph_library/graph_reduction/graph-reduction-centrality
source venv/bin/activate

srun python main.py --dataset $dataset_name --root_dataset $SCRATCH/tmp/ --centrality-measure $centrality_name --rho $rho --folder-results $SCRATCH/data/$dataset_name/centrality/$centrality_name/$rho -v


