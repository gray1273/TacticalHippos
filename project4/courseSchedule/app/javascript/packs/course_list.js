function disappear(){
    
}

var buttons = document.getElementsByClassName("disappear")

for (button in buttons) {
    button.addEventListener("click", function(){
        button.style.display = 'none';
        
    })
}
