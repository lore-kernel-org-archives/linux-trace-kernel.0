Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7A23E359
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126789; cv=none; b=MFBOQsJkrGlYaP9uXhX2t0uY+anIMa2M62bTX0OEKO5BoOGjszcUMqugD5rNwYWq55BpcOGKVvdQNk6A1m30oD8Vs318hfz0b+PALrayzsqq5psidLax+mUkVYbCiGZeSJsacFfFG/YBGzm3siuXbqmthjcolW5HVxTn/1ymFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126789; c=relaxed/simple;
	bh=iGF3Ty+r7ofrqLuDIz+M4/R+aLKluW2Zd4ZasASSJss=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WTHFaFxYdKBFXBy6RITzWCQZdYUv+QUaJmUDhTByY5UE77cv8Js90q8fVC4dQw78vFakqKotrpFD/Jb3bHKZJ7JLP6sc3ZybkSnnd7CLWqWKmXJQiCivh9UOWcvcAn9t1A67kHScOPX2QNDS+Sy4CUxqwRS1UFCK5f1LaHvd0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlxwGU/c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlxwGU/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756126787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jJKCjDL06Zvlad/zq74VP/8/pkLusWhDPD7bZSNNC80=;
	b=SlxwGU/crqtXr2W/U1QDH3kDFsWBjWjLZlD6AFkPHiJyd+MDXR3zgV7o7tZFg/ZxXPN9C6
	1B3uKCHVAKo4uI8Acvaynw5zifFZCy3ryuIB3Myp99iaz2wRRAuOOo+Ngzd7d2hu6BspNj
	UWWsLW9qnS8n7UvCsPepCS5UjxMM+2g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-UWYJL6GsMfavtmYJJV1Lgg-1; Mon,
 25 Aug 2025 08:59:41 -0400
X-MC-Unique: UWYJL6GsMfavtmYJJV1Lgg-1
X-Mimecast-MFC-AGG-ID: UWYJL6GsMfavtmYJJV1Lgg_1756126780
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1C30180036E;
	Mon, 25 Aug 2025 12:59:39 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.151])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66C951955F24;
	Mon, 25 Aug 2025 12:59:35 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [RESEND PATCH] kmem/tracing: Add kmem name to kmem_cache_alloc tracepoint
Date: Mon, 25 Aug 2025 09:59:26 -0300
Message-ID: <20250825125927.59816-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The kmem_cache_free tracepoint includes a "name" field, which allows
for easy identification and filtering of specific kmem's. However, the
kmem_cache_alloc tracepoint lacks this field, making it difficult to
pair corresponding alloc and free events for analysis.

Add the "name" field to kmem_cache_alloc to enable consistent tracking
and correlation of kmem alloc and free events.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 include/trace/events/kmem.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 474358773abe..7f93e754da5c 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -22,6 +22,7 @@ TRACE_EVENT(kmem_cache_alloc,
 	TP_STRUCT__entry(
 		__field(	unsigned long,	call_site	)
 		__field(	const void *,	ptr		)
+		__string(	name,		s->name		)
 		__field(	size_t,		bytes_req	)
 		__field(	size_t,		bytes_alloc	)
 		__field(	unsigned long,	gfp_flags	)
@@ -32,6 +33,7 @@ TRACE_EVENT(kmem_cache_alloc,
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
2.51.0

