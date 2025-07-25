Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E571A705C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753450722; cv=none; b=AmP5agugy7B6NvtFil1/QzXwy959aJb0LFbFnuTWt2JBisPn02A1kbkjKQzCf/EQjuV/aZUCL1C48U9nrIhIlyBvayXy9kpqSs4CGEDrpePU0Q1coGZwinUrjaAp1/9dN9NCLUKPTattBs9tEf+4CvNG71wcWIJQ3oqptv01iXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753450722; c=relaxed/simple;
	bh=r6fWaNqe+ruV7yA5A+LeYbU+3WnqfAaRoph3jlWDLJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k60Hlh93xsoUcndNVnOQqpzYkyOs+l30rmfGt9gHy4NkzWrO8F98L3NpO5wf9jTu4dE6FHLYYO5xVm/i/ykOTRUAGwXC8b4P23m2YPfkd4YKGlO8qCUaw96gQ0yJTF2qIfmBqMCqo8DoHou15x2YYX7gltc5vjGpNenHhGLtcrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8X880o6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8X880o6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753450719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mFHHmts8S1WbDwfmJJhgycHjqnLAs3OvIn97hWel7E=;
	b=N8X880o6KlA8g12Qz5jIKRVxM+xwulz1zu6+pOzr0zwemlanlfDtzrCbdjUnZfCM22VngP
	Co5X3aDEMqBpTofN4tPayQP9MVSzZm8qBEX1nMzjTAi9npQVEgHGboet2ZHRhgWVi5z0cD
	zI1wFEp5olexVNA6dGf2cV2Ywed6tZU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-NuclpY3zO3SiAWio1b8CRg-1; Fri,
 25 Jul 2025 09:38:37 -0400
X-MC-Unique: NuclpY3zO3SiAWio1b8CRg-1
X-Mimecast-MFC-AGG-ID: NuclpY3zO3SiAWio1b8CRg_1753450715
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BB8918009B6;
	Fri, 25 Jul 2025 13:38:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.89])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D92619560AA;
	Fri, 25 Jul 2025 13:38:32 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/2] rtla/tests: Add grep checks for base test cases
Date: Fri, 25 Jul 2025 15:38:16 +0200
Message-ID: <20250725133817.59237-2-tglozar@redhat.com>
In-Reply-To: <20250725133817.59237-1-tglozar@redhat.com>
References: <20250725133817.59237-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Checking for patterns in rtla output with grep was added to test rtla
actions. Add grep checks also for base tests where applicable.

Also fix trace event histogram trigger check to use the correct syntax
for the command-line option so that the test passes with the grep check.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/hwnoise.t  | 11 ++++++-----
 tools/tracing/rtla/tests/osnoise.t  |  6 +++---
 tools/tracing/rtla/tests/timerlat.t | 12 +++++++-----
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/tracing/rtla/tests/hwnoise.t b/tools/tracing/rtla/tests/hwnoise.t
index 448877564b8d..23ce250a6852 100644
--- a/tools/tracing/rtla/tests/hwnoise.t
+++ b/tools/tracing/rtla/tests/hwnoise.t
@@ -6,16 +6,17 @@ test_begin
 set_timeout 2m
 
 check "verify help page" \
-	"hwnoise --help"
+	"hwnoise --help" 0 "summary of hardware-related noise"
 check "detect noise higher than one microsecond" \
-	"hwnoise -c 0 -T 1 -d 5s -q"
+	"hwnoise -c 0 -T 1 -d 5s -q" 0
 check "set the automatic trace mode" \
-	"hwnoise -a 5 -d 10s" 2
+	"hwnoise -a 5 -d 10s" 2 "osnoise hit stop tracing"
 check "set scheduling param to the osnoise tracer threads" \
 	"hwnoise -P F:1 -c 0 -r 900000 -d 10s -q"
 check "stop the trace if a single sample is higher than 1 us" \
-	"hwnoise -s 1 -T 1 -t -d 10s" 2
+	"hwnoise -s 1 -T 1 -t -d 10s" 2 "Saving trace to osnoise_trace.txt"
 check "enable a trace event trigger" \
-	"hwnoise -t -e osnoise:irq_noise trigger=\"hist:key=desc,duration:sort=desc,duration:vals=hitcount\" -d 10s"
+	"hwnoise -t -e osnoise:irq_noise --trigger=\"hist:key=desc,duration:sort=desc,duration:vals=hitcount\" -d 10s" \
+	0 "Saving event osnoise:irq_noise hist to osnoise_irq_noise_hist.txt"
 
 test_end
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 6a4dfa31dc55..7574ec6a5a53 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -6,13 +6,13 @@ test_begin
 set_timeout 2m
 
 check "verify help page" \
-	"osnoise --help"
+	"osnoise --help" 0 "osnoise version"
 check "verify the --priority/-P param" \
 	"osnoise top -P F:1 -c 0 -r 900000 -d 10s -q"
 check "verify the --stop/-s param" \
-	"osnoise top -s 30 -T 1 -t" 2
+	"osnoise top -s 30 -T 1" 2 "osnoise hit stop tracing"
 check "verify the  --trace param" \
-	"osnoise hist -s 30 -T 1 -t" 2
+	"osnoise hist -s 30 -T 1 -t" 2 "Saving trace to osnoise_trace.txt"
 check "verify the --entries/-E param" \
 	"osnoise hist -P F:1 -c 0 -r 900000 -d 10s -b 10 -E 25"
 
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 2d59ee199c4d..db263dc90a2d 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -21,15 +21,17 @@ export RTLA_NO_BPF=$option
 
 # Basic tests
 check "verify help page" \
-	"timerlat --help"
+	"timerlat --help" 0 "timerlat version"
 check "verify -s/--stack" \
-	"timerlat top -s 3 -T 10 -t" 2
+	"timerlat top -s 3 -T 10 -t" 2 "Blocking thread stack trace"
 check "verify -P/--priority" \
 	"timerlat top -P F:1 -c 0 -d 10s -q"
 check "test in nanoseconds" \
-	"timerlat top -i 2 -c 0 -n -d 10s" 2
+	"timerlat top -i 2 -c 0 -n -d 10s" 2 "ns"
 check "set the automatic trace mode" \
-	"timerlat top -a 5 --dump-tasks" 2
+	"timerlat top -a 5" 2 "analyzing it"
+check "dump tasks" \
+	"timerlat top -a 5 --dump-tasks" 2 "Printing CPU tasks"
 check "print the auto-analysis if hits the stop tracing condition" \
 	"timerlat top --aa-only 5" 2
 check "disable auto-analysis" \
@@ -37,7 +39,7 @@ check "disable auto-analysis" \
 check "verify -c/--cpus" \
 	"timerlat hist -c 0 -d 10s"
 check "hist test in nanoseconds" \
-	"timerlat hist -i 2 -c 0 -n -d 10s" 2
+	"timerlat hist -i 2 -c 0 -n -d 10s" 2 "ns"
 
 # Actions tests
 check "trace output through -t" \
-- 
2.49.0

