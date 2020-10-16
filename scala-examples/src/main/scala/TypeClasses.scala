object TypeClasses {

  // data
  case class Person(name: String, age: Int)

  // type class definition
  trait Show[T] {
    def show(t: T): String
  }
  object Show {
    // when you want to use it like: Show[T].show(t)
    def apply[T: Show]: Show[T] = implicitly[Show[T]]

    // you repeat method signature in object
    // but in user code you get syntax like in haskell: show(t)
    def show[T: Show](t: T): String = implicitly[Show[T]].show(t)

    // yet another way to invoke: t.show
    implicit class ShowEx[T: Show](t: T) {
      // note: you repeat method signature again
      def show: String = implicitly[Show[T]].show(t)
    }
  }

  // instance of type class
  implicit object ShowPerson extends Show[Person] {
    override def show(person: Person): String = s"Person[name='${person.name}', age='${person.age}']"
  }


  // -- Usage --

  // using implicitly
  def logList1[T: Show](list: List[T]): List[String] = {
    list.map { t => implicitly[Show[T]].show(t) }
  }

  // using apply() from object
  def logList2[T: Show](list: List[T]): List[String] = {
    list.map { t => Show[T].show(t) }
  }

  // using method from object
  import Show._
  def logList3[T: Show](list: List[T]): List[String] = {
    list.map { t => show(t) }
  }

  // using method from implicit class
  def logList3[T: Show](list: List[T]): List[String] = {
    list.map { t => t.show }
  }

  // using method from implicit class, de sugaring version
  def logList3DeSugaringVersion[T: Show](list: List[T]): List[String] = {
    list.map { t =>
      val showExtension = new ShowEx[T](t)
      showExtension.show
    }
  }






}
