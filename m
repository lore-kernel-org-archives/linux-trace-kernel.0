Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85430566E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150633; cv=none; b=SgOwhAO9eZYpL3WVBdx4B9G3zxIVzYw4WfYFx3eRLQ1vHMdztHqScRwWZEzBJyANonrJBF9ag4YkfVpkPoeBeWd3F190WoEA1tN/p8lKHPHLVYh8yPFyyOsmaUm/eFdmvPXIOLBmexgrlt1yVKkCvINnGetwvUtLALg3+QvPv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150633; c=relaxed/simple;
	bh=rt7PVioEGyjExEkO42rRcqYR0XN7bI9hxdnBpOgsBk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=e9Y1YKFe9y1rYZhrKeBArEclNwc07FZYY5E858m9VJBoRdDSIyMAwMIy/Bzsk0DbPN29h5t4vC/88IfrcT3TvxTVzncvBpd+F7hCMv5JkkdhBT90XKK8LPdT2q5nRCVbx5MhCdGphvBeknC74shhoi12pbeZ8iCd7sfWb2PC73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+qFJ7AD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+qFJ7AD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780150630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjnH9+WCgsTWGHXLYxnxil3w674m5wdbB8GjhbcCqcY=;
	b=i+qFJ7ADvcBB3IT/hQPbXA+46hRzA1Wklbicy99RWPQ8TVoLeiUZwoMCbHbzGIWt+4VHt/
	0ijzjC/WOQAFi92TFn+jpUnoWxioGkUEsikXJpALsGqoYf1+O8Lf+Rvz1s9W0OpyZPI6iV
	eJlhk34Xv4LDSu9Vb8S2i50VEJJ/cYs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-iHL4KIDAMWCKDgoj33jHEg-1; Sat,
 30 May 2026 10:17:08 -0400
X-MC-Unique: iHL4KIDAMWCKDgoj33jHEg-1
X-Mimecast-MFC-AGG-ID: iHL4KIDAMWCKDgoj33jHEg_1780150627
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F257D1956089;
	Sat, 30 May 2026 14:17:06 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD83330001BB;
	Sat, 30 May 2026 14:17:04 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 03/13] rv: Prevent in-flight per-task handlers from using invalid slots
Date: Sat, 30 May 2026 16:16:42 +0200
Message-ID: <20260530141652.58084-4-gmonaco@redhat.com>
In-Reply-To: <20260530141652.58084-1-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: eLISakiK9gMZlZo2YqiY4xqlD4jjhNdktD2-NSNfsDk_1780150627
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Per-task monitors use a slot in the task_struct->rv[] array and store
that locally (e.g. task_mon_slot), this slot is returned during the
destruction process but currently hanlers can be running while that slot
is returning and this race may lead to accessing an invalid slot.

Synchronise with all in-flight tracepoint handlers using
tracepoint_synchronize_unregister() before returning the slot.

Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
Fixes: a9769a5b9878 ("rv: Add support for LTL monitors")
Suggested-by: Wen Yang <wen.yang@linux.dev>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h  | 4 ++++
 include/rv/ltl_monitor.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 1459fb3df..cc97cc5df 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -302,6 +302,9 @@ static int da_monitor_init(void)
 
 /*
  * da_monitor_destroy - return the allocated slot
+ *
+ * Wait for all in-flight handlers before returning the slot to avoid
+ * out-of-bound accesses.
  */
 static inline void da_monitor_destroy(void)
 {
@@ -310,6 +313,7 @@ static inline void da_monitor_destroy(void)
 		return;
 	}
 
+	tracepoint_synchronize_unregister();
 	da_monitor_reset_all();
 
 	rv_put_task_monitor_slot(task_mon_slot);
diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index eff60cd61..38e792401 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -77,6 +77,7 @@ static void ltl_monitor_destroy(void)
 {
 	rv_detach_trace_probe(name, task_newtask, handle_task_newtask);
 
+	tracepoint_synchronize_unregister();
 	rv_put_task_monitor_slot(ltl_monitor_slot);
 	ltl_monitor_slot = RV_PER_TASK_MONITOR_INIT;
 }
-- 
2.54.0

