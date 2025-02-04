Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A225A657
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Feb 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675633; cv=none; b=n88nNy4d6J+PvE66fqeWk2Bv8U04oGkfLkoe0VPV+okXBoECwZ5IUKDw3FABpY04OI2myAWuAcBZcvE6On7Tb8Mv/8wezYHr4ikIbfAP07lvnaeiHKU6ajWvGgCpus0x+MDwaZi6OAAg0WtOqRRta+aqjKelDpbclr/1whAw22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675633; c=relaxed/simple;
	bh=5+zQQzeZJR1Emv3nobVatxwNfPA1kcn61LzP4rjCXZI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RYKiVobbL+s1L+pljOQOpJ3UQHd6lzwbhu+wQIhW3o1fzksuBC6I1vHtVE4EhwOsq1c2zQQrIVxol4vpNxHA07XMD0Ocxkh77omidXyTt2vcoMR/nIp8zotkeJ/y/SIg/z2NdXh5OVsJGBBnaaS1ey6xyjeR6FKY47kY/o2hcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dT7+ipUS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dT7+ipUS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738675630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BfyFmuhFF6AEPEpiDzd+Ou5ZlvgfIRcolj4214+ixhk=;
	b=dT7+ipUS7K5OTzekqMwwzzNYOv4QLGOBcK7tY+dKM5jkBAESg+PnsCYRD9c0numS/RDXxQ
	d+KAh66/7i1ChqjQQ17lEL+9hQfAKyi+ROQQ3yxjRNWD4Gi6I09qTSt+yLKD1HKNYjXAez
	QImy8JCWzBQgUGdWUguQqS9kP/YD310=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-VhmZ0z6FOWCSkBhZU9r-Dg-1; Tue,
 04 Feb 2025 08:27:07 -0500
X-MC-Unique: VhmZ0z6FOWCSkBhZU9r-Dg-1
X-Mimecast-MFC-AGG-ID: VhmZ0z6FOWCSkBhZU9r-Dg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A2D318009CD;
	Tue,  4 Feb 2025 13:27:04 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E2AB18008C0;
	Tue,  4 Feb 2025 13:26:58 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Wander Lairson Costa <wander@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH v2] kmem/tracing: Add kmem name to kmem_cache_alloc tracepoint
Date: Tue,  4 Feb 2025 10:26:35 -0300
Message-ID: <20250204132637.21652-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The kmem_cache_free tracepoint includes a "name" field, which allows
for easy identification and filtering of specific kmem's. However, the
kmem_cache_alloc tracepoint lacks this field, making it difficult to
pair corresponding alloc and free events for analysis.

Add the "name" field to kmem_cache_alloc to enable consistent tracking
and correlation of kmem alloc and free events.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>

---

Changes:

v2: move the "name" field to avoid a hole in the struct.
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 include/trace/events/kmem.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index b37eb0a7060f..c6aea6610cf5 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -26,12 +26,14 @@ TRACE_EVENT(kmem_cache_alloc,
 		__field(	size_t,		bytes_alloc	)
 		__field(	unsigned long,	gfp_flags	)
 		__field(	int,		node		)
+		__string(	name,		s->name		)
 		__field(	bool,		accounted	)
 	),
 
 	TP_fast_assign(
 		__entry->call_site	= call_site;
 		__entry->ptr		= ptr;
+		__assign_str(name);
 		__entry->bytes_req	= s->object_size;
 		__entry->bytes_alloc	= s->size;
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
@@ -41,9 +43,10 @@ TRACE_EVENT(kmem_cache_alloc,
 					  (s->flags & SLAB_ACCOUNT)) : false;
 	),
 
-	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
+	TP_printk("call_site=%pS ptr=%p name=%s bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
 		(void *)__entry->call_site,
 		__entry->ptr,
+		__get_str(name),
 		__entry->bytes_req,
 		__entry->bytes_alloc,
 		show_gfp_flags(__entry->gfp_flags),
-- 
2.48.1

