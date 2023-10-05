/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }



class Golosinas{
	var property peso
	
}

class Bombon inherits Golosinas {
	
	
	method precio() { return 5 }
    override method peso() { return 15}
	method mordisco() { peso = peso * 0.8 - 1 }
	method sabor() { return frutilla }
	method libreGluten() { return true }
}

class BombonDuro inherits Bombon{
	
    override method mordisco(){ peso = peso -1}
    method gradoDeDureza(){
    	return if (peso < 12){
    		3
    	}else if (peso > 8 and peso<12){
    		2
    	}else if (peso<8){
    		1
    	}
    }
}
/*
 * var bombon = new Bombon() 
 * bombon.mordisco()  = clase Bombon
 * bombon.peso()      = clase Bombon
 * bombon = new BombonDuro()
 * bombon.mordisco()  = clase BombonDuro
 * bombon.peso()      = clase Bombon
 * 
 * 
 */

class Alfajor inherits Golosinas{
	
	method precio() { return 12 }
	override method peso() { return 15 }
	method mordisco() { peso = peso * 0.8 }
	method sabor() { return chocolate }
	method libreGluten() { return false }
}

class Caramelo inherits Golosinas{
	var property sabor 

	method precio() { return 12 }
	override method peso() { return 5 }
	method mordisco() { peso = peso - 1 }
	method libreGluten() { return true }
}

class CarameloConCorazonDeChocolate inherits Caramelo{
	
	override method mordisco() {
		peso = peso -1
		self.sabor(chocolate)
	}
	override method precio(){
		return super() + 1
	}
}
/*
 * var caramelo = new Caramelo() 
 *caramelo.mordisco() = clase Caramelo
 *caramelo.peso()     = clase Caramelo
 *caramelo.sabor()    = clase Caramelo
 *caramelo = new CarameloRelleno() 
 *caramelo.mordisco() = clase CarameloConCorazonDeChocolate
 *caramelo.peso()     = clase Caramelo
 *caramelo.sabor()    = clase Caramelo
 */


class Chupetin inherits Golosinas{
	
	method precio() { return 2 }
	override method peso() { return 7 }
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	method sabor() { return naranja }
	method libreGluten() { return true }
}

class Oblea inherits Golosinas{
	
	method precio() { return 5 }
	override method peso() { return 250 }
	method mordisco() {                            // pongo return para que pueda ser pisado por otro metodo
		return if (peso >= 70) {                   // de la subclase
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
	method sabor() { return vainilla }
	method libreGluten() { return false }
}

class ObleaCrujiente inherits Oblea{
		
	override method mordisco(){
		var contador = 0 
		const pesoDeMordisco= if (peso >= 70){peso = peso * 0.5 contador = 1}else {peso = peso - (peso * 0.25) contador = 1}
		return if (contador < 3){pesoDeMordisco-1}else{pesoDeMordisco} 
	}
	method estaDebil(){
		return (self.mordisco() == 3)
	}
}

/*
 * var oblea = new Oblea() 
 *oblea.mordisco() = clase Oblea
 *oblea.peso()     = clase Oblea
 *oblea = new ObleaCrujiente() 
 *oblea.mordisco() = clase ObleaCrujiente
 *oblea.peso()     = clase Oblea
 */
 
 
class Chocolatin inherits Golosinas {
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0
	
	method pesoInicial(unPeso) { pesoInicial = unPeso }
	method precio() { return pesoInicial * 0.50 }
	override method peso() { return (pesoInicial - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	method sabor() { return chocolate }
	method libreGluten() { return false }

}

class ChocolatinVip inherits Chocolatin{
	var humedad
	
	method humedad(valor){
		return valor == 0.max(1)
	}
	method humedad() = humedad 
	
	override method peso() = super()*1 + humedad
}



class ChocolatinPremiun inherits ChocolatinVip{
	
	
	override method humedad() = super().div(2)
}

/*var chocolatin = new Chocolatin() 
*chocolatin.peso()   = clase Chocolatin
*chocolatin = new ChocolatinVIP() 
*chocolatin.peso()   = clase Chocolatin
*chocolatin = new ChocolatinPremium() 
*chocolatin.peso()   = clase Chocolatin
* 
*/

class GolosinaBaniada inherits Golosinas{
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	override method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti inherits Golosinas{
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	

	method precio() { return (if(self.libreGluten()) 7 else 10) }
	override method peso() { return 5 }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}

