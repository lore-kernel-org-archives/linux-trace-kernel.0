Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DCA14EC4B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260737; cv=none; b=lEqeJ+wwvf5HdyKOmH/JZXfm1co0VDyFPZF7tDFiRBqP5MYhIIeUTXcxZTZQbDehIKLjRx8dU7ooV4A6xuTYbkYmdc0T9SnfbOYbA1LI99hSbu7aPHbckCel6BS7SchZ/jFW3ZpbJm8vjkyMR7kn6LHdoExePNMcrmUeVfQUUgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260737; c=relaxed/simple;
	bh=+Jaj0ySZV4PKJxGEIPBc49bIf6R+usgarMz7NQSXuqs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ahquCEpXCj37uzAdw/TKIhuUutRpn8CQyH1FmeR2d9SHSEKoSWBaVxwUIAzo+bQeexVKHrZin84ccCBEkWUYadhMvbskEN0qFybgGPbYiWi/ssbgufPPJAmTAac+Oe9+Ac7/UBa1sAXt1lCWNibxfY5Zw9TuEdRc0xgnpmFVE9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bu+CMTHz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bu+CMTHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722260734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=IazVFhmSe+iUEdHuPTWWDxtFDsvZkZ5pxCUbkLWs1O8=;
	b=bu+CMTHzT28KqSqvQyIEJHLQCVcNYkfwQW1dXdsUgKe3yhwYc7Z9Mx06sma4yLevOuay1b
	njWFQcIHZFiUwHBuRIK24lha/ov4AItRKeck1ojY9jKOKFL4hpmkHRoIsZ9bRllfO4WBus
	573R41ejjIgIqYmWSAmHzCpqXLVPcVI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-5tb54cW8OQWUDjV3TGiRqg-1; Mon,
 29 Jul 2024 09:45:30 -0400
X-MC-Unique: 5tb54cW8OQWUDjV3TGiRqg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 243461955D59;
	Mon, 29 Jul 2024 13:45:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.232])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4C7BB1955D42;
	Mon, 29 Jul 2024 13:45:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 29 Jul 2024 15:45:29 +0200 (CEST)
Date: Mon, 29 Jul 2024 15:45:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] uprobes: simplify error handling for alloc_uprobe()
Message-ID: <20240729134525.GA12315@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729134444.GA12293@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Andrii Nakryiko <andrii@kernel.org>

Return -ENOMEM instead of NULL, which makes caller's error handling just
a touch simpler.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
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

