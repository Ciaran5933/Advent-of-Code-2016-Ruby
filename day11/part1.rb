require 'set'

def valid_floor(generators, microchips)
  generators.none? || (microchips - generators).none?
end

class Building
  attr_accessor :generators, :microchips, :elevator, :steps, :to_store

  def initialize(generators, microchips, elevator, steps)
    @generators = generators
    @microchips = microchips
    @elevator = elevator
    @steps = steps
  end

  def to_store
    store = {}

    (0..3).each do |i|
      generators[i].each { |g| store[g] ? store[g][0] = i : store[g] = [i, nil]}
      microchips[i].each { |m| store[m] ? store[m][1] = i : store[m] = [nil, i]}
    end

    return [elevator, store.values.map(&:join).sort]
  end

  def to_s
    (0..3).map do |i|
      "Level: #{i} #{'E' if i == elevator} Generators: #{generators[i].sort.join(', ')}, Microchips: #{microchips[i].sort.join(', ')}"
    end
  end

  def finished?
    generators[0..2].map(&:none?).all? && microchips[0..2].map(&:none?).all?
  end

  def valid?
    4.times.all? { |level| valid_floor(level) }
  end

  def valid_floor(level)
    generators[level].none? || (microchips[level] - generators[level]).none?
  end

  def next_buildings
    next_buildings = combinations.map do |combo|
      neigbouring_floors.map do |floor|
        gens = generators.map(&:clone)
        micros = microchips.map(&:clone)

        gens[elevator] -= combo[:gens]
        micros[elevator] -= combo[:micros]

        gens[floor] += combo[:gens]
        micros[floor] += combo[:micros]

        Building.new(gens, micros, floor, steps + 1)
      end
    end

    next_buildings.flatten.flatten.keep_if(&:valid?)
  end

  private

  def neigbouring_floors
    case elevator
    when 0
      [1]
    when 3
      [2]
    else
      [elevator+1, elevator-1]
    end
  end

  def combinations
    combos = []

    (1..2).each do |i|
      combos += generators[elevator].combination(i).map { |gens| { micros: [], gens: gens } }
      combos += microchips[elevator].combination(i).map { |micros| { micros: micros, gens: [] } }
    end

    combos += microchips[elevator]
                .product(generators[elevator])
                .reject { |micro, gen| micro != gen }
                .map { |micro, gen| { micros: [micro], gens: [gen] }}
    combos
  end
end

input = IO.readlines('input.txt')

generators = []
microchips = []

input.each do |line|
  generators << line.scan(/\w* generator/).map { |a| a.match(/\w*/)[0] }
  microchips << line.scan(/\w*-compatible microchip/).map { |a| a.match(/\w*/)[0] }
end

initial_building = Building.new(generators, microchips, 0, 0)

queue = []
queue << initial_building

states = Set.new
states << initial_building.to_store

while true
  building = queue.shift

  building.next_buildings.each do |next_building|
    if states.include?(next_building.to_store)
      next
    end
    if next_building.finished?
      puts next_building.steps
      exit
    end

    states << next_building.to_store
    queue << next_building
  end
end