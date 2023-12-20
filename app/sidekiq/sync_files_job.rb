# frozen_string_literal: true

class SyncFilesJob
  include Sidekiq::Job

  # @param member_id [String]
  def perform(member_id = '0f0e203a-ca1d-4cdd-8aa9-758999b1dbed')
    db_files = ::FileServices::List.new.call
    db_file_hashes = db_files.map(&:file_id).to_set

    openai_files = ::OpenaiFileServices::List.new.call
    openai_file_hashes = openai_files.map(&:id).to_set

    to_download_files = openai_files.reject do |openai_file|
      db_file_hashes.include?(openai_file.id)
    end
    to_download_files.each do |openai_file|
      ::FileServices::Create.new.call(openai_file, member_id)
    end

    to_delete_files = db_files.reject do |db_file|
      openai_file_hashes.include?(db_file.file_id)
    end
    to_delete_files.each do |file|
      ::FileServices::Delete.new.call(file.id)
    end
  end
end
