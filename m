Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A741185B5F;
	Wed, 29 Jan 2025 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135542; cv=none; b=XfXRbFyo3Oo04u4aIuAZRDzxGg5ASqOiLN1Us/dEsRWujXJqfhPUzRQOj07188352Fj0AO0H9x9A5X0hOC6FzpJYsEd9WfCX5pfGiS9vvXXch/jfyQKDvJC0kA9qJKLum8uPVR554Bm4uB2k6CrCf/H94NuJFp49lTzIIhqQTwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135542; c=relaxed/simple;
	bh=2eLVDv10AaRjLtbGwWY5zW7FiMveeySdQdsGv4PjuJc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hG7YO+HYJ7PYwIFAYATNklSt2i1JD2cwcL361w3CflGccel1pgGttJS5xi6tCsDSPbpmzjJdYxBKhAKmXv3kXa1xJYWQ/CRd/zZRTQ/9hvZ+wLT6Pihzr7NJfHA+dqcIx5ES/xD3iV+PZKRSN3RLxhnFygq6b1RQ3om4ukQWOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9iODo4N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9iODo4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C94CC4CED3;
	Wed, 29 Jan 2025 07:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738135541;
	bh=2eLVDv10AaRjLtbGwWY5zW7FiMveeySdQdsGv4PjuJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T9iODo4NcpP5Zh/9Sp/1LeaFzCD1t9pmw6FXJMxqNayQim9HOzztJRHxpNzzfit2z
	 gSvGwAKpz3I70QqMTPWA+4qLYIBb5M+D/T5xmVDkGQQInNfdHevjxuWPOrWfBAVPCz
	 SuRJv0qjccl/9IhmfpaH0kIL18arQ+BuWbG+DLe9t/Q5BjU4+ChXH3c1K7OMT+REbm
	 ZUpVRZF3jzBEp40ao7U8u6QzA7omIJRRSOS8SOsDToiqXfvj0s5/kLLMB7KqLHyoaZ
	 ZTL7XDYgagkk5SiQXTieaMUYZ6Hn6V21hXtpmPn1my+e+tXCefUbhGDQqdF7yU2K55
	 1VDxlBq+xXnJw==
Date: Wed, 29 Jan 2025 16:25:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] tracing: Introduce relative stacktrace
Message-Id: <20250129162538.953578b387bd4067afdd15a0@kernel.org>
In-Reply-To: <20250128200939.0cbce825@batman.local.home>
References: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
	<a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
	<20250128112733.37d7c771@gandalf.local.home>
	<c3842632-cb15-469f-a6e8-8e9ccb3fff56@efficios.com>
	<20250129095819.fe6846ddab613460647db919@kernel.org>
	<20250128200939.0cbce825@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 20:09:38 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 29 Jan 2025 09:58:19 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hmm, that also works if we only consider the kallsyms access. But that
> > means to export KASLR information in the trace buffer. We need to check
> > it is OK.
> 
> If they say we can't have KASLR information in the ring buffer then
> that is pretty much a brick wall, and we are done with this. The best
> we can do is to prevent reading the current trace buffer. But honestly,
> we want that too. Heck, already get kernel stack traces from perfetto
> right? That has KASLR information doesn't it?

I read the perfetto callstack feature, but it seems to support user
space callstack.

https://perfetto.dev/docs/quickstart/callstack-sampling

> 
> > 
> > My another concern is how to handle this stacktrace on live system. The
> > stacktrace has to be handled in both crash and live trace, but in both case
> > we need to consider not leaking KASLR offset.
> 
> I don't think we do.

I meant that my [PATCH 3/3] can do it intermediately (not directly).
So I think your idea (storing relative offset from module) is better.

> 
> > 
> > Hmm, for avoiding the security concern, as Steve said, we may need to save
> > the module relative address, which may introduce a bit more overhead, but
> > it should be safer.
> 
> Actually, if we save the addresses of where the modules are in the
> persistent ring buffer, and expose the addresses only if they are from
> the previous boot (if it's the current boot, it just says "current"),
> then we can decipher the modules from the previous boot.

OK, but when would we save it? it is OK to do it in panic()?

> 
> > 
> > Anyway, this v1 may be able to leak the KASLR offset (or estimate it easier).
> > I think we have 2 options; (A) as Mathieu pointed, expose the offset
> > information via trace buffer. (B) as Steve pointed, fully relative offset
> > in stacktrace.
> 
> It should be fine to read the full offsets. Again, perf already does this.

Indeed. Hmm, I need to know how perf solve this limitation.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
