Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD18C6FD19
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 16 Mar 2023 14:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjCPOMF (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 16 Mar 2023 10:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCPOL6 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:11:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13062768C
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B35CBB82165
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Mar 2023 14:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72ABC433EF;
        Thu, 16 Mar 2023 14:11:38 +0000 (UTC)
Date:   Thu, 16 Mar 2023 10:11:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gildong Hong <roaming2man@gmail.com>
Cc:     mhiramat@kernel.org, delyank@fb.com, peterz@infradead.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace/events/sched: Remove unit on printing vruntime
 value
Message-ID: <20230316101137.1739d1e2@gandalf.local.home>
In-Reply-To: <20230316115655.66639-1-roaming2man@gmail.com>
References: <20230316115655.66639-1-roaming2man@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 16 Mar 2023 20:56:55 +0900
Gildong Hong <roaming2man@gmail.com> wrote:

> vruntime is not actual time so remove unit on printing
> 
> Signed-off-by: Gildong Hong <roaming2man@gmail.com>
> ---
>  include/trace/events/sched.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index fbb99a61f714..26ef85a8d3cd 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -511,7 +511,7 @@ DECLARE_EVENT_CLASS(sched_stat_runtime,
>  		__entry->vruntime	= vruntime;
>  	),
>  
> -	TP_printk("comm=%s pid=%d runtime=%Lu [ns] vruntime=%Lu [ns]",
> +	TP_printk("comm=%s pid=%d runtime=%Lu [ns] vruntime=%Lu",

What about calling it "[vns]" for "virtual nanosecond" ?

;-)

-- Steve

>  			__entry->comm, __entry->pid,
>  			(unsigned long long)__entry->runtime,
>  			(unsigned long long)__entry->vruntime)

