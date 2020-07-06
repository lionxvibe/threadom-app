require 'test_helper'

class MockClient < Twitter::REST::Client
  def update(status, options = nil)
    Twitter::Tweet.new(:id => 1)
  end

  def destroy_status(*args); end
end

class TweetThreadJobTest < ActiveJob::TestCase

  setup do
    @not_posted_twitter_thread = twitter_threads(:not_posted)
    @posted_twitter_thread = twitter_threads(:posted)
    @delayed_twitter_thread = twitter_threads(:delayed)

    TweetThreadJob.any_instance.stubs(:twitter_client).returns(MockClient.new)
  end

  test 'thread is queued at scheduled_at time' do
    assert_enqueued_with(job: TweetThreadJob, at: @not_posted_twitter_thread.scheduled_at, args: [@not_posted_twitter_thread]) do
      TweetThreadJob.set(wait_until: @not_posted_twitter_thread.scheduled_at).perform_later @not_posted_twitter_thread
    end
  end

  test 'posted thread' do
    perform_enqueued_jobs do
      TweetThreadJob.perform_later(@posted_twitter_thread)
      assert_performed_jobs 1
      assert_equal(@posted_twitter_thread.scheduled_at, @posted_twitter_thread.posted_at)
    end
  end

  test 'not posted thread' do
    perform_enqueued_jobs do
      TweetThreadJob.perform_later(@not_posted_twitter_thread)
      assert_performed_jobs 1
      assert_not_nil @not_posted_twitter_thread.reload.posted_at
    end
  end

  test 'multiple thread update' do
    perform_enqueued_jobs do
      TweetThreadJob.perform_later(@not_posted_twitter_thread)
      posted_at = @not_posted_twitter_thread.reload.posted_at
      assert_not_nil posted_at
      TweetThreadJob.perform_later(@not_posted_twitter_thread)
      assert_equal(posted_at, @not_posted_twitter_thread.reload.posted_at)
      TweetThreadJob.perform_later(@not_posted_twitter_thread)
      assert_equal(posted_at, @not_posted_twitter_thread.reload.posted_at)
      assert_performed_jobs 3
    end
  end

  test 'delayed thread' do
    perform_enqueued_jobs do
      TweetThreadJob.perform_later(@delayed_twitter_thread)
      assert_performed_jobs 1
      assert_nil @delayed_twitter_thread.reload.posted_at
    end
  end
end