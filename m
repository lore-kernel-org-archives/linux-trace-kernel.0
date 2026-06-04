Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D602274FD1
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584346; cv=none; b=RHga7wvXbtrDv/P1hsVl2TrA9Dq8GXMkx6DwiGZPW4ndi0hUJaWjmm14PMV6Z1CoNENd2h/66WGtsrp2oQHIBfDTf214Ny3mGB/ms7/5n2OFk17jFsdGw5Hvfbi2iV+An7VyOqxeVlWb6H0q1IBXsU+C2bxM6fNNBHgKfDm0T1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584346; c=relaxed/simple;
	bh=bMhTrdJPEPhLHfw53eVp1ATIppnpco6kqJajNJDTgnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Na8xOwTnf9mpZKHNWbJd+4Y+qygf70KIVQ30FDVU1+YSIxCk/+kePjnT4GCNkilVCj/wOFRPq1NsrO9a3Qw+A5WuaE242Spmfxzlrtae5zXURmPoIvwns5JETo1eMV0p9xekEewsY162K1Um2ZEwqDTo72bDOD2rhqaTLaClZMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UunZbDmJ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UunZbDmJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780584342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoH9pVzSpYK0TgEx0hXQxnSD6c2BaICmL/xjSUK10Ww=;
	b=UunZbDmJFl2Hukw9c9Op95EHjP5Wse54/m/q/IlZ7etwX58pebkfyhKwUwj1wQiFgiXAWZ
	Gk38TisXJS8L6yZGP9fJd+nu8bTes3YLNenILQ0e0QyogbJL9pKJOfGhjqkzmzMtySFZEs
	VbgOWsG1RIFkQsZSvgh6sx/5q6Ncvm8=
From: Usama Arif <usama.arif@linux.dev>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v7 3/3] locking: Add contended_release tracepoint to sleepable locks
Date: Thu,  4 Jun 2026 07:45:36 -0700
Message-ID: <20260604144537.3249856-1-usama.arif@linux.dev>
In-Reply-To: <02f4f6c5ce6761e7f6587cf0ff2289d962ecddd4.1780506267.git.d@ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu,  4 Jun 2026 07:15:07 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Add the contended_release trace event. This tracepoint fires on the
> holder side when a contended lock is released, complementing the
> existing contention_begin/contention_end tracepoints which fire on the
> waiter side.
> 
> This enables correlating lock hold time under contention with waiter
> events by lock address.
> 
> Add trace_contended_release()/trace_call__contended_release() calls to
> the slowpath unlock paths of sleepable locks: mutex, rtmutex, semaphore,
> rwsem, percpu-rwsem, and RT-specific rwbase locks.
> 
> Where possible, trace_contended_release() fires before the lock is
> released and before the waiter is woken. For some lock types, the
> tracepoint fires after the release but before the wake. Making the
> placement consistent across all lock types is not worth the added
> complexity.
> 
> For reader/writer locks, the tracepoint fires for every reader releasing
> while a writer is waiting, not only for the last reader.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Usama Arif <usama.arif@linux.dev>
 
