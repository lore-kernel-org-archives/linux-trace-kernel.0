Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41B9C00A5A
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 18 Jan 2023 01:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjARBo3 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 17 Jan 2023 20:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjARBoP (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:44:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6BD51C54;
        Tue, 17 Jan 2023 17:43:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11D82615DA;
        Wed, 18 Jan 2023 01:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CFFC433EF;
        Wed, 18 Jan 2023 01:43:10 +0000 (UTC)
Date:   Tue, 17 Jan 2023 20:43:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 1/9] fprobe: Pass entry_data to handlers
Message-ID: <20230117204309.1cd8f20f@gandalf.local.home>
In-Reply-To: <166792256330.919356.14776044963704066797.stgit@devnote3>
References: <166792255429.919356.14116090269057513181.stgit@devnote3>
        <166792256330.919356.14776044963704066797.stgit@devnote3>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed,  9 Nov 2022 00:49:23 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index e8143e368074..fa25d09c9d57 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -17,14 +17,16 @@
>  struct fprobe_rethook_node {
>  	struct rethook_node node;
>  	unsigned long entry_ip;
> +	char data[];
>  };
>  
>  static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
>  			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {
>  	struct fprobe_rethook_node *fpr;
> -	struct rethook_node *rh;
> +	struct rethook_node *rh = NULL;
>  	struct fprobe *fp;
> +	void *entry_data = NULL;
>  	int bit;
>  
>  	fp = container_of(ops, struct fprobe, ops);
> @@ -37,9 +39,6 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
>  		return;
>  	}
>  
> -	if (fp->entry_handler)
> -		fp->entry_handler(fp, ip, ftrace_get_regs(fregs));
> -
>  	if (fp->exit_handler) {
>  		rh = rethook_try_get(fp->rethook);
>  		if (!rh) {
> @@ -48,9 +47,16 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
>  		}
>  		fpr = container_of(rh, struct fprobe_rethook_node, node);
>  		fpr->entry_ip = ip;
> -		rethook_hook(rh, ftrace_get_regs(fregs), true);
> +		if (fp->entry_data_size)
> +			entry_data = fpr->data;
>  	}
>  
> +	if (fp->entry_handler)
> +		fp->entry_handler(fp, ip, ftrace_get_regs(fregs), entry_data);
> +
> +	if (rh)
> +		rethook_hook(rh, ftrace_get_regs(fregs), true);
> +
>  out:
>  	ftrace_test_recursion_unlock(bit);
>  }
> @@ -81,7 +87,8 @@ static void fprobe_exit_handler(struct rethook_node *rh, void *data,
>  
>  	fpr = container_of(rh, struct fprobe_rethook_node, node);
>  
> -	fp->exit_handler(fp, fpr->entry_ip, regs);
> +	fp->exit_handler(fp, fpr->entry_ip, regs,
> +			 fp->entry_data_size ? (void *)fpr->data : NULL);
>  }
>  NOKPROBE_SYMBOL(fprobe_exit_handler);
>  
> @@ -146,7 +153,7 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
>  	for (i = 0; i < size; i++) {
>  		struct fprobe_rethook_node *node;
>  
> -		node = kzalloc(sizeof(*node), GFP_KERNEL);
> +		node = kzalloc(sizeof(*node) + fp->entry_data_size, GFP_KERNEL);

		node = kzalloc(struct_size(node, data, fp->entry_data_size), GFP_KERNEL);

Should use struct_size() for any tail structure allocations.

-- Steve


>  		if (!node) {
>  			rethook_free(fp->rethook);
>  			fp->rethook = NULL;
> diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
> index e0381b3ec410..34fa5a5bbda1 100644
