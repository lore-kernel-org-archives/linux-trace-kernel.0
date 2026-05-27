Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8070C32A3EC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863037; cv=none; b=fN3Bury4uxGXO2259Ino7gXUpPVkRaCnkAs9FYUL2zlQ+N6AoNSG4SZzMbjKEmDEQmYysOvtA/wrTFgJYn0/CNkn2zdJvAMk++X2pK2iknPNVC9urZbc0rjky5sWyNh+oEWIlyDDaHc3QrLMLXRIdWfesVTNwiqLZcB92Egp4pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863037; c=relaxed/simple;
	bh=rNassdAisJNl4nQAZn1wm+0/7C0SH5ZTaL4ainiidjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lOz7zUZkYZddHEh41R0Kc7yZ1EwmAiPN4GYI1ZMYghkIxouQmdW0+ue8M7QA46b3GGi1CBsh1mSy1QXkwOO3Nv03+YAg6kHF3rgRHL2BdUWTU0jYlkfzPhjtyLnFod4TOXqbxwmHLw2b2pmdHd/PQMr2uJmNKMj5A5/TOCzCDHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHw6hUal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHw6hUal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779863034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSsuFDsLUHgAw7G8Z5t1gaV3ukEOz/iBoYqKHZicEKA=;
	b=BHw6hUaln+x1mzO75XRgc2+W9eRFzXsAYawjQ20leqObiIu257PtcRjEjx94PeX5ORDDRu
	EZQxi8/GpqUgPo1kjs2EziGtWXi8xSvkCvdF2XVV+5Z29lsf/dqtTs5/d73ulNy4HMhn49
	WrqK6xFa/YA9SVdlISzLyFRd1lMoLGM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-O9oO2cdoPmuDzXe8ZHa8Dw-1; Wed,
 27 May 2026 02:23:51 -0400
X-MC-Unique: O9oO2cdoPmuDzXe8ZHa8Dw-1
X-Mimecast-MFC-AGG-ID: O9oO2cdoPmuDzXe8ZHa8Dw_1779863030
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E915F19560B2;
	Wed, 27 May 2026 06:23:49 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64F55180034E;
	Wed, 27 May 2026 06:23:47 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 05/12] rv: Prevent in-flight per-task handlers from using invalid slots
Date: Wed, 27 May 2026 08:23:05 +0200
Message-ID: <20260527062313.39908-6-gmonaco@redhat.com>
In-Reply-To: <20260527062313.39908-1-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 3akx6Gr2skKKsmIjOJaeZuwfMEVJRx8ymKyrbLQiPKY_1779863030
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
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h  | 4 ++++
 include/rv/ltl_monitor.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index a9fd284195ee..446a4d53d99c 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -310,6 +310,9 @@ static int da_monitor_init(void)
 
 /*
  * da_monitor_destroy - return the allocated slot
+ *
+ * Wait for all in-flight handlers before returning the slot to avoid
+ * out-of-bound accesses.
  */
 static inline void da_monitor_destroy(void)
 {
@@ -320,6 +323,7 @@ static inline void da_monitor_destroy(void)
 
 	da_monitor_reset_all();
 
+	tracepoint_synchronize_unregister();
 	rv_put_task_monitor_slot(task_mon_slot);
 	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
 }
diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index eff60cd61106..38e792401f76 100644
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

