Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B12425CD7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772134; cv=none; b=Tl2UyMK1lTrI2sJSwary5ny+Ez/XsiJBIb2tX7UTAYaKyk0kWHWkX1KJ3kQlWhGTLrHkgyNGvSQfzgXC6DcHHX/ma1YLFvxRHRiTUZJL3na5ckWTtDcdvn4xr5aS5rlMWF7QiU95WafahDT7LgV70TEuyThIZFesPHtRFQ98w3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772134; c=relaxed/simple;
	bh=pmOAGe2/dKAM04j7AO3NBZ7mElAJOEn2l8Xcwj9rons=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OFAA7H/FZSCbxlTC+ceUdCj+ZAxKLXEisy/Idpp4WW8hTZfUQol2aMudIEjWNile13G20L3mj1TfD9qrLR+d7/vK4i8XuGBeM7v0RQNajQ9WgX3CKO742Dy2UBC6Scx0/LBBp3eQvVvin8cVl0W3NWIR/KzQpQjxw2IYcxTcl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcSys9On; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcSys9On"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778772127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7WGOCgehfq4wxKxQkvMM756/S2J/BObUI/5cdc840M=;
	b=ZcSys9On9NOLHoUYslKovZtA60CnzrB4KFtnVqcNXwL2f8/a2/2HpRM/XCaYAvOp2/abnJ
	TkfQcvL7QWBkYI4avNHWC7eXzB7o7Wtp+kIUC4AMmdt6nWhqxOr3t73zJjZPOeKmFfXiY/
	XW68rzgfmNPijtox7agXb6aCRckPPc4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-cSjYZmE7NDaO0uQk-MT_nw-1; Thu,
 14 May 2026 11:22:04 -0400
X-MC-Unique: cSjYZmE7NDaO0uQk-MT_nw-1
X-Mimecast-MFC-AGG-ID: cSjYZmE7NDaO0uQk-MT_nw_1778772122
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C03C1800371;
	Thu, 14 May 2026 15:22:02 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.48.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47DA730001A2;
	Thu, 14 May 2026 15:21:58 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 10/14] rv: Add KUnit stub to rv_react() and rv_*_task_monitor_slot()
Date: Thu, 14 May 2026 17:20:51 +0200
Message-ID: <20260514152055.229162-11-gmonaco@redhat.com>
In-Reply-To: <20260514152055.229162-1-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: idLCVgHd7x6yFKB_dm2NX9iJ73LzL-lwXoWk0vv4-3I_1778772122
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
index 460af07f7aba..3435dcedc7ee 100644
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

