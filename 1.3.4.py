class CourbeElliptique:
    def __init__(self, a, b):
        self.a = a
        self.b = b
        if 4*a**3+27*b**2 == 0 :
            raise ValueError('({}, {}) n\'est pas une courbe valide'.format(a, b))
        else :
            print("Nouvelle courbe elliptique :\n y^2 = x^3 +",self.a,"x +",self.b)
           
    def __eq__(self, B):
        if self.a == B.a and self.b == B.b :
            print("Les courbes sont les mêmes")
        else :
            print("Les courbes sont différentes")


    def testPoint(self, x, y):
            if y**2 == x**3 + self.a * x + self.b :
                print("Ce point appartient à la courbe")
            else :
                print("Ce point n'appartient PAS à la courbe")


