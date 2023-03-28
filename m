Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B6AC6FD18
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 28 Mar 2023 23:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjC1XQU (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 28 Mar 2023 19:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjC1XQT (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:16:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B331BF0;
        Tue, 28 Mar 2023 16:16:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90935619E8;
        Tue, 28 Mar 2023 23:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7CDC433EF;
        Tue, 28 Mar 2023 23:16:16 +0000 (UTC)
Date:   Tue, 28 Mar 2023 19:16:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing/osnoise: Fix notify new tracing_max_latency
Message-ID: <20230328191613.33ac3f5e@gandalf.local.home>
In-Reply-To: <c22302a7db3cee6bcabf87462ed22a35dd38690f.1679675521.git.bristot@kernel.org>
References: <c22302a7db3cee6bcabf87462ed22a35dd38690f.1679675521.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 24 Mar 2023 18:51:35 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> timerlat is not reporting a new tracing_max_latency for the thread
> latency. Also, the tracer is reporting new max latency on instances
> where the tracing is off, creating inconsistencies between the max
> reported values in the trace and in the tracing_max_latency. Thus
> only report new tracing_max_latency on active tracing instances.

Sounds to me this patch fixes two different bugs. If so, can you please
break it up into two different patches?

Thanks!

-- Steve

> 
> Fixes: dae181349f1e ("tracing/osnoise: Support a list of trace_array *tr")
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  kernel/trace/trace_osnoise.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 210e1f168392..2a1b337ac643 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1296,7 +1296,7 @@ static void notify_new_max_latency(u64 latency)
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
>  		tr = inst->tr;
> -		if (tr->max_latency < latency) {
> +		if (tracer_tracing_is_on(tr) && tr->max_latency < latency) {
>  			tr->max_latency = latency;
>  			latency_fsnotify(tr);
>  		}
> @@ -1738,6 +1738,8 @@ static int timerlat_main(void *data)
>  
>  		trace_timerlat_sample(&s);
>  
> +		notify_new_max_latency(diff);
> +
>  		timerlat_dump_stack(time_to_us(diff));
>  
>  		tlat->tracing_thread = false;

