Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D92D26D4E9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710652; cv=none; b=CJOUO927FlLrDY2oS7xeldzRTEz75gdkpdexcn59NSFnslmc5qWTCMNr2aCLqgTvJrQ3hdVnYSvUgbmmZqEctCnZzjO5zetw/wpJTK8MLNtHADlr/4XoMN/S43sWD9uU4R65E5UeybuTrf2ncFVnzlYIWj7Es4RKYuJ5tlSkEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710652; c=relaxed/simple;
	bh=20BgeqDPx8BAFYoFrXp2HwYCm5oZitMEJSlofFT4BOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTOC8pgxKWxkg/27nSGqfUrjuT1ZC9O7BEYUPhTYjhN7JsdMoSfnUFu5j4izh8B81k7MY3Rzuz6R+/LiExmz22Tzv61U1dS/O74XM/vMxabWMhOkTciKexDOgqlP2xwVhDbU2sZF02oGMO0vBvB9106sVlhfBmqDzKMM14P2whc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEkFN0Ed; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEkFN0Ed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753710650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZSv6n/CJXft3fuH1gNZl5C0jDY0lVCodh+byC3xkS8=;
	b=JEkFN0EdJXpcgz2+L3lCWUQI+yassv7CJvGEAUvKY15QJnPOw23H1zgFco9K5h5drvXRm2
	XNgmWtgweGS9i0a55eExtPhl7g1WC29gHONqcn3XMJHQd7WVox/7BlUItrgdoGWe0cGMgN
	BUmixUnEW6kseeKUa8yMBAX1IPDmGKE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-m2H2LPC3M1eNt6_Y6Y9RSg-1; Mon,
 28 Jul 2025 09:50:46 -0400
X-MC-Unique: m2H2LPC3M1eNt6_Y6Y9RSg-1
X-Mimecast-MFC-AGG-ID: m2H2LPC3M1eNt6_Y6Y9RSg_1753710645
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1873D19560B2;
	Mon, 28 Jul 2025 13:50:45 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.215])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A92EE1800285;
	Mon, 28 Jul 2025 13:50:39 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v5 1/9] rv: Add da_handle_start_run_event_ to per-task monitors
Date: Mon, 28 Jul 2025 15:50:13 +0200
Message-ID: <20250728135022.255578-2-gmonaco@redhat.com>
In-Reply-To: <20250728135022.255578-1-gmonaco@redhat.com>
References: <20250728135022.255578-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The RV da_monitor API allows to start monitors in two ways:
da_handle_start_event_NAME and da_handle_start_run_event_NAME.
The former is used when the event is followed by the initial state of
the module, so we ignore the event but we know the monitor is in the
initial state and can start monitoring, the latter can be used if the
event can only occur in the initial state, so we do handle the event as
if the monitor was in the initial state.
This latter API is defined for implicit monitors but not per-task ones.

Define da_handle_start_run_event_NAME macro also for per-task monitors.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 15f9ed4e4bb6..ed3c34fe18d6 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -487,6 +487,30 @@ da_handle_start_event_##name(struct task_struct *tsk, enum events_##name event)
 	__da_handle_event_##name(da_mon, tsk, event);						\
 												\
 	return 1;										\
+}												\
+												\
+/*												\
+ * da_handle_start_run_event_##name - start monitoring and handle event				\
+ *												\
+ * This function is used to notify the monitor that the system is in the			\
+ * initial state, so the monitor can start monitoring and handling event.			\
+ */												\
+static inline bool										\
+da_handle_start_run_event_##name(struct task_struct *tsk, enum events_##name event)		\
+{												\
+	struct da_monitor *da_mon;								\
+												\
+	if (!da_monitor_enabled_##name())							\
+		return 0;									\
+												\
+	da_mon = da_get_monitor_##name(tsk);							\
+												\
+	if (unlikely(!da_monitoring_##name(da_mon)))						\
+		da_monitor_start_##name(da_mon);						\
+												\
+	__da_handle_event_##name(da_mon, tsk, event);						\
+												\
+	return 1;										\
 }
 
 /*
-- 
2.50.1

