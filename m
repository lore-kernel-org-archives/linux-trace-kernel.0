Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6A51A57DD
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518882; cv=none; b=F39Vq0EIgSn46WoXSdzKp1dTCc5OOUaq9B4u8kjFrZ2rzP56Zw/7IRlDAmrpcdFZi4l6yyZxvJH+zcqrowPWMeGQ7v94YGxaZy4+AZf0+Yt4jaAfoDAwtjaWK23oirfzbIqAdOBYTSIf1KTnTX7BMFs/5b+YoPnzcNhQrXo+Mag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518882; c=relaxed/simple;
	bh=3mptqJqBUcpOt3OBU92I5V+BMLBESmQwmLrel09LDdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WynPAhjSksYOYfsrr+Pw0r90iVNFbgxM83NU3dZISOuXVOETGOyG4CRCFsFnuWzLfvwfGDtMo0KbZHLS6yM5okFL3jVg+bMb0lCAKjBzpLMqsbZRro0L5C2H+N1nUGMuA8kYx05vRInv0W6RR3caCQFgSfECeGb60Qyr85tN7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7H3kvnD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7H3kvnD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=aKS1JV/k2FXROHkTQCa9V8ezijNkEnvTPKAJbOfwO5M=;
	b=G7H3kvnDuxpjlTAsprdLgpRXY/Xrig2H9uX63yoaR/yyIZD5bL0X9yrsvi5gmPiy2MIwyl
	mNiCFjmUnhAizcR+xKjWGi9XisvgXLNhZwfjGxIp2rDe/WT+ua4KcsMynerpO96bLqlwjy
	0fedGaDljwmuTkvamj1A0xrM1H/el50=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-qOR-ioryMWm5rZoCL8BFVg-1; Thu,
 01 Aug 2024 09:27:55 -0400
X-MC-Unique: qOR-ioryMWm5rZoCL8BFVg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D041E1955BF4;
	Thu,  1 Aug 2024 13:27:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E06C41955D42;
	Thu,  1 Aug 2024 13:27:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:27:53 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:27:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] uprobes: shift put_uprobe() from delete_uprobe() to
 uprobe_unregister()
Message-ID: <20240801132749.GA8817@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801132638.GA8759@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Kill the extra get_uprobe() + put_uprobe() in uprobe_unregister() and
move the possibly final put_uprobe() from delete_uprobe() to its only
caller, uprobe_unregister().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
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

