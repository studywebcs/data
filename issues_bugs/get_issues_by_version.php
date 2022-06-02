<?php

$app="phpmyadmin";
$app="dokuwiki";
$app="opencart";
$app="phpbb";

$app="phppgadmin";
$app="mediawiki";
$app="prestashop";
$app="vanilla";

$app="dolibarr";
$app="roundcubemail";
$app="openemr";
$app="kanboard";

$dbtable="phpmyadmin";
$dbtable="splitbrain_dokuwiki";
$dbtable="opencart_opencart";
$dbtable="phpbb_issues";

$dbtable="phppgadmin_phppgadmin";
$dbtable="wikimedia_mediawiki";
$dbtable="prestashop_prestashop";
$dbtable="vanilla_vanilla";

$dbtable="dolibarr_dolibarr";
$dbtable="roundcube_roundcubemail";
$dbtable="openemr_openemr";
$dbtable="kanboard_kanboard";



$dbg= new mysqli('localhost', 'root', '', 'gitusersdb');
$db= new mysqli('localhost', 'root', '', 'issuesdb');

//-------------------------------
print "$app\n";


$sql="select * from ". $app ."_version order by id";
$result= $dbg->query($sql);

$nrrows=$result->num_rows;

for  ($i=0; $i< $nrrows; $i++){
    $table[$i] =  $result->fetch_assoc();
}


$csv="id;version1;version2;date1;date2;count\r\n";

for  ($i=1; $i< $nrrows; $i++){



    $id=$table[$i]['id'];
    $version=$table[$i]['version'];
    $version2=$version;
    $version1=$table[$i-1]['version'];
    $date2=$table[$i]['date'];
    $date1=$table[$i-1]['date'];

    $sql="select count(title) as count from ". $dbtable ." where created > '$date1' and created <= '$date2' ";
    //print $sql . "\n";
    $result= $db->query($sql);
    $linec =  $result->fetch_assoc(); 
    $count= $linec['count'];  

    print "$id $version1 a $version2 - $date1 $date2 - $count";

    $csv.="$id;$version1;$version2;$date1;$date2;$count\r\n";


    print "\r\n------------------------\r\n";

}


file_put_contents("data/" . $app . "_issues_by_version.csv", $csv);


















