Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RNTpJRNc"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F8ED60
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:14:38 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5094cb3a036so7427299e87.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701177276; x=1701782076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3lzwLwPre7wvnqsdFYx09a6rbeV9XRoBcce+xZPKf0=;
        b=RNTpJRNcNnEb5YFU00RErkxk3Q938Q0YMiV1OCgISy7pscuhklxpap21xy+bca9FuX
         EufNZX45lM5ALVc3We2A//Qhxc3tdyo1A+oQdrpJnJb6dMFAX3h8y2RGSAdLkhlEFZm8
         IZGENb7cXFoWZS/4ZIB6c6WQt6Uk5HsspDVuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177276; x=1701782076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3lzwLwPre7wvnqsdFYx09a6rbeV9XRoBcce+xZPKf0=;
        b=anzI+ThzmdXqS7xQgsqY04SmDGdeGGpff98dcOxz0qttirG2wt2ZKwpM+b1XcVF4xh
         xP1I06YyJf2AbpTA+D9q0stXK1IT2fGdIvQgH4Kx668kb2+GzuVk4lW1TfL0rp5x+mT+
         x8VH0wOPrJnIBczkU5ivcRSvEu/3l8+G5rgeKALdcEGI4sY3UCeiF9ndJqyvqwJHtRGX
         +qAybSR4XCQz/AaxIvbqpXcLCFG93GYf7z/mMN29bYn+Ayc/OGVsOri+c4OtY/xKYGmC
         c/Dj4BEK4XvSGdABjherXMTl3z4lm50KIiSGjOMUojEqYF7CoYwEdoL3xNV/1UgLpEpW
         tFeQ==
X-Gm-Message-State: AOJu0Yw9daRVNwUxvMVWMwaRwS/O1FMuTQg8xYMMbEeqAcPArcjWYkUm
	bh5Qs6JlCfk/cRQmOkY03EkIbQ==
X-Google-Smtp-Source: AGHT+IE0Vi+lZpGWrs8F+Q6TthkcHLrt1LW8Dss/9F153YJg4v3hb9ZeesPR9HQID+L/IE0mA2CkQQ==
X-Received: by 2002:ac2:5619:0:b0:507:9f51:acee with SMTP id v25-20020ac25619000000b005079f51aceemr9291885lfd.22.1701177275725;
        Tue, 28 Nov 2023 05:14:35 -0800 (PST)
Received: from google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id k9-20020ac24f09000000b0050ba6e480fdsm1352362lfr.248.2023.11.28.05.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 05:14:35 -0800 (PST)
Date: Tue, 28 Nov 2023 14:14:29 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sean Paul <seanpaul@chromium.org>, Arun Easi <aeasi@marvell.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [RFC][PATCH] tracing: Allow creating instances with specified
 system events
Message-ID: <ZWXntcHNflkbrxd7@google.com>
References: <20231127174108.3c331c9c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127174108.3c331c9c@gandalf.local.home>

On Mon, Nov 27, 2023 at 05:41:08PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A trace instance may only need to enable specific events. As the eventfs
> directory of an instance currently creates all events which adds overhead,
> allow internal instances to be created with just the events in systems
> that they care about. This currently only deals with systems and not
> individual events, but this should bring down the overhead of creating
> instances for specific use cases quite bit.
> 
> The qla2xxx instance could just enable the systems it cares about, but that
> should be a separate patch.
> 
> Note that kprobes and synthetic events created after the creation of these
> instances, will be added to these instances, but those that are created
> before the creation of the instance will not be included.

This limitation will cause (unrelated) events created by modules that
are insmoded after creating the instance to be also added to the
instance. Why not filter those as well?

Besides that, the change looks nice to me.

> Note, this may also be useful for creating instances in the eventfs, but
> I'm not sure how to do this there. I could add a deliminator:
> 
>   mkdir /sys/kernel/tracing/instances/foo::sched,timer
> 
> But if a tool already uses "::" as a deliminator, then this will break it.
> I could just have it work if all the events after the deliminator exist.
> 
>   Thoughts?
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  drivers/scsi/qla2xxx/qla_os.c       |  2 +-
>  include/linux/trace.h               |  4 ++--
>  kernel/trace/trace.c                | 22 ++++++++++++--------
>  kernel/trace/trace.h                |  3 ++-
>  kernel/trace/trace_boot.c           |  2 +-
>  kernel/trace/trace_events.c         | 31 ++++++++++++++++++++++++++---
>  samples/ftrace/sample-trace-array.c |  2 +-
>  7 files changed, 49 insertions(+), 17 deletions(-)
