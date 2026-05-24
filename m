Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FFD30F938;
	Sun, 24 May 2026 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779617724; cv=none; b=GhGfEw1tpfnterlcuqMkjD3Q96ICZ+pgmqNqJkFm56JUw4Zn3SP5woJ+pyQlYHlSb1WEd5jCiv/2Z8MmlldoXBK64+Y+DabvVj4ZZWTa57IfIEXx69GSY1JARNqBzlEtgt1K+QnQaHOtelDpBnBRoMy2DngFCfYUktgFdKN4bFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779617724; c=relaxed/simple;
	bh=ms/arPWIOOTRkSginsguKIRZpLfjfA8iJOTacAnh2Yc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=i0u3vvdSA9fpskhTfa/MKlQy5IpfCDeRlrqB42fwW0grM0YpyWJUAUQjqzffAzvPifLywJRVFFKbmYpP6/Sx73FLSAioT4Y3GPReEl9/kLOPQ+z5CDvebCg9aQ7eZf1mkm1Eu+E1u0VzNhzswM4D1IG/YnulEyRZjGrTfq1gGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0/yNEZ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0/yNEZ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8081F000E9;
	Sun, 24 May 2026 10:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779617723;
	bh=n+m/OmufpjuZfpxU6UZkotKhLd6zAExwsNz+Et/h9hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C0/yNEZ0UmgLc7CeilVOntdA4oCFFnbTcmj1nhq/25WtrZ+js7owiqUhWTvBI8N/M
	 OVD3xZ8DZVpGBFBxV1dlrN/K9rVAs5kzWTLdu9y/TDDZ/Xhev43H+YRtUxNVpBHhw+
	 UgJIW7aISGslxUOCgVc/yNf4292lDxqphogXNJHEv33ItR+r8V5/hzlS7HI69X3sCE
	 8Au8K+1dyHL0DDqBzGQPs/U31dktW6s2tT9KbqPdvfnrhep+Q3ulC9mb+PAth9sFhF
	 SJjj0SDnspiFe8oYi321HWwjGoej1USKqsdvk0mFOhZlw+/tK5heOAJ4vU2gt32r+l
	 Kux2PNUjW7Fng==
Date: Sun, 24 May 2026 19:15:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH v6] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-Id: <20260524191516.9e996faed809e87aa0d6c9b6@kernel.org>
In-Reply-To: <20260522104521.74981686@gandalf.local.home>
References: <20260521225033.56458336@fedora>
	<20260522072322.18aa72dd@gandalf.local.home>
	<20260522104521.74981686@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 10:45:21 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> On Fri, 22 May 2026 07:23:22 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > > @@ -653,6 +686,20 @@ static int parse_btf_arg(char *varname,
> > > >  		return -EOPNOTSUPP;
> > > >  	}
> > > >  
> > > > +	if (ctx->flags & TPARG_FL_TEVENT) {
> > > > +		int ret;
> > > > +
> > > > +		ret = parse_trace_event(varname, code, ctx);
> > > > +		if (ret < 0)
> > > > +			return ret;  
> > 
> > > When parse_trace_event() returns a negative error code (such as -EINVAL or
> > > -ENOENT) because a field name is invalid, the error is propagated back up
> > > the stack. Does this path miss calling trace_probe_log_err()? 
> > > If so, users might receive a generic failure without context or a caret
> > > pointing to the specific syntax error.  
> > 
> > Hmm, there's a comment in the parse_trace_event() that sets ctx->offset for
> > backward compatibility. I'll investigate to see if we can fix that now.
> 
> Masami,
> 
> I looked at the code for parse_trace_event() that has:
> 
> 	/* backward compatibility */
> 	ctx->offset = 0;
> 	return -EINVAL;
> 
> And it was originally introduced by commit 1b8b0cd754cd ("tracing/probes:
> Move event parameter fetching code to common parser"), with:
> 
> +               ret = parse_trace_event_arg(arg, code, ctx);
> +               if (!ret)
> +                       return 0;
> +               if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
> +                       code->op = FETCH_OP_COMM;
> +                       return 0;
> +               }
> +               /* backward compatibility */
> +               ctx->offset = 0;
> +               goto inval;
> +       }
> +
> 
> 
> What was the reason for the "backward compatibility"? Can we make it a real
> error now?

This is because a wrong eprobe syntax parser error position indicator.

In tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc:

check_error 'e:foo/bar syscalls/sys_enter_openat arg=^dfd'      # BAD_FETCH_ARG
check_error 'e:foo/bar syscalls/sys_enter_openat ^arg=$foo'     # BAD_ATTACH_ARG

BAD_FETCH_ARG points the fetcharg name correctly, but the
BAD_ATTACH_ARG points wrong place in the test case.
I think we should fix test case. (Previously, since it was
a cleanup, I didn't changed it)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
