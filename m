Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634290;
	b=oqktzUf2uj2hO6d4cPkvGRGN0W9RE9eJ26JoFhbmdNfxPxsHWDNaYT/ArGfKpTlMMwER
	 33eupCNeBLJO22M9Gu9Y3dG1zsTY4LoEW39SejxvxHkvG/Lvfil71tiNTRuN9cx+TZl8v
	 JrPA4Kf8EqF1wfE/wghPNYR0kmTb+kUlQdBxXz4fy0B+QcqlxNvXhJMt4ElrJKinCXLf/
	 6IvGFqLml0MS9iXU/o/cJjVpdS3e17qGZ1s5AX8qLZ7fLdrjReQ8eIsvz/OQydmz360L6
	 nApVxeufMeSnu9Jj+zJ4Zy0yIq3RyaZfkBfmI1XrfIXmkrnLKodXs0ORUnuDDTQi67w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mq98Rc54j/apXLpD8jeCAQO2NMmsGpxAwTZHZJ6mXaI=;
	b=1gR9tI+NsM+2UgER2gPU31nukVntDdiQWAjrK5AoPjvDy80QwA2bGaoy1EL9HFD8KN2D
	 r7Xf2poI5wFH2JfvrKjB15LdVPf4aDG0VFI46FCnLW23rJCD9iqIXQufiTIVM7EVWAOfR
	 l4dT0Dl8VAniLCXWVtos9AEQ/l6bTNpR+m6r9sXQBWRvYbCAonElnCny7IwB+cbUx4QSw
	 cmcoMNDmNragu5N0fEB74SRlrMOWiyQxc6ScBJ4299Op2qLZKFVrdPuJLgp2Xda/ARq9v
	 OWaPlAo2ef+GDQkkzM29o2OIbXZDWRzBc4ytcfGYyyuwg+tZ7ca19EnoS6BYmEQr2Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LnJbrZXq;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B8B606A319
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 01:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51B8B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LnJbrZXq
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc147d86bebso265317a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 18:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634289; x=1793239089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mq98Rc54j/apXLpD8jeCAQO2NMmsGpxAwTZHZJ6mXaI=;
        b=LnJbrZXqH4ZJDIqX5PgmFmAXXvnib6E6ODKFXOuc6OWS5lYlPsOtnxl1Lub4pjY2Fj
         40dsu2efY4QIKh+o6oeROA1K4bH7NmxWw1VGktPXKZTAN8FW4GtpZIXcWV/ResOIO2gX
         VzH5HlJklSOKn4zugThz3DP5Fy5qdPv/1WJyLFVLdCKKXLOSq/L07vaHzLR09SrMU6iz
         ICz6Av6VGXJzhvSsjIgF7LzLDWaJ3JIV5r2NggzsoFfiHNKhw6qEx+bSC1yA8A4FhcZL
         FS6Ack3OyrFXi3u4Lpqm3UrDs5RwsHfjbqyJaaN05Lkq0zxKtVn5zBTgFT8Noi7q0HWF
         T+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634289; x=1793239089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mq98Rc54j/apXLpD8jeCAQO2NMmsGpxAwTZHZJ6mXaI=;
        b=DJXbR6IKIICCfUKIjCblPYVgSNf3U/E5CCCYr/ieS1hgwtHQmSNzMtX5qh0oewS2gU
         6tPee2ScZu+4iPGTCbA2MrwLPh3j5vEm59VJc0mNM1faZCmBTcpuCFVWZTOMbDxPMm6k
         acj0FjF4UDrbEHRQLxgN2mVE7W64bJSbecTnWn5Vaqu68rbMfap/hLjyRwUA+VgTVAXl
         +AUObTlmbHQdFvY07gPzf/VIsfP+znEMsqV0BGrQtaUIAy7s4kRMLp9mBlmk2rwsHRAn
         s4yj7izQDwnVgKNpAQrQTRlqcFxbMJA+RH4oSy/lXN7JI4Zoi85QHKQmyxZfhiKQy8aL
         W9XA==
X-Forwarded-Encrypted: i=1; AKwUvByTRlY89+5ukp8q7aJ9SgczNffDMjkMX9pvAeQWVPcnyRZEsFn5fiMf4IkW+yuMOe4APPOIyF7Ue3tgx6f8Ujd70cw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuca7/BuJuHxVCj8q0vzHob+yT50NZ6emC0RlkO2sf8WJ7P4zF
	RwK0PS5zeoHtYj29SzzIZwZ/5Do2877DYsiNX2CSCCtuR34yrnbYWeKl
X-Gm-Gg: AYBFou2nG4Gwtt4VUvCxd+L0IEkeLTk8XuWKy9IFTFZWbY1caD7B3ETUKR8uhdUyZk5
	IkzsxGgJxXgFpoqMVxT9P7+0J3scnBJ/BJWUenj1GQxNY+dpC4BMSuggnpud5NXJ9YVM8bI37C7
	fzpjsignkb5fyqr2I12V5xXxlJCDcWhKZLTBHzkG+qUsyFcNv0O2VfNBTrllTU9kKFPbPetXPEG
	B52bCM5RR0dXiJwUNuks8mU9HrpVBkXFNBKb8ijwAZcWyh50YRY7qEw57u7//OUomeGKnQ5eiPp
	3+1H813xseN4WwOa35LcWJ1wB9lw1BNDR90CGgKhQd+RbEErPgJ+tciY3neyz5FxxFrYGO/vlbN
	Yk9NY0rEApx2cwKV0ZogpBf+hjfv9WHl1Ord/fPue40i/APG26I4lfwVffO9V9Gtjenn9Vb3xHZ
	5+sQUWNJ2DnG0ln7vnLfunp46YwnqJ+3dqpLdEs0VJQLmS7oKQFd/hhUMMUU03kOSEfQm+JJQ45
	4HwIaAq9Vz0uwcexNnJBfjiaww6+YUB0DCg2jGS1d8GateGkhbSvqEq2l4nGIrqF7b0b0yWc4UM
	A8X1CBwvfvlffTOsIdTX4i86OaHt+s2sb4t3qejY3m7ltMyhRttrEJakeUYuWGTzmCknzzziWEG
	WqA+R8ISfLOHRqiykvRN7FsHT
X-Received: by 2002:a17:90b:2791:b0:3a0:c31d:80c with SMTP id 98e67ed59e1d1-3ada6c545c8mr517003a91.9.1792634288589;
        Wed, 21 Oct 2026 18:58:08 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4887669sm1796939a91.2.2026.10.21.18.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:58:07 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 8/9] uprobes: Don't leak the breakpoints if the unregistering task is killed
Date: Thu, 22 Oct 2026 01:57:11 +0000
Message-ID: <20261022015712.1297331-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

__get_user_pages() returns -EINTR when current has a fatal signal pending,
and uprobe_write() begins with get_user_pages_remote(). When the task is
killed in uprobe_unregister_nosync() remove_breakpoint() fails in every mm
that register_for_each_vma() hasn't visited yet:

  uprobe: <comm>:<pid> failed to unregister, leaking uprobe

uprobe stays in uprobes_tree. The breakpoints stay in these processes and
in their children, and every hit traps into the kernel for nothing.

The same happens when the task is killed in uprobe_register(). It cannot
remove the breakpoints that it installed. Since "uprobes: Don't sleep on
mmap_lock under dup_mmap_sem" busy mms come last, so the task that is
killed while it waits for one of them leaves the breakpoint in all other
mms.

Trying again after the failure isn't enough. The signal can interrupt
the removal after ref_ctr was decremented, and the second removal
decrements it again.

kworker has no signals. Remove the breakpoints from a work item and wait
for it. A kernel thread does the walk directly, and so does everybody when
nobody maps the file.

The price:
- A round trip through the workqueue for every removal, 9 usec.
- The removal runs with the priority and cpu mask of unbound kworker.
- The caller sleeps in flush_work() for the whole walk. When the walk is
  longer than hung_task_timeout_secs the caller is reported as hung.

The tracer is killed while uprobe_multi attach waits for mmap_lock of
a busy process. 100 idle processes map the file. The number of them that
keep the breakpoint, 10 rounds:

  without this series   0 or 1
  without this patch    100
  with this patch       0

uprobe_multi attach and detach in a loop, nobody is killed, 32 cpu VM,
median of 21-27 runs, msec:

                                  detach          attach
                               before  after   before  after
  4096 uprobes, 1 process        33.5   69.4     7.35   7.44
  1024 uprobes, 100 processes    95.0    102     38.1   43.4
  256 uprobes, 1000 processes     182    192      107    117

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/events/uprobes.c | 74 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 92ccb730278f..361b52c9c3bc 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1426,6 +1426,68 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 	return walk.err;
 }
 
+struct unregister_work {
+	struct work_struct work;
+	struct uprobe *uprobe;
+	int err;
+};
+
+static void unregister_work_fn(struct work_struct *work)
+{
+	struct unregister_work *uw = container_of(work, struct unregister_work, work);
+
+	uw->err = register_for_each_vma(uw->uprobe, NULL);
+}
+
+/*
+ * Remove the breakpoints. If current is killed, get_user_pages_remote() fails
+ * with -EINTR from then on: the breakpoints which are left stay for good, and
+ * the removal which was interrupted can be left half-way, with the reference
+ * counter decremented but the breakpoint still there. So let a kworker do the
+ * job, it has no signals. It takes the locks we would take ourselves.
+ * (A fork() of an mm with busy mmap_lock can still do one removal in a task
+ * which is being killed, see register_one_mm().)
+ *
+ * A kernel thread can do it itself. So can anybody if nobody maps the file:
+ * then there is no breakpoint, and uprobe_mmap() installs none which we would
+ * have to remove.
+ */
+static int unregister_all_vmas(struct uprobe *uprobe)
+{
+	struct address_space *mapping = uprobe->inode->i_mapping;
+	struct unregister_work uw = { .uprobe = uprobe };
+	bool mapped;
+	int err;
+
+	/*
+	 * vma_prepare() takes a vma out of the tree and vma_complete() puts it
+	 * back, under i_mmap_lock_write(). Don't mistake that for an empty tree.
+	 */
+	i_mmap_lock_read(mapping);
+	mapped = mapping_mapped(mapping);
+	i_mmap_unlock_read(mapping);
+
+	if (!mapped || (current->flags & PF_KTHREAD)) {
+		err = register_for_each_vma(uprobe, NULL);
+		/*
+		 * An error with a fatal signal pending: the file was mapped
+		 * meanwhile, and get_user_pages_remote() returned -EINTR before
+		 * it could see that there is nothing to remove. Nothing was
+		 * written, so it is safe to let the kworker repeat the walk.
+		 * (Kernel threads which unregister uprobes don't allow SIGKILL.)
+		 */
+		if (likely(!err) || !fatal_signal_pending(current))
+			return err;
+	}
+
+	INIT_WORK_ONSTACK(&uw.work, unregister_work_fn);
+	queue_work(system_dfl_long_wq, &uw.work);
+	flush_work(&uw.work);
+	destroy_work_on_stack(&uw.work);
+
+	return uw.err;
+}
+
 /**
  * uprobe_unregister_nosync - unregister an already registered probe.
  * @uprobe: uprobe to remove
@@ -1437,10 +1499,13 @@ void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc)
 
 	down_write(&uprobe->register_rwsem);
 	consumer_del(uprobe, uc);
-	err = register_for_each_vma(uprobe, NULL);
+	err = unregister_all_vmas(uprobe);
 	up_write(&uprobe->register_rwsem);
 
-	/* TODO : cant unregister? schedule a worker thread */
+	/*
+	 * Can still fail, e.g. with -ENOMEM. Then the uprobe and the breakpoints
+	 * which are left are leaked.
+	 */
 	if (unlikely(err)) {
 		uprobe_warn(current, "unregister, leaking uprobe");
 		return;
@@ -1553,7 +1618,10 @@ int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
 	rcu_read_lock_trace();
 	list_for_each_entry_rcu(con, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
 		if (con == uc) {
-			ret = register_for_each_vma(uprobe, add ? uc : NULL);
+			if (add)
+				ret = register_for_each_vma(uprobe, uc);
+			else
+				ret = unregister_all_vmas(uprobe);
 			break;
 		}
 	}
-- 
2.55.0

