Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191743B6C1E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792846; cv=none; b=kyGik90/uPuD3WwqwowbmlXpTHYSegwTg9Pypx6yD76YLZewinXV1HSn5pHSAdoNynmcYRYBl0fCJ+Tm89E+Rb5JKMRdg5GZf7CG+qkJrKswOAao1ObQm8+Bb/rFdzTbny92Fe5B6kxT9la1qST+H01rMaedvYXeX6wWdHFWZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792846; c=relaxed/simple;
	bh=oHrzS7c2fdMxPD+EoUgQkE+zbdNYCbx8okcllqp9KYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IOLStKkUxSbhwJnhQraLH0cZ03v1lN2w5oUiiphJJPG5M6EtrCVwHfDn+cogcGnfYbj6+uIhSoiibFvsG5NRwOcb7dxxz+lhV9CptOaH2iDPy9nBItd3ilC79xR7spIO3G3GAOucjx+q3wWUo3sWXo/pmde0NZYheJaaZ7laoOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpwJy6/A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpwJy6/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784792844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rU+JQSn24qoe+8/7ChMxhPzRjJgh1VjUQ1PsYPpKZ7A=;
	b=MpwJy6/A2FQasKQP47Y1t9g4k4yIfD3MYYe96JA2j9kGDM4siQbj5EMgX/Mn8HpEQXkNsP
	POlED2k7oDRB8Sh3DExm5qQ7EleDUZAqqW4t1w1R2Zj8o9uTkNJmR0AVWZuKwA2CQlRoy2
	L7UXNEgkKj4eTTAa3el6JvaQKqBl7ic=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-OIFZQ_uGMim6Wy1GXEkM8A-1; Thu,
 23 Jul 2026 03:47:20 -0400
X-MC-Unique: OIFZQ_uGMim6Wy1GXEkM8A-1
X-Mimecast-MFC-AGG-ID: OIFZQ_uGMim6Wy1GXEkM8A_1784792839
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2FA1182FA23;
	Thu, 23 Jul 2026 07:47:18 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F0EB180029D;
	Thu, 23 Jul 2026 07:47:15 +0000 (UTC)
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
Subject: [PATCH v5 15/17] selftests/verification: Fix wrong errexit assumption
Date: Thu, 23 Jul 2026 09:45:32 +0200
Message-ID: <20260723074534.43521-16-gmonaco@redhat.com>
In-Reply-To: <20260723074534.43521-1-gmonaco@redhat.com>
References: <20260723074534.43521-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: UgYy2BYfiEJc5S5CJYM-EBDZb2d3RF6ZDwKmDSFWlDQ_1784792839
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

