Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29618C61DA0
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 24 Jan 2023 19:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjAXTGw (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 24 Jan 2023 14:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbjAXTGk (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:06:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E14F34C;
        Tue, 24 Jan 2023 11:06:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDE356132A;
        Tue, 24 Jan 2023 19:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73557C433EF;
        Tue, 24 Jan 2023 19:06:19 +0000 (UTC)
Date:   Tue, 24 Jan 2023 14:06:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, chriscli@google.com
Subject: Re: [PATCH] ftrace: Show a list of all functions that have ever
 been enabled
Message-ID: <20230124140617.4a4fe106@gandalf.local.home>
In-Reply-To: <Y9AG63mgkyzSEbSa@FVFF77S0Q05N>
References: <20230124095653.6fd1640e@gandalf.local.home>
        <Y9AG63mgkyzSEbSa@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 24 Jan 2023 16:27:23 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> > [
> >   This patch will conflict with Mark's patch that is going through the ARM
> >   tree. I will hold off pulling this patch until the next merge window, and
> >   rebase it on top of the changes when the tracing tree merges with upstream
> >   that has the changes from the ARM tree.
> > ]  
> 
> Sorry for the conflict!

No problem. This was more to help us debug something, and we are currently
just backporting it for now to our kernels in order to help with the
crashes we are seeing. No rush to get it upstream. But I figured that if it
can help us, it can also help others.

> 
> The patch looks good to me; I just gave it a spin on arm64 (resolving the
> conflcit with my changes by moving FTRCE_FL_TOUCHED to bit 20, and
> FTRACE_REF_MAX_SHIFT down to 20), and from a naive test that seems happy:
> 
> | # cat /sys/kernel/tracing/touched_functions 
> | # echo do_el0_svc > /sys/kernel/tracing/set_ftrace_filter 
> | # echo function_graph > /sys/kernel/tracing/current_tracer 
> | # cat /sys/kernel/tracing/touched_functions 
> | do_el0_svc (1)       O  ops: graph_ops+0x0/0xb8 (ftrace_graph_func+0x0/0x58)
> | # echo nop > /sys/kernel/tracing/current_tracer 
> | # cat /sys/kernel/tracing/touched_functions 
> | do_el0_svc (0) 

Thanks for testing! I guess I can add a "tested-by" from you?

-- Steve
