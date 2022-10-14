#!/bin/bash

#SBATCH --mail-user=anthony.gillioz@inf.unibe.ch
#SBATCH --mail-type=end,fail

#SBATCH --mem-per-cpu=40G
#SBATCH --cpus-per-task=10
#SBATCH --partition=epyc2
#SBATCH --qos=job_epyc2_long
#SBATCH --time=13-00:00:00
#SBATCH --output=/storage/homefs/ag21k209/neo_slurms/classification_ged_on_baseline_big_%A_%a.out
#SBATCH --array=1-4

param_store=./arguments_ged_on_baseline_big.txt

# Get first argument
dataset_name=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
dataset_save=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')
alphas=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $3}')
ks=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $4}')

# Put your code below this line
module load Workspace_Home
module load Python/3.9.5-GCCcore-10.3.0.lua
cd $HOME/graph_library/graph_classification/graph-classification-ged/
source venv/bin/activate

srun python main.py --root_dataset $SCRATCH/data/$dataset_save/baseline --n_cores 10 --save_gt_labels --save_predictions --save_distances --folder_results $HOME/graph_library/results/ged_classification/$dataset_save/baseline --alphas $alphas --ks $ks -v

