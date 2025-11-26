Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D02308F30
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168173; cv=none; b=TIsdauBdN6ws6YnYmy4K1itCqZw4bNPRAjE10RGU1cuNpdkfpn+L45bGnugPy2DyQfk9+kqYZcd9FBXqJTPNl7GewspF3swVCccA6/OULVgpPBgE7ISblBbGYpPik97EIZxe/AE01Y5x0iqqJJKfXbOUxjVF1zhClrRWxrPrPwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168173; c=relaxed/simple;
	bh=kW1gihDDcedEvkXqGdmYsSbrgzNv4svA/+2enVIdvK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYahkHDxqpE2WHb/EOD/cOaPwn82rmbF7hfGcLUpKmwkde6nMG7CG9Ju0hVis1NYImnzkS36UswBCrwDIIgcieqSNPni8VjJrZ6+5lvQBV0o029WDkru6S5tXP+mKziCDNK3wV51EKePKl5013hSBAz+HnFIHkPfISpBEXrtzq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgIB5sZP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgIB5sZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764168171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hjh7jROV8BsTpArMkOZNoEr6SM0a22WnGJ/uz3xYqvA=;
	b=PgIB5sZPr/85i+BDkgcN939/AeI5to7jXtG4bdeMrKVRLjBV1FH6hq9wq1TtA9J0zmpbR4
	4L4H+LyPP/5QOb8jABCgJ1Jfd36SI2bla2LXJ/+0McmFAriTueensfbXUIKShIQ30suBAm
	Ih0PwKm4G6I3ghtQ+R2OEhhH9c3lkR8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-0p5ltYuTPJ--QjL03Qzk-w-1; Wed,
 26 Nov 2025 09:42:47 -0500
X-MC-Unique: 0p5ltYuTPJ--QjL03Qzk-w-1
X-Mimecast-MFC-AGG-ID: 0p5ltYuTPJ--QjL03Qzk-w_1764168166
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D05DC1956058;
	Wed, 26 Nov 2025 14:42:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFA1230044DC;
	Wed, 26 Nov 2025 14:42:43 +0000 (UTC)
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
Subject: [PATCH v4 7/7] Documentation/rtla: Document --bpf-action option
Date: Wed, 26 Nov 2025 15:42:05 +0100
Message-ID: <20251126144205.331954-8-tglozar@redhat.com>
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

Add new option --bpf-action into common_timerlat_options.txt, including
the format in which it takes the BPF program, and a reference to an
example.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 .../tools/rtla/common_timerlat_options.txt     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/tools/rtla/common_timerlat_options.txt b/Documentation/tools/rtla/common_timerlat_options.txt
index 0cf7eca1f7b6..07a285fcf7cf 100644
--- a/Documentation/tools/rtla/common_timerlat_options.txt
+++ b/Documentation/tools/rtla/common_timerlat_options.txt
@@ -65,3 +65,21 @@
         Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
         task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
         See linux/tools/rtla/example/timerlat_load.py for an example of user-load code.
+
+**--bpf-action** *bpf-program*
+
+        Loads a BPF program from an ELF file and executes it when a latency threshold is exceeded.
+
+        The BPF program must be a valid ELF file loadable with libbpf. The program must contain
+        a function named ``action_handler``, stored in an ELF section with the ``tp_`` prefix.
+        The prefix is used by libbpf to set BPF program type to BPF_PROG_TYPE_TRACEPOINT.
+
+        The program receives a ``struct trace_event_raw_timerlat_sample`` parameter
+        containing timerlat sample data.
+
+        An example is provided in ``tools/tracing/rtla/example/timerlat_bpf_action.c``.
+        This example demonstrates how to create a BPF program that prints latency information using
+        bpf_trace_printk() when a threshold is exceeded.
+
+        **Note**: BPF actions require BPF support to be available. If BPF is not available
+        or disabled, the tool falls back to tracefs mode and BPF actions are not supported.
-- 
2.51.1

