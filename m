Received: from mail-pz2-f30.google.com (mail-pz2-f30.google.com [74.125.228.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E94741DE0B
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202420; cv=none; b=NQE0IyYJg8GnbjLUNB1jQeqAHNGy1aHchNwiEZirBKGGYt18SB5dx072v9Fcu5C+GsNWuHO0MokHNIVC35z43u9T/3PG2aNO4hU2OwmloqrPYrcBgSdvA2P22vE9+R3WhVQyCN5QP+QV0D9H/R46jqDzKZD2nmGvPc+vw2//awA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202420; c=relaxed/simple;
	bh=vVKv47cmfAuACjoqEhj5I+LzS+aoqmIZBNi2XYraPes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oXWdQ61y6jxe/rNqLQSLO76H+X5EX37Xk82C9cEHY4n4Q0RSV9O2iXc4B5dtqHPv+Augobzx5Ln5IyLOYbN//UoVnPw3SLogfsb1DzvU+y7Wq21hFf7/mNKv+Se7ogLn/4ue69ru5N6xdsmMe3ZV43JlbUpH4bNoNehHF8tvpCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuRJoFSp; arc=none smtp.client-ip=74.125.228.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuRJoFSp"
Received: by mail-pz2-f30.google.com with SMTP id 41be03b00d2f7-cc1cea50dc0so98150a12.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 01:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789202417; x=1789807217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D62nAxto8FBPn6ofyV4nlMYglOuFu5fWBNRz3jiEv7M=;
        b=SuRJoFSpIRLQ4qAK7vXrgRvw1ZjJlXGd87wKCyWlcf3mCVn7nZQGlukWbPx7sz8UnU
         HUtXJNHtLY7JHXsaTqe7MgLhM/j3Z48gRgfO0WUsQA6tchB45JeCh42gsrVjMuYw8UMy
         WID73GfLw5paL3my0tyhEPrgxjEP/XWTiqraYb6vplu9lkrWRygNTc6WtMDVFCJD13t5
         OiqrwpICbWRZO/9WYPTi4vn5t4BPi75O/mUfIF9BidamN2rFRV/qY12vZGf4ohxO5LY2
         ckgk/0edon7NK/MG8l3g8BYms/GX6eQ1gjlep425d2F5zR0edBWIgHD55X0oEfQoqAKH
         vUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789202417; x=1789807217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D62nAxto8FBPn6ofyV4nlMYglOuFu5fWBNRz3jiEv7M=;
        b=d8MZ8YariXHjPCfFEE2GioYVt4RNy872euJm6l+VS5llCLyKhEPeouRsV4KoSbV+8g
         Y/CTL2HowzLXMn0maWj/PO148XYsBUNLrsqnOQY3E1g71yg+adjUZiYtjFsNN+mngOpo
         li8Porwulv+MYPueE0jx44mkc4pa2QvhzzvDT1mG0B+4+9t1DlsYS94HwMLZ9sDgedsG
         iQrWHfM0pET7geePbqIBF/2vbXGxBTqu+xJJTLITgNReLC/gxx53y7TW3l7/9rCNdUYd
         g8HqY7maYkiohJI1+TWn/oUcuQzbufqqvi9W4KwGGTCOjxYXs3tIGWKqXqLG2KHMUJTY
         Jg3A==
X-Forwarded-Encrypted: i=1; AKwUvBwlBWYWgr+Q9yQOPUQ8FLzkd8x7A6+4u+H/HU7mtNItSC4ayJM+xOtcfHelIV/7qpdyrX/6cuJ0Z5hzozggImMQbqY=@vger.kernel.org
X-Gm-Message-State: AFuF++mdy9FcVPELMG/jzEPeKEHOwqRL4bXB2aAZre2ZqBxhz5p9sAe5
	kFGS5ZKjJW3TY0gL+nAlzfXpuqa6/5YEKIKiiIH5A3bI6PmJtXW5kQ4c
X-Gm-Gg: AYBFou1ntjreOXztl5y5OQkjZgQOtjkAuabv7kXkLOLQkqIFojI6M4VvaP6SjR5/Tgg
	yMXx4HuhfdSLuBSXIPi0xxVxAUyAmwqOfmHNKAtv/v8wiMRiCjUzu2FF0mz9L7okcyIx5TdG/t5
	uru6DrbbrpUOEa6lVadFDX5WpxbdDkHzqUCpc8WVWNsESbBORnMXHlI+uQr14uJu1PeeEmzomjd
	BqDVqhC+pQAmkIw6Rn8X4V8RmAhICDyZrYHhgdybhgWXFtfsF8mHE8e2pJOK+ri0jSHcO1V946M
	LLL63i4brjACw1imaXamoN+fJQ0sGiBHbwaL2ORawWl5fXn2bzgE/Nds+4/h8XnS/IHzVS8esqI
	RT6PJKcF1Guy8yZXeLt/g4hSBQQbF0ta0JTs0pZjJenpLNpW30zf9v3jVn0dYXc5ESRZ6b3Hqi1
	2k3QO234VMlmttj3NzmJrEt60d3RkE62eIIldIFCMLLU2PWp26gW7RZW26J5ias3gQlGbFIQ20k
	Szw+ozhWqd6i9nHwtR8XlcLdokWwLDCIahVLk2J
X-Received: by 2002:a17:90b:28cd:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-39dbc69b2c5mr3272923a91.13.1789202417155;
        Sat, 12 Sep 2026 01:40:17 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:16a3:d08b:6ddb:dec6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95091214sm9790583a91.3.2026.09.12.01.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:40:16 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	lkp@intel.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: [RFC PATCH v7 10/10] selftests/ftrace: add a stackmap instance gating test
Date: Sat, 12 Sep 2026 16:37:53 +0800
Message-Id: <20260912083753.3426176-11-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Verify both enforcement points for the global-instance-only stackmap
option.

Require options/stackmap and stack_map on the top-level instance. Read a
shared-kernel random UUID from /proc/sys/kernel/random/uuid and combine
it with ftracetest's $PID to create collision-resistant owned and foreign
secondary-instance names, including across PID namespaces. Verify that
neither the option nor any stack_map node appears in the owned instance.
Also require writing stackmap through its aggregate trace_options file
to fail and leave the option unset.

Create the foreign instance as a sentinel. Remove the owned instance
explicitly and verify the sentinel remains, proving that cleanup does
not remove unrelated instances.

Defer signal exit across each mkdir and ownership assignment so cleanup
removes a directory only after this invocation has created it. Put mkdir
in an if condition so ftracetest's errexit mode cannot bypass return-code
handling, the explicit failure path, or ownership bookkeeping. Track both
directories separately and remove only those created by this test. Keep
the auxiliary stack_map_stat and stack_map_bin nodes optional on the
global side.

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 .../test.d/ftrace/stackmap-instance-gate.tc   | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc
new file mode 100644
index 000000000000..818dbb7bfeb8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate.tc
@@ -0,0 +1,114 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - stackmap option is gated to the top-level trace instance
+# requires: stack_map options/stackmap instances
+
+# The 'stackmap' option is added to TOP_LEVEL_TRACE_FLAGS, matching the
+# convention used for global-only options like 'printk' and 'record-cmd'.
+# Verify that:
+# 1. The global instance exposes options/stackmap and the required
+#    stack_map node. stack_map_stat and stack_map_bin are auxiliary and
+#    may be absent if their tracefs creation failed.
+# 2. A newly created secondary instance under instances/ does NOT expose
+#    options/stackmap or any stack_map* nodes.
+
+fail() {
+    echo "FAIL: $1"
+    exit_fail
+}
+
+instance_token=$(cat /proc/sys/kernel/random/uuid 2>/dev/null) || {
+    echo "could not obtain a collision-resistant instance token"
+    exit_unresolved
+}
+[ -n "$instance_token" ] || exit_unresolved
+owned_instance=stackmap_gate_owned_${PID}_${instance_token}
+owned_dir=instances/$owned_instance
+foreign_instance=stackmap_gate_foreign_${PID}_${instance_token}
+foreign_dir=instances/$foreign_instance
+owned_created=0
+foreign_created=0
+
+remove_owned() {
+    if [ "$owned_created" -eq 1 ]; then
+        rmdir "$owned_dir" || return 1
+        owned_created=0
+    fi
+}
+
+cleanup() {
+    if [ "$owned_created" -eq 1 ]; then
+        rmdir "$owned_dir" 2>/dev/null || :
+    fi
+    if [ "$foreign_created" -eq 1 ]; then
+        rmdir "$foreign_dir" 2>/dev/null || :
+    fi
+}
+trap cleanup EXIT
+trap 'exit 1' HUP INT TERM
+
+# 1. Global instance must expose the option and required map node
+test -e options/stackmap || fail "options/stackmap missing on global instance"
+test -e stack_map        || fail "stack_map missing on global instance"
+
+# 2. Create a foreign sentinel and an owned secondary instance. Defer signal
+# exit across each mkdir and ownership assignment: cleanup must remove a path
+# only after this invocation has successfully created it.
+interrupted=0
+trap 'interrupted=1' HUP INT TERM
+create_rc=0
+if mkdir "$foreign_dir"; then
+    foreign_created=1
+else
+    create_rc=$?
+fi
+trap 'exit 1' HUP INT TERM
+[ "$interrupted" -eq 0 ] || exit 1
+[ "$create_rc" -eq 0 ] || fail "could not create foreign sentinel instance"
+
+interrupted=0
+trap 'interrupted=1' HUP INT TERM
+create_rc=0
+if mkdir "$owned_dir"; then
+    owned_created=1
+else
+    create_rc=$?
+fi
+trap 'exit 1' HUP INT TERM
+[ "$interrupted" -eq 0 ] || exit 1
+[ "$create_rc" -eq 0 ] || fail "could not create secondary instance"
+
+if [ -e "$owned_dir/options/stackmap" ]; then
+    fail "secondary instance unexpectedly exposes options/stackmap"
+fi
+
+for f in stack_map stack_map_stat stack_map_bin; do
+    if [ -e "$owned_dir/$f" ]; then
+        fail "secondary instance unexpectedly has $f"
+    fi
+done
+
+# 3. The aggregate trace_options file still reaches set_tracer_flag(),
+#    so writing 'stackmap' there must be rejected on a secondary
+#    instance. Otherwise the bit could appear set in trace_options
+#    while the hot path silently falls back to a full stack trace
+#    (tr->stackmap == NULL).
+if echo stackmap > "$owned_dir/trace_options" 2>/dev/null; then
+    fail "secondary instance accepted 'echo stackmap > trace_options'"
+fi
+if grep -qw stackmap "$owned_dir/trace_options"; then
+    fail "secondary instance trace_options reports stackmap as set"
+fi
+
+remove_owned || fail "could not remove owned secondary instance"
+if [ -e "$owned_dir" ]; then
+    fail "owned secondary instance still exists after removal"
+fi
+if [ ! -d "$foreign_dir" ]; then
+    fail "owned cleanup removed foreign sentinel instance"
+fi
+rmdir "$foreign_dir" || fail "could not remove foreign sentinel instance"
+foreign_created=0
+
+echo "stackmap option gating to top-level instance works"
+exit 0
-- 
2.34.1

