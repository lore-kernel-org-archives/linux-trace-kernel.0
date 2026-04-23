Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383B3F0744
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949590; cv=none; b=P4XQCIVbZOW9/ZRTZ8JXDNQ7wTmz2f/yg/eyHS86Tkd2WcM20YU55pAtyyg1EzdWoQo0UZ8dj3lJqqzSHV5cKvp5FrbA5VZVRFkQuS0Ah/cWvQiiLw4Ri81AfNEHhCXSptEbepXJsQO+hQc2e1RlnDgrfa5ihsCEm2kvM35XfME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949590; c=relaxed/simple;
	bh=1gc8Q3XzFD98HGFMK6tXi8hrGxSLnedCPsND7+/OfmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=G/1qzFzpRKhVE3d5F9fp8J9nBOZNVEHpVP+Pl5EaGRph7UiImY8aU9oA040D3HQSFDODCm8BLLwBQNrnWrgKItXlbqtGv1ZDLU1DwsTrQF1COQDdo1cfPbhfkTq6q9698a5tBStg68talARMmQHVJYc6MzzCPgRuEQB1JdaIhyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPXGRoDg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPXGRoDg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2hCe3kUGUg2bWuwvB9gGrn8uK7vB4ERQxGlQOgtijM=;
	b=OPXGRoDgBOFwFfxIoSgHmGWAwBnxc2xX7uWPVT2Wyq+1+Z1UaQCMQM05mCXRCDF0Jrd9H5
	O9ky7iKDr++UD6s9mPQO58zqfrBFiSTAccgM9PvCuZuOaDz2D6VRfPYRnzVLHnqenuPajh
	7PWOjJi58pu5kmochmUrIexTYQntgyM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-FYZeh4mCPwCawyM5oRlolQ-1; Thu,
 23 Apr 2026 09:06:25 -0400
X-MC-Unique: FYZeh4mCPwCawyM5oRlolQ-1
X-Mimecast-MFC-AGG-ID: FYZeh4mCPwCawyM5oRlolQ_1776949584
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42051180034A;
	Thu, 23 Apr 2026 13:06:24 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA4DE1800370;
	Thu, 23 Apr 2026 13:06:21 +0000 (UTC)
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
Subject: [PATCH 7/9] rtla/tests: Add runtime test for -H/--house-keeping
Date: Thu, 23 Apr 2026 15:05:56 +0200
Message-ID: <20260423130558.882022-8-tglozar@redhat.com>
In-Reply-To: <20260423130558.882022-1-tglozar@redhat.com>
References: <20260423130558.882022-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: d1h75czeuFyCcY92n9uvFzW30VSj3jC15eMqFkKvLe0_1776949584
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a runtime test for -H/--house-keeping option for both osnoise and
timerlat tools, with affinity checking similar to what is done for
-c/--cpus.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/osnoise.t                          | 2 ++
 tools/tracing/rtla/tests/scripts/check-housekeeping-cpus.sh | 4 ++++
 tools/tracing/rtla/tests/timerlat.t                         | 2 ++
 3 files changed, 8 insertions(+)
 create mode 100755 tools/tracing/rtla/tests/scripts/check-housekeeping-cpus.sh

diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 773a46e2dc5f..cdea84914345 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -18,6 +18,8 @@ check_top_q_hist "verify the --trace param" \
 	"osnoise TOOL -s 30 -T 1 -t" 2 "Saving trace to osnoise_trace.txt"
 check_top_q_hist "verify the -c/--cpus param" \
 	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=tests/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
+check_top_q_hist "verify the -H/--house-keeping param" \
+	"osnoise TOOL -P F:1 -H 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=tests/scripts/check-housekeeping-cpus.sh" 2 "^Affinity of threads: 0$"
 
 # Histogram tests
 check "hist with -b/--bucket-size" \
diff --git a/tools/tracing/rtla/tests/scripts/check-housekeeping-cpus.sh b/tools/tracing/rtla/tests/scripts/check-housekeeping-cpus.sh
new file mode 100755
index 000000000000..4742f34efb49
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/check-housekeeping-cpus.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+pid=$(ps -o ppid= $$)
+echo "Affinity of threads:$(taskset -c -p $pid | cut -d ':' -f 2)"
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index a14d9ec32ede..20f68bcbcb27 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -43,6 +43,8 @@ check_top_hist "disable auto-analysis" \
 	"timerlat TOOL -s 3 -T 10 -t --no-aa" 2 "" "analyzing it"
 check_top_q_hist "verify -c/--cpus" \
 	"timerlat TOOL -c 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
+check_top_q_hist "verify -H/--house-keeping" \
+	"timerlat TOOL -H 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-housekeeping-cpus.sh" 2 "^Affinity of threads: 0$"
 
 # Histogram tests
 check "hist with -b/--bucket-size" \
-- 
2.53.0

