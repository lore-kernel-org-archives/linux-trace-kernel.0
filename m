Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C1A53A8A9
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868150; cv=none; b=PJ+Do/VmQAuwkgvJpNvA6gxKflmFeWf4s5A6RAlpg60l00BrJDZSLxKe8irJNQgKt3A4mHJL87MRwANVnRGS7kZGGBxkkYNcMJvTfA8Kk1b+QZIJX2a1RLQfxXcJ5IMVw7dRpDeShosfRLdGv5Wwdul52vZwtCbbAL3GPIqChoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868150; c=relaxed/simple;
	bh=evOHeMUf8T4CbHEA/Mc+fwTZsoGAfg1aVs1HWB1bmrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=eI8iNTMWe5BvwQRginbvNnVACM6hI7J54QozkRbouLkjCX6AIx0Cf986k9ttknzMcgBWbK2Nt9IyWgzSR6xNRR9qaZeuQa0UR6x7MLba752oP+JwbERyRv+37hpV6bCdKy+tNJFPxA5pqAdBI8hI/JVVKx8H4uzv8RszXUSCPqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fK4ps/Hd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fK4ps/Hd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FxcFu6RfcNwLhm+IufdtHcvE7/uItQg/ntHZi0SPks=;
	b=fK4ps/Hdvtjd0fGRXUo6wnE9UA6qzgJ2oYN7n3mzZTmUlpnL6aUsr3jLtN/GiL2slAMsK0
	4dKlvOPHlFp6bCq/hnbSQX/V42fbTSlaovyO1KoBTGcPWKsHdz3Iqiupd3ha6u8Q0eB0Yl
	6A+dXG25EVoaRMeinaazdw1gk3WU/ug=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-xKlG_FNePU-U4oeV0eRddg-1; Thu,
 01 Oct 2026 11:22:24 -0400
X-MC-Unique: xKlG_FNePU-U4oeV0eRddg-1
X-Mimecast-MFC-AGG-ID: xKlG_FNePU-U4oeV0eRddg_1790868142
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59B791936111;
	Thu,  1 Oct 2026 15:22:22 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CA0A1800352;
	Thu,  1 Oct 2026 15:22:19 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH v2 14/15] tools/rv: Add selftest for rv bpf monitors
Date: Thu,  1 Oct 2026 17:20:41 +0200
Message-ID: <20261001152042.124445-15-gmonaco@redhat.com>
In-Reply-To: <20261001152042.124445-1-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: ScjKnYwsQiaLYKepFDiw7u1UPpp8degWn6Ss-tdwN6A_1790868142
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add selftest cases for the rv userspace tool BPF monitors, test BPF
monitors listing and functionality, including traces and reactors.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/tests/rv_list.t |  6 ++-
 tools/verification/rv/tests/rv_mon.t  | 61 ++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rv/tests/rv_list.t b/tools/verification/rv/tests/rv_list.t
index 201af33a52cc..3c94f2af2109 100644
--- a/tools/verification/rv/tests/rv_list.t
+++ b/tools/verification/rv/tests/rv_list.t
@@ -6,6 +6,8 @@ test_begin
 set_timeout 30s
 
 RVDIR=/sys/kernel/tracing/rv/
+# only works when running in the kernel tree
+RVTOOL=$(dirname "$RV")
 
 # Help and basic tests
 check "verify help page" \
@@ -17,13 +19,15 @@ check "verify list subcommand help" \
 all_nested=$(grep : $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
 all_non_nested=$(grep -v : $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
 sched_monitors=$(grep sched: $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
+all_bpf=$(find "$RVTOOL/bpf_monitors" -name "*.o" -exec basename \{} .o \; | paste -s | sed 's/\t/\\|/g')
 description_state="[[:space:]]\+[[:print:]]\+\[\(OFF\|ON\)\]"
 line_nested=" - \($all_nested\)${description_state}"
 line_non_nested="\($all_non_nested\)${description_state}"
+line_bpf="\($all_bpf\)${description_state}"
 
 # List monitors and containers
 check "list all monitors" \
-	"$RV list" 0 "" "" "^\($line_nested\|$line_non_nested\)$"
+	"$RV list" 0 "" "" "^\($line_nested\|$line_non_nested\|$line_bpf\)$"
 
 check_if_exists "list container" \
 	"$RV list sched" "$RVDIR/monitors/sched" \
diff --git a/tools/verification/rv/tests/rv_mon.t b/tools/verification/rv/tests/rv_mon.t
index cbc346c74c71..8e14471661c7 100644
--- a/tools/verification/rv/tests/rv_mon.t
+++ b/tools/verification/rv/tests/rv_mon.t
@@ -6,6 +6,7 @@ test_begin
 set_timeout 30s
 
 RVDIR=/sys/kernel/tracing/rv/
+RVTOOL=$(dirname "$RV")
 
 # Help and basic tests
 check "verify mon subcommand help" \
@@ -23,13 +24,34 @@ if [ -d $RVDIR/monitors/wwnr ]; then
 check "invalid reactor name" \
 	"$RV mon wwnr -r invalid" 1 "failed to set invalid reactor, is it available?"
 
+check "invalid BPF reactor name" \
+	"$RV mon nohz -r invalid" 1 "failed to set invalid reactor, is it available?"
+
+check "invalid BPF reactor name check available" \
+	"$RV mon nohz -r invalid" 1 "available BPF reactors: nop [a-z]\+" \
+	"available reactors:"
+
 check "monitor name is substring of another monitor" \
 	"$RV mon nr" 1 "monitor nr does not exist"
 
 check "already enabled monitor returns error" \
 	"echo 1 > $RVDIR/monitors/wwnr/enable; $RV mon wwnr" 1 \
 	"monitor wwnr (in-kernel) is already enabled"
-echo 0 > $RVDIR/monitors/wwnr/enable
+[ -n "$TEST_COUNT" ] && echo 0 > $RVDIR/monitors/wwnr/enable
+
+fi
+
+if [ -f "$RVTOOL/bpf_monitors/tqueue.o" ]; then
+
+[ -n "$TEST_COUNT" ] && { $RV mon tqueue & disown ; tmp=$! ; sleep 1 ; }
+check "already enabled BPF monitor returns error" \
+	"$RV mon tqueue" 1 "monitor tqueue (BPF) is already enabled"
+
+[ -n "$TEST_COUNT" ] && { kill -9 "$tmp" && sleep 1 ; }
+set_expected_timeout 1s
+
+check "crashed BPF monitor does not leak resources" \
+	"$RV mon tqueue" 0 "" "monitor tqueue (BPF) is already enabled"
 
 fi
 
@@ -40,6 +62,12 @@ set_expected_timeout 2s
 check_if_exists "run the monitor without parameters" \
 	"$RV mon wwnr" "$RVDIR/monitors/wwnr" "" "."
 
+check_if_exists "run a BPF monitor without parameters" \
+	"$RV mon nohz" "$RVTOOL/bpf_monitors/nohz.o" "" "."
+
+check_if_exists "run a per-task BPF monitor without parameters" \
+	"$RV mon tqueue" "$RVTOOL/bpf_monitors/tqueue.o" "" "."
+
 check_if_exists "run the monitor as verbose" \
 	"$RV mon wwnr -v" "$RVDIR/monitors/wwnr" \
 	"my pid is \$pid" "\(event\|error\)"
@@ -60,6 +88,20 @@ check_if_exists "run an explicitly nested monitor with a reactor" \
 	"$RV mon sched:sssw -r printk & sleep .5 && cat $RVDIR/monitors/sched/sssw/reactors && wait" \
 	"$RVDIR/monitors/sched/sssw/reactors" "\[printk\]"
 
+TRACE=/sys/kernel/tracing/trace
+
+[ -n "$TEST_COUNT" ] && echo -n > $TRACE
+check_if_exists "run a BPF monitor with a reactor" \
+	"$RV mon nohz -r printk && cat $TRACE" "$RVTOOL/bpf_monitors/nohz.o" \
+	"rv: monitor nohz does not allow event [a-z_]\+ on state [a-z_]\+"
+
+# Give some time for maps from previous run to be cleaned up
+[ -n "$TEST_COUNT" ] && sleep 1
+[ -n "$TEST_COUNT" ] && echo -n > $TRACE
+check_if_exists "run BPF monitors with nop reactor" \
+	"$RV mon nohz -r nop && cat $TRACE" "$RVTOOL/bpf_monitors/nohz.o" \
+	"" "rv: monitor nohz does not allow event"
+
 check_if_exists "run container monitor" \
 	"$RV mon sched & sleep .5 && cat $RVDIR/monitors/sched/{sssw,sco}/enable && wait" \
 	"$RVDIR/monitors/sched" "1" "0" "^1$"
@@ -92,4 +134,21 @@ check_if_exists "run per-cpu monitor tracing also self" \
 	"$RV mon sco -t -s" "$RVDIR/monitors/sched/sco" \
 	"$trace_cpu_self" "" "\($header\|$trace_cpu\)"
 
+check_if_exists "run per-task BPF monitor with tracing" \
+	"$RV mon tqueue -t" "$RVTOOL/bpf_monitors/tqueue.o" \
+	"$header" "$trace_task_self" "\($header\|$trace_task\)"
+
+check_if_exists "run per-task BPF monitor tracing also self" \
+	"$RV mon tqueue -t -s" "$RVTOOL/bpf_monitors/tqueue.o" \
+	"$trace_task_self" "" "\($header\|$trace_task\)"
+
+check_if_exists "run per-cpu BPF monitor with tracing" \
+	"$RV mon nohz -t" "$RVTOOL/bpf_monitors/nohz.o" \
+	"$header" "$trace_cpu_self" "\($header\|$trace_cpu\)"
+
+# This is unstable, we may never see events from self
+#check_if_exists "run per-cpu BPF monitor tracing also self" \
+#	"$RV mon nohz -t -s" "$RVTOOL/bpf_monitors/nohz.o" \
+#	"$trace_cpu_self" "" "\($header\|$trace_cpu\)"
+
 test_end
-- 
2.55.0

