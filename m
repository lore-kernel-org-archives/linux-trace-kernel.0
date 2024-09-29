Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB9183088
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727620998; cv=none; b=nW8ijxR7NebKBOI4RwGqKhXmYwlK/vOkxUXfDZoPdTel9bppyOT12fFlrJVw3K+49pOxUYUCNjkzVP/CJ+xoVBa728my3iDvizpOe+ptNyyGVNJlWHmx5KF1lo+l8dcks4xxvQBSptB92MONcUu3ke4mG27juMVj8fis1/WwaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727620998; c=relaxed/simple;
	bh=mnE4trvkE9/VgExdbnRnWJG5l/jEO8ThaYtZ1F8rCuk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jE+tTaK0vIVhE+5p5+FOmliXrYAReNzE+Dc1MLZm0cjopq4JdIFyGlHV3i5/Rvs9fn/Q3KAftCokEet+3FcqDAlg44o3uSZbpmH7QR7aA/o88vapRcOXD0kEdE0psw8pGwKF5f7SZ6cK6tL2If28kMBww52h0eaJmmlHlkRtWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7Fdbxnb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7Fdbxnb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727620995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=sQ1CTBKnRWK4uC6arvzLMaDJzn3AO5JvwnwPCBgfSjU=;
	b=C7FdbxnbFRa9aY3+3spPSqdilvMynsnTm1cml9NvEhK841q1ydf2pdJZ4+VeVsga3e6DYz
	+uOBQetSSImndxhRWyD8y+RT015lE92HnXddJj+vYf1FkHkLqezr1MwWmD4jerSjpHnzuH
	yGExQ0TUKhPSZzuGQPeyh9doCBqoDvg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-aVe4cFt4PJiC0Hz1rE7SrA-1; Sun,
 29 Sep 2024 10:43:12 -0400
X-MC-Unique: aVe4cFt4PJiC0Hz1rE7SrA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A353219030A7;
	Sun, 29 Sep 2024 14:43:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D883B3003E40;
	Sun, 29 Sep 2024 14:43:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Sep 2024 16:42:57 +0200 (CEST)
Date: Sun, 29 Sep 2024 16:42:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 6/7] uprobes: pass utask to xol_get_insn_slot() and
 xol_free_insn_slot()
Message-ID: <20240929144253.GA9487@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929144201.GA9429@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add the "struct uprobe_task *utask" argument to xol_get_insn_slot() and
xol_free_insn_slot(), their callers already have it so we can avoid the
unnecessary dereference and simplify the code.

Kill the "tsk" argument of xol_free_insn_slot(), it is always current.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a7223be5ac2e..da45d0e5bcf4 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1650,9 +1650,8 @@ static unsigned long xol_take_insn_slot(struct xol_area *area)
 /*
  * xol_get_insn_slot - allocate a slot for xol.
  */
-static bool xol_get_insn_slot(struct uprobe *uprobe)
+static bool xol_get_insn_slot(struct uprobe *uprobe, struct uprobe_task *utask)
 {
-	struct uprobe_task *utask = current->utask;
 	struct xol_area *area = get_xol_area();
 
 	if (!area)
@@ -1667,12 +1666,12 @@ static bool xol_get_insn_slot(struct uprobe *uprobe)
 /*
  * xol_free_insn_slot - free the slot allocated by xol_get_insn_slot()
  */
-static void xol_free_insn_slot(struct task_struct *tsk)
+static void xol_free_insn_slot(struct uprobe_task *utask)
 {
-	struct xol_area *area = tsk->mm->uprobes_state.xol_area;
-	unsigned long offset = tsk->utask->xol_vaddr - area->vaddr;
+	struct xol_area *area = current->mm->uprobes_state.xol_area;
+	unsigned long offset = utask->xol_vaddr - area->vaddr;
 
-	tsk->utask->xol_vaddr = 0;
+	utask->xol_vaddr = 0;
 	/*
 	 * xol_vaddr must fit into [area->vaddr, area->vaddr + PAGE_SIZE).
 	 * This check can only fail if the "[uprobes]" vma was mremap'ed.
@@ -1954,7 +1953,7 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	if (!try_get_uprobe(uprobe))
 		return -EINVAL;
 
-	if (!xol_get_insn_slot(uprobe)) {
+	if (!xol_get_insn_slot(uprobe, utask)) {
 		err = -ENOMEM;
 		goto err_out;
 	}
@@ -1962,7 +1961,7 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	utask->vaddr = bp_vaddr;
 	err = arch_uprobe_pre_xol(&uprobe->arch, regs);
 	if (unlikely(err)) {
-		xol_free_insn_slot(current);
+		xol_free_insn_slot(utask);
 		goto err_out;
 	}
 
@@ -2313,7 +2312,7 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 	put_uprobe(uprobe);
 	utask->active_uprobe = NULL;
 	utask->state = UTASK_RUNNING;
-	xol_free_insn_slot(current);
+	xol_free_insn_slot(utask);
 
 	spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending(); /* see uprobe_deny_signal() */
-- 
2.25.1.362.g51ebf55

