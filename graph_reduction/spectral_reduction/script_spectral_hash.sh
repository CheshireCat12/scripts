#!/bin/bash

#SBATCH --mail-user=anthony.gillioz@inf.unibe.ch
#SBATCH --mail-type=end,fail

#SBATCH --mem-per-cpu=80G
#SBATCH --cpus-per-task=1
#SBATCH --time=2-10:00:00
#SBATCH --output=/storage/homefs/ag21k209/neo_slurms/spectral_full_hash_%A_%a.out
#SBATCH --array=1-560

param_store=./arguments_spectral_reduction_full.txt

# Get first argument
dataset_name=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
dataset_save=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')
dimension=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $3}')
reduction=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $4}')
clustering_algo=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $5}')
merging_method=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $6}')

# Put your code below this line
module load Workspace_Home
module load Python/3.9.5-GCCcore-10.3.0.lua
cd $HOME/graph_library/graph_reduction/graph-reduction-spectral
source venv/bin/activate

srun python main.py --dataset $dataset_name --root_dataset $SCRATCH/tmp/ --split_by_cc --embedding_algorithm spectral --dim_embedding $dimension --clustering_algorithm $clustering_algo --reduction_factor $reduction --node_merging_method hash --folder_results $SCRATCH/data/$dataset_save/spectral/$clustering_algo/hash/red_fact$reduction/dimensions$dimension -v

