#!/bin/bash

#SBATCH --mail-user=anthony.gillioz@inf.unibe.ch
#SBATCH --mail-type=end,fail

#SBATCH --mem-per-cpu=20G
#SBATCH --cpus-per-task=2
#SBATCH --time=0-02:00:00
#SBATCH --output=/storage/homefs/ag21k209/neo_slurms/classification_gk_WL_on_baseline_small_%A_%a.out
#SBATCH --array=1-11

param_store=./arguments_gk_baseline_small.txt

# Get first argument
dataset_name=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
dataset_save=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')

# Put your code below this line
module load Workspace_Home
module load Python/3.9.5-GCCcore-10.3.0.lua
cd $HOME/graph_library/graph_classification/graph-classification-kernel/
source venv/bin/activate

srun python main.py --root_dataset $SCRATCH/data/$dataset_save/baseline --graph_kernel WL --n_cores 2 --save_gt_labels --save_predictions --folder_results $HOME/graph_library/results/gk_WL_classification/$dataset_save/baseline -v

