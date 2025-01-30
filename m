Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2DA19DFAB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jan 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738261024; cv=none; b=ON+sTWrxY8tprQxp3+HA7L8bY/dlpXiWJa6lCvCLcc9LjgWbDLmQkLIR+vgTFNv6Bvk++UJvGy2p/VtOL/gVG1DPiMMAdhk/Kc4ZxpNJlSpj94yMVMDd4glvPF4t+g5KwB8fEw7jzJsgmMq/mMW6zCMXPbqtjnlWrvrN7OwGNKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738261024; c=relaxed/simple;
	bh=oUXFeKCMxGcWYs6ZqqM+rh1qxGA53CJ5hBxEoMOjjR0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VjVHB1B9Rq501wOsULGPndMRbnQdOEOE1DW/yxoWKmcpmFrpw69Mk1ZXk0KpZ0xJSNwQwP8KrTFM/kB6rd542zbcNMQCkAXUFBFlJb4xuPMBEkUNFrSkSpq4QRje1Yre6HgSaY90y6OuF6sK4EXUgCzOdtvikg/twKbWtYPQJH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWXxpO/H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWXxpO/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738261021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ro3Og8hIo5aG4/Cep1XHpBidSUViZ6V5LwMn3Rc0G64=;
	b=FWXxpO/HoKa88j2QdGVmfpMNBgXHZyeiIB+QSTub814UJEUakFQm8AwyHaIToQa792Df4e
	jA2HUq24NbSPOGfHI98FsCpLSJLhH0Z2zGZcRgg3+QA4kGoV1dOs/qLgtRecw5UnxHaTp7
	8KaN+z9BBcqWZJ6S9hk0fIByjNg3Gx8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-yZOc_28AP8O0GD0gsHWpxQ-1; Thu,
 30 Jan 2025 13:16:58 -0500
X-MC-Unique: yZOc_28AP8O0GD0gsHWpxQ-1
X-Mimecast-MFC-AGG-ID: yZOc_28AP8O0GD0gsHWpxQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30B061956053;
	Thu, 30 Jan 2025 18:16:56 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.125])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B14B019560A3;
	Thu, 30 Jan 2025 18:16:50 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Richard Chang <richardycc@google.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH] kmem/tracing: Add kmem name to kmem_cache_alloc tracepoint
Date: Thu, 30 Jan 2025 15:16:37 -0300
Message-ID: <20250130181639.58280-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index b37eb0a7060f..8ffb022f024c 100644
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
2.48.1

