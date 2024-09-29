Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD1183CC9
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727621002; cv=none; b=o7u913SI74dM0CK9AHAqS6pdbiONIsn62gn9Bop0MYwEQfb1/veNarNivFBG3fHWFnnVKf6D3QkbrWXdQFKxJkTZxp2dB8QHBcJRIlj3qRy2QDr2DPvOHJHjbLzmTiiKOOjFg12fiIq0dWNQeBSVTSgQ7U+sRzo39FA5qNnGNQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727621002; c=relaxed/simple;
	bh=FfaZhrQq34BZlheLdSwojN4sapArypT72+Y+nLTOLDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HfBnbHLGkdmbH4HZ9zr6ATiqY5e158mmKy8m0m7hCYUuNM1XpeELRbMX2oARkYbDV97uLyMr+gwfuuZjjSlEmJu+OPB3TioiRk+SMDTIVdMrqD9Y3EDWc92L9QuQWe638r7/+fq6FZTS6rbOtWpQyTFj/Y0/7yt7Y6LUmXDf1CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcOlL1X9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcOlL1X9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727621000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=PFEiL3F5MSjU++Jxe01AvOazddBzZZRjIDhG9rgyzoQ=;
	b=fcOlL1X9TFa4n8u/GCm8dWpVUOpDmdhiRws/8o/KJTDva0nQyHtKi7KGxGe6lE7ac6hsli
	2V3CV4FlleOhUfOy9o/0TLn1BX6sm5N0o6J39/T81V+DJgBi9hH+oQCLEKT0unIZei5kLy
	NzbyHbJfnuoqjHyCTBZrKuAAnbGMU/k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-2aiClEGVNq6dSkKRgCxqKg-1; Sun,
 29 Sep 2024 10:43:16 -0400
X-MC-Unique: 2aiClEGVNq6dSkKRgCxqKg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42BB0195FE21;
	Sun, 29 Sep 2024 14:43:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 90E271979060;
	Sun, 29 Sep 2024 14:43:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Sep 2024 16:43:01 +0200 (CEST)
Date: Sun, 29 Sep 2024 16:42:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 7/7] uprobes: deny mremap(xol_vma)
Message-ID: <20240929144258.GA9492@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

kernel/events/uprobes.c assumes that xol_area->vaddr is always correct but
a malicious application can remap its "[uprobes]" vma to another adress to
confuse the kernel. Introduce xol_mremap() to make this impossible.

With this change utask->xol_vaddr in xol_free_insn_slot() can't be invalid,
we can turn the offset check into WARN_ON_ONCE(offset >= PAGE_SIZE).

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index da45d0e5bcf4..20c58b6ee1ad 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1475,9 +1475,15 @@ static vm_fault_t xol_fault(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+static int xol_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
+{
+	return -EPERM;
+}
+
 static const struct vm_special_mapping xol_mapping = {
 	.name = "[uprobes]",
 	.fault = xol_fault,
+	.mremap = xol_mremap,
 };
 
 /* Slot allocation for XOL */
@@ -1670,21 +1676,19 @@ static void xol_free_insn_slot(struct uprobe_task *utask)
 {
 	struct xol_area *area = current->mm->uprobes_state.xol_area;
 	unsigned long offset = utask->xol_vaddr - area->vaddr;
+	unsigned int slot_nr;
 
 	utask->xol_vaddr = 0;
-	/*
-	 * xol_vaddr must fit into [area->vaddr, area->vaddr + PAGE_SIZE).
-	 * This check can only fail if the "[uprobes]" vma was mremap'ed.
-	 */
-	if (offset < PAGE_SIZE) {
-		int slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
-
-		clear_bit(slot_nr, area->bitmap);
-		atomic_dec(&area->slot_count);
-		smp_mb__after_atomic(); /* pairs with prepare_to_wait() */
-		if (waitqueue_active(&area->wq))
-			wake_up(&area->wq);
-	}
+	/* xol_vaddr must fit into [area->vaddr, area->vaddr + PAGE_SIZE) */
+	if (WARN_ON_ONCE(offset >= PAGE_SIZE))
+		return;
+
+	slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
+	clear_bit(slot_nr, area->bitmap);
+	atomic_dec(&area->slot_count);
+	smp_mb__after_atomic(); /* pairs with prepare_to_wait() */
+	if (waitqueue_active(&area->wq))
+		wake_up(&area->wq);
 }
 
 void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
-- 
2.25.1.362.g51ebf55

