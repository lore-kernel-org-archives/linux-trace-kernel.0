Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014E3CB2E0;
	Tue,  2 Jun 2026 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410793; cv=none; b=U5aCb+UOlPxXkhEE07ERWEF7fAkxWEOIq54R+/oeX5E3ntILLUcJFlbF4UCrX+PvowxO09MY32PBim/D8lJ6aUZWJlx0oDSnlbc5B2BL3NQNi9Nm/MxC/woLIa2fkoxuhnrcu93siZPj9ockVBBfHVsbSNDl25z2zcp09S/EMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410793; c=relaxed/simple;
	bh=atjr+7aeHzW2hutcA0wG1nJ1+Co2TZbYJ/4/OqbjXeE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o13yTM1ZXNJBpLtbkq4XkKspCZuqKCfPI58REkp1IK2EKia0sBTtZ93DAzSxAbiiu5i0d2+kaxke6Ql46k5OxgJuqp+m2A4Xd6QH87tT3otXlI0RfiwMB6WGOrG/Mw8oblIbQ48xS6JpwvcjfPWed/aXKbqZYsscxIMY1tX61rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6wkY8Dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6wkY8Dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C021F00893;
	Tue,  2 Jun 2026 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780410791;
	bh=hVZ0oov0yHtpz2hGsM6y+7qEk+o8pGDLXvj+G92IoAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W6wkY8DpRKNob0Z/tH9xZcboc+J/mScc/fI+4qaL8D97MosIExeYYvSUjAcfoOweP
	 pKIqmm9CCKXSE/za2WLlcSiA7MeZRRFzN2xBcismZ4yFujBi3imAA+E17NZL9RJmsi
	 nSLfODU5ttVH3aAyZyld3iD9KjUp0NSNOZ0Km2gKHZ0kZ2WVCevZ7H7byBNh6HBreH
	 ONs6YDEIZ4YIXB//y9BBz7EKmtscuKlzZUacXLV2OprC77Cq5NXCiNuFare/quB+OL
	 /HRc7gucbvim1yLWZTp1ttdxKnQRJ0s6R9uwsR7kfYQEslAX5a3qWIQRMMRGR63ZwH
	 19/NeNvUo6fVA==
Date: Tue, 2 Jun 2026 23:33:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 peterz@infradead.org, jpoimboe@kernel.org, samitolvanen@google.com
Subject: Re: [PATCH v2] tracing: fix CFI violation in probestub test
Message-Id: <20260602233307.787a539d9c5cb5015368ff7c@kernel.org>
In-Reply-To: <20260602135425.542073-1-eva.kurchatova@virtuozzo.com>
References: <20260602135425.542073-1-eva.kurchatova@virtuozzo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jun 2026 16:54:08 +0300
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
> 

Thanks, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Fixes: d5173f753750 ("objtool: Exclude __tracepoints data from ENDBR checks")
> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> ---
>  include/linux/tracepoint.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 763eea4d80d8..38e9f49a71b7 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -20,6 +20,7 @@
>  #include <linux/rcupdate_trace.h>
>  #include <linux/tracepoint-defs.h>
>  #include <linux/static_call.h>
> +#include <asm/cfi.h>
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
