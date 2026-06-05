Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4D830E82C;
	Fri,  5 Jun 2026 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667030; cv=none; b=b/uhFSgoQsg6dzQwGWlWcgyinRIoKzq+r6AR+ePsKmFY14EI+YMGupioMakaOcBGqdb3aHHPK8GLpzfLZCkYWfE7hogmKnWtLJgDXdODK5oOF68GVdHe5QMCm7E2itqM2YgY5RPNXc+z1XtImLrwbFk+lUITmlSeEoRaXTQXhCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667030; c=relaxed/simple;
	bh=kBdiHbuoE4P2DZbV9Z7w0sZbYDPKcAVGH8EO/tQn75s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lWWD0l4VzDU1rFFpJS6e7NCMRgY/XOr5Fn9UE9htSKGc13IwO0tBtsshlfnp2EzMJZMaw4YXxl7mowDqfqSba391MHC6Vw5oQdNXwZVt6nwD3RgWj8yDZhY5ViZvEknvJJDVeWmCmWhNAaB8ye6lgjUFePt/2uoYbgJS5ZRe/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUAeRHqS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUAeRHqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6811F00898;
	Fri,  5 Jun 2026 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780667025;
	bh=w6vOgUfhEOr+brE8rTVNUwtCYey2HbjqkiediRhK/JM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iUAeRHqSbXIzvyRiVlVcYozGK6EC4CID14sek3zpyVYcaauKBD6bnzcnkBCyYwklR
	 ZhiUFfxfMTxGzbd2Ruj4wDK4x0RZp9KqdQ2pj29b6VBplrrHpIpKWdt4TfNxt0mDtD
	 HNDN89vcMNjTrxb+oLwLzXvUzFr5hKoE3FOmk9Hcj8V4hNjUSshgDfqmQNT7EO0GoW
	 nVF4ExGOzhPGp0PDR9ZpClAVJNdd3lXnhA+uIOLL/veb4SrJr9VmJFMorPIZbZBBzD
	 /0J9xmLZxu9YGa48UR/j16w7r89EpdfKbECsK3+UrTU+KCo7jRKitUpOX9ZXLY/Lfk
	 GPgGyMQQZeKOA==
Date: Fri, 5 Jun 2026 22:43:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tengda Wu <wutengda@huaweicloud.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
Message-Id: <20260605224341.c926299d613b6102912c9a3f@kernel.org>
In-Reply-To: <20260604093445.GF3126523@noisy.programming.kicks-ass.net>
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
	<20260526123719.482f07a3843e207e22d95378@kernel.org>
	<94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
	<20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
	<20260604093445.GF3126523@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 11:34:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jun 01, 2026 at 08:40:01AM +0900, Masami Hiramatsu wrote:
> 
> > Peter, is it OK to drop @rq from task_on_cpu()? 
> 
> Sure.
> 
> > Then we can use it from rethook.
> 
> Well, it is in sched/sched.h, which is an internal header, and no you
> cannot use that header in rethook.

Ah, OK. Hmm, then we should not use it. Maybe ->on_cpu is also internal
state?

> 
> But lets step back first, what is the actual problem here, why are we
> looking at ->on_cpu at all?

Tengda, can you explain it?
I think you want to take a stacktrace on !current process, and
rethook_find_ret_addr() is rejected i the task is running state.

But if you can share actual situation what you need, it is
helpful for us to understand.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
