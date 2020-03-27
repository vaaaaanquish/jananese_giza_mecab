# train GIZA++
/app/giza-pp/GIZA++-v2/plain2snt.out ja en
/app/giza-pp/GIZA++-v2/snt2cooc.out ja.vcb en.vcb ja_en.snt > ja_en.cooc
/app/giza-pp/GIZA++-v2/GIZA++ -s ja.vcb -t en.vcb -c ja_en.snt -coocurrence ja_en.cooc
