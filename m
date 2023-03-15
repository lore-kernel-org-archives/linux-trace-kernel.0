Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B088C6FD1D
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 15 Mar 2023 14:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjCOOPF (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjCOOOs (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:14:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F2CA0280;
        Wed, 15 Mar 2023 07:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BE2EB81E34;
        Wed, 15 Mar 2023 14:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5443C4339C;
        Wed, 15 Mar 2023 14:13:50 +0000 (UTC)
Date:   Wed, 15 Mar 2023 10:13:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Donglin Peng <pengdonglin@sangfor.com.cn>, mhiramat@kernel.org,
        linux@armlinux.org.uk, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] function_graph: Support recording and printing
 the return value of function
Message-ID: <20230315101348.1234c7f5@gandalf.local.home>
In-Reply-To: <20230315134911.GD2006103@hirez.programming.kicks-ass.net>
References: <20230315133911.958741-1-pengdonglin@sangfor.com.cn>
        <20230315133911.958741-2-pengdonglin@sangfor.com.cn>
        <20230315134911.GD2006103@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 15 Mar 2023 14:49:11 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> > index 1265ad519249..35ac9c58dc77 100644
> > --- a/arch/x86/kernel/ftrace_64.S
> > +++ b/arch/x86/kernel/ftrace_64.S
> > @@ -348,6 +348,10 @@ SYM_CODE_START(return_to_handler)
> >  	movq %rax, (%rsp)
> >  	movq %rdx, 8(%rsp)
> >  	movq %rbp, %rdi
> > +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> > +	/* Pass the function return value to ftrace_return_to_handler */
> > +	movq %rax, %rsi
> > +#endif
> >  
> >  	call ftrace_return_to_handler  
> 
> What about the case of double register return values (when the value
> is returned in the A,D pair) ?

Is there anything that does that in 64 bit kernels?

-- Steve
