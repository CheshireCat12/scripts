#!/bin/bash

#SBATCH --mail-user=anthony.gillioz@inf.unibe.ch
#SBATCH --mail-type=end,fail

#SBATCH --mem-per-cpu=30G
#SBATCH --cpus-per-task=10
#SBATCH --partition=epyc2
#SBATCH --qos=job_epyc2_long
#SBATCH --time=12-00:00:00
#SBATCH --output=/storage/homefs/ag21k209/neo_slurms/classification_ged_on_spectral_big_%A_%a.out
#SBATCH --array=9-50

param_store=./arguments_ged_on_spectral_big.txt

# Get first argument
dataset_name=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
dataset_save=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')
dimension=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $3}')
reduction=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $4}')
clustering_algo=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $5}')
merging_method=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $6}')
alphas=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $7}')
ks=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $8}')


# Put your code below this line
module load Workspace_Home
module load Python/3.9.5-GCCcore-10.3.0.lua
cd $HOME/graph_library/graph_classification/graph-classification-ged/
source venv/bin/activate

srun python main.py --root_dataset $SCRATCH/data/$dataset_save/spectral/$clustering_algo/$merging_method/red_fact$reduction/dimensions$dimension --n_cores 10 --save_gt_labels --save_predictions --save_distances --folder_results $HOME/graph_library/results/ged_classification/$dataset_save/spectral/$clustering_algo/$merging_method/red_fact$reduction/dimensions$dimension --alphas $alphas --ks $ks -v

