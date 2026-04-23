Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C6A3EF0DC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949579; cv=none; b=UM5HN9bKyTILq4ckSsPQwigcumdsKCFcU/2qzKK1Fqe2RIeIF8eC6cBo4H7QjD/rnZhmPlr5YjkDeKYt2a/+oZQFxjCnFznG9YbClW1/xkKyivXSlUY0UqTYqWhpbqrpzDGOemYLrpaA3fiLcr/zdo7CiuAUXmxXFwIRAWH3LjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949579; c=relaxed/simple;
	bh=ZHbziZ7SSDDIyMa/qC2uNWQceQJRFa3sQdroVyxIa0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TW/7j+aNntV24yxBOHp7x39CaCJYNZMsLR22YVTspTOG0t0SIaZd/p5c2UaTuWK9B7Guj3FHnsrIhhtg0/vUj2a56JafDr/xCLsgZJ35KkYcYAy2Wo9w3jD9yoF4CjdbnoGiMaIRUNi2o0a2BgBqNMJsucq22oYV0oiWcYrGXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Op1ZAvZb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Op1ZAvZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bFT2UtsWbdy9IKHYDAuh6L9yXrT3X5aXupRblNPuj4=;
	b=Op1ZAvZbs1tdZTQkU+ZV5bNcctNsaFqxMrMe9mGI1nvoHvTuOda+XtZ6cDdDLik1LexR79
	eS1WnGJ2R1qbdCfiHhFhyROhVtomNeBWmEJbT2OTSQRWEFz65212PXNJxTh2eyY8mdy+OJ
	9YK5GSM0yOsBvC0ykvAx4m9qvbLlHzA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-LZusY-t0PdCvTUoQP2Ph7w-1; Thu,
 23 Apr 2026 09:06:14 -0400
X-MC-Unique: LZusY-t0PdCvTUoQP2Ph7w-1
X-Mimecast-MFC-AGG-ID: LZusY-t0PdCvTUoQP2Ph7w_1776949573
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AC6019560BA;
	Thu, 23 Apr 2026 13:06:13 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE6951800348;
	Thu, 23 Apr 2026 13:06:10 +0000 (UTC)
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
Subject: [PATCH 3/9] rtla/tests: Check -c/--cpus thread affinity
Date: Thu, 23 Apr 2026 15:05:52 +0200
Message-ID: <20260423130558.882022-4-tglozar@redhat.com>
In-Reply-To: <20260423130558.882022-1-tglozar@redhat.com>
References: <20260423130558.882022-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: NUChCZ7TyHVFyQDsQAofpNGUx3O9pmqTioU4_-JniV4_1776949573
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

RTLA runtime tests verify the -c/--cpus options, but do not check
whether the correct affinity is actually applied.

Add a script named check-cpus.sh that retrieves the affinity of all
workload threads and use it to check the -c/--cpus option for both
osnoise and timerlat tools.

Also add missing -c/--cpus test for osnoise.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/osnoise.t             | 2 ++
 tools/tracing/rtla/tests/scripts/check-cpus.sh | 9 +++++++++
 tools/tracing/rtla/tests/timerlat.t            | 4 ++--
 3 files changed, 13 insertions(+), 2 deletions(-)
 create mode 100755 tools/tracing/rtla/tests/scripts/check-cpus.sh

diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index ed6ff0cc3329..5edffb23981b 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -18,6 +18,8 @@ check_top_q_hist "verify the --trace param" \
 	"osnoise TOOL -s 30 -T 1 -t" 2 "Saving trace to osnoise_trace.txt"
 check "verify the --entries/-E param" \
 	"osnoise hist -P F:1 -c 0 -r 900000 -d 10s -b 10 -E 25"
+check_top_q_hist "verify the -c/--cpus param" \
+	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=tests/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
 
 # Test setting default period by putting an absurdly high period
 # and stopping on threshold.
diff --git a/tools/tracing/rtla/tests/scripts/check-cpus.sh b/tools/tracing/rtla/tests/scripts/check-cpus.sh
new file mode 100755
index 000000000000..0b016d4a7945
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/check-cpus.sh
@@ -0,0 +1,9 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+. "$(dirname $0)/lib/get_workload_pids.sh"
+echo -n "Affinity of threads: "
+for pid in $(get_workload_pids)
+do
+    echo -n $(taskset -c -p $pid | cut -d ':' -f 2)
+done
+echo
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 765dffd9d42a..fb60022aaa64 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -39,8 +39,8 @@ check "print the auto-analysis if hits the stop tracing condition" \
 	"timerlat top --aa-only 5" 2
 check_top_hist "disable auto-analysis" \
 	"timerlat TOOL -s 3 -T 10 -t --no-aa" 2
-check_top_hist "verify -c/--cpus" \
-	"timerlat TOOL -c 0 -d 10s"
+check_top_q_hist "verify -c/--cpus" \
+	"timerlat TOOL -c 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
 
 # Actions tests
 check_top_q_hist "trace output through -t" \
-- 
2.53.0

