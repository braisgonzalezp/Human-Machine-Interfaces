const open = document.getElementById('open');
const submit = document.getElementById('boton')
const modal_container = document.getElementById('modal_container');

open.addEventListener('click', () =>{
    modal_container.classList.add('show');
})

submit.addEventListener('click', captura);

function captura  (){

    //Capturamos la información del formulario
    let nombreR=document.getElementById("field1").value;
    let fechaV=document.getElementById("start").value;
    let numP=document.getElementById("personas").value;
    let momentoV=document.getElementById("field2").value;
    let listaP=document.getElementById("listaP").value;

    let comprobar = validaCaracter(nombreR);

    //Comprobamos que metan todos los valores
    if (nombreR!=="" && numP!=="" && momentoV!=="" && comprobar){
        //verificamos nombre propio
        var li=document.createElement('li');
        li.id=listaP;
        li.innerHTML+= foto(momentoV) + "Reserva de " + nombreR + " para " + numP + " persona/s " + (fechaV) ;
        document.getElementById("listaP").appendChild(li);
        resetForm();
        modal_container.classList.remove('show');
    }
    if(nombreR!=="" && numP!=="" && momentoV!=="" && !comprobar){
        resetForm();
    }

}

function foto(momento){
    if(momento === '0'){
        return "<img src=\"/assets/mañana.png\" width=\"50\" height=\"50\" alt=\"foto\">";
    } else if (momento === '1'){
        return "<img src=\"/assets/tarde.png\" width=\"50\" height=\"50\" alt=\"foto\">";
    } else {
        return "<img src=\"/assets/noche.png\" width=\"60\" height=\"60\" alt=\"foto\">";
    }
}

function resetForm() {
    document.getElementById("field1").value = "";
    document.getElementById("start").value = "";
    document.getElementById("personas").value = "";
    document.getElementById("field2").value = "";
}

function validaCaracter(pEvent){
    var regex = /^[a-zA-Z ]+$/;
    if (regex.test(pEvent)){
        return true;
    } else {
      return false;
    }
}



















