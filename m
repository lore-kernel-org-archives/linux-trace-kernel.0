Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1A3C433FE
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 14 Nov 2022 01:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiKNBub (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 13 Nov 2022 20:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbiKNBua (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:50:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E7D91;
        Sun, 13 Nov 2022 17:50:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A03460BD6;
        Mon, 14 Nov 2022 01:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0314C433D6;
        Mon, 14 Nov 2022 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668390628;
        bh=4V9YbxChV9WUSpnF4+YUz3YrvsUYrk7aSD6B1Bbml2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B0H+3SkDYeDKqrw3gQKlyCwSTTZijJGNBXftbJpzS37nmYznamsqrvYq8bvH2KG7W
         bDF5dlgyYvuoJ5rqqp/bZ9QI8XGYgIW7usGyztc7bD8VJsuL3NIbTcDWzusL5EN9/f
         9h87wozryv+ReIpGPXE1hC9w0+SE7heKja1kSErJUJEWzFV7xYpFNkgV4Y0D/MAQWR
         hBtBaHDCPRg/qwWK81MYyyRIsaG7RmRpESgUD/oaC9vk/YnFjy/ke3WuFrokZdrPGm
         fexWaAvxrzpb7QVLsIaP+ZOOVzHwjo5d8IUjRpLRl2AAfK9awjcfyhhVZq8UCrGmC0
         5ma4TiG5i6Axw==
Date:   Mon, 14 Nov 2022 10:50:25 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Rafael Mendonca <rafaelmendsr@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH] tracing/eprobe: Fix eprobe filter to make a filter
 correctly
Message-Id: <20221114105025.570082c976b24cc399bf693c@kernel.org>
In-Reply-To: <166823166395.1385292.8931770640212414483.stgit@devnote3>
References: <166823166395.1385292.8931770640212414483.stgit@devnote3>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi Rafael,

Can you give me your Tested-by on this?

Thank you,

On Sat, 12 Nov 2022 14:41:04 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the eprobe filter was defined based on the eprobe's trace event
> itself, it doesn't work correctly. Use the original trace event of
> the eprobe when making the filter so that the filter works correctly.
> 
> Without this fix:
> 
>  # echo 'e syscalls/sys_enter_openat \
> 	flags_rename=$flags:u32 if flags < 1000' >> dynamic_events
>  # echo 1 > events/eprobes/sys_enter_openat/enable
> [  114.551550] event trace: Could not enable event sys_enter_openat
> -bash: echo: write error: Invalid argument
> 
> With this fix:
>  # echo 'e syscalls/sys_enter_openat \
> 	flags_rename=$flags:u32 if flags < 1000' >> dynamic_events
>  # echo 1 > events/eprobes/sys_enter_openat/enable
>  # tail trace
> cat-241     [000] ...1.   266.498449: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
> cat-242     [000] ...1.   266.977640: sys_enter_openat: (syscalls.sys_enter_openat) flags_rename=0
> 
> Fixes: 752be5c5c910 ("tracing/eprobe: Add eprobe filter support")
> Reported-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_eprobe.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index fe4833a7b7b3..1c3096ab2fe7 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -643,7 +643,7 @@ new_eprobe_trigger(struct trace_eprobe *ep, struct trace_event_file *file)
>  	INIT_LIST_HEAD(&trigger->list);
>  
>  	if (ep->filter_str) {
> -		ret = create_event_filter(file->tr, file->event_call,
> +		ret = create_event_filter(file->tr, ep->event,
>  					ep->filter_str, false, &filter);
>  		if (ret)
>  			goto error;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
