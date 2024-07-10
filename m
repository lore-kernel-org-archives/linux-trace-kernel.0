Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC4194C91
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629180; cv=none; b=crxsaPffrCPF2y5lFJmcaPVRCuqr2/hfGTg2ad6rZZUfDp/0B7lKoocwH43E4O0PisUU4uYXihpdnbRSn7MJgXEzb4vTsr4CFfPhGECpPfnJP3CjrLDbuI0jOpXm5wP7dw1bRsuKljyTcR0bJLZRr8wNpH66Ueqg9RlJflPYj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629180; c=relaxed/simple;
	bh=aAahZ81cp6l2Bo/AWj1nNCotB2/5rFnSlXs5oFgf1V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuaNx/5q6vUzA4vw29449EnXBPPacQCYFL5LO955EPvK3pBwFKEQnUsNCQkWDBgCXk+Xoxt85uxYQmdU6DAkLJpDBzSizNWBvPyS9bkmcoqGUGC342+fv4Did4IuL+Ya1AwqDpW79zGEKQVK7jutvisvxwJKRaw5YptLD4u4bzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3nIa8H8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3nIa8H8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720629178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rPMFFJYddIhNjkt3fBjOr9WxNVU8h9PjyIJFEdw0Xs4=;
	b=U3nIa8H8VP4lLVjuSRN13qE7igbfrsWVb3UNb8Q1k/L0ElHdbOCBlkT1SB79VhEbGepiq2
	boiKcmQ9kmc6sZoDsHnxu6SEP8jhHkGH7wnhr8rr0PwnLA15LxsxI8X39BQQaE5WOgyZug
	CGn1yEasEZBuSIajX1MsmVG7SycbIvQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-hMOkT15aNX-4iSjKRoClVQ-1; Wed,
 10 Jul 2024 12:32:54 -0400
X-MC-Unique: hMOkT15aNX-4iSjKRoClVQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6039C1956048;
	Wed, 10 Jul 2024 16:32:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9924B19560AE;
	Wed, 10 Jul 2024 16:32:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 18:31:15 +0200 (CEST)
Date: Wed, 10 Jul 2024 18:31:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: clm@meta.com, jolsa@kernel.org, mingo@kernel.org, paulmck@kernel.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/3] uprobes: simplify error handling for alloc_uprobe()
Message-ID: <20240710163111.GC13298@redhat.com>
References: <20240710140017.GA1074@redhat.com>
 <20240710163022.GA13298@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710163022.GA13298@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Andrii Nakryiko <andrii@kernel.org>

Return -ENOMEM instead of NULL, which makes caller's error handling just
a touch simpler.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4950decebe5c..e5b7c6239970 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -725,7 +725,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 
 	uprobe = kzalloc(sizeof(struct uprobe), GFP_KERNEL);
 	if (!uprobe)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	uprobe->inode = inode;
 	uprobe->offset = offset;
@@ -1166,8 +1166,6 @@ int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset,
 
  retry:
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
-	if (!uprobe)
-		return -ENOMEM;
 	if (IS_ERR(uprobe))
 		return PTR_ERR(uprobe);
 
-- 
2.25.1.362.g51ebf55


