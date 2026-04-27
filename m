Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D1334C2B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302764; cv=none; b=nc+9DPte0TwkyspF16KHbcIzS0kTb5AwIx9Lm+sflaTIRBy3qaW7haF33kEavHFT21WiJhXCiDsnrZXafp6+Zm4jwpf761uRfMy35gXUh2S4cevy2c1Jn6FSpO7mKDf3XPwOokeCEm6vAWk2Tv4QSI2mPvyOaMwVrOJHI/fVrWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302764; c=relaxed/simple;
	bh=oEzG6KIS9LOm+BclNKrfGnKYk+0uX4IBFxKkCA3K2qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FL9Cvaddl9/3rt6b6PnoLE9Ko2fUjD3mhBjMX4005CwGMnoWIWMSbXPywk0z42YxlziWkgUTrxXXRr5+BfLJTKzHpd3rUuvwMGaX5Pq3glQwbCp5BUPVqAp+JieD73es6Fn72em90+AHlcdcAPWBA64b/aHS+V38R09hM8MqGbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifXgC+Bb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifXgC+Bb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777302761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jxEnHj0d2Dslqe17siW0C7arZRD0qgC5bF07E72dZk=;
	b=ifXgC+Bb5ZAi4S31UDNQ/fNd30r8XiMad+IrrK/NasHydSG44VVYs5+IHdJwEQJ4Yx6U3u
	o+2eQlwzUw51PiQE0QVeszwCID9qZDS4PN6KyWcxbIRTI/73PeRwGZLkO3XBj295OwwDW/
	9TT9WsExfvx+BPQrkTtLL9nomp1W5Hk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-3hAN9zCEOpKwiSEc3taOfw-1; Mon,
 27 Apr 2026 11:12:40 -0400
X-MC-Unique: 3hAN9zCEOpKwiSEc3taOfw-1
X-Mimecast-MFC-AGG-ID: 3hAN9zCEOpKwiSEc3taOfw_1777302759
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D9E51956095;
	Mon, 27 Apr 2026 15:12:39 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5C77195608E;
	Mon, 27 Apr 2026 15:12:35 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH 09/12] rv: Add KUnit stub to rv_react() and rv_*_task_monitor_slot()
Date: Mon, 27 Apr 2026 17:11:31 +0200
Message-ID: <20260427151134.192971-10-gmonaco@redhat.com>
In-Reply-To: <20260427151134.192971-1-gmonaco@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: GAQIAsKic4AzzdMtafnZl0vp_td_B7BUXkS5det4JUI_1777302759
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add KUNIT_STATIC_STUB_REDIRECT to allow those functions to be stubbed in
a KUnit test. This is useful to catch reaction without creating a custom
reactor and going through the effort of setting it from a test.
rv_{get/put}_task_monitor_slot() rely on a lock, but this isn't
necessary during a unit test, so simply skip the calls.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/rv.c          | 5 +++++
 kernel/trace/rv/rv_reactors.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index ee4e68102f17..f59385a24fa1 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -142,6 +142,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <kunit/static_stub.h>
 
 #ifdef CONFIG_RV_MON_EVENTS
 #define CREATE_TRACE_POINTS
@@ -171,6 +172,8 @@ int rv_get_task_monitor_slot(void)
 {
 	int i;
 
+	KUNIT_STATIC_STUB_REDIRECT(rv_get_task_monitor_slot);
+
 	lockdep_assert_held(&rv_interface_lock);
 
 	if (task_monitor_count == CONFIG_RV_PER_TASK_MONITORS)
@@ -192,6 +195,8 @@ int rv_get_task_monitor_slot(void)
 
 void rv_put_task_monitor_slot(int slot)
 {
+	KUNIT_STATIC_STUB_REDIRECT(rv_put_task_monitor_slot, slot);
+
 	lockdep_assert_held(&rv_interface_lock);
 
 	if (slot < 0 || slot >= CONFIG_RV_PER_TASK_MONITORS) {
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 460af07f7aba..f9b6a034c022 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -63,6 +63,7 @@
 
 #include <linux/lockdep.h>
 #include <linux/slab.h>
+#include <kunit/static_stub.h>
 
 #include "rv.h"
 
@@ -468,6 +469,8 @@ void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
 	va_list args;
 
+	KUNIT_STATIC_STUB_REDIRECT(rv_react, monitor, msg);
+
 	if (!rv_reacting_on() || !monitor->react)
 		return;
 
-- 
2.53.0

