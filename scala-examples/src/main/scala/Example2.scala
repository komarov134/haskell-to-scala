object Example2 {
  trait HasString[A] { 
    def someString(a: A): String 
  } 
   
  object HasString { 
    def apply[A](implicit ev: HasString[A]): HasString[A] = ev 
     
    implicit val exampleHasString: HasString[Example] = new HasString[Example] { 
      def someString(e: Example): String = e.value 
    } 
   
    implicit val anotherExampleHasString: HasString[AnotherExample] = new HasString[AnotherExample
] { 
        def someString(e: AnotherExample): String = e.value 
    } 
  } 
   
  trait Test[A] { 
    val hasStringInstance: HasString[A] 
    def someInt: Int 
  } 
   
  object Test { 
    def apply[A](implicit ev: Test[A]): Test[A] = ev 
   
    implicit val exampleTest: Test[Example] = new Test[Example] { 
      val hasStringInstance: HasString[Example] = HasString[Example] 
      def someInt: Int = 1 
    } 
   
    implicit val anotherExampleTest: Test[AnotherExample] = new Test[AnotherExample] { 
        val hasStringInstance: HasString[AnotherExample] = HasString[AnotherExample] 
        def someInt: Int = 1 
    } 
  } 
}
