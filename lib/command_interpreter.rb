class CommandInterpreter
  attr_reader :runner

  def initialize(runner_input = CommandRunner)
    @runner = runner_input.new
  end

  def default_filename
    "event_attendees.csv"
  end

  def run(command)
    parts       = command.split
    instruction = parts.first
    case instruction
      when "load"
        run_load(parts)
      when "queue"
        run_queue(parts[1..-1])
      when "help"
        run_help(parts[1..-1])
      when "find"
        run_find(parts[1..-1])
    end
  end

  def run_load(parts)
    filename = parts[1] || default_filename
    runner.load(filename)
  end

  def run_queue(parts)
    case parts.first
      when "print"
        order = parts[2]
        runner.queue_print(order)
      when "count"
        runner.queue_count
      when "clear"
        runner.queue_clear
      when "save"
        filename = parts[2]
        runner.queue_save_to(filename)
    end
  end

  def run_help(parts)
    case parts.first
      when nil
        runner.help
      else
        commands = parts.join(" ")
        runner.help_commands(commands.to_s)
    end
  end

  def run_find(parts)
    command = parts.shift
    query = parts.join(' ')
    runner.send("find_#{command}", query)
  end

end
