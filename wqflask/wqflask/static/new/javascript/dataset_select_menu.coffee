# 
#*  function: based on different browser use, will have different initial actions; 
#*  Once the index.html page is loaded, this function will be called
#
initialDatasetSelection = ->
  defaultSpecies = getDefaultValue("species")
  defaultSet = getDefaultValue("cross")
  defaultType = getDefaultValue("tissue")
  defaultDB = getDefaultValue("database")
  if navigator.userAgent.indexOf("MSIE") >= 0
    sOptions = fillOptionsForIE(null, defaultSpecies)
    menu0 = "<SELECT NAME='species' ID='species' SIZE='1' onChange='fillOptions(\"species\");'>" + sOptions + "</Select>"
    document.getElementById("menu0").innerHTML = menu0
    gOptions = fillOptionsForIE("species", defaultSet)
    menu1 = "<Select NAME='cross' size=1 id='cross' onchange='fillOptions(\"cross\");'>" + gOptions + "</Select><input type=\"button\" class=\"button\" value=\"Info\" onCLick=\"javascript:crossinfo();\">"
    document.getElementById("menu1").innerHTML = menu1
    tOptions = fillOptionsForIE("cross", defaultType)
    menu2 = "<Select NAME='tissue' size=1 id='tissue' onchange='fillOptions(\"tissue\");'>" + tOptions + "</Select>"
    document.getElementById("menu2").innerHTML = menu2
    dOptions = fillOptionsForIE("tissue", defaultDB)
    menu3 = "<Select NAME='database' size=1 id='database'>" + dOptions + "</Select><input type=\"button\" class=\"button\" value=\"Info\" onCLick=\"javascript:databaseinfo();\">"
    document.getElementById("menu3").innerHTML = menu3
  else
    fillOptions null
  searchtip()

# 
#*  input: selectObjId (designated select menu, such as species, cross, etc... )
#*  defaultValue (default Value of species, cross,tissue or database)
#*  function: special for IE browser,setting options value for select menu dynamically based on linkage array(lArr), 
#*  output: options string
#
fillOptionsForIE = (selectObjId, defaultValue) ->
  options = ""
  unless selectObjId?
    len = sArr.length
    i = 1

    while i < len
      
      # setting Species' option			
      if sArr[i].val is defaultValue
        options = options + "<option selected=\"selected\" value='" + sArr[i].val + "'>" + sArr[i].txt + "</option>"
      else
        options = options + "<option value='" + sArr[i].val + "'>" + sArr[i].txt + "</option>"
      i++
  else if selectObjId is "species"
    speciesObj = document.getElementById("species")
    len = lArr.length
    arr = []
    idx = 0
    i = 1

    while i < len
      
      #get group(cross) info from lArr
      arr[idx++] = lArr[i][1]  if lArr[i][0] is (getIndexByValue("species", speciesObj.value)).toString() and not Contains(arr, lArr[i][1])
      i++
    idx = 0
    len = arr.length
    removeOptions "cross"
    i = 0

    while i < len
      
      # setting Group's option
      if gArr[arr[i]].val is defaultValue
        options = options + "<option selected=\"selected\" value='" + gArr[arr[i]].val + "'>" + gArr[arr[i]].txt + "</option>"
      else
        options = options + "<option value='" + gArr[arr[i]].val + "'>" + gArr[arr[i]].txt + "</option>"
      i++
  else if selectObjId is "cross"
    speciesObj = document.getElementById("species")
    groupObj = document.getElementById("cross")
    len = lArr.length
    arr = []
    idx = 0
    i = 1

    while i < len
      
      #get type(tissue) info from lArr
      arr[idx++] = lArr[i][2]  if lArr[i][0] is (getIndexByValue("species", speciesObj.value)).toString() and lArr[i][1] is (getIndexByValue("cross", groupObj.value)).toString() and not Contains(arr, lArr[i][2])
      i++
    idx = 0
    len = arr.length
    removeOptions "tissue"
    i = 0

    while i < len
      
      # setting Type's option
      if tArr[arr[i]].val is defaultValue
        options = options + "<option selected=\"selected\" value='" + tArr[arr[i]].val + "'>" + tArr[arr[i]].txt + "</option>"
      else
        options = options + "<option value='" + tArr[arr[i]].val + "'>" + tArr[arr[i]].txt + "</option>"
      i++
  else if selectObjId is "tissue"
    speciesObj = document.getElementById("species")
    groupObj = document.getElementById("cross")
    typeObj = document.getElementById("tissue")
    len = lArr.length
    arr = []
    idx = 0
    i = 1

    while i < len
      
      #get dataset(database) info from lArr
      arr[idx++] = lArr[i][3]  if lArr[i][0] is (getIndexByValue("species", speciesObj.value)).toString() and lArr[i][1] is (getIndexByValue("cross", groupObj.value)).toString() and lArr[i][2] is (getIndexByValue("tissue", typeObj.value)).toString() and not Contains(arr, lArr[i][3])
      i++
    idx = 0
    len = arr.length
    removeOptions "database"
    i = 0

    while i < len
      
      # setting Database's option			
      if dArr[arr[i]].val is defaultValue
        options = options + "<option SELECTED value='" + dArr[arr[i]].val + "'>" + dArr[arr[i]].txt + "</option>"
      else
        options = options + "<option value='" + dArr[arr[i]].val + "'>" + dArr[arr[i]].txt + "</option>"
      i++
  options

# 
#*  input: selectObjId (designated select menu, such as species, cross, etc... )
#*  function: setting options value for select menu dynamically based on linkage array(lArr)
#*  output: null
#
fillOptions = (selectObjId) ->
  unless selectObjId?
    speciesObj = document.getElementById("species")
    len = sArr.length
    i = 1

    while i < len
      
      # setting Species' option
      speciesObj.options[i - 1] = new Option(sArr[i].txt, sArr[i].val)
      i++
    updateChocie "species"
  else if selectObjId is "species"
    speciesObj = document.getElementById("species")
    groupObj = document.getElementById("cross")
    len = lArr.length
    arr = []
    idx = 0
    i = 1

    while i < len
      
      #get group(cross) info from lArr
      arr[idx++] = lArr[i][1]  if lArr[i][0] is (getIndexByValue("species", speciesObj.value)).toString() and not Contains(arr, lArr[i][1])
      i++
    idx = 0
    len = arr.length
    removeOptions "cross"
    i = 0

    while i < len
      
      # setting Group's option
      groupObj.options[idx++] = new Option(gArr[arr[i]].txt, gArr[arr[i]].val)
      i++
    updateChocie "cross"
  else if selectObjId is "cross"
    speciesObj = document.getElementById("species")
    groupObj = document.getElementById("cross")
    typeObj = document.getElementById("tissue")
    len = lArr.length
    arr = []
    idx = 0
    i = 1

    while i < len
      
      #get type(tissue) info from lArr
      arr[idx++] = lArr[i][2]  if lArr[i][0] is (getIndexByValue("species", speciesObj.value)).toString() and lArr[i][1] is (getIndexByValue("cross", groupObj.value)).toString() and not Contains(arr, lArr[i][2])
      i++
    idx = 0
    len = arr.length
    removeOptions "tissue"
    i = 0

    while i < len
      
      # setting Type's option
      typeObj.options[idx++] = new Option(tArr[arr[i]].txt, tArr[arr[i]].val)
      i++
    updateChocie "tissue"
  else if selectObjId is "tissue"
    speciesObj = document.getElementById("species")
    groupObj = document.getElementById("cross")
    typeObj = document.getElementById("tissue")
    databaseObj = document.getElementById("database")
    len = lArr.length
    arr = []
    idx = 0
    i = 1

    while i < len
      
      #get dataset(database) info from lArr
      arr[idx++] = lArr[i][3]  if lArr[i][0] is (getIndexByValue("species", speciesObj.value)).toString() and lArr[i][1] is (getIndexByValue("cross", groupObj.value)).toString() and lArr[i][2] is (getIndexByValue("tissue", typeObj.value)).toString() and not Contains(arr, lArr[i][3])
      i++
    idx = 0
    len = arr.length
    removeOptions "database"
    i = 0

    while i < len
      
      # setting Database's option
      databaseObj.options[idx++] = new Option(dArr[arr[i]].txt, dArr[arr[i]].val)
      i++
    updateChocie "database"

# 
#*  input: arr (targeted array); obj (targeted value)
#*  function: check whether targeted array contains targeted value or not
#*  output: return true, if array contains targeted value, otherwise return false
#
Contains = (arr, obj) ->
  i = arr.length
  return true  if arr[i] is obj  while i--
  false

# 
#* input: selectObj (designated select menu, such as species, cross, etc... )
#* function: clear designated select menu's option
#* output: null
#
removeOptions = (selectObj) ->
  selectObj = document.getElementById(selectObj)  unless typeof selectObj is "object"
  len = selectObj.options.length
  i = 0

  while i < len
    
    # clear current selection       
    selectObj.options[0] = null
    i++

# 
#*  input: selectObjId (designated select menu, such as species, cross, etc... )
#*         Value: target value
#*  function: retrieve Index info of target value in designated array
#*  output: index info
#
getIndexByValue = (selectObjId, val) ->
  if selectObjId is "species"
    i = 1

    while i < sArr.length
      return i  if sArr[i].val is val
      i++
  else if selectObjId is "cross"
    i = 1

    while i < gArr.length
      return i  if gArr[i].val is val
      i++
  else if selectObjId is "tissue"
    i = 1

    while i < tArr.length
      return i  if tArr[i].val is val
      i++
  else
    return

# 
#*  input: objId (designated select menu, such as species, cross, etc... )
#*  		  val(targeted value)
#*  function: setting option's selected status for designated select menu based on target value, also update the following select menu in the main search page 
#*  output: return true if selected status has been set, otherwise return false.
#
setChoice = (objId, val) ->
  Obj = document.getElementById(objId)
  idx = -1
  i = 0
  while i < Obj.options.length
    if Obj.options[i].value is val
      idx = i
      break
    i++
  if idx >= 0
    
    #setting option's selected status 
    Obj.options[idx].selected = true
    
    #update the following select menu 
    fillOptions objId
  else
    Obj.options[0].selected = true
    fillOptions objId

# setting option's selected status based on default setting or cookie setting for Species, Group, Type and Database select menu in the main search page http://www.genenetwork.org/
updateChocie = (selectObjId) ->
  if selectObjId is "species"
    defaultSpecies = getDefaultValue("species")
    
    #setting option's selected status
    setChoice "species", defaultSpecies
  else if selectObjId is "cross"
    defaultSet = getDefaultValue("cross")
    
    #setting option's selected status
    setChoice "cross", defaultSet
  else if selectObjId is "tissue"
    defaultType = getDefaultValue("tissue")
    
    #setting option's selected status
    setChoice "tissue", defaultType
  else if selectObjId is "database"
    defaultDB = getDefaultValue("database")
    
    #setting option's selected status
    setChoice "database", defaultDB

#get default value;if cookie exists, then use cookie value, otherwise use default value
getDefaultValue = (selectObjId) ->
  
  #define default value
  defaultSpecies = "mouse"
  defaultSet = "BXD"
  defaultType = "Hippocampus"
  defaultDB = "HC_M2_0606_P"
  if selectObjId is "species"
    
    #if cookie exists, then use cookie value, otherwise use default value
    cookieSpecies = getCookie("defaultSpecies")
    defaultSpecies = cookieSpecies  if cookieSpecies
    defaultSpecies
  else if selectObjId is "cross"
    cookieSet = getCookie("defaultSet")
    defaultSet = cookieSet  if cookieSet
    defaultSet
  else if selectObjId is "tissue"
    cookieType = getCookie("defaultType")
    defaultType = cookieType  if cookieType
    defaultType
  else if selectObjId is "database"
    cookieDB = getCookie("defaultDB")
    defaultDB = cookieDB  if cookieDB
    defaultDB

#setting default value into cookies for the dropdown menus: Species,Group, Type, and Database 
setDefault = (thisform) ->
  setCookie "cookieTest", "cookieTest", 1
  cookieTest = getCookie("cookieTest")
  delCookie "cookieTest"
  if cookieTest
    defaultSpecies = thisform.species.value
    setCookie "defaultSpecies", defaultSpecies, 10
    defaultSet = thisform.cross.value
    setCookie "defaultSet", defaultSet, 10
    defaultType = thisform.tissue.value
    setCookie "defaultType", defaultType, 10
    defaultDB = thisform.database.value
    setCookie "defaultDB", defaultDB, 10
    updateChocie "species"
    updateChocie "cross"
    updateChocie "tissue"
    updateChocie "database"
    alert "The current settings are now your default"
  else
    alert "You need to enable Cookies in your browser."