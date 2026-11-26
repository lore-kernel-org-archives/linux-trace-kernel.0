Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698114;
	b=2OcnLmiF6jk/Ui3V54vq6Vzt4T8l0NLWtPOFD5Y9DAE9bOpfettB0UzGX3+JMuLQBU26
	 zhn4Fxf4vhzKIsPI3AHAMuTbHGuEeP4ISYzdTzAV0FSXxZ0tOy1FvmPj3oRnAhyc9H3Jx
	 kLxmPsl1D31VCo0yT773nDKm6Ej/2Sll0JzG6toKK2jboiI0VDkCnY6knU5jEJjLxT7Rj
	 UZpg7O5dq6CQ97mV9MtG24eAvGYyWey9shl2k4/HUV3RWtHfvJnZLWjuDT5Olbac+BfHJ
	 YxmHH5zmlUThrc4/bsVdwmvJk0rA5gVwRpZCEuqzbTHsupEojzL/LK+D04goC6tl3+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698114;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=94GBFyLqhGymKpb0WzpatnIudNDmY6MT+lr25C957NM=;
	b=iHYrPSrhxCBH2bwJ/TWW68vxqGTexdO5rsruVI8fso2jDiqdQpjmv2rhDjclkRpOoQdG
	 CLiEvdtU+c6rhas84/WDk4rXyrTeWh86ctym2hKmzbzmIYdYNaEymWjbX+FyKwLFHN90g
	 I0GXyKbxn/cbA1EEBMNuoHtutu5ICBMq1Ryu60FmOzHfMNpNCl0fN6HmBlxSmwYNS7UZ3
	 D8Y+sJib0PBWWClmXL7dY4w10HcKDdbW/250H3Pm87acUb9ARhA0T6IIjBNuejFVBR2Bz
	 rkjE44+3jknjlWYuYpbidecaafFpGr0nPnXRQG2BBy/+zvBoem9LOBrHSDlWgLFpcJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="bn/NZ5rg";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111B606A332
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 13:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6111B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bn/NZ5rg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94GBFyLqhGymKpb0WzpatnIudNDmY6MT+lr25C957NM=;
	b=bn/NZ5rgjF9az93SfkIS/xOSZaWszveGZf89EpC0vX34FaM0Doc9gFPqiN46fhJW13cvhO
	Eja98W4f54U//YAG7UB6F1WC/33Zpa+E72tzr02/5025ShcrJsmxAsD7A7uCMyo/BW1OG4
	cO+xHlKznPQhMmVsIH+7hSQDr29c9dI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-WuCDb3g9Md-UsRTbdTsUUA-1; Thu,
 26 Nov 2026 13:01:50 +0000
X-MC-Unique: WuCDb3g9Md-UsRTbdTsUUA-1
X-Mimecast-MFC-AGG-ID: WuCDb3g9Md-UsRTbdTsUUA_1795698108
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B25C1955BC2;
	Thu, 26 Nov 2026 13:01:48 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 090DA1800543;
	Thu, 26 Nov 2026 13:01:44 +0000 (UTC)
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
	Viktor Malik <vmalik@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 17/18] tools/rv: Add selftest for rv bpf monitors
Date: Thu, 26 Nov 2026 14:00:03 +0100
Message-ID: <20261126130004.127155-18-gmonaco@redhat.com>
In-Reply-To: <20261126130004.127155-1-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: YSeQE0TRd0XF1juhWy2ij93EOufZ6nz2WrjUBsAcYOM_1795698108
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add selftest cases for the rv userspace tool BPF monitors, test BPF
monitors listing and functionality, including traces and reactors.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/tests/rv_list.t |  6 +-
 tools/verification/rv/tests/rv_mon.t  | 80 +++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/tools/verification/rv/tests/rv_list.t b/tools/verification/rv/tests/rv_list.t
index 201af33a52cc..9eae5c3c6eba 100644
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
+all_bpf=$(find "$RVTOOL/bpf_monitors" -name "*.o" -exec basename \{\} .o \; | paste -s | sed 's/\t/\\|/g')
 description_state="[[:space:]]\+[[:print:]]\+\[\(OFF\|ON\)\]"
 line_nested=" - \($all_nested\)${description_state}"
 line_non_nested="\($all_non_nested\)${description_state}"
+[ -n "$all_bpf" ] && line_bpf="\($all_bpf\)${description_state}" || line_bpf="<empty>"
 
 # List monitors and containers
 check "list all monitors" \
-	"$RV list" 0 "" "" "^\($line_nested\|$line_non_nested\)$"
+	"$RV list" 0 "" "" "^\($line_nested\|$line_non_nested\|$line_bpf\)$"
 
 check_if_exists "list container" \
 	"$RV list sched" "$RVDIR/monitors/sched" \
diff --git a/tools/verification/rv/tests/rv_mon.t b/tools/verification/rv/tests/rv_mon.t
index cbc346c74c71..30d1ddaf0538 100644
--- a/tools/verification/rv/tests/rv_mon.t
+++ b/tools/verification/rv/tests/rv_mon.t
@@ -6,6 +6,7 @@ test_begin
 set_timeout 30s
 
 RVDIR=/sys/kernel/tracing/rv/
+RVTOOL=$(dirname "$RV")
 
 # Help and basic tests
 check "verify mon subcommand help" \
@@ -29,7 +30,28 @@ check "monitor name is substring of another monitor" \
 check "already enabled monitor returns error" \
 	"echo 1 > $RVDIR/monitors/wwnr/enable; $RV mon wwnr" 1 \
 	"monitor wwnr (in-kernel) is already enabled"
-echo 0 > $RVDIR/monitors/wwnr/enable
+[ -n "$TEST_COUNT" ] && echo 0 > $RVDIR/monitors/wwnr/enable
+
+fi
+
+if [ -f "$RVTOOL/bpf_monitors/nohz.o" ]; then
+
+check "invalid BPF reactor name" \
+	"$RV mon nohz -r invalid" 1 "failed to set invalid reactor, is it available?"
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
@@ -60,21 +88,32 @@ check_if_exists "run an explicitly nested monitor with a reactor" \
 	"$RV mon sched:sssw -r printk & sleep .5 && cat $RVDIR/monitors/sched/sssw/reactors && wait" \
 	"$RVDIR/monitors/sched/sssw/reactors" "\[printk\]"
 
+TRACE=/sys/kernel/tracing/trace
+
 check_if_exists "run container monitor" \
 	"$RV mon sched & sleep .5 && cat $RVDIR/monitors/sched/{sssw,sco}/enable && wait" \
 	"$RVDIR/monitors/sched" "1" "0" "^1$"
 
 # Regexes for the trace
 header="^[[:space:]]\+\(\([][A-Z_x<>-]\+\||\)[[:space:]]*\)\+$"
-type="\(event\|error\)[[:space:]]\+"
+mon="[a-z_]\+"
+type="\(event\|error\)_$mon"
 genpid="[0-9]\+[[:space:]]\+"
 selfpid="\$pid[[:space:]]\+"
 cpu="\[[0-9]\{3\}\][[:space:]]\+"
 state="[a-z_]\+ "
-trace_task="${genpid}${cpu}${type}${genpid}${state}"
-trace_task_self="${genpid}${cpu}${type}${selfpid}${state}"
-trace_cpu="${genpid}${cpu}${type}${state}"
-trace_cpu_self="${selfpid}${cpu}${type}${state}"
+id="[0-9]\+"
+selfid="\$pid"
+# BPF monitors report via the common rv:event_monitor/rv:error_monitor
+# events, which add a "<mon>: " prefix to the message.
+trace_task="${genpid}${cpu}${type}: ${id}: ${state}"
+trace_task_self="${genpid}${cpu}${type}: ${selfid}: ${state}"
+trace_cpu="${genpid}${cpu}${type}: ${state}"
+trace_cpu_self="${selfpid}${cpu}${type}: ${state}"
+trace_task_bpf="${genpid}${cpu}${type}: ${mon}: ${id}: ${state}"
+trace_task_bpf_self="${genpid}${cpu}${type}: ${mon}: ${selfid}: ${state}"
+trace_cpu_bpf="${genpid}${cpu}${type}: ${mon}: ${state}"
+trace_cpu_bpf_self="${selfpid}${cpu}${type}: ${mon}: ${state}"
 
 check_if_exists "run per-task monitor with tracing" \
 	"$RV mon sssw -t" "$RVDIR/monitors/sched/sssw" \
@@ -92,4 +131,33 @@ check_if_exists "run per-cpu monitor tracing also self" \
 	"$RV mon sco -t -s" "$RVDIR/monitors/sched/sco" \
 	"$trace_cpu_self" "" "\($header\|$trace_cpu\)"
 
+check_if_exists "run per-task BPF monitor with tracing" \
+	"$RV mon tqueue -t" "$RVTOOL/bpf_monitors/tqueue.o" \
+	"$header" "$trace_task_bpf_self" "\($header\|$trace_task_bpf\)"
+
+check_if_exists "run per-task BPF monitor tracing also self" \
+	"$RV mon tqueue -t -s" "$RVTOOL/bpf_monitors/tqueue.o" \
+	"$trace_task_bpf_self" "" "\($header\|$trace_task_bpf\)"
+
+check_if_exists "run per-cpu BPF monitor with tracing" \
+	"$RV mon nohz -t" "$RVTOOL/bpf_monitors/nohz.o" \
+	"$header" "$trace_cpu_bpf_self" "\($header\|$trace_cpu_bpf\)"
+
+# This is unstable, we may never see events from self
+#check_if_exists "run per-cpu BPF monitor tracing also self" \
+#	"$RV mon nohz -t -s" "$RVTOOL/bpf_monitors/nohz.o" \
+#	"$trace_cpu_bpf_self" "" "\($header\|$trace_cpu_bpf\)"
+
+check_if_exists "run per-task monitor tracing only errors" \
+	"$RV mon sssw -t -E" "$RVDIR/monitors/sched/sssw" \
+	"$header" "event_"
+
+check_if_exists "run per-task BPF monitor tracing only errors" \
+	"$RV mon tqueue -t -E" "$RVTOOL/bpf_monitors/tqueue.o" \
+	"$header" "event_monitor"
+
+check_if_exists "run per-cpu BPF monitor tracing only errors" \
+	"$RV mon nohz -t -E" "$RVTOOL/bpf_monitors/nohz.o" \
+	"error_monitor" "event_monitor"
+
 test_end
-- 
2.56.1

