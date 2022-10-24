Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28636FA373F
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 24 Oct 2022 16:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiJXQdj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 24 Oct 2022 12:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiJXQdM (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8DD642CE;
        Mon, 24 Oct 2022 08:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 272DC61388;
        Mon, 24 Oct 2022 14:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F64C433D7;
        Mon, 24 Oct 2022 14:22:20 +0000 (UTC)
Date:   Mon, 24 Oct 2022 10:22:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] tracing/fprobe: Fix to check whether fprobe is
 registered correctly
Message-ID: <20221024102230.6b02c978@gandalf.local.home>
In-Reply-To: <166653477373.988423.13256491425983587550.stgit@mhiramat.roam.corp.google.com>
References: <166653477373.988423.13256491425983587550.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, 23 Oct 2022 23:19:33 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since commit ab51e15d535e ("fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag
> for fprobe") introduced fprobe_kprobe_handler() for fprobe::f_op::func,
> unregister_fprobe() fails to unregister the registered if user specifies
> FPROBE_FL_KPROBE_SHARED flag.
> To check it correctly, it should confirm the fprobe::f_op::func is either
> fprobe_handler() or fprobe_kprobe_handler().
> 
> Fixes: ab51e15d535e ("fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag for fprobe")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fprobe.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index aac63ca9c3d1..9000d8ea6274 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -301,7 +301,8 @@ int unregister_fprobe(struct fprobe *fp)
>  {
>  	int ret;
>  
> -	if (!fp || fp->ops.func != fprobe_handler)
> +	if (!fp || (fp->ops.func != fprobe_handler &&
> +		    fp->ops.func != fprobe_kprobe_handler))
>  		return -EINVAL;
>  
>  	/*

Should we make this more paranoid?

	if (!fp ||
	    (fprobe_shared_with_kprobes(fp) && fp->ops.func != fprobe_kprobe_handler) ||
	    (!fprobe_shared_with_kprobes(fp) && fp->ops.func != fprobe_handler))

Or is that over-kill?

-- Steve
