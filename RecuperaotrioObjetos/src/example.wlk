class Desayuno {
	var property gasto = 0
	var property valor
	var property especial
	var property esNatural
	
	method natural() = if (esNatural) 120 else 0
	
	method valoracion(){}
	
	method esEspecial(){}
	
	method precio(){
		gasto = ((30 * valor) + self.natural())
	}
}

class Macarron inherits Desayuno {
	var property peso
	var property cobertura
	
	override method esNatural() = !cobertura
	
	
	override method esEspecial() {
		especial = (peso > 50 && cobertura)
	}
	
	override method valoracion(){
		valor = (if (especial) 120 else 80)
	}
}


class Alfajor inherits Desayuno{
	var peso
	var property relleno
	var property pesoTapa = 5
	
	override method esNatural() = relleno.esNatural()
	
	
	override method esEspecial() {
		especial = (relleno.peso() > 50)
	}
	
	override method valoracion(){
		valor = (peso / 10)
	}
	method peso(){
		return (relleno.peso() + pesoTapa*2)
	}
}

class AlfajorTriple inherits Desayuno{
	var property peso
	var property relleno1
	var property relleno2
	var property pesoTapa = 5
	
	override method esNatural() = (relleno1.esNatural() && relleno2.esNatural()) 
	
	override method esEspecial() {
		especial = (peso > 100)
	}
	
	override method valoracion(){
		valor = (peso / 10)
	}
	
	method peso(){
		return (relleno1.peso() + relleno2.peso() + pesoTapa*3)
	}
}

object dulceDeLeche{
	var property peso = 30
	
	method esNatural() = false
}

object groseilles{
	var property peso = 25
	
	method esNatural() = false
}

object miel{
	var property peso = 20
	
	method esNatural() = true
}

class PorcionesDeTorta inherits Desayuno{
	var peso 
	
	override method esNatural() = true
	
	override method esEspecial() {
		especial = (peso > 50)
	}
	
	override method valoracion(){
		valor = 100
	}
}

class MesaDulce inherits Desayuno{
	var property dulces = []
	
	
	override method esNatural() = dulces.all({d=>d.esNatural()})
	
	
	override method esEspecial() {
		especial = ((self.peso() > 50) && (dulces.size() < 2))
	}
	
	override method valoracion(){
		valor = dulces.max({m=>m.valoracion()})
	}
	method agregarDulce(){
		dulces.add()
	}
	method peso(){
		return dulces.sum({p=>p.peso()})
	}
}

class Cliente{
	var property credito = 1000
	var property tipo
	var property comproAlgo = false
	
	
	method puedeComprar(){
		patisserie.menu().filter({x=>(tipo.leGusta(x)&& x.precio() <= self.credito())})
	}
	
	method decideComprar(){
		patisserie.menu().head()
	}
	
}

object naturista{
	method leGusta(dulce) = dulce.esNatural()
}

object chefPadawan{
	method leGusta(dulce) = (dulce.esEspecial() or dulce.valoracion() > 100)
}

object todoVale{
	method leGusta(dulce){}
}

object patisserie{
	var property clientes = []
	var property menu = []
	
	method promocion() {
		clientes.all({c=>(c.credito()+700)})
	}
}

