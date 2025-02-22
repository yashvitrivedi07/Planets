class PlanetModal {
  String? position, name, image, velocity, distance, description;

  PlanetModal(
      {this.position,
      this.name,
      this.image,
      this.velocity,
      this.distance,
      this.description});

  factory PlanetModal.toModal(Map m) {
    return PlanetModal(
        description: m['description'],
        distance: m['distance'],
        image: m['image'],
        name: m['name'],
        position: m['position'],
        velocity: m['velocity']);
  }
}
