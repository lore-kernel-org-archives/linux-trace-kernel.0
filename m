Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F625B1FC
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576538; cv=none; b=K4V4nt/HZeRmRRb/NfnrNGvxuKDGnME6xdUK6c5EUx9+hXFV3tBAxOgR2idoyCvGEsBYcLfJYk8EsqBXEnh9j7XK2D4hgH+ks78n96eadnKwCH6E7ELNDo7EdrST83HU5oWYIBZLuK0S6XBTRzuzg/gEY9bLuQ74RjndiwF6zDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576538; c=relaxed/simple;
	bh=H4YFI6jMBxuTfma66yvWdpil+xS6qySRpqzaahtkstw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFLahiGbhDOhj866FRc3RyH8+xdJ19HcG1yqXfGjymsSVBBqw/FbELppChFtGTj4cBmvrxzvcpo9xqvHvEgKDHvjAigEem6Kk89+O8ILuWXqW2hdQbPU3/cW7Lq3QOd/FkFvuShR1DvQqSR/k29oSK4JZ6LUTulgsLUnBl91QE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HjeDWiFO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjeDWiFO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkdOfBoeQUK++FxdaoJ0VFHifIEmAE6q/udIJ/iSXRc=;
	b=HjeDWiFOqsipzuvcA+oaQCRk0QPxEHLBoBx6T5hkWtQAIpm4M/YNQn3r/JAF5edNe6LGX1
	3ljYu8bBbkCpdzQ1b5ADoSbkAY9SJWpJEiTFZEaZ2ClPF6qjThIy4Stwo6/Ak0SW1iAru0
	4a/nh17oPO+B/f0nBm6+CNq2Z7LnbVs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-wmAMHQNYOjGQEUBYrHpqKw-1; Mon,
 27 Oct 2025 10:48:51 -0400
X-MC-Unique: wmAMHQNYOjGQEUBYrHpqKw-1
X-Mimecast-MFC-AGG-ID: wmAMHQNYOjGQEUBYrHpqKw_1761576530
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 293971800743;
	Mon, 27 Oct 2025 14:48:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DAEB0195398C;
	Mon, 27 Oct 2025 14:48:46 +0000 (UTC)
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
Subject: [PATCH v2 3/7] rtla/timerlat: Add example for BPF action program
Date: Mon, 27 Oct 2025 15:48:15 +0100
Message-ID: <20251027144819.1034041-4-tglozar@redhat.com>
In-Reply-To: <20251027144819.1034041-1-tglozar@redhat.com>
References: <20251027144819.1034041-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
2.51.0

