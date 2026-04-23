Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988E3EF0BD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949579; cv=none; b=B6xdeoxHccodpWF7muTcT4hpLN6p9kv1WG1G95MRpPtfETR7djqxr+cA+RDw8/dAdSiIJS2tJ5aybulKRxPbq2kgit5ZQ70jflzX3LFp4lQWYsgC4hQJPcR2D+yriomY977N4N3SvXPekmqeBL587ftAgl40Ez6kyQESxhWQEoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949579; c=relaxed/simple;
	bh=0vtLZmqJ9+Z43kFh9gXZxnBWxliSwl4qmbK463/AatQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CreDmC8fqBCFNsFfboHjjtFwxsBd1/Sz/sX1imIlR+pUHmfyc1T8SDwkG5fI0rZ0uIZX4om3TQuIobxfJJEIu2lFLDuC2/0uyGbe+9osgv64wiQ/R+/lGsg/yf3P4T9jyZfyX8pa7+g6ZsByDnbQMm6g1zU+v0fEyY1QkxFlqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwBhP/B6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwBhP/B6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISIlbm7FM42+QOYm/52hF3mwhKKiVuHDOEi8RJI68Ks=;
	b=VwBhP/B6K564RTAlTog5R2b6B+7IjoF2hfIbVu1vY/+PXzjjMEYlgIgWWvuyCUF8DUlVbb
	S0KFUSRra4X72sB3jFuFXuN6jNSC+T0h3UAo29yOjHxQUrovLv61pdg8365RRoBVUtVom5
	KPP3s8UEMomJspL1XiDwUdsqv3QSyMI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-frvYNX9LP6idmrPoSLBa4g-1; Thu,
 23 Apr 2026 09:06:08 -0400
X-MC-Unique: frvYNX9LP6idmrPoSLBa4g-1
X-Mimecast-MFC-AGG-ID: frvYNX9LP6idmrPoSLBa4g_1776949568
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9A56180064B;
	Thu, 23 Apr 2026 13:06:07 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98EBF1800348;
	Thu, 23 Apr 2026 13:06:05 +0000 (UTC)
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
Subject: [PATCH 1/9] rtla/tests: Cover both top and hist tools where possible
Date: Thu, 23 Apr 2026 15:05:50 +0200
Message-ID: <20260423130558.882022-2-tglozar@redhat.com>
In-Reply-To: <20260423130558.882022-1-tglozar@redhat.com>
References: <20260423130558.882022-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: mBr1DbTT1PK-csP4Lxr-bIy3XhRFmR88niqZOVYDtVY_1776949568
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

RTLA runtime tests currently do not cover both tool variants for osnoise
and timerlat properly. Many tests applicable to both tools are only
tested for one tool, selected randomly.

Introduce two new shell functions, check_top_hist() and
check_top_q_hist(). The functions use the same syntax as check() and run
check() on the arguments twice: once replacing the "TOOL" string in the
command with "top" (or "top -q"), once replacing it with "hist". The top
-q variant is used for tests relying on messages printed after aborting
the RTLA main loop with a starting new line, which only happens for top
tools in quiet mode; without -q, the top output is printed on the same
line and the matches would fail.

Tests that are applicable to both top and hist tools were modified to
the run for both; additionally, tests that were already done for both
tools were migrated to the new shell functions, unless the test command
or matches differ between the tools. Additional tests were added to test
tool-specific help messages.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/engine.sh  | 15 ++++++
 tools/tracing/rtla/tests/osnoise.t  | 46 +++++++++--------
 tools/tracing/rtla/tests/timerlat.t | 76 ++++++++++++++---------------
 3 files changed, 73 insertions(+), 64 deletions(-)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index ed261e07c6d9..27d92f19a322 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -112,6 +112,21 @@ check_with_osnoise_options() {
 	NO_RESET_OSNOISE=1 check "$arg1" "$arg2" "$arg3"
 }
 
+check_top_hist() {
+	# Test one command with both "top" and "hist" tools, replacing "TOOL" in
+	# command with either "top" or "hist" respectively, and prefixing the test
+	# names with "top " and "hist ".
+	check "top $1" "$(echo "$2" | sed 's/TOOL/top/g')" "${@:3}"
+	check "hist $1" "$(echo "$2" | sed 's/TOOL/hist/g')" "${@:3}"
+}
+
+check_top_q_hist() {
+	# Same as above, but pass "-q" to top so that strings printed in main
+	# loop are on their own line for top too, not only for hist.
+	check "top $1" "$(echo "$2" | sed 's/TOOL/top -q/g')" "${@:3}"
+	check "hist $1" "$(echo "$2" | sed 's/TOOL/hist/g')" "${@:3}"
+}
+
 set_timeout() {
 	TIMEOUT="timeout -v -k 15s $1"
 }
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 396334608920..ce3a448b1f87 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -7,13 +7,15 @@ set_timeout 2m
 
 check "verify help page" \
 	"osnoise --help" 0 "osnoise version"
-check "verify the --priority/-P param" \
-	"osnoise top -P F:1 -c 0 -r 900000 -d 10s -q -S 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh osnoise/ SCHED_FIFO 1\"" \
+check_top_hist "verify help page" \
+	"osnoise TOOL --help" 0 "rtla osnoise"
+check_top_q_hist "verify the --priority/-P param" \
+	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh osnoise/ SCHED_FIFO 1\"" \
 	2 "Priorities are set correctly"
-check "verify the --stop/-s param" \
-	"osnoise top -s 30 -T 1" 2 "osnoise hit stop tracing"
-check "verify the  --trace param" \
-	"osnoise hist -s 30 -T 1 -t" 2 "Saving trace to osnoise_trace.txt"
+check_top_q_hist "verify the --stop/-s param" \
+	"osnoise TOOL -s 30 -T 1" 2 "osnoise hit stop tracing"
+check_top_q_hist "verify the --trace param" \
+	"osnoise TOOL -s 30 -T 1 -t" 2 "Saving trace to osnoise_trace.txt"
 check "verify the --entries/-E param" \
 	"osnoise hist -P F:1 -c 0 -r 900000 -d 10s -b 10 -E 25"
 
@@ -24,27 +26,23 @@ check_with_osnoise_options "apply default period" \
 	"osnoise hist -s 1" 2 period_us=600000000
 
 # Actions tests
-check "trace output through -t with custom filename" \
-	"osnoise hist -S 2 -t custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
-check "trace output through --on-threshold trace" \
-	"osnoise hist -S 2 --on-threshold trace" 2 "^  Saving trace to osnoise_trace.txt$"
-check "trace output through --on-threshold trace with custom filename" \
-	"osnoise hist -S 2 --on-threshold trace,file=custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
-check "exec command" \
-	"osnoise hist -S 2 --on-threshold shell,command='echo TestOutput'" 2 "^TestOutput$"
-check "multiple actions" \
-	"osnoise hist -S 2 --on-threshold shell,command='echo -n 1' --on-threshold shell,command='echo 2'" 2 "^12$"
+check_top_q_hist "trace output through -t with custom filename" \
+	"osnoise TOOL -S 2 -t custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+check_top_q_hist "trace output through --on-threshold trace" \
+	"osnoise TOOL -S 2 --on-threshold trace" 2 "^  Saving trace to osnoise_trace.txt$"
+check_top_q_hist "trace output through --on-threshold trace with custom filename" \
+	"osnoise TOOL -S 2 --on-threshold trace,file=custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+check_top_q_hist "exec command" \
+	"osnoise TOOL -S 2 --on-threshold shell,command='echo TestOutput'" 2 "^TestOutput$"
+check_top_q_hist "multiple actions" \
+	"osnoise TOOL -S 2 --on-threshold shell,command='echo -n 1' --on-threshold shell,command='echo 2'" 2 "^12$"
 check "hist stop at failed action" \
 	"osnoise hist -S 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1# RTLA osnoise histogram$"
 check "top stop at failed action" \
 	"osnoise top -S 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
-check "hist with continue" \
-	"osnoise hist -S 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
-check "top with continue" \
-	"osnoise top -q -S 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
-check "hist with trace output at end" \
-	"osnoise hist -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
-check "top with trace output at end" \
-	"osnoise top -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
+check_top_q_hist "with continue" \
+	"osnoise TOOL -S 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+check_top_hist "with trace output at end" \
+	"osnoise TOOL -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
 
 test_end
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index fd4935fd7b49..d7944710a859 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -22,64 +22,60 @@ export RTLA_NO_BPF=$option
 # Basic tests
 check "verify help page" \
 	"timerlat --help" 0 "timerlat version"
-check "verify -s/--stack" \
-	"timerlat top -s 3 -T 10 -t" 2 "Blocking thread stack trace"
-check "verify -P/--priority" \
-	"timerlat top -P F:1 -c 0 -d 10s -q -T 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh timerlatu/ SCHED_FIFO 1\"" \
+check_top_hist "verify help page" \
+	"timerlat TOOL --help" 0 "rtla timerlat"
+check_top_hist "verify -s/--stack" \
+	"timerlat TOOL -s 3 -T 10 -t" 2 "Blocking thread stack trace"
+check_top_hist "verify -P/--priority" \
+	"timerlat TOOL -P F:1 -c 0 -d 10s -T 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh timerlatu/ SCHED_FIFO 1\"" \
 	2 "Priorities are set correctly"
-check "test in nanoseconds" \
-	"timerlat top -i 2 -c 0 -n -d 10s" 2 "ns"
-check "set the automatic trace mode" \
-	"timerlat top -a 5" 2 "analyzing it"
-check "dump tasks" \
-	"timerlat top -a 5 --dump-tasks" 2 "Printing CPU tasks"
+check_top_hist "test in nanoseconds" \
+	"timerlat TOOL -i 2 -c 0 -n -d 10s" 2 "ns"
+check_top_hist "set the automatic trace mode" \
+	"timerlat TOOL -a 5" 2 "analyzing it"
+check_top_hist "dump tasks" \
+	"timerlat TOOL -a 5 --dump-tasks" 2 "Printing CPU tasks"
 check "print the auto-analysis if hits the stop tracing condition" \
 	"timerlat top --aa-only 5" 2
-check "disable auto-analysis" \
-	"timerlat top -s 3 -T 10 -t --no-aa" 2
-check "verify -c/--cpus" \
-	"timerlat hist -c 0 -d 10s"
-check "hist test in nanoseconds" \
-	"timerlat hist -i 2 -c 0 -n -d 10s" 2 "ns"
+check_top_hist "disable auto-analysis" \
+	"timerlat TOOL -s 3 -T 10 -t --no-aa" 2
+check_top_hist "verify -c/--cpus" \
+	"timerlat TOOL -c 0 -d 10s"
 
 # Actions tests
-check "trace output through -t" \
-	"timerlat hist -T 2 -t" 2 "^  Saving trace to timerlat_trace.txt$"
-check "trace output through -t with custom filename" \
-	"timerlat hist -T 2 -t custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
-check "trace output through --on-threshold trace" \
-	"timerlat hist -T 2 --on-threshold trace" 2 "^  Saving trace to timerlat_trace.txt$"
-check "trace output through --on-threshold trace with custom filename" \
-	"timerlat hist -T 2 --on-threshold trace,file=custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
-check "exec command" \
-	"timerlat hist -T 2 --on-threshold shell,command='echo TestOutput'" 2 "^TestOutput$"
-check "multiple actions" \
-	"timerlat hist -T 2 --on-threshold shell,command='echo -n 1' --on-threshold shell,command='echo 2'" 2 "^12$"
+check_top_q_hist "trace output through -t" \
+	"timerlat TOOL -T 2 -t" 2 "^  Saving trace to timerlat_trace.txt$"
+check_top_q_hist "trace output through -t with custom filename" \
+	"timerlat TOOL -T 2 -t custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+check_top_q_hist "trace output through --on-threshold trace" \
+	"timerlat TOOL -T 2 --on-threshold trace" 2 "^  Saving trace to timerlat_trace.txt$"
+check_top_q_hist "trace output through --on-threshold trace with custom filename" \
+	"timerlat TOOL -T 2 --on-threshold trace,file=custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+check_top_q_hist "exec command" \
+	"timerlat TOOL -T 2 --on-threshold shell,command='echo TestOutput'" 2 "^TestOutput$"
+check_top_q_hist "multiple actions" \
+	"timerlat TOOL -T 2 --on-threshold shell,command='echo -n 1' --on-threshold shell,command='echo 2'" 2 "^12$"
 check "hist stop at failed action" \
 	"timerlat hist -T 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1# RTLA timerlat histogram$"
 check "top stop at failed action" \
 	"timerlat top -T 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
-check "hist with continue" \
-	"timerlat hist -T 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
-check "top with continue" \
-	"timerlat top -q -T 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
-check "hist with trace output at end" \
-	"timerlat hist -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
-check "top with trace output at end" \
-	"timerlat top -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
+check_top_q_hist "with continue" \
+	"timerlat TOOL -T 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+check_top_hist "with trace output at end" \
+	"timerlat TOOL -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
 
 # BPF action program tests
 if [ "$option" -eq 0 ]
 then
 	# Test BPF action program properly in BPF mode
 	[ -z "$BPFTOOL" ] && BPFTOOL=bpftool
-	check "hist with BPF action program (BPF mode)" \
-		"timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map.o --on-threshold shell,command='$BPFTOOL map dump name rtla_test_map'" \
+	check_top_q_hist "with BPF action program (BPF mode)" \
+		"timerlat TOOL -T 2 --bpf-action tests/bpf/bpf_action_map.o --on-threshold shell,command='$BPFTOOL map dump name rtla_test_map'" \
 		2 '"value": 42'
 else
 	# Test BPF action program failure in non-BPF mode
-	check "hist with BPF action program (non-BPF mode)" \
-		"timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map.o" \
+	check_top_q_hist "with BPF action program (non-BPF mode)" \
+		"timerlat TOOL -T 2 --bpf-action tests/bpf/bpf_action_map.o" \
 		1 "BPF actions are not supported in tracefs-only mode"
 fi
 done
-- 
2.53.0

