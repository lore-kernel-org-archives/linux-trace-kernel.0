Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B37EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  6 Jul 2023 16:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjGFQJZ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 6 Jul 2023 12:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGFQJY (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33FB9D;
        Thu,  6 Jul 2023 09:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 400E260ECB;
        Thu,  6 Jul 2023 16:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A4EC433C7;
        Thu,  6 Jul 2023 16:09:20 +0000 (UTC)
Date:   Thu, 6 Jul 2023 12:09:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Ze Gao <zegao@tencent.com>, Yafang <laoar.shao@gmail.com>
Subject: Re: [PATCH v2] fprobe: add unlock to match a succeeded
 ftrace_test_recursion_trylock
Message-ID: <20230706120916.3c6abf15@gandalf.local.home>
In-Reply-To: <20230703092336.268371-1-zegao@tencent.com>
References: <20230703092336.268371-1-zegao@tencent.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon,  3 Jul 2023 17:23:36 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> Unlock ftrace recursion lock when fprobe_kprobe_handler() is failed
> because of some running kprobe.
> 
> Fixes: 3cc4e2c5fbae ("fprobe: make fprobe_kprobe_handler recursion free")
> Reported-by: Yafang <laoar.shao@gmail.com>
> Closes: https://lore.kernel.org/linux-trace-kernel/CALOAHbC6UpfFOOibdDiC7xFc5YFUgZnk3MZ=3Ny6we=AcrNbew@mail.gmail.com/
> Signed-off-by: Ze Gao <zegao@tencent.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

> ---
>  kernel/trace/fprobe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 18d36842faf5..93b3e361bb97 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -102,12 +102,14 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
>  
>  	if (unlikely(kprobe_running())) {

Off topic for this patch, but Masami, what's the purpose of not calling the
fprobe when a kprobe is running? Does that mean it has probed another kprobe?

Probably could add a comment here to explain the issue.

-- Steve


>  		fp->nmissed++;
> -		return;
> +		goto recursion_unlock;
>  	}
>  
>  	kprobe_busy_begin();
>  	__fprobe_handler(ip, parent_ip, ops, fregs);
>  	kprobe_busy_end();
> +
> +recursion_unlock:
>  	ftrace_test_recursion_unlock(bit);
>  }
>  

