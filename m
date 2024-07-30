Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2519EEAB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342901; cv=none; b=UbAZcESLiJHyQvq/B9VUuaEfbKlqolF5qHIz8CxFX6YULiDrRn8947NXsXZyUNgkJhU5t9wtCK11HpGHcCQHknXnyBZHB+Nk7Rkjnw5AfS7L+eeRNHRiM8YK9RTaj3Q5a8h/hKVfOlKHBswEepIT6FcE3dnQ0HUBdj6zLwm4nag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342901; c=relaxed/simple;
	bh=BBXJ5D2usMmLkVDgx+EehBNNTQyFT4oHfRgegUnHgB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FGtG4KZV411m/u86Nu3H/WLIUt8D+ncU4otbmcmAqlnAJBYVmS4N4SRPg9ZS6lDYI8G0lIWQ/g6uu2XPTcu+WuAf1I+n+XHFKD3SemTHCwA7tFb3qzs1n2CmzqqwKv9ByyqnbB1tPTcTylucRhnz4ITcKCHhRXsSL4yTwOccT64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBSGS1tK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBSGS1tK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722342898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=mMsMX+s+FCwFLj8IxmPfp89JXcAN1I51Q1VOGUdFT2I=;
	b=fBSGS1tKi5lbQDeRxq1A86P4k0cglz7s9VRkjrXSIJy1HB3kolaTeewEuOghMmKT0McacZ
	pIQOVMer7cov7OQCnixTRkdcizLcRKzSbxruDeNPusIbhB54TLtVaa3t7m1xOojSe+cvWA
	HoJVkC5I2/2yUGse5C/JY7VyiwEH72Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-w5TsqMK3Px-C3aFUE0ebfg-1; Tue,
 30 Jul 2024 08:34:53 -0400
X-MC-Unique: w5TsqMK3Px-C3aFUE0ebfg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35FE61955F2D;
	Tue, 30 Jul 2024 12:34:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 475CE19560AA;
	Tue, 30 Jul 2024 12:34:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 30 Jul 2024 14:34:51 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:34:47 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/3] uprobes: change uprobe_register() to use
 uprobe_unregister() instead of __uprobe_unregister()
Message-ID: <20240730123447.GA9099@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

If register_for_each_vma() fails uprobe_register() can safely drop
uprobe->register_rwsem and use uprobe_unregister(). There is no worry
about the races with another register/unregister, consumer_add() was
already called so this case doesn't differ from _unregister() right
after the successful _register().

Yes this means the extra up_write() + down_write(), but this is the
slow and unlikely case anyway.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 974474680820..5ea0aabe8774 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1174,16 +1174,18 @@ struct uprobe *uprobe_register(struct inode *inode,
 	if (likely(uprobe_is_active(uprobe))) {
 		consumer_add(uprobe, uc);
 		ret = register_for_each_vma(uprobe, uc);
-		if (ret)
-			__uprobe_unregister(uprobe, uc);
 	}
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
 
-	if (unlikely(ret == -EAGAIN))
-		goto retry;
+	if (ret) {
+		if (unlikely(ret == -EAGAIN))
+			goto retry;
+		uprobe_unregister(uprobe, uc);
+		return ERR_PTR(ret);
+	}
 
-	return ret ? ERR_PTR(ret) : uprobe;
+	return uprobe;
 }
 EXPORT_SYMBOL_GPL(uprobe_register);
 
-- 
2.25.1.362.g51ebf55

