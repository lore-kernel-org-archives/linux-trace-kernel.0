Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777AB23E358
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643272; cv=none; b=tqyh8vO/ieVnN764rISQedP0Y97cpREldPh11MozmG+iOMa3Tu2u2X5GxpZKUsFT6Ib25CaLR/24cxRKDpfpdqcePS2Ir0nCn/i/2RJpJP7Sr1r1pVdKKb1Rsd0pmnCaPa25PaXQutbXpuWEplLbRA9Dh8HtUd9fevXm7PMnuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643272; c=relaxed/simple;
	bh=/ZN+t8Y7O1ERXt/PK2W2EQrnipLYq8zXZKVAc4oVFWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPvfdEEPtfN1DWCEqIkbz7IQJyTEvlC8qQwxSTvlb8cWiA7P4g4vaEmBPlx2i/rebvaJ/nko86NI467+S7OyShPtKRJsZWQoGY+9n/go387rXxrfiff93MFsJcUdRZYhzS4eUSEyVCgzGA0THs+IwFZBBhGAlabRKFi6Va+kZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mglw3o4Y; arc=none smtp.client-ip=91.218.175.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mglw3o4Y"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/ZN+t8Y7O1ERXt/PK2W2EQrnipLYq8zXZKVAc4oVFWI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790643265; v=1; x=1791248065;
 b=Mglw3o4YJzOE9E/fUASCaVbZzVUoeoTR3iPFguCTOxR9EI2RHNh/DHlVGgEQ8b6/OcYUIl81
 mtjSldAf23rq7YE4Ac/7bU8CaO8jzv5Po9NVgldAAcpBGzSKjfLL9DJHVl7ce7zuEWVn8iK+g17
 8v9EOBdimyLmlbnwEhd9ITZg=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 36436f1125b35320;
	Tue, 29 Sep 2026 00:54:25 +0000
X-Mizu-Trace-ID: 36436f1125b35320
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	andrii@kernel.org,
	peterz@infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH v2] tracing: fgraph: fix the quadratic shadow stack walk
Date: Mon, 28 Sep 2026 17:54:10 -0700
Message-ID: <20260929005411.4105448-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 tried to make the sweep loop cheaper: raise the batch from 32 to
1024, and add a cond_resched() so the walk could not hold a CPU. Peter
pointed out that the loop does not need to be batched at all. Allocating
inline with GFP_NOWAIT is legal under rcu_read_lock() because it cannot
sleep, so a single sweep can serve every task and the pre-allocated
array becomes an out-of-memory fallback.

That removes the quadratic behaviour rather than dividing it by a
constant, so both v1 patches are dropped in favour of this one.

Measured at 400000 threads on a 60-core Sapphire Rapids machine,
PREEMPT_LAZY:

	v1 base (batch 32)      227.8 s     12503 sweeps
	v1 patch (batch 1024)     7.2 s       391 sweeps
	v2 (this patch)           0.092 s       1 sweep

With one sweep there is no retry loop left, so the v1 cond_resched()
patch has nothing to attach to and is dropped too.

v1: https://lore.kernel.org/all/20260922225526.1554758-1-vineet.gupta@linux.dev/

Changes since v1:
 - replace both patches with Peter's inline GFP_NOWAIT approach
 - comment why returning from inside scoped_guard() skips the free
   loop safely

Vineet Gupta (1):
  tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT

 kernel/trace/fgraph.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

-- 
2.53.0-Meta

