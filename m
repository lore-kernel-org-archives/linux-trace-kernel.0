Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1C3EB64D7
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 16 Jun 2023 16:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjFPQIx (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 16 Jun 2023 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFPQIw (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:08:52 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 320602132;
        Fri, 16 Jun 2023 09:08:51 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6925A20FF4EB;
        Fri, 16 Jun 2023 09:08:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6925A20FF4EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686931730;
        bh=Edk+Pe6dwWUZBN6lSPEQX7bkpxex/hiXHOA1uOpPkwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5LoPW3oKOYnFRFodgCb2JIWTgMcTLH+kzuuAzQFIzAoYif9rLOtJ69ZTYldyOOu2
         eSIbQFTVEF5xrcRPAqPP2/GT6JBqSv3a+FPtKZOQZlX4PdgzyiYAkyQnCGrfOlRZTA
         NtAGF2gtuCz/14xwYnf34enPt5hm3fLTvm1t6ms0=
Date:   Fri, 16 Jun 2023 09:08:45 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <sunliming@kylinos.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com
Subject: Re: [PATCH v2 1/3] tracing/user_events: Fix incorrect return value
 for writing operation when events are disabled
Message-ID: <20230616160845.GA88@W11-BEAU-MD.localdomain>
References: <20230609030302.1278716-1-sunliming@kylinos.cn>
 <20230609030302.1278716-2-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609030302.1278716-2-sunliming@kylinos.cn>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 11:03:00AM +0800, sunliming wrote:
> The writing operation return the count of writes whether events are
> enabled or disabled. This is incorrect when events are disabled. Fix
> this by just return -ENOENT when events are disabled.
> 

When testing this patch locally I found that we would occasionally get
-ENOENT when events were enabled, but then become disabled, since writes
do not have any locking around the tracepoint checks for performance
reasons.

I've asked a few peers of mine their thoughts on this, whether an error
should result when there are no enabled events. The consensus I've heard
back is that they would not consider this case an actual error, just as
writing to /dev/null does not actually return an error.

However, if you feel strongly we need this and have a good use case, it
seems better to enable this logic behind a flag instead of having it
default based on my conversations with others.

Thanks,
-Beau

> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  kernel/trace/trace_events_user.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 1ac5ba5685ed..92204bbe79da 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1957,7 +1957,8 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
>  
>  		if (unlikely(faulted))
>  			return -EFAULT;
> -	}
> +	} else
> +		return -ENOENT;
>  
>  	return ret;
>  }
> -- 
> 2.25.1
