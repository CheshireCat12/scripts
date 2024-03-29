#!/bin/bash

#SBATCH --mail-user=anthony.gillioz@inf.unibe.ch
#SBATCH --mail-type=end,fail

#SBATCH --mem-per-cpu=20G
#SBATCH --cpus-per-task=2
#SBATCH --time=0-10:00:00
#SBATCH --output=/storage/homefs/ag21k209/neo_slurms/baseline_%A_%a.out
#SBATCH --array=1-3

param_store=./arguments_baseline.txt

# Get first argument
dataset_name=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
dataset_save=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')

# Put your code below this line
module load Workspace_Home
module load Python/3.9.5-GCCcore-10.3.0.lua
cd $HOME/graph_library/graph_reduction/baseline/
source venv/bin/activate

srun python baseline.py --dataset $dataset_name --root_dataset $SCRATCH/tmp/ --folder_results $SCRATCH/data/$dataset_save/baseline/ -v

