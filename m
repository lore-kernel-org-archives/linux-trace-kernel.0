Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1281A00E6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342908; cv=none; b=B27uaA8NHm4V4jpTVdmSG/0WbXfrq8OzR3gjIEXzy1T7oeVIg6yWkc999Sy2uyaYQJZ/lfOBne9M85X4sFY2AlSpLx3n6qiOjxHBnh3DFmUPeUzmbhts8zwsp6R3Dt9dtj1mA62P7RmPl15BE3aRVkomKgh4xdDYt7sNsBzNXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342908; c=relaxed/simple;
	bh=eTPlETMFSzawnE7+nWGynmK/voAnwa4EzyxfwYwnCLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Lek4Xl9Njwe3xNHZ7wRmmsy4dIkxT6P9iwihREQ/JjHruo4eHiy/FK1Ghjtl4uEhZk6tUbPcdCS1dxrwpaYa9nk2Pcgi4RngnXbEtgGzfo58NsZ/G274NzBqQBIlAidQ/+3D5jsQyueHtWV1SKtB9ZaK0dAtN2jZIbR/at/EvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2JPEO8S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2JPEO8S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722342906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=m2S9pMY0lLQ0FyIYgioWcdjQraPadw78t9CcL3DCq40=;
	b=d2JPEO8ShSFqZg2VHjD4Mee0KA7fzaCvWvRFZbPsFPWEC9LfznfLNzbmU2QkFRJWMHJ1cM
	y2eXRzKWQgJchsRcyJZU1xA/QcULedZGKyLkymKpYzFPNU0O9AGTN2zFTYFYtjzkE2yCxC
	ronUM8qpSBe/cDC6k+AAS9o6KAc7D7Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-u0b2-BC2MyCsNt1Av35Xhg-1; Tue,
 30 Jul 2024 08:35:00 -0400
X-MC-Unique: u0b2-BC2MyCsNt1Av35Xhg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E87091955F2F;
	Tue, 30 Jul 2024 12:34:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 30C3119560AE;
	Tue, 30 Jul 2024 12:34:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 30 Jul 2024 14:34:56 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:34:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/3] uprobes: fold __uprobe_unregister() into
 uprobe_unregister()
Message-ID: <20240730123452.GA9102@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fold __uprobe_unregister() into its single caller, uprobe_unregister().
A separate patch to simplify the next change.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 5ea0aabe8774..c06e1a5f1783 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1085,20 +1085,6 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 	return err;
 }
 
-static void
-__uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
-{
-	int err;
-
-	if (WARN_ON(!consumer_del(uprobe, uc)))
-		return;
-
-	err = register_for_each_vma(uprobe, NULL);
-	/* TODO : cant unregister? schedule a worker thread */
-	if (!uprobe->consumers && !err)
-		delete_uprobe(uprobe);
-}
-
 /**
  * uprobe_unregister - unregister an already registered probe.
  * @uprobe: uprobe to remove
@@ -1106,9 +1092,18 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
  */
 void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
+	int err;
+
 	get_uprobe(uprobe);
 	down_write(&uprobe->register_rwsem);
-	__uprobe_unregister(uprobe, uc);
+	if (WARN_ON(!consumer_del(uprobe, uc)))
+		err = -ENOENT;
+	else
+		err = register_for_each_vma(uprobe, NULL);
+
+	/* TODO : cant unregister? schedule a worker thread */
+	if (!err && !uprobe->consumers)
+		delete_uprobe(uprobe);
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
 }
-- 
2.25.1.362.g51ebf55

