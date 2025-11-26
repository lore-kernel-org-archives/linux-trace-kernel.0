Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB7306496
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168159; cv=none; b=bLJGhZ9+RJCl/JKLpJC8iJ7z8RHtePXb9Poorjg1BEB7zbe52DW04kdXu4H4N84tHE3OzlMH9MpJY5xHuWzBXVnDTbNKr5VQs7i+MuuvIHa98WqtT+0ZuyljNY/7670hRpf5HK4h5Ekz2VjX2YjQ0kiXopJ4+bSbo+JQRntJXSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168159; c=relaxed/simple;
	bh=dbFvGLyIeVEicx/vLCln8WylCwQ3fSZK5YvDmlwVJ+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPRFhMMaZxENTP6dz14xcOZULbvZqItIK6htrq+kEW/oW5JR6kwk867UeS/Zp0p4B9WC74KiwFiAROsmFOxidLRcnOfrTJY6hE96sRrl4DO2D+NUsqC3WNN1UYHDTJ9mQirSJUuZetgKhn6+FQ226nmT57CSwOAyojsuDVvQj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xmms+c3l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xmms+c3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764168156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zdTrZJ6e1+3ErgoegEEu9PfM4To0rBlVIY+g6vLATw=;
	b=Xmms+c3lCvnA6RHpLb03fmWgmHf3Uxr1UerKSfP/+xM4VgguNPkQdrdXYCHXmJLDuoeS9j
	KOqnjHhPhbqznEhNW0VaO6SYMrUQj1o7zdz3aUXhgwt4AT2v2FR147kul9dv7YPOiqDG8G
	eXHRPdfXRXl0Fml+M1T2HOuCaRc3myo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-usj36g0fMEKC5Z4E7Mlbmw-1; Wed,
 26 Nov 2025 09:42:32 -0500
X-MC-Unique: usj36g0fMEKC5Z4E7Mlbmw-1
X-Mimecast-MFC-AGG-ID: usj36g0fMEKC5Z4E7Mlbmw_1764168152
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAC67180057A;
	Wed, 26 Nov 2025 14:42:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7970B30044DC;
	Wed, 26 Nov 2025 14:42:27 +0000 (UTC)
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
Subject: [PATCH v4 3/7] rtla/timerlat: Add example for BPF action program
Date: Wed, 26 Nov 2025 15:42:01 +0100
Message-ID: <20251126144205.331954-4-tglozar@redhat.com>
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

Add an example BPF action program that prints the measured latency to
the tracefs buffer via bpf_printk().

A new Makefile target, "examples", is added to build the example. In
addition, "sample/" subfolder is renamed to "example".

If BPF skeleton support is unavailable or disabled, a warning will be
displayed when building the BPF action program example.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/Makefile                      |  9 ++++++++-
 tools/tracing/rtla/example/timerlat_bpf_action.c | 16 ++++++++++++++++
 .../rtla/{sample => example}/timerlat_load.py    |  0
 3 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 tools/tracing/rtla/example/timerlat_bpf_action.c
 rename tools/tracing/rtla/{sample => example}/timerlat_load.py (100%)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 746ccf2f5808..5f1529ce3693 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -73,9 +73,15 @@ src/timerlat.bpf.o: src/timerlat.bpf.c
 
 src/timerlat.skel.h: src/timerlat.bpf.o
 	$(QUIET_GENSKEL)$(SYSTEM_BPFTOOL) gen skeleton $< > $@
+
+example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
+	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
 else
 src/timerlat.skel.h:
 	$(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
+
+example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
+	$(Q)echo "BPF skeleton support is disabled, skipping example/timerlat_bpf_action.o"
 endif
 
 $(RTLA): $(RTLA_IN)
@@ -96,7 +102,8 @@ clean: doc_clean fixdep-clean
 	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
 	$(Q)rm -rf feature
-	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h
+	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_action.o
 check: $(RTLA)
 	RTLA=$(RTLA) prove -o -f tests/
+examples: example/timerlat_bpf_action.o
 .PHONY: FORCE clean check
diff --git a/tools/tracing/rtla/example/timerlat_bpf_action.c b/tools/tracing/rtla/example/timerlat_bpf_action.c
new file mode 100644
index 000000000000..ac1be049a848
--- /dev/null
+++ b/tools/tracing/rtla/example/timerlat_bpf_action.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_tracing.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct trace_event_raw_timerlat_sample {
+	unsigned long long timer_latency;
+} __attribute__((preserve_access_index));
+
+SEC("tp/timerlat_action")
+int action_handler(struct trace_event_raw_timerlat_sample *tp_args)
+{
+	bpf_printk("Latency: %lld\n", tp_args->timer_latency);
+	return 0;
+}
diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/rtla/example/timerlat_load.py
similarity index 100%
rename from tools/tracing/rtla/sample/timerlat_load.py
rename to tools/tracing/rtla/example/timerlat_load.py
-- 
2.51.1

