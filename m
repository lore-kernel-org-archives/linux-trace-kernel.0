Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67C35304BA
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868152; cv=none; b=IvNVy6Sm1JowNgx8OZQzWq/W2BX/oX1zvPl8WatBoywGsbXYkcYwqgXQOYAfwM35kpogSg7c7CtdErVUVSlLEPUYFS5nxUmz8e40Kr0z9MMGsrp5ncLmxMcAk0hbmHVyR6Mt9l6DOKbFUQTuhcEiABBE1ukFSRUMRK+aqUhqlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868152; c=relaxed/simple;
	bh=lZ7Ka7Xq6qnJRH9q3wXy/FPcZNa2VWZR6M/dhKOBZMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=T6F9FuhT/G0W9vD373DUt98Mk1v5olziQdgp7A97osu5JLomHA4ctFDT0d3P9ZSMIlN3gmgkhfGgTjmp+e3ous7tsq1/ZTAamnYsxQqNXcCl3uzTFAdgaJ3MGytEi2wML92hrc9IT121LqdBr28L+zP5uxAKQkpbC2nX2BZVkfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zu3Xhd2g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zu3Xhd2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iuk2+6ythm6C+q+Xn/hn5DZXc3kO8pD/dnjk1Vkkegg=;
	b=Zu3Xhd2gNYvYXbJP5/IYOGCg2AfMfSsw+TPMH+FGTIepzfWjbVkbiJy6477/UtzVja+YFL
	QQ5ArDL4bYNIbpIJoOFR95c8VNHO0hhXMLQJ+73QVPVAdCzylQvw5na0lJbr4zIwwckwS1
	A2dBNX7jtOYKlcdF0Eidw9VIVs2fb8s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-aCU18smHNzCcJGnERqrf2g-1; Thu,
 01 Oct 2026 11:22:28 -0400
X-MC-Unique: aCU18smHNzCcJGnERqrf2g-1
X-Mimecast-MFC-AGG-ID: aCU18smHNzCcJGnERqrf2g_1790868147
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00AC3180ABDC;
	Thu,  1 Oct 2026 15:22:27 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14FAB1800361;
	Thu,  1 Oct 2026 15:22:23 +0000 (UTC)
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
Subject: [PATCH v2 15/15] verification/rvgen: Add selftest for rvgen -b
Date: Thu,  1 Oct 2026 17:20:42 +0200
Message-ID: <20261001152042.124445-16-gmonaco@redhat.com>
In-Reply-To: <20261001152042.124445-1-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: d2StT8Tg8DUPgwolLo2Gkpg4m9G_Jk5UFBKwMyiJjwo_1790868147
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add selftest cases for BPF monitors generation.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 .../tests/golden/da_bpf_cpu/da_bpf_cpu.c      | 35 +++++++++++++
 .../tests/golden/da_bpf_cpu/da_bpf_cpu.h      | 47 ++++++++++++++++++
 .../tests/golden/da_bpf_obj/da_bpf_obj.c      | 49 +++++++++++++++++++
 .../tests/golden/da_bpf_obj/da_bpf_obj.h      | 47 ++++++++++++++++++
 .../verification/rvgen/tests/rvgen_monitor.t  | 11 +++++
 5 files changed, 189 insertions(+)
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h

diff --git a/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c b/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c
new file mode 100644
index 000000000000..5a652ce9b461
--- /dev/null
+++ b/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#define RV_MON_TYPE RV_MON_PER_CPU
+#include "da_bpf_cpu.h"
+#include <rv/da_monitor.h>
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ */
+SEC(/* XXX: tracepoint or other probe */)
+int BPF_PROG(handle_event_1, /* XXX: fill header */)
+{
+	da_handle_event(event_1_da_bpf_cpu);
+	return 0;
+}
+
+SEC(/* XXX: tracepoint or other probe */)
+int BPF_PROG(handle_event_2, /* XXX: fill header */)
+{
+	/* XXX: validate that this event always leads to the initial state */
+	da_handle_start_event(event_2_da_bpf_cpu);
+	return 0;
+}
+
+static struct rv_monitor rv_this = {
+	.enabled = 0,
+};
+
+char LICENSE[] SEC("license") = "GPL";
+char DESCRIPTION[] SEC(".rodata.description") = "auto-generated";
diff --git a/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h b/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h
new file mode 100644
index 000000000000..fd8125118d81
--- /dev/null
+++ b/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of da_bpf_cpu automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME da_bpf_cpu
+
+enum states_da_bpf_cpu {
+	state_a_da_bpf_cpu,
+	state_b_da_bpf_cpu,
+	state_max_da_bpf_cpu,
+};
+
+#define INVALID_STATE state_max_da_bpf_cpu
+
+enum events_da_bpf_cpu {
+	event_1_da_bpf_cpu,
+	event_2_da_bpf_cpu,
+	event_max_da_bpf_cpu,
+};
+
+struct automaton_da_bpf_cpu {
+	char state_names[state_max_da_bpf_cpu][32];
+	char event_names[event_max_da_bpf_cpu][32];
+	unsigned char function[state_max_da_bpf_cpu][event_max_da_bpf_cpu];
+	unsigned char initial_state;
+	bool final_states[state_max_da_bpf_cpu];
+};
+
+static const struct automaton_da_bpf_cpu automaton_da_bpf_cpu = {
+	.state_names = {
+		"state_a",
+		"state_b",
+	},
+	.event_names = {
+		"event_1",
+		"event_2",
+	},
+	.function = {
+		{       state_b_da_bpf_cpu,       state_a_da_bpf_cpu },
+		{            INVALID_STATE,       state_a_da_bpf_cpu },
+	},
+	.initial_state = state_a_da_bpf_cpu,
+	.final_states = { 1, 0 },
+};
diff --git a/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.c b/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.c
new file mode 100644
index 000000000000..a7d465f84f05
--- /dev/null
+++ b/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#define RV_MON_TYPE RV_MON_PER_OBJ
+typedef /* XXX: define the target type */ *monitor_target_bpf;
+#include "da_bpf_obj.h"
+#include <rv/da_monitor.h>
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ */
+SEC(/* XXX: tracepoint or other probe */)
+int BPF_PROG(handle_event_1, /* XXX: fill header */)
+{
+	int id = /* XXX: how do I get the id? */;
+	monitor_target_bpf t = /* XXX: how do I get t? */;
+	da_handle_event(id, t, event_1_da_bpf_obj);
+	return 0;
+}
+
+SEC(/* XXX: tracepoint or other probe */)
+int BPF_PROG(handle_event_2, /* XXX: fill header */)
+{
+	/* XXX: validate that this event always leads to the initial state */
+	int id = /* XXX: how do I get the id? */;
+	monitor_target_bpf t = /* XXX: how do I get t? */;
+	da_handle_start_event(id, t, event_2_da_bpf_obj);
+	return 0;
+}
+
+/* XXX: obj is being destroyed, remove if not required (e.g. obj is static) */
+SEC(/* XXX: tracepoint or other probe */)
+int BPF_PROG(handle_obj_cleanup, /* XXX: fill header */)
+{
+	int id = /* XXX: how do I get the id? */;
+	da_destroy_storage(id);
+	return 0;
+}
+
+static struct rv_monitor rv_this = {
+	.enabled = 0,
+};
+
+char LICENSE[] SEC("license") = "GPL";
+char DESCRIPTION[] SEC(".rodata.description") = "auto-generated";
diff --git a/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h b/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h
new file mode 100644
index 000000000000..385006098049
--- /dev/null
+++ b/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of da_bpf_obj automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME da_bpf_obj
+
+enum states_da_bpf_obj {
+	state_a_da_bpf_obj,
+	state_b_da_bpf_obj,
+	state_max_da_bpf_obj,
+};
+
+#define INVALID_STATE state_max_da_bpf_obj
+
+enum events_da_bpf_obj {
+	event_1_da_bpf_obj,
+	event_2_da_bpf_obj,
+	event_max_da_bpf_obj,
+};
+
+struct automaton_da_bpf_obj {
+	char state_names[state_max_da_bpf_obj][32];
+	char event_names[event_max_da_bpf_obj][32];
+	unsigned char function[state_max_da_bpf_obj][event_max_da_bpf_obj];
+	unsigned char initial_state;
+	bool final_states[state_max_da_bpf_obj];
+};
+
+static const struct automaton_da_bpf_obj automaton_da_bpf_obj = {
+	.state_names = {
+		"state_a",
+		"state_b",
+	},
+	.event_names = {
+		"event_1",
+		"event_2",
+	},
+	.function = {
+		{       state_b_da_bpf_obj,       state_a_da_bpf_obj },
+		{            INVALID_STATE,       state_a_da_bpf_obj },
+	},
+	.initial_state = state_a_da_bpf_obj,
+	.final_states = { 1, 0 },
+};
diff --git a/tools/verification/rvgen/tests/rvgen_monitor.t b/tools/verification/rvgen/tests/rvgen_monitor.t
index 5f2562600bad..3d71685a7ad5 100644
--- a/tools/verification/rvgen/tests/rvgen_monitor.t
+++ b/tools/verification/rvgen/tests/rvgen_monitor.t
@@ -47,6 +47,17 @@ check_and_compare_folder "LTL per_task with parent and description (default name
 	"$RVGEN monitor -c ltl -s tests/specs/test_ltl.ltl -t per_task -p ltl_parent -D 'Simple description'" \
 	"test_ltl" "LTL_MON_EVENTS_ID"
 
+# BPF monitor test
+check_and_compare_folder "DA BPF per_cpu" \
+	"$RVGEN monitor -b -c da -s tests/specs/test_da.dot -t per_cpu -n da_bpf_cpu" \
+	"da_bpf_cpu" "Edit the da_bpf_cpu/da_bpf_cpu.c to add the instrumentation" \
+	"Edit kernel/trace/rv/Makefile"
+
+check_and_compare_folder "DA BPF per_obj" \
+	"$RVGEN monitor -b -c da -s tests/specs/test_da.dot -t per_obj -n da_bpf_obj" \
+	"da_bpf_obj" "Edit the da_bpf_obj/da_bpf_obj.c to add the instrumentation" \
+	"Edit kernel/trace/rv/Kconfig"
+
 # Error handling tests
 check "missing required spec argument" \
 	"$RVGEN monitor -c da -t per_cpu" 2 \
-- 
2.55.0

