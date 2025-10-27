Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C02FE078
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576539; cv=none; b=tUpwMq5OC5p6w34z2YDL0zOOcJxyg4BaWKFMoTxdfzh1OwXY0iCEgg1J3BcDyIdRyctKtp2Vm6o6wsPhJ2N7x98oZC+7ZEqH2jT/h5RuVBBUvpB3BaMj7oY45nS+cmjDqWPHifsDydul/7nE8oTnwcbsPCQx6sb5obb4wCND4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576539; c=relaxed/simple;
	bh=UBJ/37A7WlMN9ZjPjuDzh79HvqMoDgHgJ6Zw2w7kmsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUl+yTERjHLztcMbGhFi39zNK9AAkRaRj79XbT3RwOsSEiRdi1ibBZqA0+jhEr2tO1D7ZJlfgzx7+ZimHJ4m7d4Z9VXRlYXvSwntMk1Z6C6Baj33HfWgFh8zY4F9VEjo7DrTjrYxgoKIjyggtMPYAjWUAz7cRFXnTd0Wj+yoiZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKOLcxca; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKOLcxca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nSe6Dqx1Zz4gyONo9npX6Dn7VQSJT1f+7SYleKGnDM=;
	b=PKOLcxcaf5Eam/GpVobzp4tpOQEmBSVtCD7RkGNymLk3WhqpuUeV83KWbl1lkhqpKXYeJ5
	U/LAr+kQ/g6vwu/2ghk23QmcG9HcvxnvmBpl6tHiQH+N3PnDxan9g1aQow9uPhy+V7KFBi
	PPMk49gKkT+kWAVJHnYqN+AYmFBUyYg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-PVPl4-dmPWyoC_XdtBQKtg-1; Mon,
 27 Oct 2025 10:48:54 -0400
X-MC-Unique: PVPl4-dmPWyoC_XdtBQKtg-1
X-Mimecast-MFC-AGG-ID: PVPl4-dmPWyoC_XdtBQKtg_1761576533
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7680419541BD;
	Mon, 27 Oct 2025 14:48:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EE8A19540EB;
	Mon, 27 Oct 2025 14:48:50 +0000 (UTC)
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
Subject: [PATCH v2 4/7] rtla/tests: Test BPF action program
Date: Mon, 27 Oct 2025 15:48:16 +0100
Message-ID: <20251027144819.1034041-5-tglozar@redhat.com>
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

Add a test that implements a BPF program writing to a test map, which
is attached to RTLA via --bpf-action to be executed on theshold
overflow.

A combination of --on-threshold shell with bpftool (which is always
present if BPF support is enabled) is used to check whether the BPF
program has executed successfully.

Suggested-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/Makefile         | 10 ++++++++--
 tools/tracing/rtla/tests/timerlat.t | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

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
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index b5d1e7260a9b..89e28cc6df82 100644
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
2.51.0

