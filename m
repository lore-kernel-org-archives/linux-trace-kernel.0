Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCFF3E022A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389730; cv=none; b=IsQwLG3rwXkUKBx078iLDVpwF/eXcbKXFhkp+SZMfzLFaRyVIlVGw4TnQk0xMRpP3KFHnlcc61/PawRvvNrhP9J2HcgSBGRIqg7edHPiqjXhgb0I4mnQF6HbBsHbbuSCpYCO2FPLzPQtfsBb/TlYQvLbrnDwZkOSGgOKQ4F7J5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389730; c=relaxed/simple;
	bh=s/0+8Cxf+Ir1HuoUVOrP+MC9yhCgb7Lhy20QqyFErLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XdFGr3ZUBXuGENu016aQj3Z/5WBkuVmw7MGSP6HLkg+VwKBTRn2er/kniF6OMa3ZzTl3y0GSwGRpurxMpcb40aJoM3fd9H7HqHtr88PUXHqn6dMccKWNmvKZf5cqhzMvLljAAgS3ZlgsX7UQIPd3VhyMEOSVLZdscPDGj5aOJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikkITo2i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikkITo2i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782389728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJn9XVUmmuQBZjJcX0ynC7b3SzUl9FvVJbhyJT2F9/s=;
	b=ikkITo2iKiD9Y1NvO37R7EzqpqePsn2/Oqnx/uf0KZIF3LEjzfnAwVSUdrXgMv2pxeVvQ1
	ePuAsHHzArthMyJLliPj+mdJHZks8kQaAzR8LdL1tLkI8xt3QgFZXNwJYjV8WcrbEWaNQZ
	DstF4qCejmRip8vPkfBnb0MSqeO+y5A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-gMl-1UAJO9OB0OQ9j8XAxA-1; Thu,
 25 Jun 2026 08:15:25 -0400
X-MC-Unique: gMl-1UAJO9OB0OQ9j8XAxA-1
X-Mimecast-MFC-AGG-ID: gMl-1UAJO9OB0OQ9j8XAxA_1782389723
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE1741953946;
	Thu, 25 Jun 2026 12:15:23 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1706E30002E0;
	Thu, 25 Jun 2026 12:15:20 +0000 (UTC)
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
Subject: [PATCH v3 07/17] rv: Add KUnit stub to rv_react() and rv_*_task_monitor_slot()
Date: Thu, 25 Jun 2026 14:14:29 +0200
Message-ID: <20260625121440.116317-8-gmonaco@redhat.com>
In-Reply-To: <20260625121440.116317-1-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: ajZtlHSmNxkK5BItk-pfN6Tr4GmnJbxGaPaEnGK-3s8_1782389723
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
 kernel/trace/rv/rv_reactors.c | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index ee4e68102f..f59385a24f 100644
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
index 460af07f7a..3435dcedc7 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -63,6 +63,7 @@
 
 #include <linux/lockdep.h>
 #include <linux/slab.h>
+#include <kunit/static_stub.h>
 
 #include "rv.h"
 
@@ -468,6 +469,12 @@ void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
 	va_list args;
 
+	__diag_push();
+	__diag_ignore(GCC, all, "-Wsuggest-attribute=format",
+		      "Not a valid __printf() conversion candidate.");
+	KUNIT_STATIC_STUB_REDIRECT(rv_react, monitor, msg);
+	__diag_pop();
+
 	if (!rv_reacting_on() || !monitor->react)
 		return;
 
-- 
2.54.0

