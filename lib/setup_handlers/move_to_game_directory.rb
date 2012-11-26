module Metro
  module SetupHandlers

    #
    # If the filename provide contains path information, then we need to move the
    # current working directory into the root of the game directory. This is
    # important because assets and other various paths are dependent on that
    # being the location during execution.
    #
    class MoveToGameDirectory
      def setup(options)
        filename = options.fetch(:filename,'.')
        game_directory = File.dirname(filename)
        Dir.chdir game_directory
      end
    end
  end

  register_setup_handler SetupHandlers::MoveToGameDirectory.new

end