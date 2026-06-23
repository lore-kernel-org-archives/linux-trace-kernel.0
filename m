Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB19A3CBE7A;
	Tue, 23 Jun 2026 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202975; cv=none; b=qS6czt6KRPGZ5x4jmB22s7nCGaAKxbBWKdx1n0QDxOd90nApFVUqDZbB6EYikocFAUm91adWGgoCOoobSIuomeN7GOnSFRGc4nys/7qRPOvnf3lfBWrNCB8m7JtOh6HwVbCSRGvfXF25xZPuTRU7bT2XCrnYa64XSsxaJw2abSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202975; c=relaxed/simple;
	bh=KRFBlUVQa6TpullfHyT4kAvqgjwMUpzUbeEMUDYaCTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSu/FXCbaZp6JH3DkddlpzgnvH4ZHUIICAiqbMtOigJMa6cXzp4+/Y28KnS9fP6ZkcL4GtW48jlY87cmTeZBqD5EOtQqlziafqXKUq1BvLcqdmJpTDpoZR504Asd6U3L4wEfC2aLpjrY1X4xrvjdvK0HiOcvaMMHUwfkM6LiBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2JAYOg5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2JAYOg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFA11F000E9;
	Tue, 23 Jun 2026 08:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782202974;
	bh=JudsckoAG3uJVaQQckyuM6W+j0dJo5mYMjHxT3gN3Cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F2JAYOg5PCZItFoUMI4ZEpoUiIETawwv3iZJhROzRhzDqu/8w4hQ8dV2uCZGbaoaE
	 a+NdKJKfccgOtPl5CJaGzcdIz/n5nz10VSVum0QVKyn1RcP2uhkO4CA3jpT8UqRGYr
	 Q5QFYCscM2yNAFFY3mAPbawccThWnDLq5J6ReiAwNuj8t2PKB27Xfhd7YJV4MDvtRb
	 c0WtYXhBPbDDJTItBGq9l8EAQfGY8jeAxKcJl/J5gu9f8DvRxPjvUNuJozGmXTrFL+
	 ISqiWzNp5gqo1xECOzhkYtcH2O4OoyUFwBdvF7MxgePy1x6F+EUZdsDE9jBBx4g+/I
	 emERVY4IgsyiA==
Date: Tue, 23 Jun 2026 04:22:48 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v2 1/2] tracing: Move non-trace_printk prototypes into
 trace_controls.h
Message-ID: <20260623042248.7e564b70@fedora>
In-Reply-To: <ajk7fN5v31kCfGVp@yury>
References: <20260622130739.375198646@kernel.org>
	<20260622131029.655382134@kernel.org>
	<ajk7fN5v31kCfGVp@yury>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 09:41:16 -0400
Yury Norov <yury.norov@gmail.com> wrote:

> > +void trace_dump_stack(int skip);  
> 
> The function description says:
> 
>   record a stack back trace in the trace buffer
> 
> So, to me it sounds like it should go to the trace_printk.h.

The main reason I don't want these in trace_printk.h is because they
are not the same as trace_printk(). These are usually called when
things go wrong, and are usually called along with tracing_off(), to
stop the trace to make sure you don't lose the trace of the bug that
triggered the dump.

These can also be in production with no problem, as they are triggered
when things go wrong. trace_printk() should *not* be used in production.

The uses of these are fundamentally different than the use of
trace_printk(). They are not just for development environments.

I'll update the change log to note this.

-- Steve
