Received: from mta1.migadu.com (out-232.mta1.migadu.com [95.215.58.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650A47A876
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790117746; cv=none; b=Sr9JOoGtNMGUr7ISYskPvKc8tSP/CHQMOOg9yCE+ZoSKiODjWDkXj2lwZhrVaFG1QgXvxz9lagJTax2uiVY4mPJADWTTdCAFMfLFW9RRPk16Ha2CjrLkzrHM2jyS8V2HQC4GSbziOjUJqKbRdIUsissHn6vFZM6kJbBHSwnHOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790117746; c=relaxed/simple;
	bh=egq8ko5c2V6iEzm9Szc3PLZGOoZrPdKCNmOY/XOR3GU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdK/UWgEzXeb1OXWEICDxoqaHgwaer1ExnMwGYXAa6pyhWryxZHUJWwZ7bKbpn9ji4ulpgcXO+cMC81NwpXiF6SIAMtXWx6n55DuU+ZHDn1/aAJ1Bd71yV4VofOxcxHfgXyC9tG2rPwxdIAOSuwn8TkavdQqUB+IeTOY3mvMEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DqohTIOg; arc=none smtp.client-ip=95.215.58.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DqohTIOg"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=egq8ko5c2V6iEzm9Szc3PLZGOoZrPdKCNmOY/XOR3GU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790117739; v=1; x=1790722539;
 b=DqohTIOgurSWdJnbuEEFjShoVikit79qlRusrqpztJ4Ma9xKE1+8npLIm2deMPIzHCqFV3ZK
 8Ip6JDVUztN17o0cQUfp7QbFsiFObLDSX1m6/LXCwR1MZCxXmgldR+fZBkDXBUmKbZOpu6Md90n
 yRyxayKnuNDzSwfRwvjdBf38=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8c6bcc892373d610;
	Tue, 22 Sep 2026 22:55:39 +0000
X-Mizu-Trace-ID: 8c6bcc892373d610
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
Subject: [PATCH 0/2] tracing: fgraph: cut the cost of the shadow stack retry loop
Date: Tue, 22 Sep 2026 15:55:24 -0700
Message-ID: <20260922225526.1554758-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turning on function-graph tracing, or attaching a kprobe_multi return
probe, hands every thread a shadow stack. alloc_retstack_tasklist()
does that 32 tasks at a time, and since for_each_process_thread() has
no cursor, every sweep restarts from init_task and re-walks the tasks
already served. Total work is quadratic O(N^2) on thread count.

On a 60-core Sapphire Rapids machine with 400000 idle threads the 0 -> 1
transition takes 227 s, inside a single bpf() syscall for the kprobe_multi
case. On Meta fleet this showed up as RCU stalls and softlockup panics.

Patch 1 raises the batch to 1024, dividing the sweeps by 32:
227 s -> 7.2 s at 400000 threads. It helps on every preemption model.

Patch 2 adds a cond_resched() between sweeps. It is supplementary and
separable: a no-op on current x86 and arm64, but on !CONFIG_PREEMPTION
builds it takes soft lockups from 3-of-3 runs to 0-of-3. Dropping it
leaves patch 1 intact.

Neither changes the O(N^2) shape; a cursor-based walk would, but
task_struct lifetime makes that considerably more involved.

Vineet Gupta (2):
  tracing: fgraph: Raise FTRACE_RETSTACK_ALLOC_SIZE to 1024
  tracing: fgraph: Add a cond_resched() to the shadow stack retry loop

 include/linux/ftrace.h | 7 ++++++-
 kernel/trace/fgraph.c  | 8 ++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.53.0-Meta

