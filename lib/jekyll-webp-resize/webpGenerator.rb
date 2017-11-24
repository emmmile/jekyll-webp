require 'jekyll/document'
require 'fileutils'

module Jekyll
  module Webp
    # A static file to hold the generated webp image after generation
    # so that Jekyll will copy it into the site output directory
    class WebpFile < StaticFile
      def write(dest)
        true # Recover from strange exception when starting server without --auto
      end
    end

    class WebpGenerator < Generator
      # This generator is safe from arbitrary code execution.
      safe true

      # This generator should be passive with regard to its execution
      priority :lowest

      def generate(site)
        # Retrieve and merge the configuration from the site yml file
        @config = DEFAULT.merge(site.config['webp'] || {})

        # If disabled then simply quit
        if !@config['enabled']
          Jekyll.logger.info("WebP:", "Disabled in site.config.")
          return
        end

        # If the site destination directory has not yet been created then create it now. Otherwise, we cannot write our file there.
        Dir::mkdir(site.dest) if !File.directory? site.dest

        # Counting the number of files generated
        files_generated = 0

        # Iterate through every image in each of the image folders and create a webp image
        # if one has not been created already for that image.
        for imgdir in @config['img_dir']
          source_directory = File.join(site.source, imgdir)
          destination_directory = File.join(site.dest, imgdir)
          FileUtils::mkdir_p(destination_directory)
          Jekyll.logger.info("WebP:", "Processing #{source_directory}")

          for file in Dir[source_directory + "**/*.*"]
            prefix = File.dirname(file.sub(source_directory, ""))

            # If the file is not one of the supported formats, exit early
            extension = File.extname(file).downcase
            next if !@config['formats'].include? extension

            # Create the output file path
            filename = File.basename(file, extension) + ".webp"
            FileUtils::mkdir_p(destination_directory + prefix)
            output_full_path = File.join(destination_directory + prefix, filename)

            # Keep the webp file from being cleaned by Jekyll
            site.static_files << WebpFile.new(site,
                                              site.dest,
                                              File.join(imgdir, prefix),
                                              filename)

            # Check if the file already has a webp alternative?
            # If we're force rebuilding all webp files then ignore the check
            # also check the modified time on the files to ensure that the webp file
            # is newer than the source file, if not then regenerate
            next if File.file?(output_full_path) && File.mtime(output_full_path) > File.mtime(file)

            if File.file?(output_full_path) && File.mtime(output_full_path) <= File.mtime(file)
              Jekyll.logger.info("WebP:", "Change to source image file #{file} detected, regenerating WebP")
            end

            # Generate the file
            WebpExec.run(@config['flags'], file, output_full_path)
            files_generated += 1
          end # dir.foreach
        end # img_dir

        Jekyll.logger.info("WebP:", "Generator Complete: #{files_generated} file(s) generated")
      end #function generate
    end #class WebPGenerator
  end #module Webp
end #module Jekyll
