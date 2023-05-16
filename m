Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A848C77B7D
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 16 May 2023 01:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjEPBZx (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 15 May 2023 21:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEPBZw (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:25:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27C71FDC;
        Mon, 15 May 2023 18:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8864C633E5;
        Tue, 16 May 2023 01:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E39C433D2;
        Tue, 16 May 2023 01:25:49 +0000 (UTC)
Date:   Mon, 15 May 2023 21:25:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, Ze Gao <zegao@tencent.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fprobe: make fprobe_kprobe_handler recursion free
Message-ID: <20230515212546.7a467a1f@gandalf.local.home>
In-Reply-To: <6c428b9f74090b2780b67ca498c45aa5e8c38c44.1684120990.git.zegao@tencent.com>
References: <cover.1684120990.git.zegao@tencent.com>
        <6c428b9f74090b2780b67ca498c45aa5e8c38c44.1684120990.git.zegao@tencent.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 15 May 2023 11:26:39 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> Current implementation calls kprobe related functions before doing
> ftrace recursion check in fprobe_kprobe_handler, which opens door
> to kernel crash due to stack recursion if preempt_count_{add, sub}
> is traceable.
> 
> Refactor the common part out of fprobe_kprobe_handler and fprobe_
> handler and call ftrace recursion detection at the very beginning,
> and also mark these functions notrace so that the whole fprobe_k-
> probe_handler is free from recusion. And
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>  kernel/trace/fprobe.c | 61 +++++++++++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 9abb3905bc8e..ad9a36c87ad9 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -20,30 +20,22 @@ struct fprobe_rethook_node {
>  	char data[];
>  };
>  
> -static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> -			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
> +static inline notrace void __fprobe_handler(unsigned long ip, unsigned long


FYI, if you look in kernel/trace/Makefile you'll see:

ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)

Which removes the flags to add tracing. So there's no reason to add
"notrace" here, as all functions in this directory are by default "notrace".

-- Steve


> +		parent_ip, struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {
>  	struct fprobe_rethook_node *fpr;
>  	struct rethook_node *rh = NULL;
>  	struct fprobe *fp;
>  	void *entry_data = NULL;
> -	int bit, ret;
> +	int ret;
>  
>  	fp = container_of(ops, struct fprobe, ops);
> -	if (fprobe_disabled(fp))
> -		return;
> -
> -	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> -	if (bit < 0) {
> -		fp->nmissed++;
> -		return;
> -	}
>  
>  	if (fp->exit_handler) {
>  		rh = rethook_try_get(fp->rethook);
>  		if (!rh) {
>  			fp->nmissed++;
> -			goto out;
> +			return;
>  		}
>  		fpr = container_of(rh, struct fprobe_rethook_node, node);
>  		fpr->entry_ip = ip;
> @@ -61,23 +53,60 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
>  		else
>  			rethook_hook(rh, ftrace_get_regs(fregs), true);
>  	}
>
