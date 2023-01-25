Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBBEC27C76
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 25 Jan 2023 09:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjAYJ3g (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 25 Jan 2023 04:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAYJ3g (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:29:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52FC214EAC;
        Wed, 25 Jan 2023 01:29:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A61054B3;
        Wed, 25 Jan 2023 01:30:16 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.9.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAD233F5A1;
        Wed, 25 Jan 2023 01:29:33 -0800 (PST)
Date:   Wed, 25 Jan 2023 09:29:31 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, chriscli@google.com
Subject: Re: [PATCH] ftrace: Show a list of all functions that have ever been
 enabled
Message-ID: <Y9D2e6zqwRpua9A8@FVFF77S0Q05N>
References: <20230124095653.6fd1640e@gandalf.local.home>
 <Y9AG63mgkyzSEbSa@FVFF77S0Q05N>
 <20230124140617.4a4fe106@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124140617.4a4fe106@gandalf.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:06:17PM -0500, Steven Rostedt wrote:
> On Tue, 24 Jan 2023 16:27:23 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > > [
> > >   This patch will conflict with Mark's patch that is going through the ARM
> > >   tree. I will hold off pulling this patch until the next merge window, and
> > >   rebase it on top of the changes when the tracing tree merges with upstream
> > >   that has the changes from the ARM tree.
> > > ]  
> > 
> > Sorry for the conflict!
> 
> No problem. This was more to help us debug something, and we are currently
> just backporting it for now to our kernels in order to help with the
> crashes we are seeing. No rush to get it upstream. But I figured that if it
> can help us, it can also help others.

Indeed!

> > The patch looks good to me; I just gave it a spin on arm64 (resolving the
> > conflcit with my changes by moving FTRCE_FL_TOUCHED to bit 20, and
> > FTRACE_REF_MAX_SHIFT down to 20), and from a naive test that seems happy:
> > 
> > | # cat /sys/kernel/tracing/touched_functions 
> > | # echo do_el0_svc > /sys/kernel/tracing/set_ftrace_filter 
> > | # echo function_graph > /sys/kernel/tracing/current_tracer 
> > | # cat /sys/kernel/tracing/touched_functions 
> > | do_el0_svc (1)       O  ops: graph_ops+0x0/0xb8 (ftrace_graph_func+0x0/0x58)
> > | # echo nop > /sys/kernel/tracing/current_tracer 
> > | # cat /sys/kernel/tracing/touched_functions 
> > | do_el0_svc (0) 
> 
> Thanks for testing! I guess I can add a "tested-by" from you?

Yes, please feel free to add:

Tested-by: Mark Rutland <mark.rutland@arm.com>

... and I'm happy to test the rebased version once this marge window as
settled.

Thanks,
Mark.
