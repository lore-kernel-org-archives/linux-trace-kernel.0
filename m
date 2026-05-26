Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601A93655FF;
	Tue, 26 May 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809562; cv=none; b=ovJPyXDWLp+p6JZyBKRxIPjQimG7g5VISIJENT3sySqWuNks140bp1TO16A7o0iZZpV+qCexgdmPE5f2FeEwTK6ewzRN8TOd/sowy5u8JsE4nwi77cMGLP4dTShwkNfBanqhjGE6SYrVgS8RdGNIfkTvjZewpHYYGgGPNGmjv1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809562; c=relaxed/simple;
	bh=/MWcv121K7rZpgbnvEe/lHpKc3LVynobiGS5r2efja0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ht5ag5Y+IHCxkxHmqVu6prO6LHLQD/1O0TAZ/dWRBf1NWJnv54USFmksP77GT4x+D1TmJHA4EcPJCSTyZyBITwg0kvwV6p7iO5pJtSurUIiLs6AeTHftKL6/dWSkm7cR0q3Kv/2Tnh5XRYAt1Zy5IcIwcRF0CoB8f4zqTH1wKvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2Trf2yo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2Trf2yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895931F000E9;
	Tue, 26 May 2026 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809561;
	bh=+Pui1BK3nQ15oA6B6kPC2URJ9IM3q+ur3vvq/E1vcpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K2Trf2yo383PSy8IJ7jmNXJlmPgMgKtjY8kMNf9xKgGaNEhkVi4ivrnoCtFfHV9Ee
	 f1AXcpwNUjvcMnyL7G9lx0Kdxnm4yxfORLm+wS0+OVGtsizswUtdr6fSgNP3OG+ElM
	 R5D4kNAvjhsWuUBIMS9AHuuyvpMUC86oPvkrAvLFNhaqU2IIu/MrAdthdbyRL5DEbe
	 zbetevXXR5WFiqfRdE06Q1Kjk9cSMtye7MpW53fhouUc83BgzUBQj6jXfExI57Vchq
	 t2hoj3BsY4g1KyGdMXSUDnXHfDNINlVstMNGXhNeDs0TBSpuQo/e2NDoHKNykp319P
	 AzbIRSgCoWjiw==
Date: Tue, 26 May 2026 11:33:11 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v6] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260526113311.18d1858e@gandalf.local.home>
In-Reply-To: <20260525235507.a81c565023258c63fc9201f4@kernel.org>
References: <20260521225033.56458336@fedora>
	<20260525235507.a81c565023258c63fc9201f4@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 23:55:07 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 21 May 2026 22:50:33 -0400
> Steven Rostedt <rostedt@kernel.org> wrote:
> 
> > +static int handle_typecast(char *arg, struct fetch_insn **pcode,
> > +			   struct fetch_insn *end,
> > +			   struct traceprobe_parse_context *ctx)
> > +{
> > +	char *tmp;
> > +	int ret;
> > +
> > +	/* Currently this only works for eprobes */
> > +	if (!(ctx->flags & TPARG_FL_TEVENT)) {
> > +		trace_probe_log_err(ctx->offset, TYPECAST_NOT_EVENT);
> > +		return -EINVAL;
> > +	}
> > +
> > +	tmp = strchr(arg, ')');
> > +	if (!tmp) {
> > +		trace_probe_log_err(ctx->offset + strlen(arg),
> > +				    DEREF_OPEN_BRACE);
> > +		return -EINVAL;
> > +	}
> > +	*tmp = '\0';
> > +	ret = query_btf_struct(arg + 1, ctx);
> > +	*tmp = ')';  
> 
> BTW, is there any reason to recover this? The @arg is copied
> string, see traceprobe_parse_probe_arg_body().

Yeah I know. But it's just something I prefer to do to keep code more
robust. That is, don't leave side effects if you can help it. It likely
doesn't matter here, but I've always errored on the side of caution. ;-)

-- Steve

