Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4E2D8795
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712447; cv=none; b=DIcDW5wvqMirzpEbLWTb+iAmqksx5h29F0pTt8NJiUkhfOMTan4LD4FK16iMzWhKorfrctuogV98k20LOc2+RzqZLmKGeESMyFtsMq7UEG0w1clTq626Z9wq8TogbjXa32AuFpqopuBwg18fbd8VeAI6ssrAsSEGYDZBhv9P6bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712447; c=relaxed/simple;
	bh=Srk+Fr4TqyjLD7nJUa5pnoyjK2m8oW4zuu6Kvh8HhdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTA8BvIUCA3YX/br4bvXaLI6nl71O54xKUDOFX9h2MvZpHVVcw3UWQlcIhbjnixXc4pS4jOTAuoZV48YTaZi6VAPKWPyyFeajRN3olwIvzMmUfsdG5gOFCo11/FVb6S2z+zpaC1KKIwmWLh8fNQEhJE/iuKitPy8l0gSmts5EJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPZOmPVd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPZOmPVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760712445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+g39942jtLGJd3OsDmw3XB6JSqklKuGB9oYb6LS2jo=;
	b=EPZOmPVdRwONp5oZKjXTPkjkv4bb1+fmqj3uc8Moyie1TaV2lzV0hQS6Z+TMaFryoeyccw
	/HVUH/jlSKCF9uR30AcJ2aPiYQdOYV5X/FxR4dUkbg1OJwnU1CKkDpDauz57IkcGLNnHdb
	UgIuUqS+PVFPJB8uUAJ6smxtGcFM284=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-v_DwCMsAPQeD3eKnXiuP3w-1; Fri,
 17 Oct 2025 10:47:22 -0400
X-MC-Unique: v_DwCMsAPQeD3eKnXiuP3w-1
X-Mimecast-MFC-AGG-ID: v_DwCMsAPQeD3eKnXiuP3w_1760712441
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1CBB1954210;
	Fri, 17 Oct 2025 14:47:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D5601800452;
	Fri, 17 Oct 2025 14:47:18 +0000 (UTC)
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
Subject: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
Date: Fri, 17 Oct 2025 16:46:49 +0200
Message-ID: <20251017144650.663238-4-tglozar@redhat.com>
In-Reply-To: <20251017144650.663238-1-tglozar@redhat.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add an example BPF action program that prints the measured latency to
the tracefs buffer via bpf_printk().

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/sample/timerlat_bpf_action.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 tools/tracing/rtla/sample/timerlat_bpf_action.c

diff --git a/tools/tracing/rtla/sample/timerlat_bpf_action.c b/tools/tracing/rtla/sample/timerlat_bpf_action.c
new file mode 100644
index 000000000000..ac1be049a848
--- /dev/null
+++ b/tools/tracing/rtla/sample/timerlat_bpf_action.c
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
-- 
2.51.0

