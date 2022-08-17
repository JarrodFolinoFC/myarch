class LoggerMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    puts "LoggerMiddleware reporting in!"
    puts "The app is: #{@app}"
    puts "The has the methods: #{@app.methods - Object.methods}"
    status, headers, body = @app.call(env)
    [status, headers, body]
  end
end