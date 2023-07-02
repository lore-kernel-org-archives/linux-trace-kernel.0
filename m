Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B54EB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Sun,  2 Jul 2023 01:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjGBBQW (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 1 Jul 2023 21:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGBBQW (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 21:16:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299BC171D;
        Sat,  1 Jul 2023 18:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1DC260B42;
        Sun,  2 Jul 2023 01:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7850EC433C7;
        Sun,  2 Jul 2023 01:16:19 +0000 (UTC)
Date:   Sat, 1 Jul 2023 21:16:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tracing/probes: Fix to exit fetching if an error is
 detected
Message-ID: <20230701211617.401fbbd6@rorschach.local.home>
In-Reply-To: <168804802668.2028538.4634073314317984220.stgit@mhiramat.roam.corp.google.com>
References: <8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain>
        <168804802668.2028538.4634073314317984220.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 29 Jun 2023 23:13:46 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to exit fetching arguments if an error is detected when storing
> strings. Without this fix, if an array is specified with string types
> it may point wrong address to store the data.

  "it may store that data at the wrong address".

> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain/
> Fixes: 9b960a38835f ("tracing: probeevent: Unify fetch_insn processing common part")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_probe_tmpl.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> index 4735c5cb76fa..d6f2bf69f9bc 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -193,6 +193,8 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
>  	default:
>  		return -EILSEQ;
>  	}
> +	if (ret < 0)
> +		return ret;

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

>  	code++;
>  
>  	/* 4th stage: modify stored value if needed */

