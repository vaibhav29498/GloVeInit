# GloVeInit
Implementation of the GloVeInit model for SemEval-2020 Task 1: Unsupervised Lexical Semantic Change Detection. To be presented at the 2020 International Workshop on Semantic Evaluation. Preprint can be found on [arXiv](https://arxiv.org/abs/2007.05618).

Run the following command to set the required permissions.
```
chmod 755 *.sh
```

To run the program, execute the following command in Bash.
```
./gloveinit.sh <window-size> <embeddding-dimensionality> <epochs> <min-count>
```

For example, use the following command to use the best-performing model as per the experiments -
```bash
./gloveinit.sh 10 50 60 5
```

If you use this code in your work, kindly cite the following paper.
```
@inproceedings{jain2020GVI,
  title={GloVeInit at SemEval-2020 Task 1: Using GloVe Vector Initialization for Unsupervised Lexical Semantic Change Detection},
  author={Vaibhav Jain}
  booktitle = "Proceedings of the 14th International Workshop on Semantic Evaluation",
  year = "2020",
  address = "Barcelona, Spain",
  publisher = "Association for Computational Linguistics"
}
```
