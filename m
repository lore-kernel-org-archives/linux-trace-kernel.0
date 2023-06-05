Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEFFC7EE24
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  5 Jun 2023 16:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjFEQwy (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 5 Jun 2023 12:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjFEQwx (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:52:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C862E8;
        Mon,  5 Jun 2023 09:52:52 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id ABD8120BCFC0;
        Mon,  5 Jun 2023 09:52:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ABD8120BCFC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685983971;
        bh=WNAcW4ZNKgmMTBdX8dnLj9J/dbA41pDD5x7Q9LxEEFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgGzae1GIuDruLlQYioh1xuNiOBwErEHYDOFjOlyR5lpzdCPdVKnkvIelxKQzIZBz
         4Ymahx5CRkk4fYXxiyS+iBN+boXskz/E/S5czNBNQdQz9pirHfXiNO6bygDWpkpgRb
         qY5LwT3cnWMSHT7oT/syldRQ55qXKa4zKln5DcBA=
Date:   Mon, 5 Jun 2023 09:52:45 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <sunliming@kylinos.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com
Subject: Re: [PATCH V2 1/4] tracing/user_events: Fix the incorrect trace
 record for empty arguments events
Message-ID: <20230605165245.GA140@W11-BEAU-MD.localdomain>
References: <20230605073023.923316-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605073023.923316-1-sunliming@kylinos.cn>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 03:30:20PM +0800, sunliming wrote:
> The user_events support events that has empty arguments. But the trace event
> is discarded and not really committed when the arguments is empty. Fix this
> by not attempting to copy in zero-length data.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---

This series looks good to me, functionally. I applied it locally and ran
this code with the new test additions. Everything works well. Thank you!

The only thing I ask before an ACK is patch 2 and 4 in the series only use
"user_events: " prefix. Can you change these to "selftests/user_events: "?

You marked 3 this way, so I'd like to stick with a consistent form:
I think it would be good going forward we use "tracing/user_events"
for functional changes and "selftests/user_events" for self test
changes.

Thanks,
-Beau

>  kernel/trace/trace_events_user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 0d91dac206ff..698703a3d234 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1399,7 +1399,7 @@ static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
>  	if (unlikely(!entry))
>  		return;
>  
> -	if (unlikely(!copy_nofault(entry + 1, i->count, i)))
> +	if (unlikely(i->count != 0 && !copy_nofault(entry + 1, i->count, i)))
>  		goto discard;
>  
>  	if (!list_empty(&user->validators) &&
> @@ -1440,7 +1440,7 @@ static void user_event_perf(struct user_event *user, struct iov_iter *i,
>  
>  		perf_fetch_caller_regs(regs);
>  
> -		if (unlikely(!copy_nofault(perf_entry + 1, i->count, i)))
> +		if (unlikely(i->count != 0 && !copy_nofault(perf_entry + 1, i->count, i)))
>  			goto discard;
>  
>  		if (!list_empty(&user->validators) &&
> -- 
> 2.25.1
