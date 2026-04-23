Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F663EF646
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949596; cv=none; b=C2/607F8ZXAs5994a6eSW2MUAiXJhMHnZ53zyox3B9j3DB/MC1aJzylx5FLEIXLMVe/uwlUkQPWd5tZPqWU5FjkzsFm5EiO7wMboMDLXRVQM601prpD23E6r+TdTB4eV1nRnRh1rFT6PqLtzHZvM+3ZZ/ROf//H6oh1kzTgB3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949596; c=relaxed/simple;
	bh=HlFuSJ4fhTIa0RGc2qOzwMZqFPgTieten6LtQBHdlvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=uNK6WDHDfAVQTAUpyFjOs46d0zEiLUTzTtsAJ6iaD4pG+ec26t549/9TxmxSOAMncxCUeIIlhC+E1qyGymSm2Pj5tn6aBc3QVhG3SVO4czwcBV4ncltIqw2UQLPuxOZsheJUnNmBVt2ZuV1TkUu/Rb5DKF90psP1/e9IYQTrK5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfH5ZZJh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfH5ZZJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kltkYTjIyWTmUYzKqWZ15Hc2o1gDOHMNhYh+zJ6DjrQ=;
	b=GfH5ZZJhBZVBZTToqIw8DZAI2UIqlkDFt4RclbdparzkyZvQOrMPfDxv8oit4i5NXCrgk7
	71UtVX0PZnXz3Vq8Th1tXU3CMZWYJ441XIrOegpcOEOXzJFBqnhC+6LYI+vL350wKOxm+G
	ff5c0JyyfAd5SMKJoddbpSGUModF9Js=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-feQI92AbOIu98CLEIpVpMw-1; Thu,
 23 Apr 2026 09:06:31 -0400
X-MC-Unique: feQI92AbOIu98CLEIpVpMw-1
X-Mimecast-MFC-AGG-ID: feQI92AbOIu98CLEIpVpMw_1776949591
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9AED1955BCE;
	Thu, 23 Apr 2026 13:06:30 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A7A9C1800357;
	Thu, 23 Apr 2026 13:06:28 +0000 (UTC)
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
Subject: [PATCH 9/9] rtla/tests: Add runtime tests for -C/--cgroup
Date: Thu, 23 Apr 2026 15:05:58 +0200
Message-ID: <20260423130558.882022-10-tglozar@redhat.com>
In-Reply-To: <20260423130558.882022-1-tglozar@redhat.com>
References: <20260423130558.882022-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: MrT-1uayK86Fhstb5vp9birB5jntoJNwGvMLkBdR8qA_1776949591
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a new script check-cgroup-match.sh that retrieves the cgroup of the
main rtla process and compares it to the cgroup of the rtla workload
threads.

Add a new test based on this script, for both osnoise and timerlat
tools, testing the variant of -C without argument (which sets the cgroup
of the workload to the cgroup of the rtla main process).

Note that this has to be tested in kernel mode to be significant for
timerlat tool, as user workloads inherit the parent rtla process cgroup
even without the option.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/osnoise.t              |  3 +++
 .../rtla/tests/scripts/check-cgroup-match.sh    | 17 +++++++++++++++++
 tools/tracing/rtla/tests/timerlat.t             |  3 +++
 3 files changed, 23 insertions(+)
 create mode 100755 tools/tracing/rtla/tests/scripts/check-cgroup-match.sh

diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index d0b623233db5..06787471d0e8 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -18,6 +18,9 @@ check_top_q_hist "verify the --trace param" \
 check_top_q_hist "verify the --priority/-P param" \
 	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh SCHED_FIFO 1\"" \
 	2 "Priorities are set correctly"
+check_top_q_hist "verify the -C/--cgroup param" \
+	"osnoise TOOL -C -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=\"tests/scripts/check-cgroup-match.sh\"" \
+	2 "cgroup matches for all workload PIDs"
 check_top_q_hist "verify the -c/--cpus param" \
 	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=tests/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
 check_top_q_hist "verify the -H/--house-keeping param" \
diff --git a/tools/tracing/rtla/tests/scripts/check-cgroup-match.sh b/tools/tracing/rtla/tests/scripts/check-cgroup-match.sh
new file mode 100755
index 000000000000..fdc2c68c5957
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/check-cgroup-match.sh
@@ -0,0 +1,17 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+. "$(dirname $0)/lib/get_workload_pids.sh"
+rtla_pid=$(echo $(ps -o ppid= $$))
+rtla_cgroup=$(</proc/$rtla_pid/cgroup)
+echo "RTLA cgroup: $rtla_cgroup"
+for pid in $(get_workload_pids)
+do
+    pid_cgroup=$(</proc/$pid/cgroup)
+    echo "PID $pid cgroup: $pid_cgroup"
+    if ! [ "$pid_cgroup" = "$rtla_cgroup" ]
+    then
+        echo "Mismatch!"
+        exit 0
+    fi
+done
+echo "cgroup matches for all workload PIDs"
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 3557adbdebae..3ebfe316b39e 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -43,6 +43,9 @@ check_top_hist "disable auto-analysis" \
 check_top_hist "verify -P/--priority" \
 	"timerlat TOOL -P F:1 -c 0 -d 10s -T 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh SCHED_FIFO 1\"" \
 	2 "Priorities are set correctly"
+check_top_hist "verify -C/--cgroup" \
+	"timerlat TOOL -k -C -c 0 -d 10s -T 1 --on-threshold shell,command=\"tests/scripts/check-cgroup-match.sh\"" \
+	2 "cgroup matches for all workload PIDs"
 check_top_q_hist "verify -c/--cpus" \
 	"timerlat TOOL -c 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
 check_top_q_hist "verify -H/--house-keeping" \
-- 
2.53.0

