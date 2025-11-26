Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43EB303CB7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168151; cv=none; b=NuwzVA/nvGRLc95Icu63huPqsCP0QWxRffGyhvXJ/89WIW5TNWlNzeeC2hljCpn3InJuqWyyWzcF2XFzWOV7PBFE29XBNj08mSlLTP8bfkmqmAK8rR0sUkaQCLvsJ2D1clVTQ3Kws7ckdgqwTHi+NXEQQ01dD3pj5xry9TwLcEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168151; c=relaxed/simple;
	bh=qwsnhEptLby+7TajVZhrz/vQSlJcCTOENAdkdJOseOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocKYPkVpvRGiddKZwdoMU8vRGtZLWWtTYJ6yOtNgUn2jegpuyOxP23GH7hI32lsA2fEHu2nSpD40pfeIvorPaeDV6WuQHXQT964NKp1IvB6FzeEpulsuipG2Si+FuVvelOAyjxDXo6JP2XMkDhUyLLaZPRQ08redj9A9kuNQPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBkjybi5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBkjybi5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764168148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O29KQZdercKxM8Mac3ccF7Zfk/IAXvI2AhGZPuaVO9E=;
	b=LBkjybi5fkqlWOx/WLg/rjO+CYi5D5t1fcCpzo5rjTdJplwkP17IKWENIB1xmbOGLkW1qR
	AlkS7WpsTldlqNFPM51dG+nY+gtgJyz8Gdl4Qv2vtkp7akBpIRX5GRn8NJIaKL9lYuX4K0
	Df82iW1owhvJrqa3mijYzj7AiCGX2ck=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-yHiiIs6GOGSy0j79Q0CyBA-1; Wed,
 26 Nov 2025 09:42:25 -0500
X-MC-Unique: yHiiIs6GOGSy0j79Q0CyBA-1
X-Mimecast-MFC-AGG-ID: yHiiIs6GOGSy0j79Q0CyBA_1764168144
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D4B919541A7;
	Wed, 26 Nov 2025 14:42:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D858A30044DD;
	Wed, 26 Nov 2025 14:42:20 +0000 (UTC)
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
Subject: [PATCH v4 1/7] rtla/timerlat: Support tail call from BPF program
Date: Wed, 26 Nov 2025 15:41:59 +0100
Message-ID: <20251126144205.331954-2-tglozar@redhat.com>
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

Add a map to the rtla-timerlat BPF program that holds a file descriptor
of another BPF program, to be executed on threshold overflow.

timerlat_bpf_set_action() is added as an interface to set the program.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat.bpf.c | 25 +++++++++++++++++++++----
 tools/tracing/rtla/src/timerlat_bpf.c | 13 +++++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h |  1 +
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat.bpf.c b/tools/tracing/rtla/src/timerlat.bpf.c
index e2265b5d6491..549d2d2191d2 100644
--- a/tools/tracing/rtla/src/timerlat.bpf.c
+++ b/tools/tracing/rtla/src/timerlat.bpf.c
@@ -40,6 +40,17 @@ struct {
 	__uint(max_entries, 1);
 } signal_stop_tracing SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(key_size, sizeof(unsigned int));
+	__uint(max_entries, 1);
+	__array(values, unsigned int (void *));
+} bpf_action SEC(".maps") = {
+	.values = {
+		[0] = 0
+	},
+};
+
 /* Params to be set by rtla */
 const volatile int bucket_size = 1;
 const volatile int output_divisor = 1000;
@@ -109,7 +120,7 @@ nosubprog void update_summary(void *map,
 	map_set(map, SUMMARY_SUM, map_get(map, SUMMARY_SUM) + latency);
 }
 
-nosubprog void set_stop_tracing(void)
+nosubprog void set_stop_tracing(struct trace_event_raw_timerlat_sample *tp_args)
 {
 	int value = 0;
 
@@ -118,6 +129,12 @@ nosubprog void set_stop_tracing(void)
 
 	/* Signal to userspace */
 	bpf_ringbuf_output(&signal_stop_tracing, &value, sizeof(value), 0);
+
+	/*
+	 * Call into BPF action program, if attached.
+	 * Otherwise, just silently fail.
+	 */
+	bpf_tail_call(tp_args, &bpf_action, 0);
 }
 
 SEC("tp/osnoise/timerlat_sample")
@@ -138,19 +155,19 @@ int handle_timerlat_sample(struct trace_event_raw_timerlat_sample *tp_args)
 		update_summary(&summary_irq, latency, bucket);
 
 		if (irq_threshold != 0 && latency_us >= irq_threshold)
-			set_stop_tracing();
+			set_stop_tracing(tp_args);
 	} else if (tp_args->context == 1) {
 		update_main_hist(&hist_thread, bucket);
 		update_summary(&summary_thread, latency, bucket);
 
 		if (thread_threshold != 0 && latency_us >= thread_threshold)
-			set_stop_tracing();
+			set_stop_tracing(tp_args);
 	} else {
 		update_main_hist(&hist_user, bucket);
 		update_summary(&summary_user, latency, bucket);
 
 		if (thread_threshold != 0 && latency_us >= thread_threshold)
-			set_stop_tracing();
+			set_stop_tracing(tp_args);
 	}
 
 	return 0;
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index e97d16646bcd..1d619e502c65 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -59,6 +59,19 @@ int timerlat_bpf_init(struct timerlat_params *params)
 	return 0;
 }
 
+/*
+ * timerlat_bpf_set_action - set action on threshold executed on BPF side
+ */
+static int timerlat_bpf_set_action(struct bpf_program *prog)
+{
+	unsigned int key = 0, value = bpf_program__fd(prog);
+
+	return bpf_map__update_elem(bpf->maps.bpf_action,
+				    &key, sizeof(key),
+				    &value, sizeof(value),
+				    BPF_ANY);
+}
+
 /*
  * timerlat_bpf_attach - attach BPF program to collect timerlat data
  */
diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
index 118487436d30..b5009092c7a3 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.h
+++ b/tools/tracing/rtla/src/timerlat_bpf.h
@@ -12,6 +12,7 @@ enum summary_field {
 };
 
 #ifndef __bpf__
+#include <bpf/libbpf.h>
 #ifdef HAVE_BPF_SKEL
 int timerlat_bpf_init(struct timerlat_params *params);
 int timerlat_bpf_attach(void);
-- 
2.51.1

