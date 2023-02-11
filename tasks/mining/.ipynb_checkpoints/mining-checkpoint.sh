# encoder
model_dir="${LASER}/models"
encoder="${model_dir}/bilstm.93langs.2018-12-26.pt"
bpe_codes="${model_dir}/93langs.fcodes"


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
    --verbose 
  fi
}

Embed "/corpus/LASER/tasks/mining/test/en.txt" en
Embed "/corpus/LASER/tasks/mining/test/id.txt" id