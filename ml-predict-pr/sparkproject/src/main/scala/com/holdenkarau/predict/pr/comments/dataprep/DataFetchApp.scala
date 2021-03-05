package com.holdenkarau.predict.pr.comments.sparkProject.dataprep

import org.apache.spark.{SparkConf, SparkContext}

/**
  * Use this to fetch the PR diffs from github
  * sbt "run inputFile outputFile cachedData"
  *  (+ select DataFetch when prompted)
  */
object DataFetchApp extends App{
  val (inputFile, outputFile, cachedFile) = (args(0), args(1), args(2))
  val conf = new SparkConf()
    .setMaster("local")

  MyRunner.run(conf, inputFile, outputFile, cachedFile)
}

/**
  * Use this when submitting the app to a cluster with spark-submit
  * */
object DataFetchSCApp extends App{
  val (inputFile, outputFile, cachedFile) = (args(0), args(1), args(2))

  // spark-submit command should supply all necessary config elements
  MyRunner.run(new SparkConf(), inputFile, outputFile, cachedFile)
}

private object MyRunner {
  def run(conf: SparkConf, inputFile: String, outputFile: String,
    cachedFile: String): Unit = {

    val sc = new SparkContext(conf)
    val dataFetch = new DataFetch(sc)
    dataFetch.fetch(inputFile, outputFile, Some(cachedFile))
  }
}
