if [ -z ${LASER+x} ] ; then
  echo "Please set the environment variable 'LASER'"
  exit
fi

# encoder
model_dir="${LASER}/models"
encoder="${model_dir}/bilstm.93langs.2018-12-26.pt"
bpe_codes="${model_dir}/93langs.fcodes"

source_folder="/corpus/source_text/tourbar"
src_text=${source_folder}/en.txt
tgt_text=${source_folder}/id.txt
# src_text="/corpus/LASER/tasks/mining/test/en.txt.dup"
# tgt_text="/corpus/LASER/tasks/mining/test/id.txt.dup"
src_lang="en"
tgt_lang="id"


Embed () {
  txt=$1
  enc=${txt}.enc
  ll=$2
  if [ ! -s ${enc} ] ; then
    python ${LASER}/source/embed.py \
    --input ${txt} \
    --encoder ${encoder} \
    --token-lang ${ll} \
    --bpe-codes ${bpe_codes} \
    --output ${enc} \
    --verbose \
    --buffer-size 20000 \
    --max-tokens 30000
  fi
}

Embed ${src_text} ${src_lang}
Embed ${tgt_text} ${tgt_lang}

Mine () {
  src_text=$1
  tgt_text=$2
  src_lang=$3
  tgt_lang=$4
  
  if [ ! -s ${src_text}.out ] ; then
    python3 ${LASER}/source/mine_bitexts.py \
       ${src_text} ${tgt_text} \
       --src-lang ${src_lang} --trg-lang ${tgt_lang} \
       --src-embeddings ${src_text}.enc --trg-embeddings ${tgt_text}.enc \
       --unify --mode mine --retrieval max --margin ratio -k 4  \
       --output ${src_text}.out \
       --verbose --gpu
  fi
}

Mine ${src_text} ${tgt_text} ${src_lang} ${tgt_lang}