Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D1017E003
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727620988; cv=none; b=GEoo7yyuHSOMMSYVpX0MMHn8c3wn0RNT1iGsFtgdV8zeml1nv9saC5XjNdsqtjItxLHO6dL5GRTkXlSkzrNsLVuCms+BI2xt7zWDyQBOHUi5SHenjfIhTnuDW85FBs+NKid4DrFDyVgGolFZ9vXAEEqW9qg8NrLrX9/P2iahbhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727620988; c=relaxed/simple;
	bh=Qx3crvMAj4oJepAs7rbIw8d48jGe7BvkfQ64tpGkwjk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=unUm3Rts3U/FIBm16NeLyCqFoTi17GiSqgkWh+4vmJvMpFKCnPx8tEzFbUZ5J2huv1g7iHzOiYlzZunT/uG66UpSpQMmwb9MPL4Pr6fvJcFpr7QCKkM63ndnxPq9iNQ9VyP7KfqNDJj/wSv7lcbiiLF8Kpgc/hILXGlkdhJ0nyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJAwTOzy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJAwTOzy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727620986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=qbjSc/cnZvendjL1YV2TjPPnNKKr87Pa0C3JPTQomg0=;
	b=HJAwTOzySelOaGMtDTCU1oII6s1ovRpS6DqnbAuYEndbiwwhPRg2j+uiWAen1nLnnEr+Zx
	H/ccxQXqBvAbZcE864HIzFxqc3yUWve1PQXcaTRL3wa3eyRKPgzLiU08ej5awcBkU/bup8
	Nsd4BBRiJqjT43Gn91+9nCwybwEETUU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-J86Hbp8iMtqg-Jva_QujWQ-1; Sun,
 29 Sep 2024 10:43:02 -0400
X-MC-Unique: J86Hbp8iMtqg-Jva_QujWQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FC73190ECE8;
	Sun, 29 Sep 2024 14:43:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8A1D01979060;
	Sun, 29 Sep 2024 14:42:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Sep 2024 16:42:47 +0200 (CEST)
Date: Sun, 29 Sep 2024 16:42:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 4/7] uprobes: simplify xol_take_insn_slot() and its caller
Message-ID: <20240929144244.GA9480@redhat.com>
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

The do / while (slot_nr >= UINSNS_PER_PAGE) loop in xol_take_insn_slot()
makes no sense, the checked condition is always true. Change this code
to use the "for (;;)" loop, this way we do not need to change slot_nr if
test_and_set_bit() fails.

Also, kill the unnecessary xol_vaddr != NULL check in xol_get_insn_slot(),
xol_take_insn_slot() never returns NULL.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4619de10772e..bfe106ecad38 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1631,25 +1631,20 @@ void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
  */
 static unsigned long xol_take_insn_slot(struct xol_area *area)
 {
-	unsigned long slot_addr;
-	int slot_nr;
+	unsigned int slot_nr;
 
-	do {
+	for (;;) {
 		slot_nr = find_first_zero_bit(area->bitmap, UINSNS_PER_PAGE);
 		if (slot_nr < UINSNS_PER_PAGE) {
 			if (!test_and_set_bit(slot_nr, area->bitmap))
 				break;
-
-			slot_nr = UINSNS_PER_PAGE;
 			continue;
 		}
 		wait_event(area->wq, (atomic_read(&area->slot_count) < UINSNS_PER_PAGE));
-	} while (slot_nr >= UINSNS_PER_PAGE);
+	}
 
-	slot_addr = area->vaddr + (slot_nr * UPROBE_XOL_SLOT_BYTES);
 	atomic_inc(&area->slot_count);
-
-	return slot_addr;
+	return area->vaddr + slot_nr * UPROBE_XOL_SLOT_BYTES;
 }
 
 /*
@@ -1666,12 +1661,8 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 		return 0;
 
 	xol_vaddr = xol_take_insn_slot(area);
-	if (unlikely(!xol_vaddr))
-		return 0;
-
 	arch_uprobe_copy_ixol(area->page, xol_vaddr,
 			      &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
-
 	return xol_vaddr;
 }
 
-- 
2.25.1.362.g51ebf55

