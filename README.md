# GloVeInit
Implementation of the GloVeInit model for SemEval-2020 Task 1: Unsupervised Lexical Semantic Change Detection. To be presented at the 2020 International Workshop on Semantic Evaluation. Paper can be found on [ACL Anthology](https://www.aclweb.org/anthology/2020.semeval-1.25/).

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
@inproceedings{jain-2020-gloveinit,
    title = "{G}lo{V}e{I}nit at {S}em{E}val-2020 Task 1: Using {G}lo{V}e Vector Initialization for Unsupervised Lexical Semantic Change Detection",
    author = "Jain, Vaibhav",
    booktitle = "Proceedings of the Fourteenth Workshop on Semantic Evaluation",
    month = dec,
    year = "2020",
    address = "Barcelona (online)",
    publisher = "International Committee for Computational Linguistics",
    url = "https://www.aclweb.org/anthology/2020.semeval-1.25",
    pages = "208--213"
}
```
