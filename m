Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD03EDE76
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588695; cv=none; b=c6KWRcs/vR8e2zbDXIn5CMgCp0MCwmao+PLns28Yl0yQAe42ScFmmxNSkNVxgfIvqcy30/W/kE86w9osv6kDzU6wmeNEuHZa3OBYfoSmdERT++F+aeTuqP0XHv97Ii5AQG6NTPxnq86hcRJVv5PTIMWeAJ9J4YW3aAgr87m2cwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588695; c=relaxed/simple;
	bh=04ThZUSodpHue9b04L+YG+8tuR+6H9kX7e/IFoeLdmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=SJ8acxzWZ79MpIkUBVeay1EQ6bEhMly43UnqekbB+Zl6nGb+PYtPt2cnSNnxcCv3TgAE6YspamBeg0K/Ei2FXsHLrTKqCBduI3LeyZEIBE5Lsh9XQTu/XyouRW5lnWy/UtFnoiFGK60EIdIUuDrAlZQM3RZCotGVXVD3wFm9Csk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V0oaVHeF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0oaVHeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783588692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vPFEYDWR+/1LQpLZu2YGz7yIBPlLH2kJbi5Hp0+tNpA=;
	b=V0oaVHeFt7GNW3MQA5mVAdvaYw4193dCPURDTDg95uabzQQEB65C8gQtScu+D5512UOvfO
	06QnE3elOTXE/NyRe9tqIWo0w5FACIciQ4SG1UTrmWmlMisMv5Llq5uaFWgcyKGta6RajN
	ffAr4eo/QhsoraeCglC98ieu6ySk/is=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-qy8VAWGgNBmwqGJwG8_ZLw-1; Thu,
 09 Jul 2026 05:18:09 -0400
X-MC-Unique: qy8VAWGgNBmwqGJwG8_ZLw-1
X-Mimecast-MFC-AGG-ID: qy8VAWGgNBmwqGJwG8_ZLw_1783588688
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D5071955DCF;
	Thu,  9 Jul 2026 09:18:08 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.39])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C87E9180035F;
	Thu,  9 Jul 2026 09:18:05 +0000 (UTC)
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
Subject: [PATCH] rtla/tests: Test all tracer options in runtime tests
Date: Thu,  9 Jul 2026 11:17:55 +0200
Message-ID: <20260709091755.58265-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: o1vSRolGlWQCsU8L2RXqOplxxGP_Y3BGa2ljrEVIkU8_1783588688
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, runtime tests only test the osnoise period option
(-p/--period of rtla-osnoise tools, backed by
/sys/kernel/tracing/osnoise/period_us), using the
check_with_osnoise_options function together with a hack relying on long
period (pre-set) timing out if RTLA fails to reset it to the default
value.

Extend tracer option testing to all options used by RTLA; test both RTLA
setting the default option by pre-setting the tracer to a different
value and user-requested value.

The tests are done using a script that reads the tracer values inside an
--on-threshold action, like existing tests for runtime behavior already
do. check_with_osnoise_option is modified to support grep filters, so
that it can be used together with the script pattern.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/engine.sh            | 41 +++++++++++--------
 tools/tracing/rtla/tests/hwnoise.t            |  3 ++
 tools/tracing/rtla/tests/osnoise.t            | 37 +++++++++++++++--
 .../tests/scripts/check-osnoise-option.sh     | 16 ++++++++
 .../rtla/tests/scripts/check-tracefs-value.sh | 11 +++++
 tools/tracing/rtla/tests/timerlat.t           | 38 +++++++++++++++++
 6 files changed, 125 insertions(+), 21 deletions(-)
 create mode 100755 tools/tracing/rtla/tests/scripts/check-osnoise-option.sh
 create mode 100755 tools/tracing/rtla/tests/scripts/check-tracefs-value.sh

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index 5bf8453d354d6..4287cd64ac314 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -98,30 +98,37 @@ check() {
 }
 
 check_with_osnoise_options() {
-	# Do the same as "check", but with pre-set osnoise options.
-	# Note: rtla should reset the osnoise options, this is used to test
-	# if it indeed does so.
-	# Save original arguments
-	arg1=$1
-	arg2=$2
-	arg3=$3
-
-	# Apply osnoise options (if not dry run)
+	# Do the same as "check", but with pre-set tracefs options.
+	# Resets osnoise first, then writes the given tracefs option=value
+	# pairs before running the check with NO_RESET_OSNOISE=1.
+	# Arguments: test_name command exit_code expected_output [path=value ...]
+	# Each path is relative to /sys/kernel/tracing/
+	local arg1=$1
+	local arg2=$2
+	local arg3=$3
+	local arg4=$4
+	local opt option value
+
+	# Apply tracefs options (if not dry run)
 	if [ -n "$TEST_COUNT" ]
 	then
 		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
-		shift
-		shift
-		while shift
+		shift 4
+		for opt in "$@"
 		do
-			[ "$1" == "" ] && continue
-			option=$(echo $1 | cut -d '=' -f 1)
-			value=$(echo $1 | cut -d '=' -f 2)
-			echo "$value" > "/sys/kernel/tracing/osnoise/$option" || return 1
+			[ -z "$opt" ] && continue
+			option="${opt%%=*}"
+			value="${opt#*=}"
+			# Try to apply the option, ignore errors: when pre-setting fails
+			# (e.g. kernel does not know the option), the test itself will likely
+			# also fail.
+			# Throwing an error here would cause the test to be incorrectly
+			# skipped.
+			echo "$value" > "/sys/kernel/tracing/$option"
 		done
 	fi
 
-	NO_RESET_OSNOISE=1 check "$arg1" "$arg2" "$arg3"
+	NO_RESET_OSNOISE=1 check "$arg1" "$arg2" "$arg3" "$arg4"
 }
 
 check_top_hist() {
diff --git a/tools/tracing/rtla/tests/hwnoise.t b/tools/tracing/rtla/tests/hwnoise.t
index cfe687ff5ee1f..b53d8d440fc50 100644
--- a/tools/tracing/rtla/tests/hwnoise.t
+++ b/tools/tracing/rtla/tests/hwnoise.t
@@ -18,5 +18,8 @@ check "stop the trace if a single sample is higher than 1 us" \
 check "enable a trace event trigger" \
 	"hwnoise -t -e osnoise:irq_noise --trigger=\"hist:key=desc,duration:sort=desc,duration:vals=hitcount\" -d 10s" \
 	0 "Saving event osnoise:irq_noise hist to osnoise_irq_noise_hist.txt"
+check "verify OSNOISE_IRQ_DISABLE" \
+	"hwnoise -S 1 --on-threshold shell,command=\"$testdir/scripts/check-osnoise-option.sh OSNOISE_IRQ_DISABLE\"" \
+	2 "^OSNOISE_IRQ_DISABLE=enabled$"
 
 test_end
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 346a14a860c82..f773156e758fd 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -42,11 +42,40 @@ check "hist with --no-index" \
 check "hist with --no-summary" \
 	"osnoise hist --no-summary -d 1s" 0 "" "^count:"
 
-# Test setting default period by putting an absurdly high period
-# and stopping on threshold.
-# If default period is not set, this will time out.
+# Tracer option tests - verify that rtla correctly sets tracefs options
+# Default tests: poison tracefs with wrong values, verify rtla resets to defaults
 check_with_osnoise_options "apply default period" \
-	"osnoise hist -s 1" 2 period_us=600000000
+	"osnoise top -q -S 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/period_us\"" \
+	2 "^osnoise/period_us=1000000$" osnoise/period_us=600000000
+check_with_osnoise_options "apply default runtime" \
+	"osnoise top -q -S 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/runtime_us\"" \
+	2 "^osnoise/runtime_us=1000000$" osnoise/runtime_us=100
+check_with_osnoise_options "apply default tracing_thresh" \
+	"osnoise top -q -S 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh tracing_thresh\"" \
+	2 "^tracing_thresh=0$" tracing_thresh=999999
+check_with_osnoise_options "apply default stop_tracing_us" \
+	"osnoise top -q -S 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/stop_tracing_us\"" \
+	2 "^osnoise/stop_tracing_us=0$" osnoise/stop_tracing_us=999999
+check_with_osnoise_options "apply default stop_tracing_total_us" \
+	"osnoise top -q -s 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/stop_tracing_total_us\"" \
+	2 "^osnoise/stop_tracing_total_us=0$" osnoise/stop_tracing_total_us=999999
+
+# Non-default tracer option tests: verify CLI options correctly set tracefs values
+check_top_q_hist "verify -p sets period_us" \
+	"osnoise TOOL -p 2000000 -S 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/period_us\"" \
+	2 "^osnoise/period_us=2000000$"
+check_top_q_hist "verify -r sets runtime_us" \
+	"osnoise TOOL -r 500000 -S 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/runtime_us\"" \
+	2 "^osnoise/runtime_us=500000$"
+check_top_q_hist "verify -T sets tracing_thresh" \
+	"osnoise TOOL -T 5 -S 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh tracing_thresh\"" \
+	2 "^tracing_thresh=5$"
+check_top_q_hist "verify -s sets stop_tracing_us" \
+	"osnoise TOOL -s 30 -S 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/stop_tracing_us\"" \
+	2 "^osnoise/stop_tracing_us=30$"
+check_top_q_hist "verify -S sets stop_tracing_total_us" \
+	"osnoise TOOL -S 100 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/stop_tracing_total_us\"" \
+	2 "^osnoise/stop_tracing_total_us=100$"
 
 # Actions tests
 check_top_q_hist "trace output through -t with custom filename" \
diff --git a/tools/tracing/rtla/tests/scripts/check-osnoise-option.sh b/tools/tracing/rtla/tests/scripts/check-osnoise-option.sh
new file mode 100755
index 0000000000000..37c62268cc151
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/check-osnoise-option.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Check if osnoise options are enabled or disabled.
+# Usage: check-osnoise-option.sh <OPTION1> [<OPTION2> ...]
+# Output: one line per option in the format "OPTION=enabled" or "OPTION=disabled"
+
+options=$(tr ' ' '\n' < /sys/kernel/tracing/osnoise/options)
+for name in "$@"; do
+	if echo "$options" | grep -q "^NO_${name}$"; then
+		echo "$name=disabled"
+	elif echo "$options" | grep -q "^${name}$"; then
+		echo "$name=enabled"
+	else
+		echo "$name=unsupported"
+	fi
+done
diff --git a/tools/tracing/rtla/tests/scripts/check-tracefs-value.sh b/tools/tracing/rtla/tests/scripts/check-tracefs-value.sh
new file mode 100755
index 0000000000000..12d0eacd6a85d
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/check-tracefs-value.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Read tracefs values and print them.
+# Usage: check-tracefs-value.sh <relative_path1> [<relative_path2> ...]
+# Each path is relative to /sys/kernel/tracing/
+# Output: one line per file in the format "path=value"
+
+for file in "$@"; do
+	read value < "/sys/kernel/tracing/$file"
+	echo "$file=$value"
+done
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 8193048e8c8ce..aa5b91d88ca4b 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -55,6 +55,44 @@ check_top_q_hist "verify -k/--kernel-threads" \
 check_top_q_hist "verify -u/--user-threads" \
 	"timerlat TOOL -u -c 0 -d 10s -T 1 --on-threshold shell,command=$testdir/scripts/check-user-kernel-threads.sh" 2 "0 kernel threads, 1 user threads"
 
+# Tracer option tests - verify that rtla correctly sets tracefs options
+# Default tests: poison tracefs with wrong values, verify rtla resets to defaults
+check_with_osnoise_options "apply default timerlat_period_us" \
+	"timerlat top -q -T 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/timerlat_period_us\"" \
+	2 "^osnoise/timerlat_period_us=1000$" osnoise/timerlat_period_us=999999
+check_with_osnoise_options "apply default print_stack" \
+	"timerlat top -q -T 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/print_stack\"" \
+	2 "^osnoise/print_stack=0$" osnoise/print_stack=999999
+check_with_osnoise_options "apply default stop_tracing_us" \
+	"timerlat top -q -T 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/stop_tracing_us\"" \
+	2 "^osnoise/stop_tracing_us=0$" osnoise/stop_tracing_us=999999
+check_with_osnoise_options "apply default stop_tracing_total_us" \
+	"timerlat top -q -i 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/stop_tracing_total_us\"" \
+	2 "^osnoise/stop_tracing_total_us=0$" osnoise/stop_tracing_total_us=999999
+
+# Non-default tracer option tests: verify CLI options correctly set tracefs values
+check_top_q_hist "verify -p sets timerlat_period_us" \
+	"timerlat TOOL -p 2000 -T 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/timerlat_period_us\"" \
+	2 "^osnoise/timerlat_period_us=2000$"
+check_top_q_hist "verify -s sets print_stack" \
+	"timerlat TOOL -s 5 -T 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/print_stack\"" \
+	2 "^osnoise/print_stack=5$"
+check_top_q_hist "verify -i sets stop_tracing_us" \
+	"timerlat TOOL -i 2 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/stop_tracing_us\"" \
+	2 "^osnoise/stop_tracing_us=2$"
+check_top_q_hist "verify -T sets stop_tracing_total_us" \
+	"timerlat TOOL -T 2 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/stop_tracing_total_us\"" \
+	2 "^osnoise/stop_tracing_total_us=2$"
+check_with_osnoise_options "apply default TIMERLAT_ALIGN" \
+	"timerlat top -q -T 1 --on-threshold shell,command=\"$testdir/scripts/check-osnoise-option.sh TIMERLAT_ALIGN\"" \
+	2 "^TIMERLAT_ALIGN=disabled$" osnoise/options=TIMERLAT_ALIGN
+check_top_q_hist "verify -A sets TIMERLAT_ALIGN" \
+	"timerlat TOOL -A 100 -T 1 --on-threshold shell,command=\"$testdir/scripts/check-osnoise-option.sh TIMERLAT_ALIGN\"" \
+	2 "^TIMERLAT_ALIGN=enabled$"
+check_top_q_hist "verify -A sets timerlat_align_us" \
+	"timerlat TOOL -A 100 -T 1 --on-threshold shell,command=\"$testdir/scripts/check-tracefs-value.sh osnoise/timerlat_align_us\"" \
+	2 "^osnoise/timerlat_align_us=100$"
+
 # Histogram tests
 check "hist with -b/--bucket-size" \
 	"timerlat hist -b 1 -d 1s"
-- 
2.55.0

