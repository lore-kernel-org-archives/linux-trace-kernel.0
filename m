Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC521C68B4
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792736; cv=none; b=f4nE6KwIm8CyJpuoRn7DdG1T1JBdfjRFKHSIUsYQMbADqU5Nh5JBB/En3K7V0jJpRLO4lrFNARaYatU/1R0imwqDMHV8WefLeauDuSVQjUIzedaNHGq7LPXA0dR0zHUzzeqipwhS18uN4916e0Xh3mGGl92+T7BYUDnFXOXbmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792736; c=relaxed/simple;
	bh=kB/vCOQVk1IMdjsq58HX7OYOPky84hE7fvfuCRDEbaE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bp08BlMh1PwB/O5u59PWDNeKXjXrzOuE9Y796lcJlwF+KxzgRCg6d8wtA0A0Itsgh1kRrpUv3iMPrYPDh+whjCGPeZ4E4enouBCZN+WIeSOHD26wZNn26hpsAZZ1mM6fpsCmLiZgwVKjdalxdD1QdAOFtVk1nlJQJvziMElaX9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkoISeZk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkoISeZk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727792733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=CAhIXQw4AKu0nqECcGYlfSjZV7z+K8tHHRI3flDnkjE=;
	b=FkoISeZkq4AYrh9zZ0PTJYzPZT1fRb9CxZmJXhpplmJBqvdc7A97tYPsi7g4kEWf+1kGAe
	qHDIJO/M9X5cVM+H+4O/qOrT9qcrFnjaHGBqwelzxe6MwN5kqOSs/a8NHluMjU2v7cyfWP
	0Q4KBmv59NLr3NTWAidpYM3u0oIkmIA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-3yGILTEaMIiaAB3D8evZpg-1; Tue,
 01 Oct 2024 10:25:26 -0400
X-MC-Unique: 3yGILTEaMIiaAB3D8evZpg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF7CA18D9F11;
	Tue,  1 Oct 2024 14:25:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 861EA301228D;
	Tue,  1 Oct 2024 14:25:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  1 Oct 2024 16:25:07 +0200 (CEST)
Date: Tue, 1 Oct 2024 16:25:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] uprobes: fold xol_take_insn_slot() into
 xol_get_insn_slot()
Message-ID: <20241001142503.GA13633@redhat.com>
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

After the previous change xol_take_insn_slot() becomes trivial, kill it.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 38d91e10d455..40ecab0971ff 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1643,29 +1643,20 @@ static unsigned long xol_get_slot_nr(struct xol_area *area)
 	return UINSNS_PER_PAGE;
 }
 
-/*
- *  - search for a free slot.
- */
-static unsigned long xol_take_insn_slot(struct xol_area *area)
-{
-	unsigned long slot_nr;
-
-	wait_event(area->wq, (slot_nr = xol_get_slot_nr(area)) < UINSNS_PER_PAGE);
-
-	return area->vaddr + slot_nr * UPROBE_XOL_SLOT_BYTES;
-}
-
 /*
  * xol_get_insn_slot - allocate a slot for xol.
  */
 static bool xol_get_insn_slot(struct uprobe *uprobe, struct uprobe_task *utask)
 {
 	struct xol_area *area = get_xol_area();
+	unsigned long slot_nr;
 
 	if (!area)
 		return false;
 
-	utask->xol_vaddr = xol_take_insn_slot(area);
+	wait_event(area->wq, (slot_nr = xol_get_slot_nr(area)) < UINSNS_PER_PAGE);
+
+	utask->xol_vaddr = area->vaddr + slot_nr * UPROBE_XOL_SLOT_BYTES;
 	arch_uprobe_copy_ixol(area->page, utask->xol_vaddr,
 			      &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
 	return true;
-- 
2.25.1.362.g51ebf55

