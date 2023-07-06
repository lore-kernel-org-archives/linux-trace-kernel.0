Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3232EB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  6 Jul 2023 17:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGFRhk (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 6 Jul 2023 13:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjGFRhk (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:37:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A04410C
        for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Jul 2023 10:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D346E61070
        for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Jul 2023 17:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0062FC433C8;
        Thu,  6 Jul 2023 17:37:37 +0000 (UTC)
Date:   Thu, 6 Jul 2023 13:37:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] x86/ftrace: Make function graph use ftrace
 directly
Message-ID: <20230706133734.499e9cbe@gandalf.local.home>
In-Reply-To: <8d9bf4bb-693a-4368-8db1-9de1b80a33e1@moroto.mountain>
References: <8d9bf4bb-693a-4368-8db1-9de1b80a33e1@moroto.mountain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 6 Jul 2023 08:50:31 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hello Steven Rostedt (VMware),
> 
> The patch 0c0593b45c9b: "x86/ftrace: Make function graph use ftrace
> directly" from Oct 8, 2021, leads to the following Smatch static
> checker warning:
> 
> 	kernel/trace/trace_selftest.c:769 trace_graph_entry_watchdog()
> 	warn: sleeping in atomic context
> 
> kernel/trace/trace_selftest.c
>     765 static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace)
>     766 {
>     767         /* This is harmlessly racy, we want to approximately detect a hang */
>     768         if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
> --> 769                 ftrace_graph_stop();  
> 
> This is a sleeping function.

Hmm, this is an interesting scenario. If this triggers, it means that the
system is likely locked up by the function graph tracer. The only way to
stop the hang, is via calling ftrace_graph_stop(). But you are correct,
that's calling something that can crash the system as well.

If anything, it should be called after the dump_on_oops output, with a
warning to reboot the machine.

IOW, yes, it's doing something buggy, but pretty much the only other
alternative is to call panic(). Not sure that's better :-/

Perhaps the solution is simply to move it to after the dump, with a warning
saying: "Dazed and confused, and trying to continue, but please reboot the machine!"

??

-- Steve



> 
>     770                 printk(KERN_WARNING "BUG: Function graph tracer hang!\n");
>     771                 if (ftrace_dump_on_oops) {
>     772                         ftrace_dump(DUMP_ALL);
>     773                         /* ftrace_dump() disables tracing */
>     774                         tracing_on();
>     775                 }
>     776                 return 0;
>     777         }
>     778 
>     779         return trace_graph_entry(trace);
>     780 }
> 
> The call tree is:
> 
> prepare_ftrace_return() <- disables preempt
> -> function_graph_enter()
>    -> trace_graph_entry_watchdog()  
> 
> The ftrace_test_recursion_trylock() function disables preemption.  The
> trace_graph_entry_watchdog() function is called as a pointer so it's
> the ftrace_graph_entry() call.
> 
> regards,
> dan carpenter

