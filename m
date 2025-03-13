Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44F267721
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879590; cv=none; b=E5J1BI6llgVgGFE+0TwlaQQXpTgFkMcwH/KurbRtYBXqgnJSYrlvySBtuEyqsj1gQxE3Y3HSgCYwo1PoxUup+MIVmW05ptQWzajLVtt2UGzjXbCscL4qAIYaw2JiCY13LYeWBjhv1EokT50xzPK8UnM4PWR5XpMitOwR3O9x880=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879590; c=relaxed/simple;
	bh=4WBgdtaAJj8lE3RaGeqzvWdUFKuqE8RUa7ClMf26gpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STcSpuJq6ECTs5KZAR41iVeTt8SxWnrEJM0lF/T48ndBupdIBlxVkvrq8Jfg0AgYZbUJkC0Hj9oelJDH487pg89/FQ51Nr8vJJDyQlk8BYf5zn1XdUC3CNNr1dJw/xCzIOP1pYsN8dW2MDIHerbyH3Q2PG5a8rbFJh1IEHez8bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WKml9ICB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WKml9ICB"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-394780e98easo751618f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741879585; x=1742484385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nF8bJCnaqRKgut+9OeE/JCffQQlDqNay3vHyeCfE5bs=;
        b=WKml9ICB7FaXpJH4cA3YIvfe4QB70kFY+7p2iYG1jrQB0JKUFKuRNLtfk6zG6uswS5
         G7M+P8g51AeFhxUib2JyTH6KaX5eBAaMnuEC6835+AMxDQEuhEoMOQh+po9uNWGUW1fg
         INqJLXN45jkowV00fpTaR2TEezRhGUpV7omuuOLygNSXOdFrkqAVD5xaxvFjnA/n0A++
         xc6HibFGpjhyvj7GlUeRFNO5BobzMR2gciTqHkug/SISOOODiNlr6ptgpciZoXdM+EGC
         oHGc88fGm/Ju7fkthEp4X2rDsQQzgRvhmht2C14/DtXOlf1JGfrJRXOsQRZ9ajQXRZhl
         rNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741879585; x=1742484385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nF8bJCnaqRKgut+9OeE/JCffQQlDqNay3vHyeCfE5bs=;
        b=iLyupgbl5ntcW6glpSsO/UyPIsUgnKzu5O7RMTWmbMc5JL+k7AWQpMLJi/LTF7d2Xz
         mNrEdGNeIJrP0ixOVjNmzup2k5osAb7/EOLrPFsxavRowqx6Db1WbHYPPGSw+Hezdn21
         VeM0Zylr1n+Q3m+GksTHOSyHSw45XGgM3dwGMtLRjmtZGltFj5QKradLNOw+BU8l/tGq
         CSUMSabJwguzWqNInwTziiRvh6tVJprkCVXkHArNEeee13olnaj9H/GQoWmlmZzds2g6
         T8P5ibrkLrK4wmGkVIwXf6o3wH75NLIScmRWmaX4i3nHadx0GWtzHubsgFu2yXmqOE88
         sLHg==
X-Forwarded-Encrypted: i=1; AJvYcCU17DGU5nPkUglRxnkg3umbFTNzOPE3QgalQHjPxD2FYhJ6+aYRLq4CcczLjIKPg/obCRIttzapxRrlByPNCBlAmT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUioXhnfege/FwsmpM7us/BnvtFPvKSveOEnhf4NXxwt2lc4Al
	D5an4rYX2Xqsr+EFiDhQMYp+t3/9yqQlKn3Lz3OglvU5asGd0FL0GPWP9JvXrhs=
X-Gm-Gg: ASbGncuwX6RhWUEVuYl+AzkWQmLE89nZFTR1S8beGfBqJnU4uTHJ4zkrFwNyp69lKPX
	62hgDc13CMiQjdGclhGbvBCGZZfhJaV1xQz0yJj9XUMtkq1sSSIyYq69D+KCZbd+IxgLv2wjw9p
	4kLIW8yCa2Qo/3Mm3E6i2XmD3pMsvfPYYyi99ADq0yBIe4akTHHL9qWR0qXg/x1j1NKzX3tBHv4
	A+iRq377gz8WEp3W+ZM1vc0BhxLLeL7VJxiNyh/R4dEgsQ4bpoU8wW4JgB3axMKUV6HG0JRW2Q/
	Y9b23fUc80h8/FYBRYHzRCimCIUUjyKEzU1/ikkqqDnDGny95jM80sAeDg==
X-Google-Smtp-Source: AGHT+IHpEd8Fh94FY1f5OI0QJxvxQUXksTb6Cugi3gcHProMZyWArvioV2LMZr+zyl/u8VvB1ctqyw==
X-Received: by 2002:a5d:5889:0:b0:391:4389:f36a with SMTP id ffacd0b85a97d-3914389f8a9mr17759445f8f.48.1741879584893;
        Thu, 13 Mar 2025 08:26:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df3512sm2584522f8f.12.2025.03.13.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:26:24 -0700 (PDT)
Date: Thu, 13 Mar 2025 16:26:22 +0100
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	linux-mm@kvack.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RESEND][PATCH] tracing: gfp: Remove duplication of recording
 GFP flags
Message-ID: <Z9L5HsVzQ0bVZtjp@pathway.suse.cz>
References: <20250225135611.1942b65c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225135611.1942b65c@gandalf.local.home>

On Tue 2025-02-25 13:56:11, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The gfp_flags when recorded in the trace require being converted from
> their numbers to values. Various macros are used to help facilitate this,
> but there's two sets of macros that need to keep track of the same GFP
> flags to stay in sync.
> 
> Commit 60295b944ff68 ("tracing: gfp: Fix the GFP enum values shown for
> user space tracing tools") added a TRACE_GFP_FLAGS macro that holds the
> enum ___GFP_*_BIT defined bits, and creates the TRACE_DEFINE_ENUM()
> wrapper around them.
> 
> The __def_gfpflag_names() macro creates the mapping of various flags or
> multiple flags to give them human readable names via the __print_flags()
> tracing helper macro.
> 
> As the TRACE_GFP_FLAGS is a subset of the __def_gfpflags_names(), it can
> be used to cover the individual bit names, by redefining the internal
> macro TRACE_GFP_EM():
> 
>   #undef TRACE_GFP_EM
>   #define TRACE_GFP_EM(a) gfpflag_string(__GFP_##a),
> 
> This will remove the bits that are duplicate between the two macros. If a
> new bit is created, only the TRACE_GFP_FLAGS needs to be updated and that
> will also update the __def_gfpflags_names() macro.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Last version: https://lore.kernel.org/20250116214439.046082618@goodmis.org
> 
>   This was originally sent with a patch that fixed the output of gfp flags
>   in trace events to show human readable flags and not hex numbers.
> 
>   This patch on the other hand is a clean up as the there's now two macros
>   that define the bits to print. This makes the one macro use the other
>   macro that is a subset of the first.
> 
>   Can someone in the memory management subsystem either give me an acked-by
>   and I can take this through my tree, or you can just take this through
>   the memory management tree. Either way works for me.
> 
>  include/trace/events/mmflags.h | 41 +++++++++-------------------------
>  1 file changed, 10 insertions(+), 31 deletions(-)
> 
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 72fbfe3caeaf..82371177ef79 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -78,6 +78,13 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
>  
>  #define gfpflag_string(flag) {(__force unsigned long)flag, #flag}
>  
> +/*
> + * For the values that match the bits, use the TRACE_GFP_FLAGS
> + * which will allow any updates to be included automatically.
> + */
> +#undef TRACE_GFP_EM
> +#define TRACE_GFP_EM(a) gfpflag_string(__GFP_##a),
> +
>  #define __def_gfpflag_names			\
>  	gfpflag_string(GFP_TRANSHUGE),		\
>  	gfpflag_string(GFP_TRANSHUGE_LIGHT),	\
> @@ -91,41 +98,13 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
>  	gfpflag_string(GFP_NOIO),		\
>  	gfpflag_string(GFP_NOWAIT),		\
>  	gfpflag_string(GFP_DMA),		\
> -	gfpflag_string(__GFP_HIGHMEM),		\
>  	gfpflag_string(GFP_DMA32),		\
> -	gfpflag_string(__GFP_HIGH),		\
> -	gfpflag_string(__GFP_IO),		\
> -	gfpflag_string(__GFP_FS),		\
> -	gfpflag_string(__GFP_NOWARN),		\
> -	gfpflag_string(__GFP_RETRY_MAYFAIL),	\
> -	gfpflag_string(__GFP_NOFAIL),		\
> -	gfpflag_string(__GFP_NORETRY),		\
> -	gfpflag_string(__GFP_COMP),		\
> -	gfpflag_string(__GFP_ZERO),		\
> -	gfpflag_string(__GFP_NOMEMALLOC),	\
> -	gfpflag_string(__GFP_MEMALLOC),		\
> -	gfpflag_string(__GFP_HARDWALL),		\
> -	gfpflag_string(__GFP_THISNODE),		\
> -	gfpflag_string(__GFP_RECLAIMABLE),	\
> -	gfpflag_string(__GFP_MOVABLE),		\
> -	gfpflag_string(__GFP_ACCOUNT),		\
> -	gfpflag_string(__GFP_WRITE),		\
>  	gfpflag_string(__GFP_RECLAIM),		\
> -	gfpflag_string(__GFP_DIRECT_RECLAIM),	\
> -	gfpflag_string(__GFP_KSWAPD_RECLAIM),	\
> -	gfpflag_string(__GFP_ZEROTAGS)
> -
> -#ifdef CONFIG_KASAN_HW_TAGS
> -#define __def_gfpflag_names_kasan ,			\
> -	gfpflag_string(__GFP_SKIP_ZERO),		\
> -	gfpflag_string(__GFP_SKIP_KASAN)
> -#else
> -#define __def_gfpflag_names_kasan
> -#endif
> +	TRACE_GFP_FLAGS				\
> +	{ 0, "none" }

This causes regression in the printf selftest:

# modprobe test_printf
modprobe: ERROR: could not insert 'test_printf': Invalid argument

# dmesg | tail 
[   46.206779] test_printf: vsnprintf(buf, 256, "%pGg", ...) returned 15, expected 10
[   46.208192] test_printf: vsnprintf(buf, 3, "%pGg", ...) returned 15, expected 10
[   46.208196] test_printf: vsnprintf(buf, 0, "%pGg", ...) returned 15, expected 10
[   46.208199] test_printf: kvasprintf(..., "%pGg", ...) returned 'none|0xfc000000', expected '0xfc000000'
[   46.208202] test_printf: vsnprintf(buf, 256, "%pGg", ...) returned 26, expected 21
[   46.208204] test_printf: vsnprintf(buf, 17, "%pGg", ...) returned 26, expected 21
[   46.208206] test_printf: vsnprintf(buf, 0, "%pGg", ...) returned 26, expected 21
[   46.208209] test_printf: kvasprintf(..., "%pGg", ...) returned '__GFP_HIGH|none|0xfc000000', expected '__GFP_HIGH|0xfc000000'
[   46.208865] test_printf: failed 8 out of 448 tests

    => vprintf() started printing the "none|" string.

It seems to me that "{ 0, "none" }" was added as an "innocent" entry
to avoid the trailing "," generated by TRACE_GFP_FLAGS. So, it is
not really needed.

In fact, I think that it probably causes similar regression in the
trace output because the logic in trace_print_flags_seq()
seems to be the same as in format_flags() in lib/vsprintf.c.

The following worked for me:

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 82371177ef79..15aae955a10b 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -101,7 +101,7 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 	gfpflag_string(GFP_DMA32),		\
 	gfpflag_string(__GFP_RECLAIM),		\
 	TRACE_GFP_FLAGS				\
-	{ 0, "none" }
+	{ 0, NULL }
 
 #define show_gfp_flags(flags)						\
 	(flags) ? __print_flags(flags, "|", __def_gfpflag_names		\

It seems to be safe because the callers end up the cycle when .name == NULL.

I think that it actually allows to remove similar trailing {} but I am not sure
if we want it.

>  
>  #define show_gfp_flags(flags)						\
> -	(flags) ? __print_flags(flags, "|",				\
> -	__def_gfpflag_names __def_gfpflag_names_kasan			\
> +	(flags) ? __print_flags(flags, "|", __def_gfpflag_names		\
>  	) : "none"
>  
>  #ifdef CONFIG_MMU

Best Regards,
Petr
