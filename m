Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBCD3DD53E
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328368; cv=none; b=qtlTtPWW61B4Zgm+E4+Omcptiahh8c1+l4QS3MT5KYxypp6RjC+bDRElfsrOby6AYzioNPhzw9sHVWeXMX5SGDjaUGX+ibYKSj+GI40ntTgPhPHA9dTiBGGyvr8XdsFR2kl2/lou+rSZiTuVWi4f9dllm70NeVlNdU31CjTtDV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328368; c=relaxed/simple;
	bh=rt7PVioEGyjExEkO42rRcqYR0XN7bI9hxdnBpOgsBk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=I8jjnEfV/BYzKwoVTn4LxjfTRdfmUJteAToaofgbOrh5PPoQkJ69XTz9t2ogdt4M1rs1mZtiQdFijO7K72vCxUQsyTVy9hdVwo9wl7uU4uWt2MWqj0aVDOXUS+JyUYCmnonS0DuRtr+rnygNlYIbjXjPozE3e/lz4VIWT2vCrpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKdpyJw3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKdpyJw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780328364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjnH9+WCgsTWGHXLYxnxil3w674m5wdbB8GjhbcCqcY=;
	b=TKdpyJw3UEGZxWBPQgQiaj1c4f4A/b18gGdQ8d7/hi70ghBxBEKY+t331A9EkDlS2vr552
	wkCSMvG8Yl9uqOEnIE1MNo6CUlUjFtgmSgaOcmDyvIrjF56KbS618Xho2FRQhlE+9zzmoC
	KEIDzHgt4UP26aLK8s8oRp648v+HBHM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-4vM2OKLVOFmCdlVj2XVhrw-1; Mon,
 01 Jun 2026 11:39:00 -0400
X-MC-Unique: 4vM2OKLVOFmCdlVj2XVhrw-1
X-Mimecast-MFC-AGG-ID: 4vM2OKLVOFmCdlVj2XVhrw_1780328338
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B0B419560B5;
	Mon,  1 Jun 2026 15:38:58 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42D8E18004A3;
	Mon,  1 Jun 2026 15:38:56 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 03/13] rv: Prevent in-flight per-task handlers from using invalid slots
Date: Mon,  1 Jun 2026 17:38:30 +0200
Message-ID: <20260601153840.124372-4-gmonaco@redhat.com>
In-Reply-To: <20260601153840.124372-1-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: BtV4cWHRkOgAT9ILZhi0pigzKZGRSALgj4sL91quYk8_1780328338
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

