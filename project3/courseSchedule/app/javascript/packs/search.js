
//https://stackoverflow.com/questions/7524585/how-do-i-get-the-information-from-a-meta-tag-with-javascript
//Returns the content of meta information
function getMeta(metaName) {
  const metas = document.getElementsByTagName('meta');

  for (let i = 0; i < metas.length; i++) {
    if (metas[i].getAttribute('name') === metaName) {
      return metas[i].getAttribute('content');
    }
  }

  return '';
}

function listenForEnter(){
    var search = document.getElementById("searchForm");
    search.addEventListener("keyup", function(event) {
        if(event.keyCode === 13){
            event.preventDefault();
            console.log(getMeta("baseURL"));
            console.log("Value:" + search.value);
            window.location.replace("/search/?class_name=" + encodeURIComponent(search.value))
        }
    })
}

var checkExist = setInterval(function() {
    if (document.getElementById("searchForm")) {
        listenForEnter();
        clearInterval(checkExist);
    }
}, 100);


/*

var container = document.getElementById("main-container");


//Given a section returns a string of html
function getSectionString(classSection){
    return `<div class="col"></div>
    <div class="col-11 section-container">
        <h4>${sectionNumber}</h4>
        </br>
        <p>${semester} ${startDate} - ${endDate}</p>
        </br></br>
        <p>${buildingName} ${roomNumber}</p>
        </br>
        <div class="peopleContainer">
            <p>Graders: ${graderNames}</p>
        <p>Instructor: ${instructorName}</p>
        </div>
    </div>`;
}

//Given an array of class sections returns a string of html
function getAllSections(classSections){
    var printable = "";
    classSections.forEach(element => printable = printable.concat(addSectionString(element)));
}

//Given a class, returns a string of html to print it
function addClassString(classData) {
    return `<div class="row">
        <div class="col-12">
            <h3>${classID}&nbsp;</h3>
                <p class="font-italic">${className}</p>
            </div>
            <div class="col-12">
                <p>${classDescription}</p>
            </div>
            ${getSectionStrings()}
        </div>
    </div>`;
}

//Removes any classes/sections added to the document
function clear(){
    var children = tableFields.children;
    for (var i = children.length - 1; i > 0; i--) { //Leave out 0 for searchbar
        children[i].remove();
    }
}

//Given data from the server, prints it to the page
function display(data) {
    clear();
    var printable = "";
    data.forEach(element => printable = printable.concat(addClassString(element)));
}

//Requests all the server's class/section data
function requestAllData() {
    
}

display(requestAllData())


*/
