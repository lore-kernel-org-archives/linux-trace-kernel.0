Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6830BC46467
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  5 Jan 2023 01:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjAEBGX (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 4 Jan 2023 20:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjAEBGV (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:06:21 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8982230545
        for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:06:20 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c11so28820738qtn.11
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Jan 2023 17:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLZw8C56lIMJzQNkbtwwGx4hGjO8vFqsMmr7mkW8vBw=;
        b=wgRWLOY8/G2cT1t0w3wWMi8d0XK9Y0KkJKdGnu5t97RKeTOK2nqfXIBeWZgyQ++CeR
         6bFTDHWNeQxLDhinHGf5DORS2P5zo/zSdCvlhaC16LFfua+rKLRtormjucojI8/PY0Ph
         hAADetkklddYM2qIyFsifFEwVqWz/8KZRNi9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLZw8C56lIMJzQNkbtwwGx4hGjO8vFqsMmr7mkW8vBw=;
        b=wni98O75t3JHyQxZx1yYTN8LDL4N31hn9gzIWrbpLNjjDStvNUb6VhBsNnsbwO625y
         RI+5oEZ4dE2z2DiL0OgDeZD5/2MmQarH/BwceJyPd9R+54Dd+l/ZwHb1hktecleHCrIj
         /FD0gfPg2RQZuk4Q850HZAlK6g+F/lxV4ZM4weO8cCN1hevc+dUM7IKG10kV7guwgScQ
         pJUmk4+MaIlRH7eKx4Yc3mNygmqeixMa/fmWBnGko0eBhAxkKu4kFYP4/vBrx/DfK+G1
         9RdJLY9kREgL2IMdVcnu9l6Ok53H8MV66xE280XsJc9/sA2y37PvAP92lNUNsiEk+rUg
         md2w==
X-Gm-Message-State: AFqh2kqJrq/KiGR5k551SmMjPgPxoEpK1Wanzt5Kbo8j/JtQ+WtFTuKy
        CpW0DEJvbPEP2wKeIM3sIJrjhw==
X-Google-Smtp-Source: AMrXdXveZ2JUOrizRlhHByXTSfr3sHdgr+EqqbJTUUi5MTzjxBFX9v1rve4kwNRzwMDK76mLaRRzCQ==
X-Received: by 2002:ac8:7583:0:b0:3a7:eb2c:efea with SMTP id s3-20020ac87583000000b003a7eb2cefeamr74409840qtq.19.1672880779620;
        Wed, 04 Jan 2023 17:06:19 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id o6-20020ac872c6000000b003a57a317c17sm21131484qtp.74.2023.01.04.17.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 17:06:18 -0800 (PST)
Date:   Thu, 5 Jan 2023 01:06:18 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing: Make sure trace_printk() can output as soon as
 it can be used
Message-ID: <Y7YiiogG7xbOjrNE@google.com>
References: <20230104161412.019f6c55@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104161412.019f6c55@gandalf.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 04:14:12PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Currently trace_printk() can be used as soon as early_trace_init() is
> called from start_kernel(). But if a crash happens, and
> "ftrace_dump_on_oops" is set on the kernel command line, all you get will
> be:
> 
>   [    0.456075]   <idle>-0         0dN.2. 347519us : Unknown type 6
>   [    0.456075]   <idle>-0         0dN.2. 353141us : Unknown type 6
>   [    0.456075]   <idle>-0         0dN.2. 358684us : Unknown type 6
> 
> This is because the trace_printk() event (type 6) hasn't been registered
> yet. That gets done via an early_initcall(), which may be early, but not
> early enough.
> 
> Instead of registering the trace_printk() event (and other ftrace events,
> which are not trace events) via an early_initcall(), have them registered at
> the same time that trace_printk() can be used. This way, if there is a
> crash before early_initcall(), then the trace_printk()s will actually be
> useful.
> 
> Cc: stable@vger.kernel.org
> Reported-by: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Fixes: e725c731e3bb1 ("tracing: Split tracing initialization into two for early initialization")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  kernel/trace/trace.c        | 2 ++
>  kernel/trace/trace.h        | 1 +
>  kernel/trace/trace_output.c | 3 +--
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d3005279165d..80de338f1277 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10196,6 +10196,8 @@ void __init early_trace_init(void)
>  			static_key_enable(&tracepoint_printk_key.key);
>  	}
>  	tracer_alloc_buffers();
> +
> +	init_events();
>  }
>  
>  void __init trace_init(void)
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 900e75d96c84..11c4918ff202 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1504,6 +1504,7 @@ extern void trace_event_enable_cmd_record(bool enable);
>  extern void trace_event_enable_tgid_record(bool enable);
>  
>  extern int event_trace_init(void);
> +extern int init_events(void);
>  extern int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr);
>  extern int event_trace_del_tracer(struct trace_array *tr);
>  extern void __trace_early_add_events(struct trace_array *tr);
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 67f47ea27921..5cd4fb656306 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1568,7 +1568,7 @@ static struct trace_event *events[] __initdata = {
>  	NULL
>  };
>  
> -__init static int init_events(void)
> +__init int init_events(void)
>  {
>  	struct trace_event *event;
>  	int i, ret;
> @@ -1581,4 +1581,3 @@ __init static int init_events(void)
>  
>  	return 0;
>  }
> -early_initcall(init_events);
> -- 
> 2.35.1
> 
