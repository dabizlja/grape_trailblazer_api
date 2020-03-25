const Person = function(id) {
  this.id = id;
  this.talk = () => new Promise(resolve => setTimeout(() => (console.log('Done'), resolve()), 3000))
};

(async () => {
  for(const person of [...[...Array(10).keys()].map(i => new Person(++i))]) (console.log(`Talk Person ${person.id}`), await person.talk())
})();