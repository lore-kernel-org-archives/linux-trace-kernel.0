Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755ED2E973C;
	Wed, 19 Nov 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541102; cv=none; b=m2E31ls0QJ2SGLnxg31tPUXHqvgNytim1RMuiYn5ZxmhhebfGIyxBlQWK7u16Mi2k7vLrVOM6R69HMXhwWFkaN8d3XSDbTc069aZNxyqyAYEeG3QeKymG4cprpgxvpuOLYDZeqwScpXXtghfz46e2fD2ux05TmsalsinFoRrsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541102; c=relaxed/simple;
	bh=Dvbqcf9hfganalC/hcvYvlYK1RQeake3mZnp8JYG1Gc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B533Z74Aw3XVMQMN0n8LlYjA5f8xQ9p8+/a0acVnD4g9NMpcGsXsjTxkCyiOMmYaeZu2McYPDz5pyTWuSYM/crYEGJcw6v8q7TQ7cLxO5FJ3JMbMU6WOvZ7ZBFCAjUcBUhmzBZ8rubwjPUIjT0i8UeCqojMSh3nnebJnGc6JU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chAgeaEP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chAgeaEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0A1C19423;
	Wed, 19 Nov 2025 08:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763541101;
	bh=Dvbqcf9hfganalC/hcvYvlYK1RQeake3mZnp8JYG1Gc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=chAgeaEPbwEofU+p+g5W9njohfSVR96Wrlw0MChK0fBEzbBbR5/zA1EkJ86jzs+cB
	 70lbfFV7woSSWsciOUVp25ntCLT2IZaIzC0CqcTOKaV7inkNwZKunY2s74kUE2XzzX
	 Gup3NsZFqaQqrNh4kyhTKnBR4m8wjI3L8WvyP3uF2nPwgXUYqiI0hdPc24ihuATLY8
	 5T4F9v1Dc33d3X3P9P9cc5pzXn5NCpMEr7XaARO7S6IfKWDnMa5ZuHrHk23c/2IU6B
	 p07IT8M37cDPXtSoAyqg7d4sH30Xwa7d+s2Nbof5sSO1+geVrKpDtMTkXSphYq5t5S
	 C5gQ6d07UqU8A==
Date: Wed, 19 Nov 2025 17:31:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Show the tracer options in boot-time
 created instance
Message-Id: <20251119173137.c7e489c079e942eedd48b249@kernel.org>
In-Reply-To: <20251119133942.df3ee2c01ccd40055cf139a4@kernel.org>
References: <176351169375.1795430.7653862896005389480.stgit@mhiramat.tok.corp.google.com>
	<20251119133942.df3ee2c01ccd40055cf139a4@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 13:39:42 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 8ae95800592d..4a6784057855 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -10231,11 +10231,16 @@ static __init int __update_tracer_options(struct trace_array *tr)
> >  	return ret;
> >  }
> >  
> > -static __init void update_tracer_options(struct trace_array *tr)
> > +static __init void update_tracer_options(void)
> >  {
> > +	struct trace_array *tr;
> > +
> >  	guard(mutex)(&trace_types_lock);
> > +
> > +	list_for_each_entry(tr, &ftrace_trace_arrays, list)
> > +		__update_tracer_options(tr);
> > +
> >  	tracer_options_updated = true;

Oops, I misunderstood this flag. This should be set *before* calling
__update_tracer_options(). Not updated.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
