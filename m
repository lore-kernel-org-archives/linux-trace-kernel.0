Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245B6C001DE
	for <linux-trace-kernel@archiver.kernel.org>; Sun, 23 Jul 2023 15:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjGWPNE (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 23 Jul 2023 11:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGWPND (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 11:13:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FBAB;
        Sun, 23 Jul 2023 08:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9A2960D56;
        Sun, 23 Jul 2023 15:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D25BC433C7;
        Sun, 23 Jul 2023 15:13:00 +0000 (UTC)
Date:   Sun, 23 Jul 2023 11:12:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     sunran001@208suo.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] include: events: remove spaces after '(' and before ')'
Message-ID: <20230723111258.4e72787a@gandalf.local.home>
In-Reply-To: <7d6b48368594b2f815dff7c5375be638@208suo.com>
References: <20230719030939.18448-1-xujianghui@cdjrlc.com>
        <7d6b48368594b2f815dff7c5375be638@208suo.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 19 Jul 2023 11:21:03 +0800
sunran001@208suo.com wrote:

> Fix four occurrences of the checkpatch error:
> 
> ERROR: space prohibited after that open parenthesis '('
> ERROR: space prohibited before that close parenthesis ')'
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   include/trace/events/nmi.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/nmi.h b/include/trace/events/nmi.h
> index 18e0411398ba..99abd0bc8ebd 100644
> --- a/include/trace/events/nmi.h
> +++ b/include/trace/events/nmi.h
> @@ -15,9 +15,9 @@ TRACE_EVENT(nmi_handler,
>   	TP_ARGS(handler, delta_ns, handled),
> 
>   	TP_STRUCT__entry(
> -		__field(	void *,		handler	)
> -		__field(	s64,		delta_ns)
> -		__field(	int,		handled	)
> +		__field(void *,	handler)
> +		__field(s64, delta_ns)
> +		__field(int, handled)

NACK!

Which version looks better?

checkpatch.pl fails horribly on TRACE_EVENT macros. DON'T MODIFY THEM!

-- Steve

>   	),
> 
>   	TP_fast_assign(

