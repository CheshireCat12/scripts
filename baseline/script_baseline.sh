#!/bin/bash

#SBATCH --mail-user=anthony.gillioz@inf.unibe.ch
#SBATCH --mail-type=end,fail

#SBATCH --mem-per-cpu=16G
#SBATCH --cpus-per-task=8
#SBATCH --time=0-02:00:00
#SBATCH --output=~/slurms/test_with_preds_%A_%a.out
#SBATCH --array=1-17


param_store=./arguments_baseline.txt

# Get first argument
dataset_name=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
dataset_save=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')

# Put your code below this line
module load Python/3.9.5-GCCcore-10.3.0.lua
cd $HOME/graph_library/graph_reduction/baseline/
source venv/bin/activate

srun python baseline.py --dataset $dataset_name --folder_results $HOME/graph_library/data/$dataset_save/baseline/

