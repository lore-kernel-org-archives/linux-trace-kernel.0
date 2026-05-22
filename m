Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31AD37F8AC;
	Fri, 22 May 2026 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461103; cv=none; b=on4EIWCi1fv0Xu6Ml2GLcX8dlYyZQyTb2a1f44sp5/j/f++yOZigqYSYNVPn2PVzDYRGkz1ZO2Co3YT/ogKOmTJDdaF3ne+MlUT7OEWvpyVEOBmWhYa5lFcGgXrrgHnf77DFnCVkWIMyha5Xdw2cCESf0ZniwZ6I9clKn6sk4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461103; c=relaxed/simple;
	bh=CdLEo+ax1C9GSpVzhZDopuh9TX3AWdjXHO9wbDfoM6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhiU99M6suYUiOTUEDDnbRPugTCJL6JnQdZOQPewtUSoNytubhjHcWD3OwjJ0svP/BNyi64hqGyJ7xz7ozTl/0L7dJkASbZMZnyJaSiJ9OjzflL9iofbYnvgCf21o/ZMiMi0yNuUL9VqWD4oseZA6WEY92SRDSqwFpzPhfO4eYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6KiomUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6KiomUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0391F000E9;
	Fri, 22 May 2026 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779461100;
	bh=MH216XXgrREg/PBBIQe92jArAeQbIbepqZdPmraWA5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A6KiomUFdxRMqA5XHWbscp/Kx2YUwVdETQWDXYl/GrIA8Dznwo/6TG9TBLhR7mBeO
	 8GWhuERm7oOkVMPMI45Z3OH6GvNvZujbtGes1/kqfY/IWiiBmjxoQa9clNGRrDedUQ
	 MxJmhC0YKXwxyy0VjTDbs18S4nLMPr0ZAJ9xQ5jMKidww79a+xmiKx4kOEMWCO1Knl
	 0Mw1qvUg23vZ7cS6MzAlQaWXgsSDFGIKGcTg3D/JGmOTq/BHfd5WYaS3xYLYaiPgvT
	 0WaPS6+q2O1nXGN2tTwBGS7JZjnVCieNb7jNOF1Mfk9Z5IEM31RF9he957IB+qfUuG
	 bk5XtanY9OOHA==
Date: Fri, 22 May 2026 10:45:21 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20260522104521.74981686@gandalf.local.home>
In-Reply-To: <20260522072322.18aa72dd@gandalf.local.home>
References: <20260521225033.56458336@fedora>
	<20260522072322.18aa72dd@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 07:23:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > @@ -653,6 +686,20 @@ static int parse_btf_arg(char *varname,
> > >  		return -EOPNOTSUPP;
> > >  	}
> > >  
> > > +	if (ctx->flags & TPARG_FL_TEVENT) {
> > > +		int ret;
> > > +
> > > +		ret = parse_trace_event(varname, code, ctx);
> > > +		if (ret < 0)
> > > +			return ret;  
> 
> > When parse_trace_event() returns a negative error code (such as -EINVAL or
> > -ENOENT) because a field name is invalid, the error is propagated back up
> > the stack. Does this path miss calling trace_probe_log_err()? 
> > If so, users might receive a generic failure without context or a caret
> > pointing to the specific syntax error.  
> 
> Hmm, there's a comment in the parse_trace_event() that sets ctx->offset for
> backward compatibility. I'll investigate to see if we can fix that now.

Masami,

I looked at the code for parse_trace_event() that has:

	/* backward compatibility */
	ctx->offset = 0;
	return -EINVAL;

And it was originally introduced by commit 1b8b0cd754cd ("tracing/probes:
Move event parameter fetching code to common parser"), with:

+               ret = parse_trace_event_arg(arg, code, ctx);
+               if (!ret)
+                       return 0;
+               if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
+                       code->op = FETCH_OP_COMM;
+                       return 0;
+               }
+               /* backward compatibility */
+               ctx->offset = 0;
+               goto inval;
+       }
+


What was the reason for the "backward compatibility"? Can we make it a real
error now?

-- Steve
