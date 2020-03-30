class Person {
  var name = "";
  var children = List<Person>();

  Person(String name, {List<Person> children}) {
    this.children = children ?? [];
    this.name = name;
  }
}

dummyFamily() {
  var p1 = Person("Person 1");
  var c1 = Person("Person 2");
  var c2 = Person("Person 3");
  var c3 = Person("Person 4");
  var c4 = Person("Person 5");

  p1.children = [c1, c2, c3, c4];

  c1.children = [
    Person("Person 6", children: [
      Person("Person 18"),
      Person("Person 19"),
      Person("Person 20")
    ]),
    Person("Person 7"),
    Person("Person 8"),
    Person("Person 9")
  ];
  c2.children = [
    Person("Person 10", children: [Person("Person 21"), Person("Person 22")]),
    Person("Person 11", children: [Person("Person 23"), Person("Person 24")]),
    Person("Person 12"),
  ];
  c3.children = [
    Person("Person 13", children: [Person("Person 25"), Person("Person 26")]),
    Person("Person 14"),
    Person("Person 15"),
  ];
  c4.children = [
    Person("Person 16"),
    Person("Person 17"),
  ];

  return p1;
}
