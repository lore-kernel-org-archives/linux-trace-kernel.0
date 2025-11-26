Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0293074A9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168163; cv=none; b=IVvcD2sgC6dj/JwAZlkfmCl9mMT1lRV43xjHi3Ssl0ClE64FPkgxjnGPXaS6UMVK9pN8ZGj+OutWP0mZOkupqfvya7XK2gbnBOnO1s3SgjJHRIACoYEDf7KjuzH5WDd8/FPmKarFFaDOOZEjQzKwhvc7F9+5GoJJTSEzeNOgz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168163; c=relaxed/simple;
	bh=U6aeKU2yU9MP6txLmWMFAeuRteXaQ4ZMg2CsjVXNZko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQ+SoBiPf5XozuZEIQ2Q5gMWbS9/Fy1zG95fweSfdl1Hz5TD+q66YQfDStSlbTopAN8fihIA1jVwSKcECfLyHN8DGd1NIr/v/92ho8wIb0F8s2RoeRw7oMymEQIidPFK77kAw20g/1NyERy2NKyOLVk2Wlw08RzwljKdR9//xmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e51rZLV5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e51rZLV5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764168160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VbMVMHPsP3L/xPG4xVr2CBVZ+uFJi6CXeeR99O3ckw=;
	b=e51rZLV5xqv2d7OaabMpD/ZtqGL/VJgHs8Y+oqIjpaDt1w32xCAOWDCkacmXEfExL2iTd6
	e9sL5BSk7YS8urTweDuTM0dbaUhBzeh2NU88Q9qmCw5LcKvNUQSpk1oqb74U1PoYGZx9um
	sxjfotlUU6kgEx4+YsMOe25pvHAIl6Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-LF9LfFMqPGKRTSqncxt8Gw-1; Wed,
 26 Nov 2025 09:42:36 -0500
X-MC-Unique: LF9LfFMqPGKRTSqncxt8Gw-1
X-Mimecast-MFC-AGG-ID: LF9LfFMqPGKRTSqncxt8Gw_1764168155
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A81331956060;
	Wed, 26 Nov 2025 14:42:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D53030044DC;
	Wed, 26 Nov 2025 14:42:32 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v4 4/7] rtla/tests: Test BPF action program
Date: Wed, 26 Nov 2025 15:42:02 +0100
Message-ID: <20251126144205.331954-5-tglozar@redhat.com>
In-Reply-To: <20251126144205.331954-1-tglozar@redhat.com>
References: <20251126144205.331954-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add a test that implements a BPF program writing to a test map, which
is attached to RTLA via --bpf-action to be executed on theshold
overflow.

A combination of --on-threshold shell with bpftool (which is always
present if BPF support is enabled) is used to check whether the BPF
program has executed successfully.

Suggested-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/Makefile                   | 10 ++++++--
 tools/tracing/rtla/tests/bpf/bpf_action_map.c | 25 +++++++++++++++++++
 tools/tracing/rtla/tests/timerlat.t           | 15 +++++++++++
 3 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 tools/tracing/rtla/tests/bpf/bpf_action_map.c

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 5f1529ce3693..aef814b639b7 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -76,12 +76,18 @@ src/timerlat.skel.h: src/timerlat.bpf.o
 
 example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
+
+tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
+	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
 else
 src/timerlat.skel.h:
 	$(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
 
 example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
 	$(Q)echo "BPF skeleton support is disabled, skipping example/timerlat_bpf_action.o"
+
+tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
+	$(Q)echo "BPF skeleton support is disabled, skipping tests/bpf/bpf_action_map.o"
 endif
 
 $(RTLA): $(RTLA_IN)
@@ -103,7 +109,7 @@ clean: doc_clean fixdep-clean
 	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
 	$(Q)rm -rf feature
 	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_action.o
-check: $(RTLA)
-	RTLA=$(RTLA) prove -o -f tests/
+check: $(RTLA) tests/bpf/bpf_action_map.o
+	RTLA=$(RTLA) BPFTOOL=$(SYSTEM_BPFTOOL) prove -o -f tests/
 examples: example/timerlat_bpf_action.o
 .PHONY: FORCE clean check
diff --git a/tools/tracing/rtla/tests/bpf/bpf_action_map.c b/tools/tracing/rtla/tests/bpf/bpf_action_map.c
new file mode 100644
index 000000000000..1686e0b858e6
--- /dev/null
+++ b/tools/tracing/rtla/tests/bpf/bpf_action_map.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_tracing.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, unsigned int);
+	__type(value, unsigned long long);
+} rtla_test_map SEC(".maps");
+
+struct trace_event_raw_timerlat_sample;
+
+SEC("tp/timerlat_action")
+int action_handler(struct trace_event_raw_timerlat_sample *tp_args)
+{
+	unsigned int key = 0;
+	unsigned long long value = 42;
+
+	bpf_map_update_elem(&rtla_test_map, &key, &value, BPF_ANY);
+
+	return 0;
+}
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index bbaa1897d8a8..fd4935fd7b49 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -67,6 +67,21 @@ check "hist with trace output at end" \
 	"timerlat hist -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
 check "top with trace output at end" \
 	"timerlat top -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
+
+# BPF action program tests
+if [ "$option" -eq 0 ]
+then
+	# Test BPF action program properly in BPF mode
+	[ -z "$BPFTOOL" ] && BPFTOOL=bpftool
+	check "hist with BPF action program (BPF mode)" \
+		"timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map.o --on-threshold shell,command='$BPFTOOL map dump name rtla_test_map'" \
+		2 '"value": 42'
+else
+	# Test BPF action program failure in non-BPF mode
+	check "hist with BPF action program (non-BPF mode)" \
+		"timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map.o" \
+		1 "BPF actions are not supported in tracefs-only mode"
+fi
 done
 
 test_end
-- 
2.51.1

