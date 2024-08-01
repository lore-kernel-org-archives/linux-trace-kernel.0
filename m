Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB63C1A4867
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518872; cv=none; b=LOX2Nz0IjlCWs71jqpvm7jA8sNDtzoY1BzCaePFM+HHvkn/ueRnntkcZyrMc0efHlZGrk9mA2QcyOSyY6rYQvwwlPKwFiAVZAww4R23J2AkjesTvAxQksKO89Q/MNoGFDo08Y7XNHti45kuxe9FoVhZ9elOJbUnoI/tM4mtb6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518872; c=relaxed/simple;
	bh=NGq5dJqZqr9q6RfJulMmTHykMNw7OZbPAkupwQdmR7s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EeIFnTzvrxjNa2YKwy1woXKWUXI23oCWyKbEWqISsJetctOilDy/62EO+S42AikmXbvSqI7TrnsJ8qLQER0MSTWhxemF/kqRKDEc110Fk3T8wj28I2RojaUA020mRDdAbQcNRFZDZLo47/A8Wc3eCCx7Ym01Y3s6GSV3/lNZQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2P6IM5w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2P6IM5w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=E2USmONA9SizueAzOm+WwqtIfPfv9XdZg06/upvE0eM=;
	b=R2P6IM5wT3Q+DsV71nV2fMgMGn0nQD5j1O3dVZV5gZEcuAzq09uC9A6pce0Poph7wqATxF
	3fKqzNtw5kSYqjpxlYuYy6NEFgO29Z3xobv8zEKm//mdqd71AFV6VdYpqFQzhK5vzeJp1y
	M+DY+79/TA57Dk0runDo6ulrqBDiugA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-BT19dpVENnaIs4xJAOLMaw-1; Thu,
 01 Aug 2024 09:27:45 -0400
X-MC-Unique: BT19dpVENnaIs4xJAOLMaw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 301731955D56;
	Thu,  1 Aug 2024 13:27:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 478FD19560AA;
	Thu,  1 Aug 2024 13:27:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:27:43 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:27:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] uprobes: change uprobe_register() to use
 uprobe_unregister() instead of __uprobe_unregister()
Message-ID: <20240801132739.GA8809@redhat.com>
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

If register_for_each_vma() fails uprobe_register() can safely drop
uprobe->register_rwsem and use uprobe_unregister(). There is no worry
about the races with another register/unregister, consumer_add() was
already called so this case doesn't differ from _unregister() right
after the successful _register().

Yes this means the extra up_write() + down_write(), but this is the
slow and unlikely case anyway.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
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

