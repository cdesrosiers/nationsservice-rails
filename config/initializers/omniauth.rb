Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '0h7yxYQJhPEyMPygHFXtw', 'pwF7CbSGlbf644mgcwgKJcKunjU62cJaFU9m0Y9oc'
  
  class SafeFailureEndpoint < OmniAuth::FailureEndpoint
    def call
      redirect_to_failure
    end
  end

  OmniAuth.config.on_failure = SafeFailureEndpoint

end
