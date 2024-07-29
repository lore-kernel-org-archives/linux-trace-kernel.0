Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F61E515
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260729; cv=none; b=tcjuDmKQdQK05TRVI/Q805X6VbxPUsovdqdBS6Wz5BBdoWBFs/wbDDafaAU7wYSZjnMvHnNHKaf6Gm0Fc25Csk9QP5Ob+98EmF6DMJQ/9452e+eBVfLxbxIprQBMvcg/ouj09YwEtX0IIkjg5uWrNtrt8LXuqprRlzUZnup2vHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260729; c=relaxed/simple;
	bh=zb+iSTZql4KUsZK64L6rRY8KfVbZ0mEgSRJm30yZ8RM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HSc7ByCayzO1Nhf/wdLalcpcmo7Mr3LIs4PI68rWQaBtq5VGMYEaUKgfjUGJbJg3fU7fPdSXAtBPWbRU13Mc7ptS/pmz8mcjSObosWLJhi71MSkRRY4DZIZ9FxndnwVp86V/rVBBn2PDKKKmq+s7hICqs7uTDepeLA6c+gNq4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ItrkG75h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItrkG75h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722260726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=C1WJNTBKD5J69MOoXoXQgf3CGd2QKsmfAAAZ+V0MGsE=;
	b=ItrkG75hfNXS9ioYmpJ8dT6VFOGND98DyAFEUE+c2IAPJXYpd6Gu9MZgVrdT+UCiuxswF6
	ZQ6ExXXS5QG+1anspFAbYMzyo/9F938WvpaCmdGLBlKZBavCz8ygP3ez1SaVr7h2D3lhLA
	Ipc2dQzTAZ63sLi4Z0BEqFlkPdogtNM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-TbW1ZuUnMP6dDLjn_tNGyw-1; Mon,
 29 Jul 2024 09:45:20 -0400
X-MC-Unique: TbW1ZuUnMP6dDLjn_tNGyw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 489B41955D59;
	Mon, 29 Jul 2024 13:45:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.232])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 583151955D47;
	Mon, 29 Jul 2024 13:45:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 29 Jul 2024 15:45:18 +0200 (CEST)
Date: Mon, 29 Jul 2024 15:45:14 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] uprobes: document the usage of mm->mmap_lock
Message-ID: <20240729134514.GA12309@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729134444.GA12293@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The comment above uprobe_write_opcode() is wrong, unapply_uprobe() calls
it under mmap_read_lock() and this is correct.

And it is completely unclear why register_for_each_vma() takes mmap_lock
for writing, add a comment to explain that mmap_write_lock() is needed to
avoid the following race:

	- A task T hits the bp installed by uprobe and calls
	  find_active_uprobe()

	- uprobe_unregister() removes this uprobe/bp

	- T calls find_uprobe() which returns NULL

	- another uprobe_register() installs the bp at the same address

	- T calls is_trap_at_addr() which returns true

	- T returns to handle_swbp() and gets SIGTRAP.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 73cc47708679..73dd12b09a7b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -453,7 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * @vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @vaddr.
  *
- * Called with mm->mmap_lock held for write.
+ * Called with mm->mmap_lock held for read or write.
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
@@ -1046,7 +1046,13 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 
 		if (err && is_register)
 			goto free;
-
+		/*
+		 * We take mmap_lock for writing to avoid the race with
+		 * find_active_uprobe() which takes mmap_lock for reading.
+		 * Thus this install_breakpoint() can not make
+		 * is_trap_at_addr() true right after find_uprobe()
+		 * returns NULL in find_active_uprobe().
+		 */
 		mmap_write_lock(mm);
 		vma = find_vma(mm, info->vaddr);
 		if (!vma || !valid_vma(vma, is_register) ||
-- 
2.25.1.362.g51ebf55

