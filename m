Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567B1C4619
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792734; cv=none; b=cE19iK9O7QrTbsNNwcXR0oOm2rknXzXrODXNMPo3qSiMXelspoN9mLIog/2Mfh0wrEI9r6ZruC515x6OzhMqDhKBJElF08u9G7UWICgo4TA7+Jrfk14n+fELN5FCFfeBy61XYnrNhgwUTF3O9W4JJa2wdC4FIuY7CzGn6yqyPgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792734; c=relaxed/simple;
	bh=gs8sCIWGVClZmQGRAjTinJEKiYPTNdveadZOaLKKc6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dDYca2kWuoQEBJBqch+pfmhx1VlG8Bbz4gqn3t07grl2PKZX8XhgtbuCB+YcNlP1moJ/yKzwSRNdK4+EeNLv1XMpsEH9yju03Kp0ZysLUJ4hnptETYNBLvgUnWFtYfzRh2MJDe2DO141yRZyG6WaWij3hUXVBs6J69rEOaSGVj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2o67cWo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2o67cWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727792732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=OakJ4msEqx8tZ0UDaJqBnUchDvgKLocyq9Ke5f2R7+Y=;
	b=a2o67cWoBhDlD/6DH3otgOOVdxBd4PpE21Ysi3zCqGjJIQSB9CxH7+fPKYc/QlAdGXwBd7
	RzTNRSVbT6roAq8YPz/HDQAZ8msr74x7BJnQW82zWd5JiP/3vSFY5c3VH7VPPF+1jwUByV
	j1OpKJdyeZh8q7X5DmFb7lR4idocUo8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-KDe-G_QzMwanQAZpMA0bDA-1; Tue,
 01 Oct 2024 10:25:27 -0400
X-MC-Unique: KDe-G_QzMwanQAZpMA0bDA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7A321916BD7;
	Tue,  1 Oct 2024 14:25:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B34183011D3D;
	Tue,  1 Oct 2024 14:25:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  1 Oct 2024 16:25:02 +0200 (CEST)
Date: Tue, 1 Oct 2024 16:24:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/2] uprobes: kill xol_area->slot_count
Message-ID: <20241001142458.GA13629@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001142416.GA13599@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add the new helper, xol_get_slot_nr() which does
find_first_zero_bit() + test_and_set_bit().

xol_take_insn_slot() can wait for the "xol_get_slot_nr() < UINSNS_PER_PAGE"
event instead of "area->slot_count < UINSNS_PER_PAGE".

So we can kill area->slot_count and avoid atomic_inc() + atomic_dec(), this
simplifies the code and can slightly improve the performance.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 20c58b6ee1ad..38d91e10d455 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -100,7 +100,6 @@ static LIST_HEAD(delayed_uprobe_list);
  */
 struct xol_area {
 	wait_queue_head_t 		wq;		/* if all slots are busy */
-	atomic_t 			slot_count;	/* number of in-use slots */
 	unsigned long 			*bitmap;	/* 0 = free slot */
 
 	struct page			*page;
@@ -1559,7 +1558,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	init_waitqueue_head(&area->wq);
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
-	atomic_set(&area->slot_count, 1);
 	insns = arch_uprobe_trampoline(&insns_size);
 	arch_uprobe_copy_ixol(area->page, 0, insns, insns_size);
 
@@ -1632,24 +1630,28 @@ void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
 	}
 }
 
+static unsigned long xol_get_slot_nr(struct xol_area *area)
+{
+	unsigned long slot_nr;
+
+	slot_nr = find_first_zero_bit(area->bitmap, UINSNS_PER_PAGE);
+	if (slot_nr < UINSNS_PER_PAGE) {
+		if (!test_and_set_bit(slot_nr, area->bitmap))
+			return slot_nr;
+	}
+
+	return UINSNS_PER_PAGE;
+}
+
 /*
  *  - search for a free slot.
  */
 static unsigned long xol_take_insn_slot(struct xol_area *area)
 {
-	unsigned int slot_nr;
+	unsigned long slot_nr;
 
-	for (;;) {
-		slot_nr = find_first_zero_bit(area->bitmap, UINSNS_PER_PAGE);
-		if (slot_nr < UINSNS_PER_PAGE) {
-			if (!test_and_set_bit(slot_nr, area->bitmap))
-				break;
-			continue;
-		}
-		wait_event(area->wq, (atomic_read(&area->slot_count) < UINSNS_PER_PAGE));
-	}
+	wait_event(area->wq, (slot_nr = xol_get_slot_nr(area)) < UINSNS_PER_PAGE);
 
-	atomic_inc(&area->slot_count);
 	return area->vaddr + slot_nr * UPROBE_XOL_SLOT_BYTES;
 }
 
@@ -1685,7 +1687,6 @@ static void xol_free_insn_slot(struct uprobe_task *utask)
 
 	slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
 	clear_bit(slot_nr, area->bitmap);
-	atomic_dec(&area->slot_count);
 	smp_mb__after_atomic(); /* pairs with prepare_to_wait() */
 	if (waitqueue_active(&area->wq))
 		wake_up(&area->wq);
-- 
2.25.1.362.g51ebf55

