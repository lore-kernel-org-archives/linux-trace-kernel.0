Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94E1A3BD6
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518851; cv=none; b=t3oxmiXDZsvykP0jKzS3T3W/jiEok88sFZdGg1Rm5VrrR581k8dPx2T6+ZMZiOxiEr+Jzd0ub5Ids5if1WGNxifi5zmzHp/TWTr83b5GzERpPLvDti16jKmQxxeZPlPMfqK2mAHBdhcr5Ndy9rAiM66dX0Bdu86dQSJVNuDRZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518851; c=relaxed/simple;
	bh=W/BHTIh217X5LFOIuLa3OLBCiac6OnzoFmwIdOBErIg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KKneI7cXi16SmDrrOmMcZyBxMlPgDqg7jQXBj1zm3lqLajyrXniZz7TEa+hQocvkgoJbfBoFFLSHcSCix2tLwxRiOZvA7sMPHPWxbJgx1tmIFvbCUhvRxkpUXISlv2vr6GRi/ICYHjXiygkxyGcYxHkhU+DB5a+CQT41Cctx3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4qlGYYn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4qlGYYn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=lrwl3EQObGGIhIhl01HhAUj1wS8bhMU955oMZ7wlQuo=;
	b=I4qlGYYnIWs92wr9nGL8Aga8De6xxDq3mmiW8ewsUjPCaOW4PE87nZMvAnCZM4r7fEvT8W
	yLm66+cFDnumWXc+t3EO/SpFtxzp/c5qAMw/CSJ5EzMKnomrRyB/9MlXTIcqX9CzAE/t4p
	bSqCIxHtm4Yp1zr+rESWHT7CM8oICAU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-qrAnL_9HPOa20DY8dTG9FQ-1; Thu,
 01 Aug 2024 09:27:25 -0400
X-MC-Unique: qrAnL_9HPOa20DY8dTG9FQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B79671955BEF;
	Thu,  1 Aug 2024 13:27:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AE6311955E80;
	Thu,  1 Aug 2024 13:27:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:27:23 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:27:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 3/9] uprobes: simplify error handling for alloc_uprobe()
Message-ID: <20240801132719.GA8788@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Andrii Nakryiko <andrii@kernel.org>

Return -ENOMEM instead of NULL, which makes caller's error handling just
a touch simpler.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index eb71428691bb..dfe6306a63b1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -725,7 +725,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 
 	uprobe = kzalloc(sizeof(struct uprobe), GFP_KERNEL);
 	if (!uprobe)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	uprobe->inode = inode;
 	uprobe->offset = offset;
@@ -1167,8 +1167,6 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 
  retry:
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
-	if (!uprobe)
-		return -ENOMEM;
 	if (IS_ERR(uprobe))
 		return PTR_ERR(uprobe);
 
-- 
2.25.1.362.g51ebf55

