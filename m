Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA9331A53
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302764; cv=none; b=UXvA3lZCu5Ou4LUmz3z0Fu2qctNSoviLZsnyVDHFO2pei5EdlSf9nciekEdOvVjCdvnOleuia6E8vpwMB9B2foR+yrf+eh0gF9vacvhVDiPHPW/S/0nLf2MTgglWYEq0kAAZpCCSAOAhgitUQeyYFXxrHbkvw32xvZ4wvq6SPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302764; c=relaxed/simple;
	bh=dti/XtzTOyfJkY1DUwMxR2x6gtJ936yTx74HUBVvm3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Gh2uqXB5lAiD9QL919k+ouMgtitK6v+4em3TSqTlSOCWnQpDSJ1RHmmACR1QV1+M4SA/m1tgfFW8lia538DanmoXUQUSfy8wwOaEg3XkiBnnxcvgthGv/Xo9JR9CzkBfSVy4DlLgxZJrUAwg5JhZEVytEbzlJ/+scW2oGW6nWFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XODOmf0F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XODOmf0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777302759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7w4KyQE0yi3t8ZF1U2PmxCFiEQguUTuwofqgy1DZxk=;
	b=XODOmf0FUiiDEJX4SQbXkPPGjr8rwZ8w3MXZI+Q0NkDwNKwcB2BleNJ8IcTGuNc/7TWlfI
	2H0mlIb1GRakRG7CDEHJT3RYzf0DSzxVUlIz99aiPk+eFkzXjTSnJPFHzqILxjn6lgf/gc
	v4d44vQnEZq3nBlZ/JqLcqQi8zo192g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-7xOSmp4MO8qgm_NJB6ghWA-1; Mon,
 27 Apr 2026 11:12:36 -0400
X-MC-Unique: 7xOSmp4MO8qgm_NJB6ghWA-1
X-Mimecast-MFC-AGG-ID: 7xOSmp4MO8qgm_NJB6ghWA_1777302754
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E0F81956068;
	Mon, 27 Apr 2026 15:12:34 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD15D195608E;
	Mon, 27 Apr 2026 15:12:31 +0000 (UTC)
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
Subject: [RFC PATCH 08/12] verification/rvgen: Add selftests
Date: Mon, 27 Apr 2026 17:11:30 +0200
Message-ID: <20260427151134.192971-9-gmonaco@redhat.com>
In-Reply-To: <20260427151134.192971-1-gmonaco@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: HVtdW3BUQOP5dTZh68s5MUckpLHyNS7fcrhTWrkVBKM_1777302754
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

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/Makefile             |  4 +
 .../rvgen/tests/rvgen_container.t             | 20 +++++
 .../verification/rvgen/tests/rvgen_monitor.t  | 87 +++++++++++++++++++
 tools/verification/tests/engine.sh            | 32 +++++++
 4 files changed, 143 insertions(+)
 create mode 100644 tools/verification/rvgen/tests/rvgen_container.t
 create mode 100644 tools/verification/rvgen/tests/rvgen_monitor.t

diff --git a/tools/verification/rvgen/Makefile b/tools/verification/rvgen/Makefile
index cfc4056c1e87..2a2b9e64ea42 100644
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
diff --git a/tools/verification/rvgen/tests/rvgen_container.t b/tools/verification/rvgen/tests/rvgen_container.t
new file mode 100644
index 000000000000..fa4fb3db8288
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
index 000000000000..261476504eee
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
diff --git a/tools/verification/tests/engine.sh b/tools/verification/tests/engine.sh
index cd367dabef53..ef89df9112a4 100644
--- a/tools/verification/tests/engine.sh
+++ b/tools/verification/tests/engine.sh
@@ -5,6 +5,8 @@ test_begin() {
 	# included correctly.
 	ctr=0
 	[ -z "$RV" ] && RV="../rv/rv"
+	[ -z "$RVGEN" ] && RVGEN="python ../rvgen"
+	[ -z "$GOLDEN_DIR" ] && GOLDEN_DIR="tests/golden"
 	[ -n "$TEST_COUNT" ] && echo "1..$TEST_COUNT"
 }
 
@@ -101,6 +103,36 @@ check_if_exists() {
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
2.53.0

