Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5EC7318C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194428; cv=none; b=I/l/YMBn5u4ymFy4FKuuKkofCMNSRyi4MBUGvlIotrgxbtMEvHUQY8igxTk6RrT9qgtRohT6FUtK0EZvmZxHVxTCuuvM1cDCtzCWnwJWqL6nMAJLQSR5SgCXwnpazpA5A9wTCgURiWOn0bVfdM1KE+Rr6mRQIzGcjLUM9vWd8QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194428; c=relaxed/simple;
	bh=KPuvxE3hYAACFP7Rrdou6g9k42VF2tgVtRStJY4Iz+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy9McHok0ZRE02Vyfri45I5bmR7/EQ2/LIIHJptCnheK7VkrxQUVMrpl4Hb0pZcYuEWS5rcu2DMsVBarv4HfwKtrjAPM4lmou5i3Sv1xUKT8cqYsByWgnXQShzh4bXH92asyrH7Hp79uz+JsXPx2UyuqjI8rmql9vXmUAxfCJxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nAKQQ/E5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nAKQQ/E5"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso79994135e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706194424; x=1706799224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zFs4A0rqEkVkaFZSqApc453O/THTuhqOvYGA4M+P2s=;
        b=nAKQQ/E5Hqrve3hEGyMcbzk5N8f58A5WUNGZT69zb/dHYwaeFrM5QMG8P0l0sSzsv3
         9HXaKKij8M+BJ52ofHc6G4buY/88S30syGVECPh3SpSeetF8RQqOehtHgtU5Cy6s2KeQ
         tIyDxTJjN8iTNc5Ms0RKJgDR3mu6ElDQ6NSNUln/ixy809VwR2ZWWWSOG01i/zWxQqFC
         HyTepLol2KWR+46odErTGmdj4pFk4owK1ch21Cdkcl9HI2hJ7UDFyD+mckHrrRXZmGNC
         1pReQYdTw+SLu8watM/PsWlH8kD3gXSK7ghDk6mgYgibjg9pk1nYkGCKySu+jqmRsfLN
         nxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194424; x=1706799224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zFs4A0rqEkVkaFZSqApc453O/THTuhqOvYGA4M+P2s=;
        b=lSuXmUCyNBUa9RklBanZZ+xyd/Vj/OXAwGWSh1fTf3H+Lq5T93j7ZfqXLBiy0YYIcq
         4NO5K941YT69pmCvCkj5l6/mdNAHhwJt+VzUXYiVbBY61W1rP5gP5sTo+Fjlc8gdHY1I
         NYVX7wJLDJWCAkIhs9KTAhFOlH4tUapSTqHEXez9RU7IZvax7jFGkQwbffohNI3QA9ZB
         SjXKdR1gbXIQ8j6B8DBmOS2S5jlFi8CLYlEDo1vnS0uB/feztC7t2VE4Bl7Q2A5ptNBl
         5dzgXrHrD78N5GY6IgPGuI+Y8M/taeXK724UQqLdLFmOdMt/8DchemJ8oK0LL49gCitP
         M4OQ==
X-Gm-Message-State: AOJu0Yxw2qLGOmMtWsINcHIofaql3qa+eMlRqGagF8+ox5JprbFYew+y
	9MVOyckV3gALMqva8k6KsyLEvYu+OrN7djtdloUxzYUGeC1GhaVBQF18emRsmhmZxcc0jUaJrpJ
	X2g==
X-Google-Smtp-Source: AGHT+IHSuPmb/Q/n3aX49kCQd1VKNag0u1dTW/AsPfRZpFtYaodMFqwRC2ldUEkbGbsTAmElLaw2cw==
X-Received: by 2002:a05:600c:a45:b0:40d:5fcc:3a65 with SMTP id c5-20020a05600c0a4500b0040d5fcc3a65mr413529wmq.113.1706194424431;
        Thu, 25 Jan 2024 06:53:44 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id je1-20020a05600c1f8100b0040e5cf9a6c7sm2881251wmb.13.2024.01.25.06.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:53:44 -0800 (PST)
Date: Thu, 25 Jan 2024 14:53:40 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com
Subject: Re: [PATCH v12 3/6] tracing: Add snapshot refcount
Message-ID: <ZbJ19CF2Zv4d0R_Z@google.com>
References: <20240123110757.3657908-1-vdonnefort@google.com>
 <20240123110757.3657908-4-vdonnefort@google.com>
 <20240125001149.364c0b08237e8b7f0a69bd56@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125001149.364c0b08237e8b7f0a69bd56@kernel.org>

Hi Masami,

Thanks for taking the time to look at those changes.

On Thu, Jan 25, 2024 at 12:11:49AM +0900, Masami Hiramatsu wrote:
> On Tue, 23 Jan 2024 11:07:54 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> [...]
> > @@ -6592,8 +6641,11 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
> >  
> >  	if (t->init) {
> >  		ret = tracer_init(t, tr);
> > -		if (ret)
> > +		if (ret) {
> > +			if (t->use_max_tr)
> > +				tracing_disarm_snapshot_locked(tr);
> 
> This part is out of CONFIG_TRACER_MAX_TRACE, so it may cause a compile error
> if CONFIG_TRACER_MAX_TRACE is not set.

Duh, yes it must depends on TRACER_MAX_TRACE :-\

> 
> >  			goto out;
> > +		}
> >  	}
> >  
> >  	tr->current_trace = t;
> [...]
> > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> > index 46439e3bcec4..d41bf64741e2 100644
> > --- a/kernel/trace/trace_events_trigger.c
> > +++ b/kernel/trace/trace_events_trigger.c
> > @@ -597,20 +597,9 @@ static int register_trigger(char *glob,
> >  	return ret;
> >  }
> >  
> > -/**
> > - * unregister_trigger - Generic event_command @unreg implementation
> > - * @glob: The raw string used to register the trigger
> > - * @test: Trigger-specific data used to find the trigger to remove
> > - * @file: The trace_event_file associated with the event
> > - *
> > - * Common implementation for event trigger unregistration.
> > - *
> > - * Usually used directly as the @unreg method in event command
> > - * implementations.
> > - */
> > -static void unregister_trigger(char *glob,
> > -			       struct event_trigger_data *test,
> > -			       struct trace_event_file *file)
> 
> OK, so __unregister_trigger returns true if data exists, but
> unregister_trigger() ignores results. (I want some comment here)

Will add something for the __unregister_trigger flavour.

> 
> > +static bool __unregister_trigger(char *glob,
> > +				 struct event_trigger_data *test,
> > +				 struct trace_event_file *file)
> >  {
> >  	struct event_trigger_data *data = NULL, *iter;
> >  
> > @@ -626,8 +615,32 @@ static void unregister_trigger(char *glob,
> >  		}
> >  	}
> >  
> > -	if (data && data->ops->free)
> > -		data->ops->free(data);
> > +	if (data) {
> > +		if (data->ops->free)
> > +			data->ops->free(data);
> > +
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +/**
> > + * unregister_trigger - Generic event_command @unreg implementation
> > + * @glob: The raw string used to register the trigger
> > + * @test: Trigger-specific data used to find the trigger to remove
> > + * @file: The trace_event_file associated with the event
> > + *
> > + * Common implementation for event trigger unregistration.
> > + *
> > + * Usually used directly as the @unreg method in event command
> > + * implementations.
> > + */
> > +static void unregister_trigger(char *glob,
> > +			       struct event_trigger_data *test,
> > +			       struct trace_event_file *file)
> > +{
> > +	__unregister_trigger(glob, test, file);
> >  }
> >  
> >  /*
> > @@ -1470,12 +1483,20 @@ register_snapshot_trigger(char *glob,
> >  			  struct event_trigger_data *data,
> >  			  struct trace_event_file *file)
> >  {
> > -	if (tracing_alloc_snapshot_instance(file->tr) != 0)
> > +	if (tracing_arm_snapshot(file->tr))
> >  		return 0;
> 
> BTW, is this return value correct? It seems that the register_*_trigger()
> will return error code when it fails.

It should indeed be 

 ret = tracing_arm_snapshot()
 if (ret)
     return ret;

> 
> Thanks,
> 
> >  
> >  	return register_trigger(glob, data, file);
> >  }
> >  
> > +static void unregister_snapshot_trigger(char *glob,
> > +					struct event_trigger_data *data,
> > +					struct trace_event_file *file)
> > +{
> > +	if (__unregister_trigger(glob, data, file))
> > +		tracing_disarm_snapshot(file->tr);
> > +}
> > +
> >  static int
> >  snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
> >  {
> > @@ -1508,7 +1529,7 @@ static struct event_command trigger_snapshot_cmd = {
> >  	.trigger_type		= ETT_SNAPSHOT,
> >  	.parse			= event_trigger_parse,
> >  	.reg			= register_snapshot_trigger,
> > -	.unreg			= unregister_trigger,
> > +	.unreg			= unregister_snapshot_trigger,
> >  	.get_trigger_ops	= snapshot_get_trigger_ops,
> >  	.set_filter		= set_trigger_filter,
> >  };
> > -- 
> > 2.43.0.429.g432eaa2c6b-goog
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
