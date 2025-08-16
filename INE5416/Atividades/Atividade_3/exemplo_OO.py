from abc import ABC, abstractmethod

#Classe abstrata
class Animal(ABC):
    #Construtor
    def __init__(self, name: str, age: int) -> None:
        #Atributos
        self.__name: str = name
        self.__age: int = age
    
    #Metodos

    #metodo abstrato
    @abstractmethod
    def make_sound(self) -> None:
        ...

    #metodo statico
    @staticmethod
    def is_animal() -> bool:
        return True

    @property
    def name(self) -> str:
        return self.__name

    @property
    def age(self) -> int:
        return self.__age

#Herda de animal
class Dog(Animal):
    def __init__(self, name: str, age: int) -> None:
        super().__init__(name, age)

    def make_sound(self) -> None:
        print("%s bark: auau" % self.name)

#Agrega humano
class Cloth:
    def __init__(self, size: str, color: str, type: str) -> None:
        self.__size: str = size
        self.__color: str = color
        self.__type: str = type

    @property
    def size(self) -> str:
        return self.__size

    @property
    def color(self) -> str:
        return self.__color

    @property
    def type(self) -> str:
        return self.__type


#Tambem herado de animal - composto por um pet, e agregado por roupas
class Human(Animal):
    def __init__(self, name: str, age: int, pet: Animal) -> None:
        super().__init__(name, age)
        self.__pet: Animal = pet
        self.__clothes: list[Cloth] = list()

    def make_sound(self) -> None:
        print("%s say: Eu sou humano" % self.name)

    def add_cloth(self, cloth: Cloth) -> None:
        self.__clothes.append(cloth)

    @property
    def pet(self) -> Animal:
        return self.__pet

    @property
    def clothes(self) -> list[Cloth]:
        return self.__clothes

artur = Human("Artur", 19, Dog("Romeu", 5))

#Polimorfismo
artur.pet.make_sound()
artur.make_sound()

artur.add_cloth(Cloth("M", "Black", "T-shirt"))
artur.add_cloth(Cloth("39", "Blue", "Shoes"))
artur.add_cloth(Cloth("40", "Brown", "Pants"))

for cloth in artur.clothes:
    print("-> %s: size: %s; color: %s" % (cloth.type, cloth.size, cloth.color))

print("%s e um animal" % artur.name if (artur.is_animal) else "%s nao eh um animal" % artur.name)


