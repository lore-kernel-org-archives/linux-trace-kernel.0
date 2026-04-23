Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F63EF65B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949581; cv=none; b=Sq6npMz6bSCJIo++lIIp5KcnKdtKOpNoCONg9RRFMfDcvlF2sd3sLzJsThY5TeSCR/AmcAL4/zpehF0/PM2LtfS8seJ4y7UNAxBYR0AELrG20J47onvYQaaAFtb24JzqmXZz2yaPFV++7kaesLG366OkcgyvfXjB/Y3O/K1vlZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949581; c=relaxed/simple;
	bh=t2CoUz8Zj4/5puogtzhPfPYvc6U6e28Q4tNySmvmrlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=O+K4HsM1RVye99tjKWPUydsapwFrSCVesyHZj6jyDmp+/FrEg/sI9tmiDwFLpnJG40tScfLRdX0VKi0XDvr1OXmuuYJB+kB5+Cfgr/TjlQKir3Pt71iyOS09JFY1Jg5LBIv05gfMVOmH+HBcFeIhEgGcLRsY+9UXYP6IuFlhrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bei/mXg9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bei/mXg9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4ni7A0WiskMOxT/PAVOvxVYyiE4lLnyN8Tiox4c2aY=;
	b=bei/mXg9Dx12z3Vp2eiN/y34S72mLCWm3X8UGFjSznDx+tnBXkqVYD8OXjgkA8rFfrEuta
	eA17TsX/w1RSCbPhjX0LVlQLeJb2JBiGNzl+1eUwN8Nia95EfZOg6K5R/QvajICbCfVUh8
	Qdvp1DSPsr/6MWWBEO8uW61doENrqsE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-pFXTO4eSOnmjp04CXv9ToQ-1; Thu,
 23 Apr 2026 09:06:15 -0400
X-MC-Unique: pFXTO4eSOnmjp04CXv9ToQ-1
X-Mimecast-MFC-AGG-ID: pFXTO4eSOnmjp04CXv9ToQ_1776949570
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7808818005A9;
	Thu, 23 Apr 2026 13:06:10 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 317AE1800348;
	Thu, 23 Apr 2026 13:06:08 +0000 (UTC)
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
Subject: [PATCH 2/9] rtla/tests: Add get_workload_pids() helper
Date: Thu, 23 Apr 2026 15:05:51 +0200
Message-ID: <20260423130558.882022-3-tglozar@redhat.com>
In-Reply-To: <20260423130558.882022-1-tglozar@redhat.com>
References: <20260423130558.882022-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: SSCyW_eFlRp0Avja0IXS2OGu6G65JKFiU5mPIUgKdYM_1776949570
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

RTLA runtime tests that check workload processes (currently the test
case "verify -P/--priority" of timerlat.t and "verify the --priority/-P
param" of osnoise.t) use "pgrep timerlatu/" or "pgrep osnoise/"
respectively to identify the workload.

Make them more robust by adding a get_workload_pids() helper that
finds the main rtla process and returns the PIDs of all siblings other
than the test script itself, plus all child processes of kthreadd that
have the osnoise/timerlat kthread pattern comm.

This filters out any spurious processes not related to the running test
that happen to have "timerlatu/" or "osnoise/" in their command, for
example, a user grepping the same names at the time of the running of
the test.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/osnoise.t                    |  2 +-
 tools/tracing/rtla/tests/scripts/check-priority.sh    |  8 ++++----
 .../rtla/tests/scripts/lib/get_workload_pids.sh       | 11 +++++++++++
 tools/tracing/rtla/tests/timerlat.t                   |  2 +-
 4 files changed, 17 insertions(+), 6 deletions(-)
 create mode 100644 tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh

diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index ce3a448b1f87..ed6ff0cc3329 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -10,7 +10,7 @@ check "verify help page" \
 check_top_hist "verify help page" \
 	"osnoise TOOL --help" 0 "rtla osnoise"
 check_top_q_hist "verify the --priority/-P param" \
-	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh osnoise/ SCHED_FIFO 1\"" \
+	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh SCHED_FIFO 1\"" \
 	2 "Priorities are set correctly"
 check_top_q_hist "verify the --stop/-s param" \
 	"osnoise TOOL -s 30 -T 1" 2 "osnoise hit stop tracing"
diff --git a/tools/tracing/rtla/tests/scripts/check-priority.sh b/tools/tracing/rtla/tests/scripts/check-priority.sh
index 79b702a34a96..b51d5232a868 100755
--- a/tools/tracing/rtla/tests/scripts/check-priority.sh
+++ b/tools/tracing/rtla/tests/scripts/check-priority.sh
@@ -1,8 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
-pids="$(pgrep ^$1)" || exit 1
-for pid in $pids
+. "$(dirname $0)/lib/get_workload_pids.sh"
+for pid in $(get_workload_pids)
 do
-  chrt -p $pid | cut -d ':' -f 2 | head -n1 | grep "^ $2\$" >/dev/null
-  chrt -p $pid | cut -d ':' -f 2 | tail -n1 | grep "^ $3\$" >/dev/null
+  chrt -p $pid | cut -d ':' -f 2 | head -n1 | grep "^ $1\$" >/dev/null
+  chrt -p $pid | cut -d ':' -f 2 | tail -n1 | grep "^ $2\$" >/dev/null
 done && echo "Priorities are set correctly"
diff --git a/tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh b/tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh
new file mode 100644
index 000000000000..8aff98cd2c1f
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+get_workload_pids() {
+    local shell_pid=$$
+    local rtla_pid=$(ps -o ppid= $shell_pid)
+
+    # kernel threads
+    pgrep -P $(pgrep ^kthreadd$) -f '^(osnoise|timerlat)/[0-9]+$'
+    # user threads
+    pgrep -P $rtla_pid | grep -v "^$shell_pid$"
+}
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index d7944710a859..765dffd9d42a 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -27,7 +27,7 @@ check_top_hist "verify help page" \
 check_top_hist "verify -s/--stack" \
 	"timerlat TOOL -s 3 -T 10 -t" 2 "Blocking thread stack trace"
 check_top_hist "verify -P/--priority" \
-	"timerlat TOOL -P F:1 -c 0 -d 10s -T 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh timerlatu/ SCHED_FIFO 1\"" \
+	"timerlat TOOL -P F:1 -c 0 -d 10s -T 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh SCHED_FIFO 1\"" \
 	2 "Priorities are set correctly"
 check_top_hist "test in nanoseconds" \
 	"timerlat TOOL -i 2 -c 0 -n -d 10s" 2 "ns"
-- 
2.53.0

