Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246FF17C9B9
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727620993; cv=none; b=uE7KtVDhM1av9HoPsG4PHOMtL/17VygqFcw3DsEgWQC8cuBY4WcdzoNhmIMANwo5/qZfUsChX6Z9J+i5DpYShGbCRxfLRqha9VwwTWz9VbDOFiM8e2yWgc71Kbw/ztXJCI+4hR15QBcpFozR3/iKZlx51Go0HaL3cn3msKLq0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727620993; c=relaxed/simple;
	bh=4yqWNnyhvMBa++hA/O2fKRiM/JnaiH2w9lyssaDVduU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H5D7xZUlT7IldEV7tlzlN5wc5DQYe8uhRaNm2Z2Du6XK5bVjsO/VnnSBLlD7VRXs/PtXmyZR4dk0fJ7bHVglk1XAnovsH9Cz9pAB/egUR6MKobSw8boQoHPrXErNW8D1r6aNLRmIdNqpWzywpLgGZacA6Yo0FoVyceWerYDvS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwtUS/Fb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwtUS/Fb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727620991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=1HZRMRvEFHJMDMiUg5OPpXavNPgBWInozzwyVSKhvk4=;
	b=AwtUS/FbZU6if3usuQd80S6ZFEVd5WPCl4vxXllJ2+24TdK031ACI5s0F5eMBMaUIgNZ4b
	/zmK15Q8wqdvMZmv4i7tMbVOuekrvxMycMOqnTEb1mdURw0UjBau7WMiPIpruhkth1aXKc
	FKe7Ek2ZNVwzVt6n4KisIxaf/BsB15A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-b_c1T7tlOgqfbMOZEy7KrQ-1; Sun,
 29 Sep 2024 10:43:07 -0400
X-MC-Unique: b_c1T7tlOgqfbMOZEy7KrQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D218E19030A7;
	Sun, 29 Sep 2024 14:43:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2ACA519560AE;
	Sun, 29 Sep 2024 14:43:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Sep 2024 16:42:52 +0200 (CEST)
Date: Sun, 29 Sep 2024 16:42:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 5/7] uprobes: move the initialization of utask->xol_vaddr
 from pre_ssout() to xol_get_insn_slot()
Message-ID: <20240929144248.GA9483@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This simplifies the code and makes xol_get_insn_slot() symmetric with
xol_free_insn_slot() which clears utask->xol_vaddr.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bfe106ecad38..a7223be5ac2e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1649,21 +1649,19 @@ static unsigned long xol_take_insn_slot(struct xol_area *area)
 
 /*
  * xol_get_insn_slot - allocate a slot for xol.
- * Returns the allocated slot address or 0.
  */
-static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
+static bool xol_get_insn_slot(struct uprobe *uprobe)
 {
-	struct xol_area *area;
-	unsigned long xol_vaddr;
+	struct uprobe_task *utask = current->utask;
+	struct xol_area *area = get_xol_area();
 
-	area = get_xol_area();
 	if (!area)
-		return 0;
+		return false;
 
-	xol_vaddr = xol_take_insn_slot(area);
-	arch_uprobe_copy_ixol(area->page, xol_vaddr,
+	utask->xol_vaddr = xol_take_insn_slot(area);
+	arch_uprobe_copy_ixol(area->page, utask->xol_vaddr,
 			      &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
-	return xol_vaddr;
+	return true;
 }
 
 /*
@@ -1951,21 +1949,17 @@ static int
 pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 {
 	struct uprobe_task *utask = current->utask;
-	unsigned long xol_vaddr;
 	int err;
 
 	if (!try_get_uprobe(uprobe))
 		return -EINVAL;
 
-	xol_vaddr = xol_get_insn_slot(uprobe);
-	if (!xol_vaddr) {
+	if (!xol_get_insn_slot(uprobe)) {
 		err = -ENOMEM;
 		goto err_out;
 	}
 
-	utask->xol_vaddr = xol_vaddr;
 	utask->vaddr = bp_vaddr;
-
 	err = arch_uprobe_pre_xol(&uprobe->arch, regs);
 	if (unlikely(err)) {
 		xol_free_insn_slot(current);
-- 
2.25.1.362.g51ebf55

