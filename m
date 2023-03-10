Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B68C6FD19
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 10 Mar 2023 23:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCJXZu (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 10 Mar 2023 18:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjCJXZt (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:25:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B820916336;
        Fri, 10 Mar 2023 15:25:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3724B8244C;
        Fri, 10 Mar 2023 23:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A1DC4339B;
        Fri, 10 Mar 2023 23:25:43 +0000 (UTC)
Date:   Fri, 10 Mar 2023 18:25:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH] mm: mmap: remove newline at the end of the trace
Message-ID: <20230310182542.695e9933@gandalf.local.home>
In-Reply-To: <ZAu6qDsNPmk82UjV@minwoo-desktop>
References: <ZAu6qDsNPmk82UjV@minwoo-desktop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, 11 Mar 2023 08:18:00 +0900
Minwoo Im <minwoo.im.dev@gmail.com> wrote:

> We already have newline in TP_printk so remove the redundant newline
> character at the end of the mmap trace.
> 
> <...>-345     [006] .....    95.589290: exit_mmap: mt_mod ...
> 
> <...>-345     [006] .....    95.589413: vm_unmapped_area: addr=...
> 
> <...>-345     [006] .....    95.589571: vm_unmapped_area: addr=...
> 
> <...>-345     [006] .....    95.589606: vm_unmapped_area: addr=...
> 
> to
> 
> <...>-336     [006] .....    44.762506: exit_mmap: mt_mod ...
> <...>-336     [006] .....    44.762654: vm_unmapped_area: addr=...
> <...>-336     [006] .....    44.762794: vm_unmapped_area: addr=...
> <...>-336     [006] .....    44.762835: vm_unmapped_area: addr=...
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>

This should go through the mm folks.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  include/trace/events/mmap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
> index 216de5f03621..f8d61485de16 100644
> --- a/include/trace/events/mmap.h
> +++ b/include/trace/events/mmap.h
> @@ -35,7 +35,7 @@ TRACE_EVENT(vm_unmapped_area,
>  		__entry->align_offset = info->align_offset;
>  	),
>  
> -	TP_printk("addr=0x%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",
> +	TP_printk("addr=0x%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx",
>  		IS_ERR_VALUE(__entry->addr) ? 0 : __entry->addr,
>  		IS_ERR_VALUE(__entry->addr) ? __entry->addr : 0,
>  		__entry->total_vm, __entry->flags, __entry->length,
> @@ -110,7 +110,7 @@ TRACE_EVENT(exit_mmap,
>  		       __entry->mt		= &mm->mm_mt;
>  	),
>  
> -	TP_printk("mt_mod %p, DESTROY\n",
> +	TP_printk("mt_mod %p, DESTROY",
>  		  __entry->mt
>  	)
>  );

