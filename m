Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AA5372045
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303315; cv=none; b=Ss+3HVdPBg0YvwVEtRulYw2CkZr8UckPjux4ifIxBAu8Q8Sl4ro1oytCYJIF7/Ecf3EN6gSmrd7WWrgBHLJCdihwahJTiTpRNHhxdx6Yfd1ik9njyDnzZadzoCgk5YF1R6oPQ4Gn5959aRlzX97IPO0dHjWWsKY3DS65E1/JnAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303315; c=relaxed/simple;
	bh=oHrzS7c2fdMxPD+EoUgQkE+zbdNYCbx8okcllqp9KYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=cg+fxB+UmTz4YP1yMMzo3Pn2gp1yg6TjIWddO5aBUSYgDJEUKyrkpb741EJHSoXBAD95Nx+PRMBXWy1lNE8ftI65h+SPG19WTJ/RQoaRsmBgGCvl1p61CmVnWrLxN+qon/166qX9ecHak3p0CxCVONzx8xklU+yAE1vCbYfs8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOaB4naU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOaB4naU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784303312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rU+JQSn24qoe+8/7ChMxhPzRjJgh1VjUQ1PsYPpKZ7A=;
	b=iOaB4naUtfKRoq+qoY4uhdz99O4Pt8yiuQxnFl5nPlsQIzZnpkRtCWqvpzrnGFfu9Vwy4K
	64p3eHLIM1D4Z1Cjb+XdXvxO4bthdRfEpbrqMOUt/a+bR5trbOu07AS+qBRTCsmTbb4Dyg
	Izlt/Rb61vbzerP+Aa6plRycA/G6HpM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-FmT66Q4YP2WIdLtpdIi7Sw-1; Fri,
 17 Jul 2026 11:48:29 -0400
X-MC-Unique: FmT66Q4YP2WIdLtpdIi7Sw-1
X-Mimecast-MFC-AGG-ID: FmT66Q4YP2WIdLtpdIi7Sw_1784303307
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D6B1195D009;
	Fri, 17 Jul 2026 15:48:27 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 628EC30040BF;
	Fri, 17 Jul 2026 15:48:24 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v4 15/17] selftests/verification: Fix wrong errexit assumption
Date: Fri, 17 Jul 2026 17:46:36 +0200
Message-ID: <20260717154638.220789-16-gmonaco@redhat.com>
In-Reply-To: <20260717154638.220789-1-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: olRnjP00yqizZr5R05Ic1_qM_ntwDmm8EaIgVEHLO5E_1784303307
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

RV selftest rely on bash errexit (set -e) to terminate with error, when
a step is expected to return false, the following syntax is used:

  ! cmd

This however prevents the test from exiting when cmd is false (desired)
but doesn't exit if cmd is true, since commands prefixed with ! are
explicitly excluded from errexit.

Use the syntax

  ! cmd || false

Which ends up checking the exit value of ! cmd and supplies a false
command for errexit to evaluate.

Reviewed-by: Wen Yang <wen.yang@linux.dev>
Acked-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 .../verification/test.d/rv_monitor_enable_disable.tc   | 10 +++++-----
 .../verification/test.d/rv_monitor_reactor.tc          |  4 ++--
 .../selftests/verification/test.d/rv_wwnr_printk.tc    |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc b/tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
index f29236defb5a..61e2c8b54d9a 100644
--- a/tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
+++ b/tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
@@ -10,7 +10,7 @@ test_simple_monitor() {
     grep -q "$monitor$" enabled_monitors
 
     echo 0 > "monitors/$prefix$monitor/enable"
-    ! grep -q "$monitor$" enabled_monitors
+    ! grep -q "$monitor$" enabled_monitors || false
 
     echo "$monitor" >> enabled_monitors
     grep -q 1 "monitors/$prefix$monitor/enable"
@@ -34,12 +34,12 @@ test_container_monitor() {
 	test -n "$nested"
 
     echo 0 > "monitors/$monitor/enable"
-    ! grep -q "^$monitor$" enabled_monitors
+    ! grep -q "^$monitor$" enabled_monitors || false
 
     for nested_dir in "monitors/$monitor"/*; do
         [ -d "$nested_dir" ] || continue
         nested=$(basename "$nested_dir")
-        ! grep -q "^$monitor:$nested$" enabled_monitors
+        ! grep -q "^$monitor:$nested$" enabled_monitors || false
     done
 
     echo "$monitor" >> enabled_monitors
@@ -71,5 +71,5 @@ for monitor_dir in monitors/*; do
     fi
 done
 
-! echo non_existent_monitor > enabled_monitors
-! grep -q "^non_existent_monitor$" enabled_monitors
+! echo non_existent_monitor > enabled_monitors || false
+! grep -q "^non_existent_monitor$" enabled_monitors || false
diff --git a/tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc b/tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
index 2958bf849338..516a20971390 100644
--- a/tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
+++ b/tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
@@ -64,5 +64,5 @@ done
 
 monitor=$(ls /sys/kernel/tracing/rv/monitors -1 | head -n 1)
 test -f "monitors/$monitor/reactors"
-! echo non_existent_reactor > "monitors/$monitor/reactors"
-! grep -q "\\[non_existent_reactor\\]" "monitors/$monitor/reactors"
+! echo non_existent_reactor > "monitors/$monitor/reactors" || false
+! grep -q "\\[non_existent_reactor\\]" "monitors/$monitor/reactors" || false
diff --git a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
index 5a59432b1d93..96de95edb530 100644
--- a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
+++ b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
@@ -17,13 +17,13 @@ echo printk > monitors/wwnr/reactors
 load
 
 echo 0 > monitoring_on
-! load
+! load || false
 echo 1 > monitoring_on
 
 load
 
 echo 0 > reacting_on
-! load
+! load || false
 echo 1 > reacting_on
 
 echo nop > monitors/wwnr/reactors
-- 
2.55.0

