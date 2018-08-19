require 'pry'

class Student
    attr_accessor :name, :grade
    attr_reader :id
    def initialize(name, grade, id = nil)
      @name = name
      @grade = grade
      @id = id
    end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]


  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students(name, grade)
    VALUES(?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    #row = DB[:conn].execute(sql).flatten
    binding.pry
    @id = row[0]
    #@id = DB[:conn].execute("SELECT last_insert_row_id FROM students")[0][0]
  end
end
