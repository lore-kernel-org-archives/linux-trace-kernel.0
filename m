Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604665;
	b=cBhvGzaVF+AlSyy5K3fUZ2iV1MBtQgOl+WzkrC0G5HNzLr5t0BnrIrjWHQla4tswn/bZ
	 wyi1pqogMo3E3zXTuu/mWbW0USiK0KUWxi1sCu7ZTisFPmYmOI7e1amr6JE/XcGXj027R
	 ZMl+9pmDJf/3uWhdKZfz2vK+4Wc4OKw/lOUf5ZJ+AGvUFADdHOerNCJuVsYC5XgaxKJ/p
	 ITh88ieOwFb9Wcz/paRNyM1bRV1prY8iIu1jyLK/ZXsQ0WplC8RJswzshGsnvXqq7PlvA
	 QbLYXgwI8KsDvkY/O3EDg7/kD0EZNqZCZhDsiNqGuyWU4sMAU4cPgey0GtfNFQgsnAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604665;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7FjkA8QW79XZQoYxEN5gAZUfLr7e80YrX+p4F8rVLXI=;
	b=xjWRQHivgHpYczgcoA089doygjnRGXOuiOz6IuOeyRPckaDZNmyEwn6XsiIy8ye6Gjdr
	 eeESqrJIxGxETXu5r8EI0c9nZudl0OrJ/+413vVzKnpcilkAl6e29c/uK872Aryc7btGr
	 ou6worce2CbWrHMBC/TVq8lX0KEpv2mlDBRlpLWhjEchSL/IWJWg+Inqbw8YnxqOFADdt
	 BpPtaWrTMlPQ2DXEunQEDnAiWo4+015woR6f8i2ASnIow1Wv8vcJsAlzF7BiEyIWTELkA
	 zNYeqRvSatTYifXElwb5R/PR3AgqMHEwkTtzGLR8tgj6JRkBRp20LhVNgeblqzYjrgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jTLiA+G7;
	arc=none smtp.remote-ip=91.218.175.252
Received: from mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E43606A31A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 17:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E43606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jTLiA+G7
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KRR27gFsWCsdg3Z0l/RhpFUjK4yYAuYEtYHVLY/yD/M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792604662; v=1; x=1793209462;
 b=jTLiA+G7bk9e5cxPgHWba0Smb9HYD0gOHL4F/McH9z5og55GZujDZkGU6kPDKiEQJhxInZJ2
 OJ7t3oIcM8/tOY1EArdijrv4kDHvLgVCwaWyUm/R/SRQwJERlXkAePWII5K5JDol3c5w3gNo1eF
 BRWzB2H+k9sFcs0DawIHJxvI=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a521ecb7d8937fc5;
	Wed, 21 Oct 2026 17:44:21 +0000
X-Mizu-Trace-ID: a521ecb7d8937fc5
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
Subject: [PATCH v4 0/2] tracing: fgraph: fix the quadratic shadow stack walk
Date: Wed, 21 Oct 2026 10:44:04 -0700
Message-ID: <20261021174406.2891598-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
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

alloc_retstack_tasklist() assigns a shadow stack to every thread when
fgraph is enabled. It did so FTRACE_RETSTACK_ALLOC_SIZE (32) tasks at a
time, and since for_each_process_thread() has no cursor, every sweep
restarted from init_task and re-walked the tasks already served, making
the ftrace_graph_active 0 -> 1 transition quadratic in the thread count.
On a 60-core Sapphire Rapids machine with 400000 idle threads it took
227 s, inside a single bpf() syscall for the kprobe_multi case.

 - 1/2 allocates inline with GFP_NOWAIT, which removes the batching:
   a single sweep serves every task, 227 s -> 0.092 s. It keeps the
   open-coded rcu_read_lock() for ease of backport.

 - 2/2 is the cleanup: convert that same walk to scoped_guard(rcu).
   No functional change, and not needed by stable.

Both were tested on bare metal and in a VM, including forcing the
GFP_NOWAIT failure path with failslab injection.

v1: https://lore.kernel.org/all/20260922225526.1554758-1-vineet.gupta@linux.dev/
v2: https://lore.kernel.org/all/20260929005411.4105448-1-vineet.gupta@linux.dev/
v3: https://lore.kernel.org/all/20261001102909.1152572-1-vineet.gupta@linux.dev/

Changes since v3:
 - split into two patches: the fix keeps goto-based unwinding so it
   backports cleanly, and scoped_guard(rcu) moves to a separate
   cleanup, per Masami and Steve:
   https://lore.kernel.org/all/20261013194542.7e036b03@226.227.38.69.naturalwireless.com/
 - in the cleanup, -EAGAIN now exits via the existing free label
   rather than returning from inside the guard, so there is no longer
   a path that skips the free loop

Changes since v2:
 - update the stale alloc_retstack_tasklist() comment, which still
   described the old batch-of-32 behaviour (bot+bpf-ci)

Changes since v1:
 - replace both v1 patches with Peter's inline GFP_NOWAIT approach,
   which removes the quadratic behaviour rather than dividing it by a
   constant. With a single sweep there is no retry loop left, so the
   v1 cond_resched() patch has nothing to attach to and is dropped.

Vineet Gupta (2):
  tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT
  tracing: fgraph: use scoped_guard() for the task list walk

 kernel/trace/fgraph.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.53.0-Meta

