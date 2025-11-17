Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DEB34251C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Nov 2025 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405838; cv=none; b=pBh+WJY/Zi6uH8xkHcJl+/KvIWT0SuNstsCdQo0WMqUSVeOMOq3TGIJ95n/Y2Rs6B7qecovSE6PAHwEa1V4TaFeN4LepKoVYUtHhA0KFPQx1wMmzQqYvmVMdcXf3xlIhDr1orGvUabJzmdMr6OpHLc3B8+8R/cgDNqJP6m9bWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405838; c=relaxed/simple;
	bh=9LHwH85GVx+dILDMq0gSzAtnCgezKegZ1fVjvhUvgA4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjupYSGEBmqtAKu+lrbuS2s2KgQXrhxhc0/CKM+jDpRXvYDXECcKUy0MxMJG6AqjVsiA39Gi/VJ9xlvNqSOAGy63aaxIRL0uFX7x3n2phh8sCgkxGtrMFwuKXcEspIl9dfR8QTwyfy2A7tp+1Ok+i04dEapMzRdMGDNc4psTlwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZD5/qfAX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZD5/qfAX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUJiSXgP7OYZRNQjJLoq/fTS0neWpO/zNbumzcyTMMc=;
	b=ZD5/qfAXJOVngGLzp+SlHFi6zlj2P6AiIyxj3gkXfleIwa+8k5oJNWkJMbjyOTqMBH9zXQ
	WrJEUsXAzPDwfdyvutONKU4lO3LVF3Spe4cmAFf39uG0FrcqGbvKnblcMqCj+m2a6PTVd/
	tDa7/QpwfMX0u1/+e5NlEtPf/sx2JAQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-U9qG0fP1OjWxBOf_WPUeJA-1; Mon,
 17 Nov 2025 13:57:11 -0500
X-MC-Unique: U9qG0fP1OjWxBOf_WPUeJA-1
X-Mimecast-MFC-AGG-ID: U9qG0fP1OjWxBOf_WPUeJA_1763405830
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 034FB18AB414;
	Mon, 17 Nov 2025 18:57:10 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF9FB180049F;
	Mon, 17 Nov 2025 18:57:05 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [rtla 12/13] rtla: Remove unused headers
Date: Mon, 17 Nov 2025 15:41:19 -0300
Message-ID: <20251117184409.42831-13-wander@redhat.com>
In-Reply-To: <20251117184409.42831-1-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Remove unused includes for <errno.h> and <signal.h> to clean up the
code and reduce unnecessary dependencies.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c | 1 -
 tools/tracing/rtla/src/timerlat.c     | 1 -
 tools/tracing/rtla/src/timerlat_top.c | 1 -
 tools/tracing/rtla/src/trace.c        | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index dffb6d0a98d7d..44614f56493f2 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -9,7 +9,6 @@
 #include <string.h>
 #include <signal.h>
 #include <unistd.h>
-#include <errno.h>
 #include <stdio.h>
 #include <time.h>
 
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 50c7eb00fd6b7..9b77dbcbd1375 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -9,7 +9,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <sched.h>
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index d831a9e1818f4..7f2491e72e495 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -11,7 +11,6 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <time.h>
-#include <errno.h>
 #include <sched.h>
 #include <pthread.h>
 
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 658a6e94edfba..ab2bf6d04f2ee 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -2,7 +2,6 @@
 #define _GNU_SOURCE
 #include <sys/sendfile.h>
 #include <tracefs.h>
-#include <signal.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
-- 
2.51.1

