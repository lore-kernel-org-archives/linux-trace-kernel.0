Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669B330B1C;
	Fri, 17 Oct 2025 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716209; cv=none; b=U+OuOBEVk1Y2/KwqqGoYk42MmCFhT8xmwYNlQjqq8E3kz3tGMIj6kyMfHMbNCxu4QA8aTBhGL1b+UKJntwROP3lNql3Hhv4WTfSlGQtd6m6SARV0q9vQS1tMKc2yt85SYARSH7j4VUjCFzwp+8YeeKe0YkqefoSNjYMSNq/lg+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716209; c=relaxed/simple;
	bh=jyBkPn7FYzEd6F27C6qLmughcW5MQjxOGRkQG7/jx1I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rehwgZyJFrErdrDyDy4JG7SKOmjLD+7f19rV3AdiqxUpLEt9iUQA/TNBRCjdQX9VEME3vl5Cvt9niCki/tg9UK8IpddsUjF+eh+Dt0ZgeqEcbpDdfS4/RGpArkO0smktqLfc9xxOY0f+ReanXi8SsT+5CbMgZ8d0u1QcVp++v9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh6BYeNb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh6BYeNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5F4C4CEE7;
	Fri, 17 Oct 2025 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760716209;
	bh=jyBkPn7FYzEd6F27C6qLmughcW5MQjxOGRkQG7/jx1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oh6BYeNbgxr2X3cpAASPsDzITpdjzfFVEbF6sI1zJLf6SB/YDvqotGSXPfNXLhxgy
	 rhm0B4U0EkjBsKK2c0gmUsNCfernC+WSbOk93ASz2BwirgHMgHbkoTW67meDTEOLAj
	 M7Yivf+kscKpdezIlfKPXeM8N5tzDirtLZHsCrJXeG/AUJWaPU8fCPK8IiFSQPlI97
	 Yd0D/ppF7+4PSxShMGvF1THDcnntHjjPtIXQt4xJJKnHNaQf1irfX4lwShOYvPERUD
	 kWxtIp8IdEZ0ULs8qxyCCOnTJgaJrswsz9KowzpWBvlTwDjgdI0t/Od+JENCdP9SZn
	 JpS6CRJjoGgaA==
Date: Sat, 18 Oct 2025 00:50:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: Allow tracer to add more than 32
 options
Message-Id: <20251018005005.70d998dba256cd57a125d4c9@kernel.org>
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

With enum64, clang 18 caused this error.

In file included from /home/mhiramat/ksrc/linux/kernel/trace/ring_buffer.c:36:
/home/mhiramat/ksrc/linux/kernel/trace/trace.h:1427:1: error: unknown type name 'enum64'; did you mean 'enum'?
 1427 | enum64 trace_iterator_flags { TRACE_FLAGS };
      | ^~~~~~
      | enum

But below (C++11/C23 or clang/gcc extension) passed.

-enum trace_iterator_flags { TRACE_FLAGS };
+enum trace_iterator_flags : uint64_t { TRACE_FLAGS };


So let's use this.

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
