Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ADBEB64D7
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 26 Jun 2023 06:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjFZGPl (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 26 Jun 2023 02:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjFZGPi (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:15:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBAF4;
        Sun, 25 Jun 2023 23:15:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC45D60C8C;
        Mon, 26 Jun 2023 06:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6963DC433C8;
        Mon, 26 Jun 2023 06:15:34 +0000 (UTC)
Date:   Mon, 26 Jun 2023 02:15:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     mhiramat@kernel.org, beaub@linux.microsoft.com,
        kelulanainsley@gmail.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 1/3] tracing/user_events: Fix incorrect return value
 for writing operation when events are disable
Message-ID: <20230626021530.26603164@rorschach.local.home>
In-Reply-To: <20230621060827.151564-2-sunliming@kylinos.cn>
References: <20230621060827.151564-1-sunliming@kylinos.cn>
        <20230621060827.151564-2-sunliming@kylinos.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 21 Jun 2023 14:08:24 +0800
sunliming <sunliming@kylinos.cn> wrote:

> The writing operation return the count of writes regardless of whether events
> are enabled or disabled. Switch it to return 0 to indicates that the event
> is disabled.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  kernel/trace/trace_events_user.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 1ac5ba5685ed..c085ff829a58 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1957,7 +1957,8 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
>  
>  		if (unlikely(faulted))
>  			return -EFAULT;
> -	}
> +	} else
> +		return 0;
>  

sunliming,

If you missed the conversation about the pull request with Linus, he
pointed out (correctly) that we were mistaken to tell you to return
zero. It should return an error if the ring buffer is disabled.

But instead of returning -EFAULT, let's follow the behavior of
trace_marker and return -EBADF. This way user space has a better idea
why it failed.

Care to send another update?

Thanks!

-- Steve


>  	return ret;
>  }

