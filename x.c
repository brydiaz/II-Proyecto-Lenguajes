typedef struct nodo{ //snodo es el nombre de la estructura
    int valor;
    struct nodo *sig; //El puntero siguiente para recorrer la lista enlazada
}tnodo; //tnodo es el tipo de dato para declarar la estructura
 

 void insertarEnLista (tpuntero *cabeza, int e){
    tpuntero nuevo; //Creamos un nuevo nodo
    nuevo = malloc(sizeof(tnodo)); //Utilizamos malloc para reservar memoria para ese nodo
    nuevo->valor = e; //Le asignamos el valor ingresado por pantalla a ese nodo
    nuevo->sig = *cabeza; //Le asignamos al siguiente el valor de cabeza
    *cabeza = nuevo; //Cabeza pasa a ser el ultimo nodo agregado
}

void imprimirLista(tpuntero cabeza){
    while(cabeza != NULL){ //Mientras cabeza no sea NULL
        printf("%4d",cabeza->valor); //Imprimimos el valor del nodo
        cabeza = cabeza->sig; //Pasamos al siguiente nodo
    }
}
 
 typedef tnodo *tpuntero;

 int main(){
     tpuntero cabeza;
     cabeza = NULL;
     insertarEnLista(&cabeza, 1);
     insertarEnLista(&cabeza, 2);
     insertarEnLista(&cabeza, 3);
     insertarEnLista(&cabeza, 4);
     insertarEnLista(&cabeza, 5);
     insertarEnLista(&cabeza, 6);
     insertarEnLista(&cabeza, 7);
     insertarEnLista(&cabeza, 8);
     insertarEnLista(&cabeza, 9);
     insertarEnLista(&cabeza, 10);
     imprimirLista(cabeza);

 }