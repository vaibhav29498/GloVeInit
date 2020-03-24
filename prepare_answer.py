from gensim.models import KeyedVectors
from gensim.scripts.glove2word2vec import glove2word2vec
from sklearn.metrics.pairwise import cosine_distances

languages = ['english', 'german', 'latin', 'swedish']

for i in range(4):

  _ = glove2word2vec('data/' + languages[i] + '/glove1.txt', 'data/' + languages[i] + '/gensim1.txt')
  _ = glove2word2vec('data/' + languages[i] + '/glove2.txt', 'data/' + languages[i] + '/gensim2.txt')

  model1 = KeyedVectors.load_word2vec_format('data/' + languages[i] + '/gensim1.txt')
  model2 = KeyedVectors.load_word2vec_format('data/' + languages[i] + '/gensim2.txt')

  with open('data/' + languages[i] + '/targets.txt', 'r') as inp:
    with open('answer/task2/' + languages[i] + '.txt', 'w') as out:
      for l in inp:
        w = l.strip()
        out.write(w + '\t' + str(cosine_distances([model1[w]], [model2[w]])[0][0]) + '\n')
