# DataSolve-WK-2022

This is a first place solution to the [DataSolve 2022 competition](https://www.kaggle.com/competitions/datasolve-india/overview) organized by Wolters Kluwer.

### Weights & Biases Dashboard [Link](https://wandb.ai/gladiator/DataSolve-2022)

## Tech Stack

- [HuggingFace transformers](https://huggingface.co/docs/transformers/index) and [Datasets](https://huggingface.co/docs/datasets/index) library.
- [HuggingFace Trainer](https://huggingface.co/docs/transformers/main_classes/trainer#trainer) and [PyTorch](https://pytorch.org/).
- [XGBoost](https://xgboost.readthedocs.io/en/stable/python/index.html) and [Catboost](https://catboost.ai/) library.
- [Weights & Biases](https://wandb.ai/site) for experiment tracking.

## Platform used

- The transformer based models were primarily trained on [jarvislabs.ai](http://jarvislabs.ai) and [lambdalabs.com](http://lambdalabs.com) on RTX5000, A5000 and A100 GPU instances.
- XGBoost and Catboost models were trained on Kaggle’s P100 GPU.

## Code Details

- **[Data preprocessing notebook](https://www.kaggle.com/code/atharvaingle/datasolve-eda-cv-setup)** → this notebook contains the EDA and the Cross-validation setup used for the competition. The processed and splitted data is saved in the **[dataset here.](https://www.kaggle.com/datasets/atharvaingle/datasolve-dataset)**
- **[Transformer train-test-split pipeline](https://www.kaggle.com/code/atharvaingle/datasolve-tts-pipeline)** → Transformer based pipeline. Note, this pipeline just use a simple split from train set for evaluation which might be not the most general way to evaluate models and have a huge risk of overfitting on the validation set. This pipeline was just used for running quick and dirty experiments and the final experiments were ran with the 5-fold pipeline for more robust results. Same notebook can be found on [GitHub repo too](https://github.com/Gladiator07/DataSolve-WK-2022/blob/main/notebooks/transformer_tts_pipeline.ipynb).
- **[Transformer 5-fold pipeline](https://github.com/Gladiator07/DataSolve-WK-2022/blob/main/notebooks/transformer_kfold.ipynb)** → All the transformer models used for the final ensemble were based out of this notebook. This pipeline runs a 5-fold training. The folds are stratified using the [iterstrat package](https://github.com/trent-b/iterative-stratification) which helps to stratify multi-label data. Specifically, `MultilabelStratifiedKFold` was used to create the folds. You can also check the complete data preprocessing and preparation stage in [this notebook](https://www.kaggle.com/code/atharvaingle/datasolve-eda-cv-setup).
- **[XGBoost pipeline](https://www.kaggle.com/code/atharvaingle/datasolve-xgboost-pipeline)** - traditional approaches like XGBoost with TFIDF/CountVectorizer was also used for diversity in the final ensemble. This used the same 5-folds used in the transformer pipleline for comparing the results and leak-free ensemble. Same notebook can be found on [GitHub repo](https://github.com/Gladiator07/DataSolve-WK-2022/blob/main/notebooks/xgboost_pipeline.ipynb) too.
- **[Catboost pipeline](https://www.kaggle.com/code/atharvaingle/datasolve-catboost-pipeline)** - replaced XGBoost model with Catboost (this was trained on CPU as catboost doesn’t support multi-label training on GPU yet). Same notebook can be found on [GitHub repo](https://github.com/Gladiator07/DataSolve-WK-2022/blob/main/notebooks/catboost_pipeline.ipynb) too.
- **[Hill climbing ensemble](https://www.kaggle.com/code/atharvaingle/datasolve-hill-climbing-ensemble/notebook)** - The final leaderboard score (`0.92276 private LB`) was obtained from this notebook. This notebook uses hill climbing algorithm for selecting the final models with corresponding weights obtaining overall best score on the cross-validation setup and then take the weighted average of them.

## Extras

- Many experiments were run during the course of the competition. To keep track of all the experiments, I used [wandb.ai](http://wandb.ai). The W&B dashboard can be **[accessed here](https://wandb.ai/gladiator/DataSolve-2022)**. All the configuration, console logs, saved artifacts/models can be viewed there. Furthermore, all the code that went into each experiment can be also viewed. For example: [best single model’s code](https://wandb.ai/gladiator/DataSolve-2022/runs/3hg8xska/code/transformer_kfold.ipynb).
- To download the out-of-fold (OOF) predictions, test set predictions and submission files saved for each experiment, **[this notebook](https://www.kaggle.com/code/atharvaingle/datasolve-download-artifacts)** was used and the output was used as a dataset for [Hill Climbing Ensemble notebook](https://www.kaggle.com/code/atharvaingle/datasolve-hill-climbing-ensemble/notebook)
- Even though model efficiency was not the main aim of competition, still I tried Knowledge distillation to make the base model (which is much smaller and easier to deploy) as performant as the large model (or an ensemble of models) for faster inference (ideally suited for deployment environments) out of curiosity. However, due to the limited time I couldn’t make it work. [This is the corresponding notebook](https://github.com/Gladiator07/DataSolve-WK-2022/blob/main/notebooks/knowledge_distillation.ipynb) for the same.

### The best and the final score was obtained by **[this version](https://www.kaggle.com/code/atharvaingle/datasolve-hill-climbing-ensemble/notebook?scriptVersionId=112055511)** of the hill climbing ensemble notebook
