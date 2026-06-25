Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8103E0097
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389727; cv=none; b=BZj33Qi74GTZKi7Xz0s3LXOrkOK1OJIfbHRfcU/iFjFv9989Xx/8EZBbzH9jED8h6xhsrKClKERtIunOIf+SyIqsGj6sm7PNOTWiV8VBIDXNXxr3pF5CNnUFMu6bo9y5+EMTSxy0PhoNoCW0XOnRefZzmpx5dbv1gmTS0J74MFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389727; c=relaxed/simple;
	bh=mgkevmxQMmRUrYaGkp5ZVVfOD0mgO9O3E4IzBSIMsFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qv4X6bl43JDQ8N7L0HqDh1PsgpRVtoNzL4FUNxLNYDGvKamE2q2YfRObckfmJqKCMvhDW1QSnyO9MnoHq2aibHZHxyuqBDxtRxROwnuRW0Pa00jm5wAENFCbHWpHmRjgJVRPCwvKtehXia2s6JDIpQmXw6M+gBVEZ2U0jOLgnaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cc7X+C7I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cc7X+C7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782389724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ga1TLg+51sfGcVhAZBotACUpnkUWSJF3jJfwAHPEM6g=;
	b=Cc7X+C7Iow7uaZdz0t0yQtdogSfQTK44uwvXTY2LGUotE3URRynn+EkCJgwvUoMQnnLP7v
	q2XvAXT2Dd4lZypD3K3LI8xSJNvTrsiB5GDggHHMYJdoGAna6GLI+c8NjbdxkOVZA2k4fW
	Uq0hfARe1OAM8E78q2apCVEjIlEmW14=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-v5Ops1UuNkOwFL6bBbZFAw-1; Thu,
 25 Jun 2026 08:15:21 -0400
X-MC-Unique: v5Ops1UuNkOwFL6bBbZFAw-1
X-Mimecast-MFC-AGG-ID: v5Ops1UuNkOwFL6bBbZFAw_1782389719
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C378919540E5;
	Thu, 25 Jun 2026 12:15:19 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E96930002E0;
	Thu, 25 Jun 2026 12:15:17 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 06/17] verification/rvgen: Add selftests
Date: Thu, 25 Jun 2026 14:14:28 +0200
Message-ID: <20260625121440.116317-7-gmonaco@redhat.com>
In-Reply-To: <20260625121440.116317-1-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: xRTdab1mJyJMi6B3D_MZoVvCu6ZxZDM5CXOY3fcbvvg_1782389719
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The rvgen code generator needs validation to ensure it produces correct
monitor implementations from input specifications.

Add selftests with golden reference outputs covering all monitor classes
(DA, HA, LTL) and types (global, per_cpu, per_task, per_obj), including
optional features like descriptions and parent monitors. Container
generation and error handling (missing files, invalid specifications,
missing arguments) are also validated against expected output.

Acked-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/Makefile             |  4 +
 .../rvgen/tests/golden/ha_percpu/ha_percpu.c  |  6 +-
 .../tests/golden/ltl_pertask/ltl_pertask.c    |  6 +-
 .../rvgen/tests/golden/test_ha/test_ha.c      |  6 +-
 .../rvgen/tests/golden/test_ltl/test_ltl.c    |  6 +-
 .../rvgen/tests/rvgen_container.t             | 20 +++++
 .../verification/rvgen/tests/rvgen_monitor.t  | 87 +++++++++++++++++++
 .../rvgen/tests/specs/test_ha.dot             |  2 +-
 tools/verification/tests/engine.sh            | 34 ++++++++
 9 files changed, 158 insertions(+), 13 deletions(-)
 create mode 100644 tools/verification/rvgen/tests/rvgen_container.t
 create mode 100644 tools/verification/rvgen/tests/rvgen_monitor.t

diff --git a/tools/verification/rvgen/Makefile b/tools/verification/rvgen/Makefile
index cfc4056c1e..2a2b9e64ea 100644
--- a/tools/verification/rvgen/Makefile
+++ b/tools/verification/rvgen/Makefile
@@ -13,6 +13,10 @@ all:
 .PHONY: clean
 clean:
 
+.PHONY: check
+check:
+	prove -o --directives -f tests/
+
 .PHONY: install
 install:
 	$(INSTALL) rvgen/automata.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/automata.py
diff --git a/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c b/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c
index ba7a02a18f..14c781e1a3 100644
--- a/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c
+++ b/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu.c
@@ -132,7 +132,7 @@ static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
 		      ha_get_env(ha_mon, env2_ha_percpu, time_ns) == 0ull);
 	else if (curr_state == S3_ha_percpu && event == event1_ha_percpu) {
 		res = ha_monitor_env_invalid(ha_mon, clk_ha_percpu) ||
-		      (ha_get_env(ha_mon, clk_ha_percpu, time_ns) < foo_ns &&
+		      (ha_get_env(ha_mon, clk_ha_percpu, time_ns) < 5000ull &&
 		      ha_get_env(ha_mon, env1_ha_percpu, time_ns) == 1ull);
 		ha_reset_env(ha_mon, clk_ha_percpu, time_ns);
 	}
@@ -192,7 +192,7 @@ static int enable_ha_percpu(void)
 {
 	int retval;
 
-	retval = da_monitor_init();
+	retval = ha_monitor_init();
 	if (retval)
 		return retval;
 
@@ -211,7 +211,7 @@ static void disable_ha_percpu(void)
 	rv_detach_trace_probe("ha_percpu", /* XXX: tracepoint */, handle_event1);
 	rv_detach_trace_probe("ha_percpu", /* XXX: tracepoint */, handle_event2);
 
-	da_monitor_destroy();
+	ha_monitor_destroy();
 }
 
 /*
diff --git a/tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask.c b/tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask.c
index 1b6897200e..386b708104 100644
--- a/tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask.c
+++ b/tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask.c
@@ -82,7 +82,7 @@ static void disable_ltl_pertask(void)
 /*
  * This is the monitor register section.
  */
-static struct rv_monitor rv_ltl_pertask = {
+static struct rv_monitor rv_this = {
 	.name = "ltl_pertask",
 	.description = "auto-generated",
 	.enable = enable_ltl_pertask,
@@ -91,12 +91,12 @@ static struct rv_monitor rv_ltl_pertask = {
 
 static int __init register_ltl_pertask(void)
 {
-	return rv_register_monitor(&rv_ltl_pertask, NULL);
+	return rv_register_monitor(&rv_this, NULL);
 }
 
 static void __exit unregister_ltl_pertask(void)
 {
-	rv_unregister_monitor(&rv_ltl_pertask);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_ltl_pertask);
diff --git a/tools/verification/rvgen/tests/golden/test_ha/test_ha.c b/tools/verification/rvgen/tests/golden/test_ha/test_ha.c
index 485fcd0259..edc4781615 100644
--- a/tools/verification/rvgen/tests/golden/test_ha/test_ha.c
+++ b/tools/verification/rvgen/tests/golden/test_ha/test_ha.c
@@ -132,7 +132,7 @@ static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
 		      ha_get_env(ha_mon, env2_test_ha, time_ns) == 0ull);
 	else if (curr_state == S3_test_ha && event == event1_test_ha) {
 		res = ha_monitor_env_invalid(ha_mon, clk_test_ha) ||
-		      (ha_get_env(ha_mon, clk_test_ha, time_ns) < foo_ns &&
+		      (ha_get_env(ha_mon, clk_test_ha, time_ns) < 5000ull &&
 		      ha_get_env(ha_mon, env1_test_ha, time_ns) == 1ull);
 		ha_reset_env(ha_mon, clk_test_ha, time_ns);
 	}
@@ -195,7 +195,7 @@ static int enable_test_ha(void)
 {
 	int retval;
 
-	retval = da_monitor_init();
+	retval = ha_monitor_init();
 	if (retval)
 		return retval;
 
@@ -214,7 +214,7 @@ static void disable_test_ha(void)
 	rv_detach_trace_probe("test_ha", /* XXX: tracepoint */, handle_event1);
 	rv_detach_trace_probe("test_ha", /* XXX: tracepoint */, handle_event2);
 
-	da_monitor_destroy();
+	ha_monitor_destroy();
 }
 
 /*
diff --git a/tools/verification/rvgen/tests/golden/test_ltl/test_ltl.c b/tools/verification/rvgen/tests/golden/test_ltl/test_ltl.c
index 92c69b9d9a..c90d0ca009 100644
--- a/tools/verification/rvgen/tests/golden/test_ltl/test_ltl.c
+++ b/tools/verification/rvgen/tests/golden/test_ltl/test_ltl.c
@@ -83,7 +83,7 @@ static void disable_test_ltl(void)
 /*
  * This is the monitor register section.
  */
-static struct rv_monitor rv_test_ltl = {
+static struct rv_monitor rv_this = {
 	.name = "test_ltl",
 	.description = "Simple description",
 	.enable = enable_test_ltl,
@@ -92,12 +92,12 @@ static struct rv_monitor rv_test_ltl = {
 
 static int __init register_test_ltl(void)
 {
-	return rv_register_monitor(&rv_test_ltl, &rv_ltl_parent);
+	return rv_register_monitor(&rv_this, &rv_ltl_parent);
 }
 
 static void __exit unregister_test_ltl(void)
 {
-	rv_unregister_monitor(&rv_test_ltl);
+	rv_unregister_monitor(&rv_this);
 }
 
 module_init(register_test_ltl);
diff --git a/tools/verification/rvgen/tests/rvgen_container.t b/tools/verification/rvgen/tests/rvgen_container.t
new file mode 100644
index 0000000000..fa4fb3db82
--- /dev/null
+++ b/tools/verification/rvgen/tests/rvgen_container.t
@@ -0,0 +1,20 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source ../tests/engine.sh
+test_begin
+
+set_timeout 30s
+
+# Help tests
+check "verify container subcommand help" \
+	"$RVGEN container -h" 0 "model_name" "class"
+
+check_and_compare_folder "container with description" \
+	"$RVGEN container -n test_container -D 'Test container for grouping monitors'" \
+	"test_container" "Writing the monitor into the directory test_container"
+
+# Error handling tests
+check "missing required model_name" \
+	"$RVGEN container" 2 "the following arguments are required: -n/--model_name"
+
+test_end
diff --git a/tools/verification/rvgen/tests/rvgen_monitor.t b/tools/verification/rvgen/tests/rvgen_monitor.t
new file mode 100644
index 0000000000..261476504e
--- /dev/null
+++ b/tools/verification/rvgen/tests/rvgen_monitor.t
@@ -0,0 +1,87 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source ../tests/engine.sh
+test_begin
+
+set_timeout 30s
+
+# Help and basic tests
+check "verify help page" \
+	"$RVGEN --help" 0 "Generate kernel rv monitor"
+
+check "verify monitor subcommand help" \
+	"$RVGEN monitor --help" 0 "Monitor class"
+
+# DA monitor tests - test all monitor types
+check_and_compare_folder "DA per_cpu (default name)" \
+	"$RVGEN monitor -c da -s tests/specs/test_da.dot -t per_cpu" \
+	"test_da" "obj-\$(CONFIG_RV_MON_TEST_DA) += monitors/test_da/test_da.o"
+
+check_and_compare_folder "DA global type" \
+	"$RVGEN monitor -c da -s tests/specs/test_da.dot -t global -n da_global" \
+	"da_global" "DA_MON_EVENTS_IMPLICIT"
+
+check_and_compare_folder "DA per_task with description" \
+	"$RVGEN monitor -c da -s tests/specs/test_da2.dot -t per_task -n da_pertask_desc -D 'Custom description for testing'" \
+	"da_pertask_desc" "#include <monitors/da_pertask_desc/da_pertask_desc_trace.h>"
+
+check_and_compare_folder "DA per_obj with parent" \
+	"$RVGEN monitor -c da -s tests/specs/test_da2.dot -t per_obj -n da_perobj_parent -p parent_mon" \
+	"da_perobj_parent" "DA_MON_EVENTS_ID"
+
+# HA monitor tests
+check_and_compare_folder "HA per_task (default name)" \
+	"$RVGEN monitor -c ha -s tests/specs/test_ha.dot -t per_task" \
+	"test_ha" "HA_MON_EVENTS_ID"
+
+check_and_compare_folder "HA per_cpu type" \
+	"$RVGEN monitor -c ha -s tests/specs/test_ha.dot -t per_cpu -n ha_percpu" \
+	"ha_percpu" "HA_MON_EVENTS_IMPLICIT"
+
+# LTL monitor test
+check_and_compare_folder "LTL per_task" \
+	"$RVGEN monitor -c ltl -s tests/specs/test_ltl.ltl -t per_task -n ltl_pertask" \
+	"ltl_pertask" "source \"kernel/trace/rv/monitors/ltl_pertask/Kconfig\""
+
+check_and_compare_folder "LTL per_task with parent and description (default name)" \
+	"$RVGEN monitor -c ltl -s tests/specs/test_ltl.ltl -t per_task -p ltl_parent -D 'Simple description'" \
+	"test_ltl" "LTL_MON_EVENTS_ID"
+
+# Error handling tests
+check "missing required spec argument" \
+	"$RVGEN monitor -c da -t per_cpu" 2 \
+	"the following arguments are required: -s/--spec" "Traceback (most recent call last)"
+
+check "missing required monitor type" \
+	"$RVGEN monitor -c da -s tests/specs/test_da.dot" 2 \
+	"the following arguments are required: -t/--monitor_type" "Traceback (most recent call last)"
+
+check "missing required monitor class" \
+	"$RVGEN monitor -s tests/specs/test_da.dot -t per_cpu" 2 \
+	"the following arguments are required: -c/--class" "Traceback (most recent call last)"
+
+check "invalid monitor class" \
+	"$RVGEN monitor -c invalid -s tests/specs/test_da.dot -t per_cpu" 1 \
+	"Unknown monitor class" "Traceback (most recent call last)"
+
+check "missing dot file" \
+	"$RVGEN monitor -c da -s tests/specs/nonexistent.dot -t per_cpu" 1 \
+	"No such file or directory" "Traceback (most recent call last)"
+
+check "missing ltl file" \
+	"$RVGEN monitor -c ltl -s tests/specs/nonexistent.ltl -t per_task" 1 \
+	"No such file or directory" "Traceback (most recent call last)"
+
+check "invalid dot file syntax" \
+	"$RVGEN monitor -c da -s tests/specs/test_invalid.dot -t per_cpu" 1 \
+	"Not a valid .dot format" "Traceback (most recent call last)"
+
+check "invalid ha file syntax" \
+	"$RVGEN monitor -c ha -s tests/specs/test_invalid_ha.dot -t per_obj" 1 \
+	"Unrecognised event constraint" "Traceback (most recent call last)"
+
+check "invalid ltl file syntax" \
+	"$RVGEN monitor -c ltl -s tests/specs/test_invalid.ltl -t per_task" 1 \
+	"Illegal character 'i'" "Traceback (most recent call last)"
+
+test_end
diff --git a/tools/verification/rvgen/tests/specs/test_ha.dot b/tools/verification/rvgen/tests/specs/test_ha.dot
index 786aa8b220..af18ad7389 100644
--- a/tools/verification/rvgen/tests/specs/test_ha.dot
+++ b/tools/verification/rvgen/tests/specs/test_ha.dot
@@ -19,7 +19,7 @@ digraph state_automaton {
 	"S2" -> "S3" [ label = "event2" ];
 	"S2" -> "S2" [ label = "event1;clk < foo_ns" ];
 	"S3" -> "S0" [ label = "event0;clk < FOO_NS && env2 == 0" ];
-	"S3" -> "S1" [ label = "event1;clk < foo_ns && env1 == 1;reset(clk)" ];
+	"S3" -> "S1" [ label = "event1;clk < 5us && env1 == 1;reset(clk)" ];
 	{ rank = min ;
 		"__init_S0";
 		"S0";
diff --git a/tools/verification/tests/engine.sh b/tools/verification/tests/engine.sh
index 76cc254ff9..f86d444608 100644
--- a/tools/verification/tests/engine.sh
+++ b/tools/verification/tests/engine.sh
@@ -5,6 +5,8 @@ test_begin() {
 	# included correctly.
 	ctr=0
 	[ -z "$RV" ] && RV="../rv/rv"
+	[ -z "$RVGEN" ] && RVGEN="python3 ../rvgen"
+	[ -z "$GOLDEN_DIR" ] && GOLDEN_DIR="tests/golden"
 	[ -n "$TEST_COUNT" ] && echo "1..$TEST_COUNT"
 }
 
@@ -109,6 +111,38 @@ check_if_exists() {
 	fi
 }
 
+check_and_compare_folder() {
+	# Run command, compare generated folder to golden, and cleanup
+	local desc=$1
+	local command=$2
+	local generated_dir=$3
+	local expected_output=$4
+	local unexpected_output=$5
+	local golden_dir="$GOLDEN_DIR/$generated_dir"
+
+	ctr=$((ctr + 1))
+	if [ -n "$TEST_COUNT" ]; then
+		rm -rf "$generated_dir"
+		_check "$desc" "$command" 0 "$expected_output" "$unexpected_output"
+
+		if [ "$fail" -eq 0 ] && [ ! -d "$generated_dir" ]; then
+			failure "# Generated directory not found: $generated_dir"
+		fi
+
+		if [ "$fail" -ne 0 ]; then
+			:
+		elif ! diff -r "$generated_dir" "$golden_dir" &> /dev/null; then
+			failure "# Directories differ:"
+			failbuf+=$(diff -r "$generated_dir" "$golden_dir" 2>&1 | sed 's/^/#   /')
+			failbuf+=$'\n'
+		fi
+
+		report "$1"
+
+		rm -rf "$generated_dir"
+	fi
+}
+
 set_timeout() {
 	TIMEOUT="timeout -v -k 15s $1"
 }
-- 
2.54.0

