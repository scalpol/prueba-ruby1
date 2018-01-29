def read_alum(file_name)
  file = File.open(file_name, 'r')
  alum = file.readlines.map(&:chomp).map { |lines| lines.split(', ') }
  file.close
  alum
end

def array_to_hash(array)
  alumnos = {}
  array.each do |alumno|
    nombre = ''
    notas = []
    alumno.each do |i|
      if i.length > 1 && i != '10'
        nombre = i.to_sym
      else
        notas.push(i.to_i)
      end
      alumnos[nombre] = notas
    end
  end
  alumnos
end

def obtener_promedio(notas)
  (notas.inject(0) { |suma, i| suma + i }) / notas.count.to_f
end

def aprobado(notas, nota_de_aprobacion = 5)
  obtener_promedio(notas) > nota_de_aprobacion
end

asistencia = read_alum('asistencia.csv')
alumnos = array_to_hash(asistencia)
seleccion = 0

until seleccion == 4
  puts '¿Que desea hacer? (1) Obtener promedios (2) Obtener inasistencias (3) Obtener aprobados (4) Salir'
  seleccion = gets.chomp.to_i
  if seleccion > 4 || seleccion < 1
    puts 'Opción inválida.'
  else
    case seleccion

    when 1
      alumnos.each do |nombre, notas|
        promedio = obtener_promedio(notas)
        puts "#{nombre} tiene promedio #{promedio}."
      end

    when 2
      alumnos.each do |nombre, notas|
        inasistencias = 0
        notas.each { |nota| inasistencias += 1 if nota == 0 }
        puts "#{nombre.to_s} tiene  #{inasistencias} inasistencia(s) en total."
      end

    when 3
      puts 'Los alumnos aprobados son:'
      alumnos.each do |nombre, notas|
        puts nombre if aprobado(notas)
      end

    end
  end
end
