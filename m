Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4533711D;
	Fri, 17 Oct 2025 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713294; cv=none; b=bMxFfADfJ6hEQ/FzZ/mtnuecw6lidKQ04RK8gn8CztjjuRdBDaTF5sJdvtimxi++XeAKuCgpeDDcT6bPzrwdEKeJNItq5p6hkqZjZSsRlhUjWXoc7KRjLe/WDqyoGEeqRi1HiJPzieTMnr+fS2p5UChWMpsDSy2m1qidlaKuiuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713294; c=relaxed/simple;
	bh=aVEBdYs0yBYpk4F32BB2Cp2eEoFiHHIVi+K1xfhsNC4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ly+dtWJclteeqPA3ncVN97vjAONwMOOL9CbDIr1mtsqFFcHocB7lLY61aRAzjg4Hjr1nmasQCwk3RLyVoOrfvRddoo1JIkqvSpVhUaU2jJMhU5+bp2tRgCZeQXUjuDbVE2LLTdnj0Qy5HjAdT2rFB0uu8X2szxvb2HHS+zRpC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDZC6Ki9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDZC6Ki9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05109C4CEE7;
	Fri, 17 Oct 2025 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760713294;
	bh=aVEBdYs0yBYpk4F32BB2Cp2eEoFiHHIVi+K1xfhsNC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dDZC6Ki9rOSpqid7v/VEzHihGvvL4VDIsT7VpFPX+Eymfzp3wZNf0VjxY7JuR4fSY
	 IAsxIqSILjYuf44DwymkWFMvGB1c+HUeAZn4Cnks57ajdE+k84kPN8NkH6BFnjlFPl
	 enobg0IJqsGt0NfAipRW2xuqapmldWA5kLwumZqXDyf0zkLZ0NmLPqWE8/p2maJWYs
	 PYzblvP5Hjo2cXLbXaLw3rUPkOAJtMmIqVKyH19nDkbFY4rrq8zY7n2BEVpM++SkYB
	 VIZtYK0LgoTnHav21aJ87aDDt5KEVD+y0ynL1bt3UQXUYfNO4cbCtZmw/CNB9/4LiJ
	 XHymPb4NGBqEg==
Date: Sat, 18 Oct 2025 00:01:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: Allow tracer to add more than 32
 options
Message-Id: <20251018000130.aa69bd5b6670715b1c52d387@kernel.org>
In-Reply-To: <20251015172020.5966beaf@gandalf.local.home>
References: <175918528341.65920.10238038992631012350.stgit@devnote2>
	<175918529300.65920.15856373929947126262.stgit@devnote2>
	<20251015172020.5966beaf@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 17:20:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 30 Sep 2025 07:34:53 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -86,6 +86,11 @@ void __init disable_tracing_selftest(const char *reason)
> >  #define tracing_selftest_disabled	0
> >  #endif
> >  
> > +/* Define TRACE_ITER_* flags. */
> > +#undef C
> > +#define C(a, b) const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
> > +TRACE_FLAGS
> > +
> 
> 
> 
> >  #undef C
> > -#define C(a, b) TRACE_ITER_##a = (1 << TRACE_ITER_##a##_BIT)
> > +#define C(a, b) extern const u64 TRACE_ITER_##a;
> >  
> > -enum trace_iterator_flags { TRACE_FLAGS };
> > +TRACE_FLAGS
> > +#undef C
> 
> Why all this work when this could have been simply fixed with a:
> 
> -enum trace_iterator_flags { TRACE_FLAGS };
> +enum64 trace_iterator_flags { TRACE_FLAGS };
> 
>   ?

I could not find any other enum64 usage, so I doubt it is
available. (Does it depend on compiler?)
It seems C23 standard support it...

> 
> Not to mention, using const u64 requires saving these numbers in an address
> and referencing them, instead of doing it inlined in text. That is, using
> u64 instead of enum64 is both slower and wastes more memory.

Yeah, I expected that the compiler could easily optimize correctly, but
maybe not?

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
