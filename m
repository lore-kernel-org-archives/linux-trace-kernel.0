Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604675;
	b=lmd1Ysv1OMAHpHmJyQEYIiV24Nx4430dA9KB4K7opiNM1mY+9ZsrjBuOI8hOYlxJnM3d
	 r2RKt/JKLvLLqlGDMctPGXh5BFLNqhyaD4BxBaIRuc6GEpERMFikRJelZFny8NHcUsV4M
	 dAdBMQFxHPzs9hd1r2asmj0XN6AArl7Tqz9JA1hmc7+fMdBm5F8shf3JNkzd4mlHenyHd
	 Be2uYICm+HDekw6cFPnsTbQYilj/kcye/BCmGjwMIQ4kqETfPGTPRupCkbtP6Iyd+YKCr
	 OlIpcfZxPT6td6GmLsBwtl5jWRT97fe7hGe1bUbntwn4UleVBaEfWEy/HVT6kwHYZzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604675;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CrbQvaheVnGVHulUMcA8yjaKoTe8xjFM+3iVN2PxY5Q=;
	b=mc1e7EaM1MlRGTgiJKDJaMijvJLrvN3hyctlGnmIrVPua7Vs2y53STeHee16bgS3El8R
	 z1DeIZXv3vvkULYvgWozJjGn0UpvfhZ6Wpe49SCpDwSbijAUR48WZ8yp4PrFIu89Zn9tO
	 86aWolfVJVQXiDgE8jYBr4/UAkqvpEd/CJoJPTrU5DmUtckZmDkUTM6F/76tTAomzakyg
	 AuK3xmdBx2po7nvFUcao6cqU09GdIuV+OlPjJwR4KD5z/FHb3glStXG3Y7LWUgo3bQjdt
	 7W2WeOKf2ms/yPjtPluPAvRmfnpTDXTEgQl42kx1yREDhDsfHAhTD0TZgMZcYTVlEkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j9OO8fsD;
	arc=none smtp.remote-ip=95.215.58.17
Received: from mta1.migadu.com (out-17.mta1.migadu.com [95.215.58.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62894606A31F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 17:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62894606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j9OO8fsD
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gzQQsJPuIUKqQmkp2GndF+kkdcenF51ADI84PnJQfJs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792604672; v=1; x=1793209472;
 b=j9OO8fsD3QvShz8b87kWWn3+D2jiLTV+y79AcTqWLj2XBuwCqd1esy9yr/XXaN9nL5PXddgv
 5uYBfFiWMG8WSqIzVmx1auiyiqWMvZQTnA2qQc42vOuROw9c6I2kS1Z+gW3V55ErLkAHjmPtyiz
 t1XNwTFgnWj1je1HdmJkVq5c=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c25dbf7ea97f94ab;
	Wed, 21 Oct 2026 17:44:32 +0000
X-Mizu-Trace-ID: c25dbf7ea97f94ab
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
Subject: [PATCH v4 2/2] tracing: fgraph: use scoped_guard() for the task list walk
Date: Wed, 21 Oct 2026 10:44:06 -0700
Message-ID: <20261021174406.2891598-3-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021174406.2891598-1-vineet.gupta@linux.dev>
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_retstack_tasklist() open-codes rcu_read_lock() and unwinds it
through an unlock label. Use scoped_guard(rcu) instead and let the
compiler emit the unlock on every exit path.

The -EAGAIN case now jumps straight to the free label rather than to
unlock; leaving the guard's scope releases the RCU read lock on the
way, so the unlock label has no remaining users and is removed.

No functional change: objdump of fgraph.o shows identical call targets
and counts, including the three __rcu_read_unlock() sites the compiler
emits for the exits from the read-side section. A PROVE_RCU +
DEBUG_ATOMIC_SLEEP build with the -EAGAIN path forced several thousand
times is clean.

The preceding patch deliberately left this alone so that it stays
straightforward to backport. This is the follow-up.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
Tested-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 kernel/trace/fgraph.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 4c74f1a15ad4..bbf6e4e2da2d 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1057,32 +1057,31 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 		}
 	}
 
-	rcu_read_lock();
-	for_each_process_thread(g, t) {
-		unsigned long *rs;
+	scoped_guard (rcu) {
+		for_each_process_thread(g, t) {
+			unsigned long *rs;
 
-		if (t->ret_stack)
-			continue;
+			if (t->ret_stack)
+				continue;
 
-		rs = kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
-		if (!rs) {
-			if (start == end) {
-				ret = -EAGAIN;
-				goto unlock;
+			rs = kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
+			if (!rs) {
+				if (start == end) {
+					ret = -EAGAIN;
+					goto free;
+				}
+				rs = ret_stack_list[start++];
 			}
-			rs = ret_stack_list[start++];
-		}
 
-		atomic_set(&t->trace_overrun, 0);
-		ret_stack_init_task_vars(rs);
-		t->curr_ret_stack = 0;
-		t->curr_ret_depth = -1;
-		/* Make sure the tasks see the 0 first: */
-		smp_store_release(&t->ret_stack, rs);
+			atomic_set(&t->trace_overrun, 0);
+			ret_stack_init_task_vars(rs);
+			t->curr_ret_stack = 0;
+			t->curr_ret_depth = -1;
+			/* Make sure the tasks see the 0 first: */
+			smp_store_release(&t->ret_stack, rs);
+		}
 	}
 
-unlock:
-	rcu_read_unlock();
 free:
 	for (i = start; i < end; i++)
 		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);
-- 
2.53.0-Meta

