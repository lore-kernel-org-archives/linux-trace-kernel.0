Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACBAD24;
	Tue, 26 May 2026 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779770601; cv=none; b=s/sTM8+KXFZGrXfD36QyMOctKxrNbm8jP4eA9hkYiQBUI1Yc8ZT8kaXZlwfhYMI6goXcuuaRvlXV2Gm4hQmUYqz3upppyDA9/ogMDXSmG+1HPiqnB4p3XStFIopQVJwgL5CU08Ym811Eakk/pn5E9NvhdbXkHkV1p3fvUbd/Mbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779770601; c=relaxed/simple;
	bh=vBFuHgff7uSONnCwJz1deL+mxSyDfPzKEpR0ztYXsks=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S7H5h9hOO016+3og139B66HsUMHDnHGGT682gk8kYtrx/L+IRphki7qDGJEzSG1J6yAKBHUTRMSGM2YP/kgmsJck2o1uGvFdlRgu1CCitGY1qnX6LWaXPIrtZD5tbv1UPxfkVh/wFiiq+NV0QsfEHTddeeEld4Dt5985DbC+Ptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbqoSvAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbqoSvAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63B31F000E9;
	Tue, 26 May 2026 04:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779770599;
	bh=k72u9KSYp0ChI4YLjIs7OOnXsHAX/wDTag3J+nv7FVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gbqoSvAvP3+CD7LO4GGv5C4LSg0pFkq5MahDkkIGqQ7ZO8KTUbs40R/zfcQIkn7n0
	 p/lE61fSAc+OYeuptOSjv54HtZAs2xiDc9NRRDWXHSjpBradgaLMJmZhFMATdA3XnF
	 Sxuqiwz8dFxHyx77mkTaw17Le5m0186Su843/SkNxDOzpX5+H7bVhPPHd9TEfjHOHK
	 Qp12SLLeL1HWctM4t8aovdki4ZDuUq/RfBuqJBDaS3Iletsi4ppfgeOSDWG0bY2zOa
	 AsCjGscSA5z+zjkSKwqaXDiESFO+or5AFO6UZZHUYewdzfNfmyogM1k6q20tjaUtY0
	 PtkYZHfxoYUJQ==
Date: Tue, 26 May 2026 13:43:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Rosen Penev <rosenp@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org
 (open list:TRACING)
Subject: Re: [PATCHv2] trace: allocate fields with elt struct
Message-Id: <20260526134317.394c1cf3060e89df36662ecc@kernel.org>
In-Reply-To: <20260522212627.12406-1-rosenp@gmail.com>
References: <20260522212627.12406-1-rosenp@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Sashiko made 2 comments.

https://sashiko.dev/#/patchset/20260522212627.12406-1-rosenp%40gmail.com

On Fri, 22 May 2026 14:26:27 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> > diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> > index 0dd7927df22ac..196a7b0be99df 100644
> > --- a/kernel/trace/tracing_map.c
> > +++ b/kernel/trace/tracing_map.c
> [ ... ]
> > @@ -125,32 +125,32 @@ u64 tracing_map_read_var_once(struct tracing_map_elt *elt, unsigned int i)
> [ ... ]
> >  #define DEFINE_TRACING_MAP_CMP_FN(type)					\
> > -static int tracing_map_cmp_##type(void *val_a, void *val_b)		\
> > +static int tracing_map_cmp_##type(const void *val_a, const void *val_b)	\
> >  {									\
> > -	type a = (type)(*(u64 *)val_a);					\
> > -	type b = (type)(*(u64 *)val_b);					\
> > +	type a = (type)(*(const u64 *)val_a);				\
> > +	type b = (type)(*(const u64 *)val_b);				\
> >  									\
> >  	return (a > b) ? 1 : ((a < b) ? -1 : 0);			\
> >  }
> This is a pre-existing issue, but does unconditionally reading 8 bytes
> via the u64 cast cause unaligned access exceptions on architectures that
> do not support them?
> Additionally, for fields near the end of the dynamically allocated elt->key
> buffer, can this trigger KASAN slab-out-of-bounds reads?
> Also, on big-endian architectures, reading a smaller integer as a 64-bit
> value and casting it down extracts the least-significant bytes rather than
> the correct field value. Could this result in completely incorrect sorting
> for small types?

Steve, it seems this comes from your commit 106f41f5a302 ("tracing: Have
the histogram compare functions convert to u64 first").

I think neither of them is a problem, but could you check it?


> > diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
> > index 99c37eeebc161..ed64136782d80 100644
> > --- a/kernel/trace/tracing_map.h
> > +++ b/kernel/trace/tracing_map.h
> [ ... ]
> > @@ -137,11 +137,11 @@ struct tracing_map_field {
> >  
> >  struct tracing_map_elt {
> >  	struct tracing_map		*map;
> > -	struct tracing_map_field	*fields;
> >  	atomic64_t			*vars;
> >  	bool				*var_set;
> >  	void				*key;
> >  	void				*private_data;
> > +	struct tracing_map_field	fields[];
> >  };
>
> Is it safe to add a flexible array member to struct tracing_map_elt when it
> is embedded by value in the middle of struct track_data?
> kernel/trace/trace_events_hist.c:struct track_data {
>     ...
>     struct tracing_map_elt      elt;
>     ...
>     struct action_data          *action_data;
>     struct hist_trigger_data    *hist_data;
> };
> Embedding a struct with a flexible array member in the middle of another
> struct violates C standard constraints. Does this trigger compiler
> warnings (such as -Wflex-array-member-not-at-end on modern compilers) or
> break bounds computations for FORTIFY_SOURCE?

Yeah, from this reason, this is is not acceptable.
To fix this issue, we need to refactor the trace_events_hist.c,
because track_data only uses tracing_map_elt as a placeholder
of private_data.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
