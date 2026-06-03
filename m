Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D114D9913;
	Wed,  3 Jun 2026 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530443; cv=none; b=JBUEM5VIVrTJqNdfZocAAvm70zvctr5rRWN/QK6MnCXkfZRnrRvQbBPWrbia9EWL+H1Atw40X1dBfFUwW04J1DcUkxJxOTj1vocODNHPjpY1SbHkfWBXDrz/CimFnybXUrGvIRiUos+YiTewOr+7ZgaRIByWyjgJj7BIoWx0Pr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530443; c=relaxed/simple;
	bh=AWg95y1yjUZ8C8UucEq2Plpfj3Tuc9SWSSrI7d9ubSo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=adDu0HZG3lGtEdpCbBUAA4H4S87wr59TeXPFcB19jDKnzG6avvHYpMV4hzBG3+wIv6V6ABP7zMet5oIt3ozP53+GFBdbWIA7AAQ2d7ibZ8PzVPLV0df8gVmFQuMMSP5Sioo9r2kBXedpGNQae7hWFgjbmCXSssWeQ+8WcasHBlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAA2co3W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAA2co3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28B91F00893;
	Wed,  3 Jun 2026 23:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780530441;
	bh=9AwB2CLX0l8eK0L6bM09zKZwrdecxyyVUURyJUoGgOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jAA2co3WeuMvSylycCBloN3BtBQpob2WF/vkF8zX0/I/RnrGhlmsL0hugfxFMTSu0
	 be1nAcFv4ZR7tdyj8gD/KBYPIcOJ529SETb2TMs4qXPLspuiiPYPT5Yf8qTvlSZOMG
	 6A35BKisZm1Hcwl15KHMDyAvtkT0G4ZGQlpXrTqq/TxLk1/XFn4VdopLhPKLdxhjtd
	 H9RXYgu8cM/+lDnuhOa/u13Pps2F05Os+Y/iqdkUvHhrrE4/oiFjWyXTRlcwH/sQyh
	 pO0O9+pV5e4g17zbFASFmGrL8kzqU5DKd0l5sK0ASESBKoiVkFAsMMEvJyH5Ogy2G9
	 zbRQo4dqsk3/Q==
Date: Thu, 4 Jun 2026 08:47:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 peterz@infradead.org, jpoimboe@kernel.org, samitolvanen@google.com
Subject: Re: [PATCH v3] tracing: fix CFI violation in probestub test
Message-Id: <20260604084716.99e2be26a21c71d6e4ed8270@kernel.org>
In-Reply-To: <20260603153147.573589-1-eva.kurchatova@virtuozzo.com>
References: <20260603153147.573589-1-eva.kurchatova@virtuozzo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 18:31:42 +0300
Eva Kurchatova <eva.kurchatova@virtuozzo.com> wrote:

> When multiple callbacks are registered on the same tracepoint,
> callbacks will be indirectly called via traceiter helper.
> 
> Pointers to __probestub_* callbacks reside in __tracepoints section,
> which is excluded from ENDBR checks in objtool, causing objtool to
> assume those functions are never indirectly called.
> 
> Registering multiple callbacks using sched_wakeup test will result
> in #CP exception due to missing ENDBR in __probestub_sched_wakeup
> on a CFI-enabled machine.
> 
> Fix this by adding CFI_NOSEAL annotation to probestub declaration.

Thanks for update, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Peter, will you pick this fix because it fixes objtool change?

Thank you,

> 
> Fixes: d5173f753750 ("objtool: Exclude __tracepoints data from ENDBR checks")
> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> ---
>  include/linux/tracepoint.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 763eea4d80d8..2d2b9f8cdda4 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -20,6 +20,7 @@
>  #include <linux/rcupdate_trace.h>
>  #include <linux/tracepoint-defs.h>
>  #include <linux/static_call.h>
> +#include <linux/cfi.h>
>  
>  struct module;
>  struct tracepoint;
> @@ -389,6 +390,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	void __probestub_##_name(void *__data, proto)			\
>  	{								\
>  	}								\
> +	/*								\
> +	 * Annotate the probestub 'CFI_NOSEAL' to stop objtool from	\
> +	 * requesting the kernel remove the ENDBR, because the only	\
> +	 * references to the function are in the __tracepoint section,	\
> +	 * that objtool doesn't scan.					\
> +	 */								\
> +	CFI_NOSEAL(__probestub_##_name);				\
>  	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);	\
>  	DEFINE_RUST_DO_TRACE(_name, TP_PROTO(proto), TP_ARGS(args))
>  
> -- 
> 2.54.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
