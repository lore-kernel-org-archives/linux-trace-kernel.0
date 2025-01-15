Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C214900B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954296; cv=none; b=AZyqw2ESWIxJxPc4WZgT7H1LUtSJK3b/tRfrSRRnvQ3s+pBpgCtBmJc4VrF91LaTL+cU19v4exSGYBSamLEKuOvVI6ZQgnoEiOmDNd4MHQVSn5/ipOb1RwifoKHqdR6raWr87Iavs4W7LfRj7p2sMFGw78pfc4Ald2lVuK/XXQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954296; c=relaxed/simple;
	bh=Hx+GSE1YhBPiTEmzXZ6l8LyNYJt3oX2w0Kk98Xa8eKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpzHwkIsBxAAla8a7eaQ2VazvKPze0h7UlU8OaA2LXTWTdoodUJ09N6Mm5+qPSKRRQzzYRNjj1jju0tXYkmO7WfGUFGRe5Y1ZO1SEA/fAeIXmjai9kMgwnwI8voNgtw+qHvvuOljCEq+TBFHFLhbk7IiKAFBmG4pc3ppCgVIuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vn1/uXdX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vn1/uXdX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736954293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2wNFKSknnYOPyvxfGQXm1S/4X4bJmY/fnO3/cA6JIRA=;
	b=Vn1/uXdXAbZEUKlYqrQKHahxyZS5lciWkwV96IXjaa61YRARXSdwbyBuIU7fk6PY4nT3qB
	Nb/GitRF21qJuNzHniGTCHQ9f2H2xCvpWa8azg4jjoYTjLsEG5PiVg9qy2Yy/fdglu4KAN
	HqsSp56SQnwhrJMp1+Ec3YL7ACBBci8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-slpS7huyOmCXSI4azvfxIg-1; Wed,
 15 Jan 2025 10:18:09 -0500
X-MC-Unique: slpS7huyOmCXSI4azvfxIg-1
X-Mimecast-MFC-AGG-ID: slpS7huyOmCXSI4azvfxIg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65B0F1955DDA;
	Wed, 15 Jan 2025 15:18:08 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.193.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B6E019560BC;
	Wed, 15 Jan 2025 15:18:04 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	John Kacur <jkacur@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] rv: Reset per-task monitors also for idle tasks
Date: Wed, 15 Jan 2025 16:15:48 +0100
Message-ID: <20250115151547.605750-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

RV per-task monitors are implemented through a monitor structure
available for each task_struct. This structure is reset every time the
monitor is (re-)started, to avoid inconsistencies if the monitor was
activated previously.
To do so, we reset the monitor on all threads using the macro
for_each_process_thread. However, this macro excludes the idle tasks on
each CPU. Idle tasks could be considered tasks on their own right and it
should be up to the model whether to ignore them or not.

Reset monitors also on the idle tasks for each present CPU whenever we
reset all per-task monitors.

Fixes: 792575348ff7 ("rv/include: Add deterministic automata monitor definition via C macros")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 9705b2a98e49e..510c88bfabd43 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -14,6 +14,7 @@
 #include <rv/automata.h>
 #include <linux/rv.h>
 #include <linux/bug.h>
+#include <linux/sched.h>
 
 #ifdef CONFIG_RV_REACTORS
 
@@ -324,10 +325,13 @@ static inline struct da_monitor *da_get_monitor_##name(struct task_struct *tsk)
 static void da_monitor_reset_all_##name(void)							\
 {												\
 	struct task_struct *g, *p;								\
+	int cpu;										\
 												\
 	read_lock(&tasklist_lock);								\
 	for_each_process_thread(g, p)								\
 		da_monitor_reset_##name(da_get_monitor_##name(p));				\
+	for_each_present_cpu(cpu)								\
+		da_monitor_reset_##name(da_get_monitor_##name(idle_task(cpu)));			\
 	read_unlock(&tasklist_lock);								\
 }												\
 												\

base-commit: 619f0b6fad524f08d493a98d55bac9ab8895e3a6
-- 
2.47.1

