Received: from mta1.migadu.com (out-120.mta1.migadu.com [95.215.58.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3040D35E1BA
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791692927; cv=none; b=trFwV4QNWoztopEl0teG3PX6MPuSCXTBZ0noqZnyPdOQAdXRnYw9wlaF47Sit+BoH4o/PFQSZcheOMnnLyOU+/KOaaXAe+s788IeAdQo5hMnr1pKrQExh3fR6M25ADEvdfKhwrs4KaEeZA+dNRk+0NLXYxE7I+7qiddwbFrYv6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791692927; c=relaxed/simple;
	bh=oWfUT88ZOBjq8dRh0lwJrPuh9l3/thyYC3pPZq9Dy68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d23777h+U5U4jVBosr32jAK9gEDLLSgOR4+RvAB8GMldyy8HPHZF6VM04AAmo1MyXQzlJeufZSxC6Fcvx32CFtydIIqg75Y9Ptc2E9qNsV0hlXbgWubsGsHB+qqmUKvOa53vjE5yYCyuhxP8/kOqCxLgpIfi2K2BueuKSOVyrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vbr4HsVW; arc=none smtp.client-ip=95.215.58.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vbr4HsVW"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oWfUT88ZOBjq8dRh0lwJrPuh9l3/thyYC3pPZq9Dy68=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791692921; v=1; x=1792297721;
 b=vbr4HsVWous5T1D9Su726NF51peKQoYOYH4q7eCXLHx5nrV5Ysl+Jw4dFNP/RFRs+MQJuYk6
 TDkmVGrq1DzjnJouJ2TP1Lhnc+vpGxTaiP+D+UD04jz9SzGN4VNXZ9xSwUkvCjbC1M9VRji6HwS
 4wX8b1ezsMVvyaBOHBaFBnEA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id de44eda3b754d562;
	Sun, 11 Oct 2026 04:28:41 +0000
X-Mizu-Trace-ID: de44eda3b754d562
X-Migadu-Flow: FLOW_OUT
Message-ID: <44b54799-6cab-4bcd-bce9-d8d55517a7a2@linux.dev>
Date: Sun, 11 Oct 2026 09:58:37 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracing: fgraph: fix the quadratic shadow stack walk
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 peterz@infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
References: <20261001102909.1152572-1-vineet.gupta@linux.dev>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20261001102909.1152572-1-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 15:59, Vineet Gupta wrote:
> alloc_retstack_tasklist() assigns a shadow stack to every thread when
> fgraph is enabled. It did so FTRACE_RETSTACK_ALLOC_SIZE (32) tasks at a
> time, and since for_each_process_thread() has no cursor, every sweep
> restarted from init_task and re-walked the tasks already served, making
> the ftrace_graph_active 0 -> 1 transition quadratic in the thread count.
> On a 60-core Sapphire Rapids machine with 400000 idle threads it took
> 227 s, inside a single bpf() syscall for the kprobe_multi case.
>
> Allocating inline with GFP_NOWAIT removes the batching: a single sweep
> serves every task, 227 s -> 0.092 s.
>
> v1: https://lore.kernel.org/all/20260922225526.1554758-1-vineet.gupta@linux.dev/
> v2: https://lore.kernel.org/all/20260929005411.4105448-1-vineet.gupta@linux.dev/
>
> Changes since v2:
>   - update the stale alloc_retstack_tasklist() comment, which still
>     described the old batch-of-32 behaviour (bot+bpf-ci)
>
> Sashiko flagged the mix of goto-based cleanup and scoped_guard() in
> this function. Peter and Andrii both considered it fine as is, so it
> is unchanged:
> https://lore.kernel.org/all/20260929080346.GR4120091@noisy.programming.kicks-ass.net/
>
> Changes since v1:
>   - replace both v1 patches with Peter's inline GFP_NOWAIT approach,
>     which removes the quadratic behaviour rather than dividing it by a
>     constant. With a single sweep there is no retry loop left, so the
>     v1 cond_resched() patch has nothing to attach to and is dropped.
>   - comment why returning from inside scoped_guard() skips the free
>     loop safely
>
> Vineet Gupta (1):
>    tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT
>
>   kernel/trace/fgraph.c | 44 ++++++++++++++++++++++++++++---------------
>   1 file changed, 29 insertions(+), 15 deletions(-)

Gentle ping !

I appreciate folks might still be on the way home and the mayhem of 
merge window.

Thx,
-Vineet
