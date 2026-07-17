Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61293372066
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303252; cv=none; b=jYjFINoxgj052G/pLMHx6Xsn6aEr7wVE/ENGq9yuyfPumTdCo58ywYj68Xn6al7MJi7VO9GMxoT3iM38r0QDll+0NM2KnKmDi80jtDhDa4pGj94sfiPUbRAbExNVU8y9C0ug1UxsVzLUDshMtPcnPsQxNG5MeAkuPHAf1RY9Tq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303252; c=relaxed/simple;
	bh=XEo6Lcn87SsNgKeheHvv9+LkhsVblcmjrvZtzauIzeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=J2jLqXpKYQXS7nOrsZuXWrKVmTukD9FWQ5heBO2Isxju0WysUp9FglxlQj/gkC3xbhAFUURsVMQGAVqxxWE8uceaGV7l1AqgUYaWXqbaxHFBaDQv1YyQxDXu3Caai30qwy3hpEEA30IxDANC3UUrJzzL/C2UlW12zf9ZCEizWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNYHZiCI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNYHZiCI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784303249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7aNTglJykimQQOXOH133gOSR7LNkwiArg7Dhg4y2F8=;
	b=DNYHZiCIW7t5Q1idVb02uWa3ftX3NiFHmeliCFZ7/j2+yLutLT0xPLpNL8APNsM4CbbGLd
	Hnn3ciIpVSgGFRyCgnG4bI2lhy03t1fh3VLkrIwYpWasYLb8gMxaYYuJraQhyI/2JCreQZ
	jPadoES4u6IHILvAa16q1jWgYf/1RaM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-9dXlYPDwOTic0tcr5ZumcQ-1; Fri,
 17 Jul 2026 11:47:26 -0400
X-MC-Unique: 9dXlYPDwOTic0tcr5ZumcQ-1
X-Mimecast-MFC-AGG-ID: 9dXlYPDwOTic0tcr5ZumcQ_1784303244
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C22831955D84;
	Fri, 17 Jul 2026 15:47:24 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26EA930040BF;
	Fri, 17 Jul 2026 15:47:21 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 06/17] tools/rv: Add selftests
Date: Fri, 17 Jul 2026 17:46:27 +0200
Message-ID: <20260717154638.220789-7-gmonaco@redhat.com>
In-Reply-To: <20260717154638.220789-1-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: -YxkPYfuR8cqpJbH9GiYe1HjLfMDe80vMqIylist40E_1784303244
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The rv tool needs automated testing to catch regressions and verify
correct functionality across different usage scenarios.

Add selftests that validate monitor listing (including containers and
nested monitors), monitor execution with different configurations
(reactors, verbose output, tracing), and trace output format for both
per-task and per-cpu monitors. Error handling paths are also tested.
Tests use a shared engine for common patterns.

Acked-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V4:
    * Retry multiple times when getting the pid to avoid races

 tools/verification/rv/Makefile        |   5 +-
 tools/verification/rv/tests/rv_list.t |  48 +++++++++
 tools/verification/rv/tests/rv_mon.t  |  95 +++++++++++++++++
 tools/verification/tests/engine.sh    | 141 ++++++++++++++++++++++++++
 4 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 tools/verification/rv/tests/rv_list.t
 create mode 100644 tools/verification/rv/tests/rv_mon.t
 create mode 100644 tools/verification/tests/engine.sh

diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
index 5b898360ba48..8ae5fc0d1d17 100644
--- a/tools/verification/rv/Makefile
+++ b/tools/verification/rv/Makefile
@@ -78,4 +78,7 @@ clean: doc_clean fixdep-clean
 	$(Q)rm -f rv rv-static fixdep FEATURE-DUMP rv-*
 	$(Q)rm -rf feature
 
-.PHONY: FORCE clean
+check: $(RV)
+	RV=$(RV) prove -o --directives -f tests/
+
+.PHONY: FORCE clean check
diff --git a/tools/verification/rv/tests/rv_list.t b/tools/verification/rv/tests/rv_list.t
new file mode 100644
index 000000000000..201af33a52cc
--- /dev/null
+++ b/tools/verification/rv/tests/rv_list.t
@@ -0,0 +1,48 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source ../tests/engine.sh
+test_begin
+
+set_timeout 30s
+
+RVDIR=/sys/kernel/tracing/rv/
+
+# Help and basic tests
+check "verify help page" \
+	"$RV --help" 0 "usage: rv command"
+
+check "verify list subcommand help" \
+	"$RV list --help" 0 "list all available monitors"
+
+all_nested=$(grep : $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
+all_non_nested=$(grep -v : $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
+sched_monitors=$(grep sched: $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
+description_state="[[:space:]]\+[[:print:]]\+\[\(OFF\|ON\)\]"
+line_nested=" - \($all_nested\)${description_state}"
+line_non_nested="\($all_non_nested\)${description_state}"
+
+# List monitors and containers
+check "list all monitors" \
+	"$RV list" 0 "" "" "^\($line_nested\|$line_non_nested\)$"
+
+check_if_exists "list container" \
+	"$RV list sched" "$RVDIR/monitors/sched" \
+	"" "-- No monitor found in container sched --" \
+	"^\($sched_monitors\)${description_state}$"
+
+check_if_exists "list non-container" \
+	"$RV list wwnr" "$RVDIR/monitors/wwnr" \
+	"-- No monitor found in container wwnr --" \
+	"^\( - \)\?[[:alnum:]]\+${description_state}$"
+
+check "list incomplete container name" \
+	"$RV list s" 0 "-- No monitor found in container s --"
+
+# Error handling tests
+check "no command" \
+	"$RV" 1 "rv requires a command"
+
+check "invalid command" \
+	"$RV invalid" 1 "rv does not know the invalid command"
+
+test_end
diff --git a/tools/verification/rv/tests/rv_mon.t b/tools/verification/rv/tests/rv_mon.t
new file mode 100644
index 000000000000..cbc346c74c71
--- /dev/null
+++ b/tools/verification/rv/tests/rv_mon.t
@@ -0,0 +1,95 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source ../tests/engine.sh
+test_begin
+
+set_timeout 30s
+
+RVDIR=/sys/kernel/tracing/rv/
+
+# Help and basic tests
+check "verify mon subcommand help" \
+	"$RV mon --help" 0 "run a monitor"
+
+# Error handling tests
+check "mon without monitor name" \
+	"$RV mon" 1 "usage: rv mon"
+
+check "invalid monitor name" \
+	"$RV mon invalid" 1 "monitor invalid does not exist"
+
+if [ -d $RVDIR/monitors/wwnr ]; then
+
+check "invalid reactor name" \
+	"$RV mon wwnr -r invalid" 1 "failed to set invalid reactor, is it available?"
+
+check "monitor name is substring of another monitor" \
+	"$RV mon nr" 1 "monitor nr does not exist"
+
+check "already enabled monitor returns error" \
+	"echo 1 > $RVDIR/monitors/wwnr/enable; $RV mon wwnr" 1 \
+	"monitor wwnr (in-kernel) is already enabled"
+echo 0 > $RVDIR/monitors/wwnr/enable
+
+fi
+
+# rv mon runs until terminated
+set_expected_timeout 2s
+
+# Run monitors with different configurations
+check_if_exists "run the monitor without parameters" \
+	"$RV mon wwnr" "$RVDIR/monitors/wwnr" "" "."
+
+check_if_exists "run the monitor as verbose" \
+	"$RV mon wwnr -v" "$RVDIR/monitors/wwnr" \
+	"my pid is \$pid" "\(event\|error\)"
+
+check_if_exists "run the monitor with a reactor" \
+	"$RV mon wwnr -r printk & sleep .5 && cat $RVDIR/monitors/wwnr/reactors && wait" \
+	"$RVDIR/monitors/wwnr/reactors" "\[printk\]"
+
+check_if_exists "reactor is restored after exit" \
+	"cat $RVDIR/monitors/wwnr/reactors" \
+	"$RVDIR/monitors/wwnr/reactors" "\[nop\]"
+
+check_if_exists "run a nested monitor with a reactor" \
+	"$RV mon snroc -r printk & sleep .5 && cat $RVDIR/monitors/sched/snroc/reactors && wait" \
+	"$RVDIR/monitors/sched/snroc/reactors" "\[printk\]"
+
+check_if_exists "run an explicitly nested monitor with a reactor" \
+	"$RV mon sched:sssw -r printk & sleep .5 && cat $RVDIR/monitors/sched/sssw/reactors && wait" \
+	"$RVDIR/monitors/sched/sssw/reactors" "\[printk\]"
+
+check_if_exists "run container monitor" \
+	"$RV mon sched & sleep .5 && cat $RVDIR/monitors/sched/{sssw,sco}/enable && wait" \
+	"$RVDIR/monitors/sched" "1" "0" "^1$"
+
+# Regexes for the trace
+header="^[[:space:]]\+\(\([][A-Z_x<>-]\+\||\)[[:space:]]*\)\+$"
+type="\(event\|error\)[[:space:]]\+"
+genpid="[0-9]\+[[:space:]]\+"
+selfpid="\$pid[[:space:]]\+"
+cpu="\[[0-9]\{3\}\][[:space:]]\+"
+state="[a-z_]\+ "
+trace_task="${genpid}${cpu}${type}${genpid}${state}"
+trace_task_self="${genpid}${cpu}${type}${selfpid}${state}"
+trace_cpu="${genpid}${cpu}${type}${state}"
+trace_cpu_self="${selfpid}${cpu}${type}${state}"
+
+check_if_exists "run per-task monitor with tracing" \
+	"$RV mon sssw -t" "$RVDIR/monitors/sched/sssw" \
+	"$header" "$trace_task_self" "\($header\|$trace_task\)"
+
+check_if_exists "run per-task monitor tracing also self" \
+	"$RV mon sched:sssw -t -s" "$RVDIR/monitors/sched/sssw" \
+	"$trace_task_self" "" "\($header\|$trace_task\)"
+
+check_if_exists "run per-cpu monitor with tracing" \
+	"$RV mon sched:sco -t" "$RVDIR/monitors/sched/sco" \
+	"$header" "$trace_cpu_self" "\($header\|$trace_cpu\)"
+
+check_if_exists "run per-cpu monitor tracing also self" \
+	"$RV mon sco -t -s" "$RVDIR/monitors/sched/sco" \
+	"$trace_cpu_self" "" "\($header\|$trace_cpu\)"
+
+test_end
diff --git a/tools/verification/tests/engine.sh b/tools/verification/tests/engine.sh
new file mode 100644
index 000000000000..57e16dc980b1
--- /dev/null
+++ b/tools/verification/tests/engine.sh
@@ -0,0 +1,141 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+test_begin() {
+	# Count tests to allow the test harness to double-check if all were
+	# included correctly.
+	ctr=0
+	[ -z "$RV" ] && RV="../rv/rv"
+	[ -n "$TEST_COUNT" ] && echo "1..$TEST_COUNT"
+}
+
+failure() {
+	fail=1
+	if [ $# -gt 0 ]; then
+		failbuf+="$1"
+		failbuf+=$'\n'
+	fi
+}
+
+report() {
+	local desc="$1"
+
+	if [ "$fail" -eq 0 ]; then
+		echo "ok $ctr - $desc"
+	else
+		# Add output and exit code as comments in case of failure
+		echo "not ok $ctr - $desc"
+		echo -n "$failbuf"
+		echo "$result" | col -b | while read -r line; do echo "# $line"; done
+		printf "#\n# exit code %s\n" "$exitcode"
+	fi
+}
+
+_check() {
+	local command=$2
+	local expected_exitcode=${3:-0}
+	local expected_output=$4
+	local unexpected_output=$5
+	local all_lines_pattern=$6
+	local patterns="$expected_output $unexpected_output $all_lines_pattern"
+	local bgpid pid
+
+	eval "$TIMEOUT" "$command" &> check_output.$$ &
+	bgpid=$!
+
+	if grep -q "\$pid" <<< "$patterns"; then
+		for _ in {1..30}; do
+			pid=$(pgrep -f "${command%%[|;&>]*}" | tail -n1)
+			[ -n "$pid" ] && break
+			sleep 0.1
+		done
+	fi
+
+	wait $bgpid
+	exitcode=$?
+	result=$(tr -d '\0' < check_output.$$)
+	rm -f check_output.$$
+
+	failbuf=''
+	fail=0
+
+	# Suppress any other error if a needed pid is empty
+	if [ -z "$pid" ] && grep -q "\$pid" <<< "$patterns"; then
+		result=''
+		failure "# Empty pid for $command"
+		return 1
+	fi
+
+	expected_output="${expected_output//\$pid/$pid}"
+	unexpected_output="${unexpected_output//\$pid/$pid}"
+	all_lines_pattern="${all_lines_pattern//\$pid/$pid}"
+
+	# Test if the results matches if requested
+	if [ -n "$expected_output" ] && ! grep -qe "$expected_output" <<< "$result"; then
+		failure "# Output match failed: \"$expected_output\""
+	fi
+
+	if [ -n "$unexpected_output" ] && grep -qe "$unexpected_output" <<< "$result"; then
+		failure "# Output non-match failed: \"$unexpected_output\""
+	fi
+
+	if [ -n "$all_lines_pattern" ] && grep -vqe "$all_lines_pattern" <<< "$result"; then
+		failure "# All-lines pattern failed: \"$all_lines_pattern\""
+	fi
+
+	if [ $exitcode -ne "$expected_exitcode" ]; then
+		failure "# Expected exit code $expected_exitcode"
+	fi
+}
+
+check() {
+	# Simple check: run the command with given arguments and test exit code.
+	# If TEST_COUNT is set, run the test. Otherwise, just count.
+	ctr=$((ctr + 1))
+	if [ -n "$TEST_COUNT" ]; then
+		_check "$@"
+		report "$1"
+	fi
+}
+
+check_if_exists() {
+	# Conditional check that skips if a file or folder doesn't exist
+	local desc=$1
+	local command=$2
+	local file=$3
+	local expected_output=$4
+	local unexpected_output=$5
+	local all_lines_pattern=$6
+
+	ctr=$((ctr + 1))
+	if [ -n "$TEST_COUNT" ]; then
+		if [ ! -e "$file" ]; then
+			echo "ok $ctr - $desc # SKIP file not found: $file"
+		else
+			_check "$desc" "$command" 0 "$expected_output" \
+				"$unexpected_output" "$all_lines_pattern"
+			report "$desc"
+		fi
+	fi
+}
+
+set_timeout() {
+	TIMEOUT="timeout -v -k 30s $1"
+}
+
+set_expected_timeout() {
+	TIMEOUT="timeout --preserve-status -k 30s $1"
+}
+
+unset_timeout() {
+	unset TIMEOUT
+}
+
+test_end() {
+	# If running without TEST_COUNT, tests are not actually run, just
+	# counted. In that case, re-run the test with the correct count.
+	[ -z "$TEST_COUNT" ] && TEST_COUNT=$ctr exec bash "$0" || true
+}
+
+# Avoid any environmental discrepancies
+export LC_ALL=C
+unset_timeout
-- 
2.55.0

