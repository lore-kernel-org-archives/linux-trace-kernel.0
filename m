Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125130674D;
	Sat, 30 May 2026 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780156376; cv=none; b=YrV26wmePkkFVMsU/DS0ceFD6oyid8nwkAZBA8ytpIZvCWI1zK7MiH0tvXkOfGnGsQ05Q71Mi79Cow9+z7PgKz7oXJtPmwV4yHEuy1XxWzjyPb+Pit49mufGYVCiKJfrxxS46xXYnICEPAPEemMvz0UxlZSDXQ1OAws9Ym1uEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780156376; c=relaxed/simple;
	bh=vukJ+4Zjzr0X4oLrbkVaZfKQuCllw0Hq3ZeAkTNHsQs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ayRj2ntmtjAD8kOkrBJM5NoJRKLCV/RsPfmhe2DiLgaDTT6iGnDOUTQUarYac6GuUPhLlwKV8C1U5gBZKC7juJGVOfWNYAYO1w9j1b1Hyvlv8bzp6CracLeHAuJBqYkuUd9Jrkfb8V6nsM/dNAv9RiNoBenF3VUjpr4w61YwqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUNRjWuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUNRjWuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC46D1F00893;
	Sat, 30 May 2026 15:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780156375;
	bh=YkITv/EY/RxlE8PTxJYcYDbmRPsAo+git9p7nSVkQyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MUNRjWuLEHI07nlO6+eGyZIbU/XfvT4rhI4w+mkOcLPjw39hRCulIeoIb6Q2cHP4V
	 tmAWEYOjBZaT7FJhgPI6+QipbQ482+ubt/jPScB5nlZS9FGgWn7A0SBwHBEiBMNuiP
	 Tubs1TtWMVO/W1caxur03AfURrwNkqfgOQD7RMk8lS2uqJFi482mcV5h9rF11zq1ik
	 j6Gh0gz+tkqJ+RxCBouOuMX4JJ0d/s/gZgHOxs/jqAzkPCiOqeJb+X0VzYaGjmEz/M
	 V77XV70Be6y6I7Dq45CJ4l0qFkuSVOHsUYUJ8NfE97xrTPNIcC5FKBSVwsIkjsxHEE
	 Qxhyf3Ep4n2lQ==
Date: Sun, 31 May 2026 00:52:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Eva Kurchatova
 <eva.kurchatova@virtuozzo.com>, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, jpoimboe@kernel.org,
 samitolvanen@google.com
Subject: Re: [PATCH] tracing: fix CFI violation in probestub helper
Message-Id: <20260531005250.5523508eaac2110e0708791e@kernel.org>
In-Reply-To: <20260529195134.37d4f5cc@fedora>
References: <20260524154301.21119-1-eva.kurchatova@virtuozzo.com>
	<20260528164902.1bb985f3@gandalf.local.home>
	<20260529200826.GO3493090@noisy.programming.kicks-ass.net>
	<20260529195134.37d4f5cc@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 19:51:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 29 May 2026 22:08:26 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, May 28, 2026 at 04:49:02PM -0400, Steven Rostedt wrote:
> > > On Sun, 24 May 2026 18:43:01 +0300
> > > Eva Kurchatova <eva.kurchatova@virtuozzo.com> wrote:
> > >   
> > > > When multiple callbacks are registered on the same tracepoint, probestub
> > > > will be indirectly called via traceiter helper.
> > > > 
> > > > Pointer to probestub callback resides in __tracepoints section, which is
> > > > excluded from ENDBR checks in objtool. Pointers to regfunc/unregfunc
> > > > callbacks reside in extended structure however, which is not affected.
> > > > 
> > > > Registering multiple callbacks will result in a #CP exception due to
> > > > missed ENDBR in __probestub helper on a CFI-enabled machine.
> > > > 
> > > > Fix this by adding CFI_NOSEAL annotation to probestub declaration.
> > > > 
> > > > Fixes: d5173f753750 ("objtool: Exclude __tracepoints data from ENDBR checks")
> > > > Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>  
> 
> > 
> > The only place the function address lives is in that __tracepoint
> > section. Since that is explicitly excluded by objtool, it figures there
> > are no actual references to __probestub and the function goes on the
> > seal list and the kernel explicitly scribbles the ENDBR on boot.
> > 
> > Then, if it ever gets used on an IBT enabled host, *boom*.
> 
> That makes much more sense.

Ah, I got it.

> 
> > 
> > I agree it would've perhaps been clearer if there was part of a splat in
> > the changelog, but the issue is real afaict.
> > 
> > Also, I do think this:
> > 
> > > > @@ -356,6 +357,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > > >  	void __probestub_##_name(void *__data, proto)			\
> > > >  	{								\
> > > >  	}								\
> > > > +	CFI_NOSEAL(__probestub_##_name);				\
> > > >  	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
> > > >  
> > > >  #define DEFINE_TRACE_FN(_name, _reg, _unreg, _proto, _args)		\  
> > 
> > could do with a comment, explaining why it wants the NOSEAL.
> 
> Yes.
> 
> Thus, the above change log is totally incorrect and should be updated to:
> 
>    tprobes uses a stub function of the tracepoint to allow fprobes to
>    attach to the tracepoint call site and have access to its arguments.
>    The stub function is called __probestub_##_name() and is only
>    referenced as a pointer in the tracepoint structure so that the
>    tprobe can have access to it.
> 
>    The issue is that the probstub function is only referenced in the
>    __tracepoint section and objtool thinks nothing calls it. Since it
>    explicitly excludes the __tracepoint section, objtool thinks there
>    are no callers so it puts the probstub function into the seal list
>    and then the kernel scrubs its ENDBR on boot.
> 
>    This becomes an issue if someone were to use a tprobe which will
>    register the probestub as a callback to the tracepoint so that a
>    fprobe may attach to it and get access to the arguments. Without the
>    ENDBR it will make the kernel go BOOM!
> 
> 
> Then have a comment in the patch with:
> 
>  void __probestub_##_name(void *__data, proto)			\
>  {								\
>  }								\
> +/*								\
> + * The probestub is only used for tprobes and not referenced	\
> + * anywhere else. This causes objtool to think it's not called	\
> + * at all and will add it to the seal list which will remove	\
> + * the ENDBR causing issues if a tprobe is ever used.		\
> + */								\
> +CFI_NOSEAL(__probestub_##_name);				\
>  DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);

This looks good to me. Eva, can you update the patch?

Thanks for fix.

> 
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
