Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B218B3D902F;
	Thu,  5 Mar 2026 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772733931; cv=none; b=QH4S1o9vDgClFRMBSD+Xknced0jim6meNrvdEVcjyelnKHx2EcdBnjC0Xpdv9Qee7sAtXK6naaw5MNviR6TxK9GMGd0Rsxp7RUpPUll8SkC030bXy6+3djYFikRWO1EBfYu22TQ5JpHNPuwzrIOwW8HmS/WHjjzGYAK/ldK7+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772733931; c=relaxed/simple;
	bh=vU8WC2E3y4JSKjjc/LacAPhWsX82SYdBzV94iFaOGQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J04FnPLqzvnzt/KBbU7aohJ5ddXEFqVXa4r1SHHLb+6qPquUvut2Q0RbU9/OyfT/2LBE9wLHuIX7hXxDmChpMslvX/H+wX64MU1z1qRnM23MkzG/dVFclImkn5Yb/is1+2cwouFJ21/IEMf7xA7qDd3iWmEOGgsPhhjmAn+tY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 71FE6C124F;
	Thu,  5 Mar 2026 18:05:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 8DC0520027;
	Thu,  5 Mar 2026 18:05:25 +0000 (UTC)
Date: Thu, 5 Mar 2026 13:06:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, Dennis Zhou <dennis@kernel.org>, Tejun
 Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH RFC 3/3] locking: Wire up contended_release tracepoint
Message-ID: <20260305130604.659cca36@gandalf.local.home>
In-Reply-To: <20260305174223.GA1442992@noisy.programming.kicks-ass.net>
References: <cover.1772642407.git.d@ilvokhin.com>
	<8298e098d3418cb446ef396f119edac58a3414e9.1772642407.git.d@ilvokhin.com>
	<20260305105924.7069eb23@gandalf.local.home>
	<20260305174223.GA1442992@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7e37yoxoqbfox1qt9hisz4ytcd6fx6fk
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 8DC0520027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18NdASASaDUUqrewaKrX7VQ1YHMm7kOZy4=
X-HE-Tag: 1772733925-773976
X-HE-Meta: U2FsdGVkX18Cwu3Ie+Ud/EYZs/iZOO+gEKcsZJG5kc+m818AijzCNfTe15GqcbqPGu5UD5364uYz52fYMJsuYKSLuVZMWPUxjHJqTuXpjdqUpzOpgHs/C86AVdvo4JPtJZ8OVPP96+eGAUdAAuEuP3XTuWY8kLZfsaIeqUAJQoDBOJjigtMWDFuNTQr6KFNJdwWtXDCBEIk2yPzkqg/0AShIPEhsBJ4ry5eOCUClWeoRC0Orw1pS3fQA3oU7ihUUpk51cgBmHeIKw4U9PFk6KKWrdgiRwxVPnq+HHiPvjLfLPgH+tR9enQ0AyVzzyjQLyS7dE6UWok/Y7/CrwJRoRvmXZlqb/w4bRh4RZIjZuYl9Qu0jmiVUw+Z/sQk2bP2x

On Thu, 5 Mar 2026 18:42:23 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> I still wish you would accept:
> 
> 	if (trace_foo_enabled() && foo)
> 		__do_trace_foo();
> 
> The compilers can't optimize the static branches and thus you'll get it
> twice for no reason.
> 
> I really wish they would just accept __pure, but alas.

Makes sense, and that could probably be done. It shouldn't be too hard to
do. If I find some time I could look at it, or perhaps someone lurking on
this thread could possibly give it a try! (I may even Cc some people that
want to learn this code).

-- Steve
