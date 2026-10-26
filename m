Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051572;
	b=iIFUIi09RpyRbbczVFZuz5rWEa5lAS++QdHoOkMiNWPqKtDfa82sRYQu2/zuIu+/wk/o
	 rgLGoNWjm6SIchL885RKmCOVzz1ZY95pcw4/zb/1I9uql+wEr9WszNk17jP6R11Jn7rts
	 gpXUBTys1BULZeb+3AzDHhRa06K2/hdLfXR/KwlAh6feqEVIVfIkh59dAssP/R+pvi2ui
	 Rvd2xBRCp9XkRoT7PQIKs61ZOJyZjloheWg74hbxS2U+pMC9JndmeV2r9th/Pt7DlhjYw
	 uqWpdyMR6LrCERGvol+hhg6/+TYpWLYvK+Ek3oxaxXxhOpnV8rmMFMD1N+73YOURaWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0zQfCS+xbNCI3ecGYMw9q9f4jA1EzYR8/pz81vPbgxA=;
	b=4vT+ynTwZs5LFmlR+MrnK8m5vdhoQSgq3hpUP69geGwfN1OZIM0sZQVcwbRwHEcKwUqe
	 jhTgN6lAQe05KiyWPz32RObwhm0tqA8lKVo5xv6xVS5lFgh6fkm1c+mNOKoRLw/BN2mQ0
	 Hg+8B7xtyFKtsAeOu6IZqBQMLUnl49JhnZO877+GySqUoGPMKeOqEXlNv9RaRDSbhu0dd
	 Qa45EwkXQtWEJQWtLmzf41Xo6bLuq5y9zs/FoMiVCGKF6S5uEKhioFM8pzSgvnCCdfU6M
	 CRMLv3kPSc4CeR/jdNjmVhFICV3UTiHkT2YrUz6lWlbV2J82KUgIwITzkDYXisptLZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RC8kMmU1;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA360A3819
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 21:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34AA360A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RC8kMmU1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a01e2962a1so3748357b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 14:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793051572; x=1793656372; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0zQfCS+xbNCI3ecGYMw9q9f4jA1EzYR8/pz81vPbgxA=;
        b=RC8kMmU1ng9PI0xVDUVB9y4b2qkHrIc62PNyX4CzWbIdDe/vbucy2fxbMQVvz5M/xe
         IO7bs505etfgEHNsbXHOq1v8h8HofxMyo+PKPU+my9lhsGvDArvAYhYz55zgEC2MkyOf
         J46ym8a3S5Jp5fu3b7pIzq3ZgvKG/BWDa77DRrlIIXA6EMPsQpKBLv7/sbzdO6/CUcKe
         Hm4Zk7JL4UbMt2ax+X6noxQGwVuFhcvfgX+0jyCFIlr0T4a+inqsYhiXD0iuHZueewf4
         BhOxnojGjwJATQ35C5SS63tXVQxqgWO4TEgqnfuB0+6qy3MHnLM2dV3exIa8s5AQ+XD5
         5Lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051572; x=1793656372;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0zQfCS+xbNCI3ecGYMw9q9f4jA1EzYR8/pz81vPbgxA=;
        b=j/7kprWP4T++4xxf6Mqms0V24m+q8/Fw4ljzAJkT94uURpGpNsGaaQw+gAc03ugSWO
         J/iovF9AXF+ddFvpmUM4LLtJBcIBWpBbJvwr4X1T2nm2Kl74PKvPfi8cqGh+SOQeSFBq
         Z6lgm3yLL9a4XuD0eYP/8bcWei3D8zz3SZolJSfc+uZy51uigf+NeeCJwHbk9dRujpog
         Sv/Pza9crB0sjNOONBm6HCU/NtLyl96OOs6GzTT/1tSi9ShkvuDDmIBIea5mVzn4zWCE
         5HxY5HieJ84G1dvJT9uC8ta0UTlBihlkraxggkckqcySKZzrK86XQ47NSVsXiT+TPvZf
         s8Fg==
X-Forwarded-Encrypted: i=1; AKwUvByb5ZRxGiueCZkyINCbVi8Ji3BW3qktQoL95lEAu3IQj7hcHIfpro2z+WOGvzqL6z61uq9buMZkl/4fFzVjr+9Bouw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKM4+v6LAw7lsxhj9G0iLEX02fMtA472d9Fy6NWibhH+l3sIjkz
	cANFOBrRheZj9h1L4DdZBvL4JinJPflvLZul3XZEIVVxYa7G7zgS5k5JtoB2yHaz7cY6ZMBmpNv
	0mPP6Z265u98l9vkhV/Ymxw==
X-Received: from pfbho14.prod.google.com ([2002:a05:6a00:880e:b0:8a0:6a08:e927])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bd81:b0:87c:e44e:5694 with SMTP id d2e1a72fcca58-8a366b88ce9mr5902881b3a.21.1793051571129;
 Mon, 26 Oct 2026 14:52:51 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:52:20 +0000
In-Reply-To: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026215226.3713941-5-jthoughton@google.com>
Subject: [RFC PATCH 04/10] stacktrace: Don't unwind the user stack without an mm
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

stack_trace_save_user() only refuses to unwind the user stack of tasks
with PF_KTHREAD set. That doesn't cover all tasks without an mm:

 - A user task that has already gone through exit_mm(), e.g. when an
   event fires from exit_files(), exit_task_work() or the final context
   switch in do_exit().
 - PID 1 before it execs init, and usermode helper children before they
   exec, which are created with user_mode_thread() and don't have
   PF_KTHREAD set. E.g. booting with trace_options=userstacktrace and
   an event enabled with trace_event= unwinds PID 1's "user stack"
   during initcalls.

With the ftrace userstacktrace option enabled, the architecture
unwinders then read the user stack without an mm. That access does not
reliably fail: the user half of the address space belongs to whatever
mm happens to be lazily loaded, if any, so the unwinder may read
another task's memory.

Use is_user_task() instead, which also checks current->mm, as perf
already does for the same reason since commit 76ed27608f7d ("perf:
sched: Fix perf crash with new is_user_task() helper"). This also stops
unwinding the user stack of PF_USER_WORKER threads, which never run in
user space, matching perf.

Fixes: 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
Signed-off-by: James Houghton <jthoughton@google.com>
---
 kernel/stacktrace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index afb3c116da91..f96a5ec12f6c 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -228,8 +228,12 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 		.size	= size,
 	};
 
-	/* Trace user stack if not a kernel thread */
-	if (current->flags & PF_KTHREAD)
+	/*
+	 * Trace user stack only if this is a user task that still has an mm,
+	 * i.e. not a kernel thread or user worker, and not a task that has
+	 * already gone through exit_mm().
+	 */
+	if (!is_user_task(current))
 		return 0;
 
 	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
-- 
2.56.0.307.g5fe7bd680c-goog

