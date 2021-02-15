$text = ""
$i = 0
$splitByNum = 200
While ($i -le ($text.length-$splitByNum)){
  if ($i -eq 0){
    write-host ('theString = "' +$text.Substring($i,$splitByNum) + '"')
  }else{
    write-host ('theString = theString + "' +$text.Substring($i,$splitByNum) + '"')
  }
  $i += $splitByNum
}
write-host ('theString = theString + "' +$text.Substring($i) + '"')
