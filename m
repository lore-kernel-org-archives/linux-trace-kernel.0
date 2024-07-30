Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4111A00ED
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342910; cv=none; b=JBHO9ao5cdvQqaw72h8Ivhp1DNwOZTLuCaw5ay0ALp/9DAnES231DKr5pAHGBJNkEgIqrdip5BM9fnm3zr4AoBjtEV2aOzIrgD41BOsFAU/Mqf+PJkQQJJ4LqQJeIjO602xXtolCdowqtuKPgWNlahWiZea+eJoWZhZYrYW3qzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342910; c=relaxed/simple;
	bh=/PCbAvWmRtPIzmNX9OnXe40hTDSZWtCJ0mGNTRGIJnI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WVkPIJA5EnX+VWf0Ue94G3rQz/iTUnK2ttjEjjuiIn+3pDbvYCDy41pWhjw1lF2Hm2b5NrpvZNzib6t9SqzdAti6Sx6IQzUeOhHHOEp+SNlEu2tsly6npeADvX90RrfMsykqRDpKJ1eDCL/x2q/p3OckOsjZhY0A0ViMwuCDiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VvA6CIgp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvA6CIgp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722342908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=834ISJOXXbFjU55uIUoKOdwIp7ruo2OPQB7D9lPIwf4=;
	b=VvA6CIgp7O2iG0+tpUzfd4niO68cJhjExUP40M2MR9uvYwe1OkfCDGZTZ1iJzITuV+Fczm
	HtnNZ7vLqjxyBY3AkFQ1SLIcudtAGZsQXYNkQCNO/QIMUj4VOAiJzzwvnzYOORc8evmTDU
	Hi7yMM5t9GQjV/k7X9XVG0ESsP0Nd5E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-_PSnSOoJPJW3AJtrPJmjQQ-1; Tue,
 30 Jul 2024 08:35:03 -0400
X-MC-Unique: _PSnSOoJPJW3AJtrPJmjQQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BD3E1955D50;
	Tue, 30 Jul 2024 12:35:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C5868300018D;
	Tue, 30 Jul 2024 12:34:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 30 Jul 2024 14:35:01 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:34:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/3] uprobes: shift put_uprobe() from delete_uprobe() to
 uprobe_unregister()
Message-ID: <20240730123457.GA9108@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730123421.GA9085@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Kill the extra get_uprobe() + put_uprobe() in uprobe_unregister() and
move the possibly final put_uprobe() from delete_uprobe() to its only
caller, uprobe_unregister().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c06e1a5f1783..f88b7ff20587 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -939,7 +939,6 @@ static void delete_uprobe(struct uprobe *uprobe)
 	rb_erase(&uprobe->rb_node, &uprobes_tree);
 	write_unlock(&uprobes_treelock);
 	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
-	put_uprobe(uprobe);
 }
 
 struct map_info {
@@ -1094,7 +1093,6 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	int err;
 
-	get_uprobe(uprobe);
 	down_write(&uprobe->register_rwsem);
 	if (WARN_ON(!consumer_del(uprobe, uc)))
 		err = -ENOENT;
@@ -1102,10 +1100,16 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 		err = register_for_each_vma(uprobe, NULL);
 
 	/* TODO : cant unregister? schedule a worker thread */
-	if (!err && !uprobe->consumers)
-		delete_uprobe(uprobe);
+	if (!err) {
+		if (!uprobe->consumers)
+			delete_uprobe(uprobe);
+		else
+			err = -EBUSY;
+	}
 	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
+
+	if (!err)
+		put_uprobe(uprobe);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
-- 
2.25.1.362.g51ebf55

