Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3653EF0D3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949593; cv=none; b=UaRPe2qab3sptRI4rP8n2mlM2UG9VlpplTkUy6nqWB3TUVvIOgT5e1x9fnJk/ritE/b0CUuz7yBAre55uf4l4Zvf6JiCS0YulkPSOzgsMNH7rIMpw2yCbQcRnI1HLYwY5VtVIty211/tZ8xWuh6NYFdgk/jbMExt84iWjX80byw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949593; c=relaxed/simple;
	bh=fIRggRYjsYVwKIEFdZmfHHKTU0++5qUwzOsajykDlQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Qv3s/ZgBBcE/Lp2chGEPj1XyVy8sQR49dKeKjq7Xo1cdB21r4MOUry8tkbeUhgHMzSmFHk06f2l4Zt05F8wkZj4UE8zBSmHbA0RPBjGiqwDpxuTa4TxqKRA+bheeGc0RxAF7j8puuE9q+Oxos1fgRKE/D+UyGC2mX921lCklvjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZ87Yh2k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZ87Yh2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQvgbGFGfpii8v/KdPeQXIxsFLMvdw8xYLo9b00Q32E=;
	b=FZ87Yh2knl8AScWe9MYjqeGkdsv89UKa6NlfowNMiCpNmbSOw0N/dGuMXQff8t5UguOdh1
	qXwScRf4oj6cvPGLqBBkSMFNKzdRaMotxIx2xvnpD3Z0UJPOho8huQrGM1xKwM5hZHJB+n
	jCyKF4nR4rL1MNZ/CZQLaBjgseRF8tw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-t0KX1iQ1Mq29DlIV4EuAjw-1; Thu,
 23 Apr 2026 09:06:29 -0400
X-MC-Unique: t0KX1iQ1Mq29DlIV4EuAjw-1
X-Mimecast-MFC-AGG-ID: t0KX1iQ1Mq29DlIV4EuAjw_1776949588
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C6BD1955BD0;
	Thu, 23 Apr 2026 13:06:28 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F6D51800347;
	Thu, 23 Apr 2026 13:06:24 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 8/9] rtla/tests: Add runtime test for -k and -u options
Date: Thu, 23 Apr 2026 15:05:57 +0200
Message-ID: <20260423130558.882022-9-tglozar@redhat.com>
In-Reply-To: <20260423130558.882022-1-tglozar@redhat.com>
References: <20260423130558.882022-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: PuZr3d2OQt8wnz8wmMumTyhH4F1W7Gw0KQ23_IMuqVc_1776949588
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add runtime test for rtla-timerlat's -k/--kernel-threads and
-u/--user-threads options using get_workload_pids.sh to check whether
the appropriate threads are being created.

The tests are implemented for both top and hist. Additionally, all tests
related to timerlat threads are moved to a separate section in the test
files. The latter is also done for rtla-osnoise tests.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/osnoise.t               |  8 +++++---
 .../tests/scripts/check-user-kernel-threads.sh   | 16 ++++++++++++++++
 tools/tracing/rtla/tests/timerlat.t              | 12 +++++++++---
 3 files changed, 30 insertions(+), 6 deletions(-)
 create mode 100755 tools/tracing/rtla/tests/scripts/check-user-kernel-threads.sh

diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index cdea84914345..d0b623233db5 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -9,13 +9,15 @@ check "verify help page" \
 	"osnoise --help" 0 "osnoise version"
 check_top_hist "verify help page" \
 	"osnoise TOOL --help" 0 "rtla osnoise"
-check_top_q_hist "verify the --priority/-P param" \
-	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh SCHED_FIFO 1\"" \
-	2 "Priorities are set correctly"
 check_top_q_hist "verify the --stop/-s param" \
 	"osnoise TOOL -s 30 -T 1" 2 "osnoise hit stop tracing"
 check_top_q_hist "verify the --trace param" \
 	"osnoise TOOL -s 30 -T 1 -t" 2 "Saving trace to osnoise_trace.txt"
+
+# Thread tests
+check_top_q_hist "verify the --priority/-P param" \
+	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh SCHED_FIFO 1\"" \
+	2 "Priorities are set correctly"
 check_top_q_hist "verify the -c/--cpus param" \
 	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=tests/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
 check_top_q_hist "verify the -H/--house-keeping param" \
diff --git a/tools/tracing/rtla/tests/scripts/check-user-kernel-threads.sh b/tools/tracing/rtla/tests/scripts/check-user-kernel-threads.sh
new file mode 100755
index 000000000000..bb7ac510a735
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/check-user-kernel-threads.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+. "$(dirname $0)/lib/get_workload_pids.sh"
+kthreadd_pid=$(pgrep ^kthreadd$)
+cnt_kernel=0
+cnt_user=0
+for pid in $(get_workload_pids)
+do
+    if [ "$(echo $(ps -o ppid= $pid))" = "$kthreadd_pid" ]
+    then
+        ((++cnt_kernel))
+    else
+        ((++cnt_user))
+    fi
+done
+echo "$cnt_kernel kernel threads, $cnt_user user threads"
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 20f68bcbcb27..3557adbdebae 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -26,9 +26,6 @@ check_top_hist "verify help page" \
 	"timerlat TOOL --help" 0 "rtla timerlat"
 check_top_hist "verify -s/--stack" \
 	"timerlat TOOL -s 3 -T 10 -t" 2 "Blocking thread stack trace"
-check_top_hist "verify -P/--priority" \
-	"timerlat TOOL -P F:1 -c 0 -d 10s -T 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh SCHED_FIFO 1\"" \
-	2 "Priorities are set correctly"
 check_top_hist "test in nanoseconds" \
 	"timerlat TOOL -i 2 -c 0 -n -d 10s" 2 "ns"
 check_top_hist "set the automatic trace mode" \
@@ -41,10 +38,19 @@ check "verify --aa-only max latency" \
 	"timerlat top --aa-only 2000000 -d 1s" 0 "^  Max latency was" "Timer Latency"
 check_top_hist "disable auto-analysis" \
 	"timerlat TOOL -s 3 -T 10 -t --no-aa" 2 "" "analyzing it"
+
+# Thread tests
+check_top_hist "verify -P/--priority" \
+	"timerlat TOOL -P F:1 -c 0 -d 10s -T 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh SCHED_FIFO 1\"" \
+	2 "Priorities are set correctly"
 check_top_q_hist "verify -c/--cpus" \
 	"timerlat TOOL -c 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
 check_top_q_hist "verify -H/--house-keeping" \
 	"timerlat TOOL -H 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-housekeeping-cpus.sh" 2 "^Affinity of threads: 0$"
+check_top_q_hist "verify -k/--kernel-threads" \
+	"timerlat TOOL -k -c 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-user-kernel-threads.sh" 2 "1 kernel threads, 0 user threads"
+check_top_q_hist "verify -u/--user-threads" \
+	"timerlat TOOL -u -c 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-user-kernel-threads.sh" 2 "0 kernel threads, 1 user threads"
 
 # Histogram tests
 check "hist with -b/--bucket-size" \
-- 
2.53.0

