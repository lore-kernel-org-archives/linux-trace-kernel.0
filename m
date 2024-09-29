Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4FF152790
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727620980; cv=none; b=cd/6Y/jknYPcQgu3KwGlzj/RsR5k84+i29RXTe1/IjYyQLuGJH50bZgq8GtyPL2fXNJZ0/jNfAkY+XCQKKh9YwPZb48/AbkoYf08Pg/rtdMRf5A1ZX4Z6+CqYsTknFsTPTqVPwakR5FBE24HTiIRN97tpjowvIKYZjGDhD7wIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727620980; c=relaxed/simple;
	bh=SW0a/2y9x5XuxLHYhEeUJoJubePyKUh+UH4ExDXUbI8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sNHiRhNPVKcAeoFwuTMP30VofADessurhTzXeS01isgJegfB8BJzRXbO35S17dBqYnybYvCAC53icqNKOEUrdb7oF2EVa3ZBOSZuHy3G4hhsUk16qesYIejCXdZy0oo89MxJpBq9FPHQ/+MywPCm/0CrIxkcxvOIGM1I0/IfoPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=av+c0kuL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="av+c0kuL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727620977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=+dC6z3bA6xQ8q0W/xhGSjQmv+2uYs7hECJrc8EdB/mM=;
	b=av+c0kuLkNz+ZWl6WpCCip9j58lMRsD6wdOrfyk2rBnThvKe9xd+//et6HmrLgI+waiSiP
	lFss/K4SdtHSa0mlXTM/TD4o0qwM9CcRtd4xnknseHZuQAMJBYyTeJEFKB1i9Ia03dkNrX
	Ur3hBmSHL0lcTs/U4YsibqzVg8oc+nk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-mQEtUGoCOaCeMjArfJysMQ-1; Sun,
 29 Sep 2024 10:42:54 -0400
X-MC-Unique: mQEtUGoCOaCeMjArfJysMQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 206071919156;
	Sun, 29 Sep 2024 14:42:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6E3E41979060;
	Sun, 29 Sep 2024 14:42:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Sep 2024 16:42:38 +0200 (CEST)
Date: Sun, 29 Sep 2024 16:42:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/7] uprobes: sanitiize xol_free_insn_slot()
Message-ID: <20240929144235.GA9471@redhat.com>
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

1. Clear utask->xol_vaddr unconditionally, even if this addr is not valid,
   xol_free_insn_slot() should never return with utask->xol_vaddr != NULL.

2. Add a comment to explain why do we need to validate slot_addr.

3. Simplify the validation above. We can simply check offset < PAGE_SIZE,
   unsigned underflows are fine, it should work if slot_addr < area->vaddr.

4. Kill the unnecessary "slot_nr >= UINSNS_PER_PAGE" check, slot_nr must
   be valid if offset < PAGE_SIZE.

The next patches will cleanup this function even more.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2a9cdd5c82d7..3023714b83f2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1683,8 +1683,8 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 static void xol_free_insn_slot(struct task_struct *tsk)
 {
 	struct xol_area *area;
-	unsigned long vma_end;
 	unsigned long slot_addr;
+	unsigned long offset;
 
 	if (!tsk->mm || !tsk->mm->uprobes_state.xol_area || !tsk->utask)
 		return;
@@ -1693,24 +1693,21 @@ static void xol_free_insn_slot(struct task_struct *tsk)
 	if (unlikely(!slot_addr))
 		return;
 
+	tsk->utask->xol_vaddr = 0;
 	area = tsk->mm->uprobes_state.xol_area;
-	vma_end = area->vaddr + PAGE_SIZE;
-	if (area->vaddr <= slot_addr && slot_addr < vma_end) {
-		unsigned long offset;
-		int slot_nr;
-
-		offset = slot_addr - area->vaddr;
-		slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
-		if (slot_nr >= UINSNS_PER_PAGE)
-			return;
+	offset = slot_addr - area->vaddr;
+	/*
+	 * slot_addr must fit into [area->vaddr, area->vaddr + PAGE_SIZE).
+	 * This check can only fail if the "[uprobes]" vma was mremap'ed.
+	 */
+	if (offset < PAGE_SIZE) {
+		int slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
 
 		clear_bit(slot_nr, area->bitmap);
 		atomic_dec(&area->slot_count);
 		smp_mb__after_atomic(); /* pairs with prepare_to_wait() */
 		if (waitqueue_active(&area->wq))
 			wake_up(&area->wq);
-
-		tsk->utask->xol_vaddr = 0;
 	}
 }
 
-- 
2.25.1.362.g51ebf55

