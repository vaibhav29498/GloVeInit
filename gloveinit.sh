# Data download
mkdir data

# English
wget https://www2.ims.uni-stuttgart.de/data/sem-eval-ulscd/semeval2020_ulscd_eng.zip
unzip -n semeval2020_ulscd_eng.zip
rm -rf data/english
mv semeval2020_ulscd_eng  data/english
rm semeval2020_ulscd_eng.zip

gzip -d data/english/corpus1/lemma/ccoha1.txt.gz
gzip -d data/english/corpus2/lemma/ccoha2.txt.gz

cat data/english/corpus1/lemma/ccoha1.txt data/english/corpus2/lemma/ccoha2.txt > data/english/corpora.txt

# German
wget https://www2.ims.uni-stuttgart.de/data/sem-eval-ulscd/semeval2020_ulscd_ger.zip
unzip -n semeval2020_ulscd_ger.zip
rm -rf data/german
mv semeval2020_ulscd_ger  data/german
rm semeval2020_ulscd_ger.zip

gzip -d data/german/corpus1/lemma/dta.txt.gz
gzip -d data/german/corpus2/lemma/bznd.txt.gz

cat data/german/corpus1/lemma/dta.txt data/german/corpus2/lemma/bznd.txt > data/german/corpora.txt

# Latin
wget https://zenodo.org/record/3674988/files/semeval2020_ulscd_lat.zip
unzip -n semeval2020_ulscd_lat.zip
rm -rf data/latin
mv semeval2020_ulscd_lat  data/latin
rm semeval2020_ulscd_lat.zip

gzip -d data/latin/corpus1/lemma/LatinISE1.txt.gz
gzip -d data/latin/corpus2/lemma/LatinISE2.txt.gz

cat data/latin/corpus1/lemma/LatinISE1.txt data/latin/corpus2/lemma/LatinISE2.txt > data/latin/corpora.txt

# Swedish
wget https://zenodo.org/record/3672950/files/semeval2020_ulscd_swe.zip
unzip -n semeval2020_ulscd_swe.zip
rm -rf data/swedish
mv semeval2020_ulscd_swe  data/swedish
rm semeval2020_ulscd_swe.zip

gzip -d data/swedish/corpus1/lemma/kubhist2a.txt.gz
gzip -d data/swedish/corpus2/lemma/kubhist2b.txt.gz

cat data/swedish/corpus1/lemma/kubhist2a.txt data/swedish/corpus2/lemma/kubhist2b.txt > data/swedish/corpora.txt

# GloVe
git clone https://github.com/stanfordnlp/GloVe.git
cd GloVe
make
cd ..
chmod -R 755 GloVe

# Training

!mkdir answer answer/task1 answer/task2

declare -a l=("english" "german" "latin" "swedish")
declare -a f=("ccoha1" "dta" "LatinISE1" "kubhist2a")
declare -a s=("ccoha2" "bznd" "LatinISE2" "kubhist2b")

for i in {0..3}
do
    GloVe/build/vocab_count -min-count $4 < data/${l[$i]}/corpora.txt > data/${l[$i]}/vocab.txt -verbose 1
    rm data/${l[$i]}/corpora.txt

    GloVe/build/cooccur -vocab-file data/${l[$i]}/vocab.txt -window-size $1 < data/${l[$i]}/corpus1/lemma/${f[$i]}.txt > data/${l[$i]}/cooccur1.bin -verbose 1
    rm data/${l[$i]}/corpus1/lemma/${f[$i]}.txt
    GloVe/build/cooccur -vocab-file data/${l[$i]}/vocab.txt -window-size $1 < data/${l[$i]}/corpus2/lemma/${s[$i]}.txt > data/${l[$i]}/cooccur2.bin -verbose 1
    rm data/${l[$i]}/corpus2/lemma/${s[$i]}.txt

    GloVe/build/shuffle -seed 42 < data/${l[$i]}/cooccur1.bin > data/${l[$i]}/shuffle1.bin -verbose 1
    rm data/${l[$i]}/cooccur1.bin
    GloVe/build/shuffle -seed 42 < data/${l[$i]}/cooccur2.bin > data/${l[$i]}/shuffle2.bin -verbose 1
    data/${l[$i]}/cooccur2.bin

    GloVe/build/glove -save-file data/${l[$i]}/glove1 -seed 29 -binary 2 -threads 4 -input-file data/${l[$i]}/shuffle1.bin -iter $3 -vector-size $2 -vocab-file data/${l[$i]}/vocab.txt -verbose 1
    rm data/${l[$i]}/shuffle1.bin

    GloVe/build/glove -save-file data/${l[$i]}/glove2 -seed 98 -binary 2 -input-file data/${l[$i]}/shuffle2.bin -iter $3 -vector-size $2 -vocab-file data/${l[$i]}/vocab.txt -verbose 1 -load-init-param 1 -init-param-file data/${l[$i]}/glove1.bin
    rm data/${l[$i]}/shuffle2.bin

    rm data/${l[$i]}/vocab.txt
done

# Determining scores

pip install gensim
pip install sklearn
python prepare_answer.py
zip -r answer-$1-$2-$3-$4.zip answer