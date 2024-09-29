Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462717ADF8
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727620973; cv=none; b=HGHC8yTSTuDWAnGPcmt9OQussKmqS19EU1hKkH8kGEefRmauS5X5Qk0oSm6ttgq/WXhq13WnnQO2brq3yEykjuAHrioKLwm8SSq/IIyfmxxORppGQ3K42/V57I3t0vSZ68s528ZuhAd2knYvxxmlUjZ3ouNc1tochMmfIYoFPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727620973; c=relaxed/simple;
	bh=6WTZso5WGhvtb2/OxjllcDfJ4f6hMAM6NKTHQqMFnIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ky97EZV5PMWtiyJjczjJmRBpZWTBjfvyQ1y1q6t+H8QoGvNpelwss41adq+mHIR4l/5VE8cEWz8vHDmb7hyOs7o9RHX26Rts9A6GkKz+Slqr8HAcPusz6YH9I3FYqae73XC3New2exo+xUqeAAVbWxy8+/JIDEsotlt2Wbp5VfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IH8kdwcO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IH8kdwcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727620970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=UjMkCez+I6XaIxZPG+o4NZ0Bsl2LfAkraC0d9Mrst+o=;
	b=IH8kdwcOpkZWw84ebQ19dbXehgBPuh/BUGMgFSC2Ijuj+eZIy877bMg+Cr6QEuhj8OulWh
	VM0fvV7v+oePjXsqzhpgRi2hVukSIqZbQXK29dt7xk+KjHdKU+gJ0amWsfiuzsp3ECbGWC
	Scm1qHzw4m1+HDCskVikMPKyfzSvdAo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-doMx__8qNg-wZ2uUUCItBQ-1; Sun,
 29 Sep 2024 10:42:48 -0400
X-MC-Unique: doMx__8qNg-wZ2uUUCItBQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82CE018E6A6C;
	Sun, 29 Sep 2024 14:42:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B8DC01944B22;
	Sun, 29 Sep 2024 14:42:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Sep 2024 16:42:34 +0200 (CEST)
Date: Sun, 29 Sep 2024 16:42:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/7] uprobes: don't abuse get_utask() in pre_ssout() and
 prepare_uretprobe()
Message-ID: <20240929144230.GA9468@redhat.com>
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

handle_swbp() calls get_utask() before prepare_uretprobe() or pre_ssout()
can be called, they can simply use current->utask which can't be NULL.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4b52cb2ae6d6..2a9cdd5c82d7 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1908,18 +1908,14 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 
 static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 {
-	struct return_instance *ri;
-	struct uprobe_task *utask;
+	struct uprobe_task *utask = current->utask;
 	unsigned long orig_ret_vaddr, trampoline_vaddr;
+	struct return_instance *ri;
 	bool chained;
 
 	if (!get_xol_area())
 		return;
 
-	utask = get_utask();
-	if (!utask)
-		return;
-
 	if (utask->depth >= MAX_URETPROBE_DEPTH) {
 		printk_ratelimited(KERN_INFO "uprobe: omit uretprobe due to"
 				" nestedness limit pid/tgid=%d/%d\n",
@@ -1980,14 +1976,10 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 static int
 pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 {
-	struct uprobe_task *utask;
+	struct uprobe_task *utask = current->utask;
 	unsigned long xol_vaddr;
 	int err;
 
-	utask = get_utask();
-	if (!utask)
-		return -ENOMEM;
-
 	if (!try_get_uprobe(uprobe))
 		return -EINVAL;
 
-- 
2.25.1.362.g51ebf55

