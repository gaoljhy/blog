# 七、运行YARN应用程序

YARN应用程序（Application）可以是一个简单的shell脚本、MapReduce作业或其它任意类型的作业。

需要运行应用程序时，客户端需要事先生成一个ApplicationMaster，而后客户端把application context提交给ResourceManager，随后RM向AM分配内存及运行应用程序的容器。

大体来说，此过程分为六个阶段。

1. Application初始化及提交；
2. 分配内存并启动AM；
3. AM注册及资源分配；
4. 启动并监控容器；
5. Application进度报告；
6. Application运行完成；

下面利用搭建好的Hadoop平台处理一个任务，看一下这个流程是怎样的。

Hadoop安装包默认提供了以下运行示例，如下操作：

```hadoop
[hadoop@c0a80a5b logs]$yarn jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.4.jar
An example program must be given as the first argument.
Valid program names are:
  aggregatewordcount: An Aggregate based map/reduce program that counts the words in the input files.
  aggregatewordhist: An Aggregate based map/reduce program that computes the histogram of the words in the input files.
  bbp: A map/reduce program that uses Bailey-Borwein-Plouffe to compute exact digits of Pi.
  dbcount: An example job that count the pageview counts from a database.
  distbbp: A map/reduce program that uses a BBP-type formula to compute exact bits of Pi.
  grep: A map/reduce program that counts the matches of a regex in the input.
  join: A job that effects a join over sorted, equally partitioned datasets
  multifilewc: A job that counts words from several files.
  pentomino: A map/reduce tile laying program to find solutions to pentomino problems.
  pi: A map/reduce program that estimates Pi using a quasi-Monte Carlo method.
  randomtextwriter: A map/reduce program that writes 10GB of random textual data per node.
  randomwriter: A map/reduce program that writes 10GB of random data per node.
  secondarysort: An example defining a secondary sort to the reduce.
  sort: A map/reduce program that sorts the data written by the random writer.
  sudoku: A sudoku solver.
  teragen: Generate data for the terasort
  terasort: Run the terasort
  teravalidate: Checking results of terasort
  wordcount: A map/reduce program that counts the words in the input files.
  wordmean: A map/reduce program that counts the average length of the words in the input files.
  wordmedian: A map/reduce program that counts the median length of the words in the input files.
  wordstandarddeviation: A map/reduce program that counts the standard deviation of the length of the words in the input files.
```

找一个比较好理解的wordcount进行测试，还记得刚开始提供一个funcations文件到了HDFS集群中，下面就把funcations这个文件进行单词统计处理，

示例如下：

```bash
[hadoop@c0a80a5b logs]$yarn jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.4.jar wordcount /test/fstab /test/functions /test/wc
18/04/26 20:11:52 INFO client.RMProxy: Connecting to ResourceManager at master/192.168.10.90:8032
18/04/26 20:11:53 INFO input.FileInputFormat: Total input files to process : 2
18/04/26 20:11:53 INFO mapreduce.JobSubmitter: number of splits:2
18/04/26 20:11:54 INFO mapreduce.JobSubmitter: Submitting tokens for job: job_1524741305301_0001
18/04/26 20:11:54 INFO impl.YarnClientImpl: Submitted application application_1524741305301_0001
18/04/26 20:11:54 INFO mapreduce.Job: The url to track the job: http://master:8088/proxy/application_1524741305301_0001/
18/04/26 20:11:54 INFO mapreduce.Job: Running job: job_1524741305301_0001
18/04/26 20:12:04 INFO mapreduce.Job: Job job_1524741305301_0001 running in uber mode : false
18/04/26 20:12:04 INFO mapreduce.Job:  map 0% reduce 0%
18/04/26 20:12:11 INFO mapreduce.Job:  map 50% reduce 0%
18/04/26 20:12:12 INFO mapreduce.Job:  map 100% reduce 0%
18/04/26 20:12:18 INFO mapreduce.Job:  map 100% reduce 100%
18/04/26 20:12:18 INFO mapreduce.Job: Job job_1524741305301_0001 completed successfully
18/04/26 20:12:18 INFO mapreduce.Job: Counters: 49
        File System Counters
                FILE: Number of bytes read=10779
                FILE: Number of bytes written=494063
                FILE: Number of read operations=0
                FILE: Number of large read operations=0
                FILE: Number of write operations=0
                HDFS: Number of bytes read=15880
                HDFS: Number of bytes written=8015
                HDFS: Number of read operations=9
                HDFS: Number of large read operations=0
                HDFS: Number of write operations=2
        Job Counters
                Launched map tasks=2
                Launched reduce tasks=1
                Data-local map tasks=2
                Total time spent by all maps in occupied slots (ms)=8926
                Total time spent by all reduces in occupied slots (ms)=5022
                Total time spent by all map tasks (ms)=8926
                Total time spent by all reduce tasks (ms)=5022
                Total vcore-milliseconds taken by all map tasks=8926
                Total vcore-milliseconds taken by all reduce tasks=5022
                Total megabyte-milliseconds taken by all map tasks=9140224
                Total megabyte-milliseconds taken by all reduce tasks=5142528
        Map-Reduce Framework
                Map input records=666
                Map output records=2210
                Map output bytes=22507
                Map output materialized bytes=10785
                Input split bytes=192
                Combine input records=2210
                Combine output records=692
                Reduce input groups=686
                Reduce shuffle bytes=10785
                Reduce input records=692
                Reduce output records=686
                Spilled Records=1384
                Shuffled Maps =2
                Failed Shuffles=0
                Merged Map outputs=2
                GC time elapsed (ms)=201
                CPU time spent (ms)=2080
                Physical memory (bytes) snapshot=711757824
                Virtual memory (bytes) snapshot=6615576576
                Total committed heap usage (bytes)=492306432
        Shuffle Errors
                BAD_ID=0
                CONNECTION=0
                IO_ERROR=0
                WRONG_LENGTH=0
                WRONG_MAP=0
                WRONG_REDUCE=0
        File Input Format Counters
                Bytes Read=15688
        File Output Format Counters
                Bytes Written=8015
```

把统计结果放到`HDFS`集群的`/test/wc`目录下。

另外，注意当输出目录存在时执行任务会报错。任务运行时，你可以去Hadoop管理平台（8088端口）看一下会有如下类似的输出信息，包括此次应用名称，运行用户、任务名称、应用类型、执行时间、执行状态、以及处理进度。


可以看一下/test/wc目录下有什么：

```bash
[hadoop@c0a80a5b logs]$hdfs dfs -ls /test/wc
Found 2 items
-rw-r--r--   2 hadoop supergroup          0 2018-04-26 20:12 /test/wc/_SUCCESS
-rw-r--r--   2 hadoop supergroup       8015 2018-04-26 20:12 /test/wc/part-r-00000
```

看一下单词统计结果：
