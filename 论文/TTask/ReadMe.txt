Usage Condition:Java 1.8
Feature Extract usage: perl Bin\feature_extract.pl Text
recognition usage: java edu.stanford.nlp.classify.ColumnDataClassifier -prop 配置文件 > 结果
										NOTE: recognition usage -->路径在edu的父目录下执行java edu.stanford.nlp.classify.ColumnDataClassifier -prop 配置文件 > 结果
										配置文件:可以任意修改
										
										
										
Text Usage(纯文本的使用方法):
E:\Task\unify_text.bat TextAbsolutePath TopN
			unify_text.bat里面perl feature_extract_textVersion.pl -f %textpath%其中特征提取是以单词为默认特征
			[-f|-file] 表示文本路径
			[-p|-pos] 表示pos特征 如 -p pos或者-pos pos其中pos不区分大小写
			[-c|-chunk] 表示chunk特征
Tag Usage(标记文本方法)：
Note:
E:\Task\unify_text.bat TextAbsolutePath TopN
