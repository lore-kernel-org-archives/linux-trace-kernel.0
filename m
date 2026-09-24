Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E3F1AAE17;
	Thu, 24 Sep 2026 01:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790211823; cv=none; b=hB1KZ07Irsp1HzoKdtLi2+kmGKGXOh0LEXbd9dqeAt7ciBhygBvWXjUCFOG1nA4vOofyRbm0kkroNYvGy2Cd/GymsQQ9cdJI2W3Kw00/M7XSld6l8iptheskiDUcLvGgo51BAdRFkSWKoZUU1aVsNLSf+qHguRk2BmVb+9K5KE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790211823; c=relaxed/simple;
	bh=Pnc2eG5KpssQK71R6RJZ0Z1lN5ASTvc+bbXex7x/P0o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AyJIawEA9pGDnN3Acbb3RU9BkioQXMv4iaXmQoJ6u9Yidh37XOTsckLCUzGe3/2RVPYhS1UjOnamJMXgvbY4h9kKU65n97rJWLu+Hb79L2meZkQqHjZfi+ngcsF++Am0Mj+6q2QtCTCqpsP4dsAL26SK81hWfDV/q2EyJSDWbPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZe3yRnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZe3yRnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8B71F000FF;
	Thu, 24 Sep 2026 01:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790211821;
	bh=471CiwhaDOmAQt1rc5Q/KApp2ZszpOYdGXO9pnQREjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iZe3yRnTS/wlCZfYNfZwHHnK8yERscMeX2N0nv1rd1r2iwJy5a1M0ZiKER6JEuccO
	 tCfbRsWcHVudipaGvqaV8/vZ+FUjphX1cI6MYhPgTMn2SW3qtiCgpOVH9xNc/TIVmi
	 24c8YcKi5MEsSge3aYREqfT0cuVviO/5uxE2A4xp0onOqnMLC+X2uvzn/HO3FAY7CA
	 lUnH/q1u4uBkD4cH0jww1GghIVG9CX4P4fhSw2Gc9Cy4ib4lHPHnxYq+jayH9Xj1TN
	 yniiMl2sr3FEB6fGnH4Sx4/gWxAehLsjyC1C859VZKCLgR7DHpozkkdr5DaPRWUKnN
	 89YBOowa8nu7A==
Date: Thu, 24 Sep 2026 10:03:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Add a MAINTAINERS category specific for
 the tracing ring-buffer
Message-Id: <20260924100337.a138c4f2c4e87d6ddbfe0d07@kernel.org>
In-Reply-To: <20260910155058.1ac4c991@gandalf.local.home>
References: <20260908094035.0b180833@gandalf.local.home>
	<20260910155058.1ac4c991@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 15:50:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Masami,
> 
> Can I get an official Acked-by on this?
> 
> Vincent, you can also give an Acked-by too.

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> -- Steve
> 
> 
> On Tue, 8 Sep 2026 09:40:35 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > The ring buffer code in the tracing directory has always been decoupled
> > from the tracing code. It had a clean abstracted API to allow it to be
> > used by systems outside of tracing. The API even allowed the ring buffer
> > code to be drastically changed without affecting the tracing sub-system.
> > 
> > Recently, Vincent Donnefort has been contributing a lot of work to enhance
> > the ring buffer. He implemented the user space mappings and recently
> > created a version to allow pKVM hypervisors to use the code to trace
> > the hypervisor and expose the events to the user.
> > 
> > Create a separate category for maintaining the ring buffer code so that
> > Vincent can become an official maintainer of it. His work has little to do
> > with the tracing code itself. In the future, he may even be the main
> > maintainer of the ring buffer.
> > 
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > ---
> >  MAINTAINERS | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3a19da74d00c..71bd2f57055d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -27778,6 +27778,22 @@ F:	kernel/trace/trace_irqsoff.c
> >  F:	kernel/trace/trace_osnoise.c
> >  F:	kernel/trace/trace_sched_wakeup.c
> >  
> > +TRACING RING BUFFER
> > +M:	Steven Rostedt <rostedt@goodmis.org>
> > +M:	Vincent Donnefort <vdonnefort@google.com>
> > +M:	Masami Hiramatsu <mhiramat@kernel.org>
> > +L:	linux-kernel@vger.kernel.org
> > +L:	linux-trace-kernel@vger.kernel.org
> > +S:	Maintained
> > +Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> > +F:	Documentation/trace/ring-buffer*
> > +F:	Documentation/trace/remotes.rst
> > +F:	include/linux/ring-buffer*.h
> > +F:	kernel/trace/*ring_buffer*.c
> > +F:	kernel/trace/remote*.c
> > +F:	tools/testing/selftests/ring-buffer/
> > +
> >  TRADITIONAL CHINESE DOCUMENTATION
> >  M:	Chen-Yu Yeh <chenyou910331@gmail.com>
> >  M:	Weijie Yuan <wy@wyuan.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
