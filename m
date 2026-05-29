Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D033D6F7;
	Fri, 29 May 2026 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085314; cv=none; b=eAVvOc1wCko1HZHR+ZyGpny29A5jdJ+OhqganInBVUaxd7nqnFxVA/8EBZyQDMHbLMfmWc5YfA57enxrhqCJ7GJv0a3KdCtqiMfxVvnN2A2d4QIxRkEJp5UlBhn60F/oPESuJ5ZeYmYixTzfRwynxPKWxt5ZqDuL3ROg8fX9NVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085314; c=relaxed/simple;
	bh=8yTzywkVYIVQ2e6jf4JJfKkc2oUU+zRzaF2ILh3+Nzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYco75QxQ2uSqLS0TfBSN8VOjMDzFtiuyfVBzw7vJxHNHpOu1NpIEaeYHSEYyu2t02/uRsYDMLvRrRHuavwO3aea0/fNEAYrgxdCnKfuxyW8ywBABQYj+0DjzbLKS3esvBmTw21ws1YO6Lg/vkEn9L/vDcLQdKar5afdITkOK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DvrNbWKP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DvrNbWKP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9+0X7pgG21cO8nq3m1Osdu61um1VtlXwcQJItq5FGeI=; b=DvrNbWKP8Y+LV8yfVfod2nhqwB
	3KkhooLiHp9VTr80L+bUZv2pinsagnULV9FX0v3a/fHPsF2dkbvjd5U9GLICa8u+uonhXiYR0f/4M
	P0cyFR6H9MxeT995hc4B7AkGNnfbhGPpJhNi+coduDufQby052woY/ORvea1dqDpTgMybvEWQdZ/V
	mvosBWuZJ2xxLCG9VDsZuLuWhvnZdTybxEBxjzX5Sr9MTkwy/Ff/m7Z47AJ1pPZ51ynkfb2+RvVAU
	Sp6WqaVF7SlFsMHfppX/UYa48zVFs5gx91D/R2U8eLbYqKzGg6W22qLOuI9M9kIKifp1Sv96nvuP9
	b6PcgW6Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT3VL-00000006irN-2cMM;
	Fri, 29 May 2026 20:08:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6AE1F3003DE; Fri, 29 May 2026 22:08:26 +0200 (CEST)
Date: Fri, 29 May 2026 22:08:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Eva Kurchatova <eva.kurchatova@virtuozzo.com>, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, jpoimboe@kernel.org,
	samitolvanen@google.com
Subject: Re: [PATCH] tracing: fix CFI violation in probestub helper
Message-ID: <20260529200826.GO3493090@noisy.programming.kicks-ass.net>
References: <20260524154301.21119-1-eva.kurchatova@virtuozzo.com>
 <20260528164902.1bb985f3@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528164902.1bb985f3@gandalf.local.home>

On Thu, May 28, 2026 at 04:49:02PM -0400, Steven Rostedt wrote:
> On Sun, 24 May 2026 18:43:01 +0300
> Eva Kurchatova <eva.kurchatova@virtuozzo.com> wrote:
> 
> > When multiple callbacks are registered on the same tracepoint, probestub
> > will be indirectly called via traceiter helper.
> > 
> > Pointer to probestub callback resides in __tracepoints section, which is
> > excluded from ENDBR checks in objtool. Pointers to regfunc/unregfunc
> > callbacks reside in extended structure however, which is not affected.
> > 
> > Registering multiple callbacks will result in a #CP exception due to
> > missed ENDBR in __probestub helper on a CFI-enabled machine.
> > 
> > Fix this by adding CFI_NOSEAL annotation to probestub declaration.
> > 
> > Fixes: d5173f753750 ("objtool: Exclude __tracepoints data from ENDBR checks")
> > Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> 
> Wait! The probestub is not in the __tracepoints section. At least it
> shouldn't be. Are you sure there's not another issue here?
> 
> #define __DEFINE_TRACE_EXT(_name, _ext, proto, args)			\
> 	static const char __tpstrtab_##_name[]				\
> 	__section("__tracepoints_strings") = #_name;			\
> 	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
> 	int __traceiter_##_name(void *__data, proto);			\
> 	void __probestub_##_name(void *__data, proto);			\
> 	struct tracepoint __tracepoint_##_name	__used			\
> 	__section("__tracepoints") = {					\
> 
>  Here the structure __tracepoint_##name is in the __tracepoints section.
> 
> 		.name = __tpstrtab_##_name,				\
> 		.key = STATIC_KEY_FALSE_INIT,				\
> 		.static_call_key = &STATIC_CALL_KEY(tp_func_##_name),	\
> 		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
> 		.iterator = &__traceiter_##_name,			\
> 		.probestub = &__probestub_##_name,			\

                    ^^^^^^^^^^ this

> 		.funcs = NULL,						\
> 		.ext = _ext,						\
> 	};								\
> 	__TRACEPOINT_ENTRY(_name);					\
> 	int __traceiter_##_name(void *__data, proto)			\
> 	{								\
> 		struct tracepoint_func *it_func_ptr;			\
> 		void *it_func;						\
> 									\
> 		it_func_ptr =						\
> 			rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
> 		if (it_func_ptr) {					\
> 			do {						\
> 				it_func = READ_ONCE((it_func_ptr)->func); \
> 				__data = (it_func_ptr)->data;		\
> 				((void(*)(void *, proto))(it_func))(__data, args); \
> 			} while ((++it_func_ptr)->func);		\
> 		}							\
> 		return 0;						\
> 	}								\
> 	void __probestub_##_name(void *__data, proto)			\
> 	{								\
> 	}
> 
> But above, probestub is just a function defined wherever the tracepoint is
> created.
> 
> In fact, it's just there for fprobes to work. It doesn't get called if you
> add more than one callback to the tracepoint. So your explanation is totally
> bogus.

The only place the function address lives is in that __tracepoint
section. Since that is explicitly excluded by objtool, it figures there
are no actual references to __probestub and the function goes on the
seal list and the kernel explicitly scribbles the ENDBR on boot.

Then, if it ever gets used on an IBT enabled host, *boom*.

I agree it would've perhaps been clearer if there was part of a splat in
the changelog, but the issue is real afaict.

Also, I do think this:

> > @@ -356,6 +357,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >  	void __probestub_##_name(void *__data, proto)			\
> >  	{								\
> >  	}								\
> > +	CFI_NOSEAL(__probestub_##_name);				\
> >  	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
> >  
> >  #define DEFINE_TRACE_FN(_name, _reg, _unreg, _proto, _args)		\

could do with a comment, explaining why it wants the NOSEAL.
