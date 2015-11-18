CHINESE StanFord NER 
step1:
download http://nlp.stanford.edu/software/segmenter.shtml
step2:
install "Stanford Word Segmenter"
step3
compile "segDemo.java"
		--note: UnZip stanford-segmenter-3.5.0.jar to current edu directory 
		--usage: javac segDemo.java
		--modification: convert ctb to pku(Peking University standard);ctb( Chinese Penn Treebank standard model) by default
step4:
command: java -mx1g SegDemo test.txt > test.seg
Note:    test.txt(coding scheme:utf-8) 
step5:
test.seg file in the directory NER model
java -mx500m -cp stanford-ner.jar edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier classifiers\chinese.misc.distsim.crf.ser.gz -textFile test.seg -outputFormat inlineXML
