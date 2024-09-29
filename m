Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F6917D346
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727620983; cv=none; b=MeD/+xpQR18IKbJH1WO2u3lbkesx17NIzl9tOfiBbrHEs6sm6b0Cx8q4nrdvZ2cI8gTuWV5OXQHQ47ovaGALEJ+Kzmeiozd4vFUKT15Fk6563hcRbTh7MTi6MNiPxB91M5tRFWPfu5UHY1Oju7qALK2Ydl+RMbgilx9g867ObrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727620983; c=relaxed/simple;
	bh=r9g2mDKo1VyZh/uQk94rwCQODx7VEt13cnsjwkriLJY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b2jFb8E6uWeHdgsTWC14Fok/RPtGHP9rm70qpiApYO9q9XdKVpRAdXRo4y53g4xEAB0pKKBB1GP4ntHD5eHzKRCDCFc2QwdGNjeslvE7r4P3nfCW7MO5lFywMExPs/gKu2ctPEIokvMDpo56lHhYsmTBz/OEcMDv2FBfUpKgyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMgAssKR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMgAssKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727620981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=mEl9ds8cbxbLGs6JnmKeAQsfkw4QJ2bnOpSp9pzGta8=;
	b=AMgAssKRdhMznu4P+I1AFafYG15ofOaz41szQaD6HV4QqUgAqoLOWNRk841qvicIM1baBf
	wLBT4DDUhgY+gje97BY41zJYt1R2WFKQ+Yba8LdHscyk04jDe7iDxn3p6wakzYpjDOz3+A
	FeygGk7KLkvug/4DdKuKd6CpUYwWGSI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-Yhzs64IxNfqpMlvjWoTwfw-1; Sun,
 29 Sep 2024 10:42:58 -0400
X-MC-Unique: Yhzs64IxNfqpMlvjWoTwfw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B460119B9ABA;
	Sun, 29 Sep 2024 14:42:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0ED1B1944B22;
	Sun, 29 Sep 2024 14:42:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Sep 2024 16:42:43 +0200 (CEST)
Date: Sun, 29 Sep 2024 16:42:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/7] uprobes: kill the unnecessary
 put_uprobe/xol_free_insn_slot in uprobe_free_utask()
Message-ID: <20240929144239.GA9475@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

If pre_ssout() succeeds and sets utask->active_uprobe and utask->xol_vaddr
the task must not exit until it calls handle_singlestep() which does the
necessary put_uprobe() and xol_free_insn_slot().

Remove put_uprobe() and xol_free_insn_slot() from uprobe_free_utask(). With
this change xol_free_insn_slot() can't hit xol_area/utask/xol_vaddr == NULL,
we can kill the unnecessary checks checks and simplify this function more.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 3023714b83f2..4619de10772e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1676,28 +1676,16 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 }
 
 /*
- * xol_free_insn_slot - If slot was earlier allocated by
- * @xol_get_insn_slot(), make the slot available for
- * subsequent requests.
+ * xol_free_insn_slot - free the slot allocated by xol_get_insn_slot()
  */
 static void xol_free_insn_slot(struct task_struct *tsk)
 {
-	struct xol_area *area;
-	unsigned long slot_addr;
-	unsigned long offset;
-
-	if (!tsk->mm || !tsk->mm->uprobes_state.xol_area || !tsk->utask)
-		return;
-
-	slot_addr = tsk->utask->xol_vaddr;
-	if (unlikely(!slot_addr))
-		return;
+	struct xol_area *area = tsk->mm->uprobes_state.xol_area;
+	unsigned long offset = tsk->utask->xol_vaddr - area->vaddr;
 
 	tsk->utask->xol_vaddr = 0;
-	area = tsk->mm->uprobes_state.xol_area;
-	offset = slot_addr - area->vaddr;
 	/*
-	 * slot_addr must fit into [area->vaddr, area->vaddr + PAGE_SIZE).
+	 * xol_vaddr must fit into [area->vaddr, area->vaddr + PAGE_SIZE).
 	 * This check can only fail if the "[uprobes]" vma was mremap'ed.
 	 */
 	if (offset < PAGE_SIZE) {
@@ -1767,14 +1755,12 @@ void uprobe_free_utask(struct task_struct *t)
 	if (!utask)
 		return;
 
-	if (utask->active_uprobe)
-		put_uprobe(utask->active_uprobe);
+	WARN_ON_ONCE(utask->active_uprobe || utask->xol_vaddr);
 
 	ri = utask->return_instances;
 	while (ri)
 		ri = free_ret_instance(ri);
 
-	xol_free_insn_slot(t);
 	kfree(utask);
 	t->utask = NULL;
 }
-- 
2.25.1.362.g51ebf55

