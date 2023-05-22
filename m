Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF8C7EE2D
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 22 May 2023 14:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjEVOc3 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 22 May 2023 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjEVOc2 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:32:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D5399;
        Mon, 22 May 2023 07:32:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83940613F7;
        Mon, 22 May 2023 14:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AB2C433EF;
        Mon, 22 May 2023 14:32:26 +0000 (UTC)
Date:   Mon, 22 May 2023 10:32:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [PATCH] racing/user_events: Prevent same address and bit per
 process
Message-ID: <20230522103224.032ec78f@rorschach.local.home>
In-Reply-To: <20230519081035.228891-1-sunliming@kylinos.cn>
References: <20230519081035.228891-1-sunliming@kylinos.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org


Is the subject a Freudian slip?

Added Beau. I need to add him to the maintainers file for user events ;-)

On Fri, 19 May 2023 16:10:35 +0800
sunliming <sunliming@kylinos.cn> wrote:

> User processes register name_args for events. If the same name are registered
> multiple times in the same process, it can cause undefined behavior. Because
> the same name may be used for a diffrent event. If this event has the same
> format as the original event, it is impossible to distinguish the trace output
> of these two events. If the event has a different format from the original event,
> the trace output of the new event is incorrect.
> 
> Return EADDRINUSE back to the user process if the same event has being registered
> in the same process.

I'll let Beau ack this or not.

-- Steve

> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  kernel/trace/trace_events_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index b1ecd7677642..4ef6bdb5c07c 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1996,7 +1996,7 @@ static int user_events_ref_add(struct user_event_file_info *info,
>  
>  		for (i = 0; i < count; ++i)
>  			if (refs->events[i] == user)
> -				return i;
> +				return -EADDRINUSE;
>  	}
>  
>  	size = struct_size(refs, events, count + 1);

