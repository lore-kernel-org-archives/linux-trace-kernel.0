Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177911A4867
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518876; cv=none; b=F0GE6cmqFejwFJNFZjKbEuUsUI0i7ifZzyadUpiKfjJ15ru4Kfd/TrbiQgD9X/S8czaFdQYoAkRDxua5O5y3mjmnXDsPy9x1rRHbrmMJVTRpTbtpc5o6XspwrhJjT8Kmu4yFskCpZBvAwor/gNBej41WQgqD7ZC8cIspU3T1bPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518876; c=relaxed/simple;
	bh=jEEZP+Pk2H225A3SW76266+ap+IrdA7Op1pwDuBfNKE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Tt4zc/1gNSwaqhlfrGAJqfWmfhLegub8AqbDUfdJ9NK/sEyf7kHH0ggV8QDcsC8C/MRKzBrrlC8x8RsAYUffXPFih9jIeqGeaevw5JhQOjTvTlt52fKVULVeacHnWeLKRmZpHexpe4cq2Mklga6bREHV1gBc67PFTyM7qy9eqP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNGtajxz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNGtajxz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=OXmgynbq1bkVhUcMMchL2Y521eQlQHyLkiICBIwyHIo=;
	b=dNGtajxzQDtCzBjGIVK4FackoxqSPtQIgXGovj9cPOHXO2GnYzR71wFoCgGMTUfH7gkZCn
	5yXnpwDViLIuMYDmtsACt8Yrh0B2syCL4/KDr7siwZF8Mu0/vTMHpVMJz5Zr+qzvARUH9j
	40kP8gXOQeYKNWYRA5JSU6JsNZYLI4M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-JsGZ0owOMoSqqYKNoYBWcQ-1; Thu,
 01 Aug 2024 09:27:51 -0400
X-MC-Unique: JsGZ0owOMoSqqYKNoYBWcQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43E681955D59;
	Thu,  1 Aug 2024 13:27:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1A2E819560AA;
	Thu,  1 Aug 2024 13:27:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:27:48 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:27:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] uprobes: fold __uprobe_unregister() into
 uprobe_unregister()
Message-ID: <20240801132744.GA8814@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Fold __uprobe_unregister() into its single caller, uprobe_unregister().
A separate patch to simplify the next change.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
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

