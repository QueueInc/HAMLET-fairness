#!/bin/bash
echo Running EXPERIMENTS
wget https://github.com/QueueInc/HAMLET/releases/download/$3/hamlet-$3-all.jar
python automl/run_hamlet.py --fair-mode $1 --workspace $2/hamlet/baseline --metric balanced_accuracy --fair_metric $5 --mining_target $7 --mode max --batch_size 500 --time_budget 7200 --version $3 --iterations 1 --volume $4 --kb /home/HAMLET-fairness/resources/kb.txt
python automl/run_hamlet.py --fair-mode $1 --workspace $2/hamlet/pkb --metric balanced_accuracy --fair_metric $5 --mining_target $7 --mode max --batch_size 500 --time_budget 7200 --version $3 --iterations 1 --volume $4 --kb /home/HAMLET-fairness/resources/pkb.txt
python automl/run_hamlet.py --fair-mode $1 --workspace $2/hamlet/ika --metric balanced_accuracy --fair_metric $5 --mining_target $7 --mode max --batch_size 125 --time_budget 1800 --version $3 --iterations 4 --volume $4 --kb /home/HAMLET-fairness/resources/kb.txt
python automl/run_hamlet.py --fair-mode $1 --workspace $2/hamlet/pkb_ika --metric balanced_accuracy --fair_metric $5 --mining_target $7 --mode max --batch_size 125 --time_budget 1800 --version $3 --iterations 4 --volume $4 --kb /home/HAMLET-fairness/resources/pkb.txt
cd ..
git config --global user.email "j.giovanelli@unibo.it"
git config --global user.name "Joseph Giovanelli"
git clone "https://$6@github.com/QueueInc/HAMLET-fairness-results.git"
cd HAMLET-fairness-results
cp -r $2 "./$1-$3-$5-$7"
git add .
git commit -m "new results in $1-$3-$5-$7"
git push

# python automl/run_comparison.py --tool auto-sklearn --budget 3600 --output_folder $1/auto_sklearn
# python automl/run_comparison.py --tool h2o --budget 3600 --output_folder $1/h2o
# python automl/post_processor/etl.py --path $1 --input-folder hamlet --output-folder hamlet --budget 500
