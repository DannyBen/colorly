module SpecMixin
  def reset_tmp_dir
    if Dir.exist? tmp_dir
      Dir["#{tmp_dir}/**/*"].each { |file| File.delete file if File.file? file }
    else
      # :nocov:
      Dir.mkdir tmp_dir
      # :nocov:
    end
  end

  def tmp_dir
    File.expand_path 'tmp', __dir__
  end
end
