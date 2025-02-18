Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68E243377
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881905; cv=none; b=XshBy9tvq+hruAhyM5XqdQLhWuBI4J62/eXzHE2Mqau/pmdtkbRiPdRNgNc7yNHNHigeeaye67TUFCXfnzGIIox6fgOg64/DERdJG4qMghTM19juRlRmGc2tRBgroZDiV8z4bpLyYs9YPfVaSv+jqm2qaG2GUp7x7S89P2/mIOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881905; c=relaxed/simple;
	bh=FgvNNOrKi5BTCOctf/X5ZFDE9UwogkDozn2yBiLEj/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dT4N5BhBRt9HEyPeBtfBq1AdQv2IOmm8XXX1avc/l9qbGm9BqpkimqCXwhZW8hUfW5frvNDMbEd+LbagFbfCuNwK2aTGuDposqt9NkdACr+jiRYrqC9vMhXPj3tF/l5uTpqoodQluiw/RwAW29RhlI+f9U6u8mHvmqIMMVqwUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7hOlTTV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7hOlTTV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739881902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ttz+a3pnQUmTf0MGk2lsv1aLrwsABrFcgglcEw3OomU=;
	b=R7hOlTTVlYEOsVIg3eib65TbTRoB59CSkdgZDQncrcbeGGhYfUf8sdjOXu8XRrjcb6iF8W
	Bmce8NuCZt8d4zzJTvdyxif7AtkGV9kdpnZVIg+tyNbTcIGIpxUTb9qYQbPY987j4TzeMW
	4qiidxgNdq4+phq2Gxf7OVReEoyiHhI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-RvUoOthIOcW4AiC9_p8XSA-1; Tue,
 18 Feb 2025 07:31:39 -0500
X-MC-Unique: RvUoOthIOcW4AiC9_p8XSA-1
X-Mimecast-MFC-AGG-ID: RvUoOthIOcW4AiC9_p8XSA_1739881898
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3AF619373D8;
	Tue, 18 Feb 2025 12:31:37 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.33.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 113DF1800360;
	Tue, 18 Feb 2025 12:31:34 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v4 02/11] rv: Add license identifiers to monitor files
Date: Tue, 18 Feb 2025 13:31:07 +0100
Message-ID: <20250218123121.253551-3-gmonaco@redhat.com>
In-Reply-To: <20250218123121.253551-1-gmonaco@redhat.com>
References: <20250218123121.253551-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Some monitor files like the main header and the Kconfig are missing the
license identifier.

Add it to those and make sure the automatic generation script includes
the line in newly created monitors.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/wip/Kconfig            | 2 ++
 kernel/trace/rv/monitors/wip/wip.h              | 1 +
 kernel/trace/rv/monitors/wwnr/Kconfig           | 2 ++
 kernel/trace/rv/monitors/wwnr/wwnr.h            | 1 +
 tools/verification/dot2/dot2k.py                | 1 +
 tools/verification/dot2/dot2k_templates/Kconfig | 2 ++
 6 files changed, 9 insertions(+)

diff --git a/kernel/trace/rv/monitors/wip/Kconfig b/kernel/trace/rv/monitors/wip/Kconfig
index 3ef664b5cd903..e464b9294865b 100644
--- a/kernel/trace/rv/monitors/wip/Kconfig
+++ b/kernel/trace/rv/monitors/wip/Kconfig
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
 config RV_MON_WIP
 	depends on RV
 	depends on PREEMPT_TRACER
diff --git a/kernel/trace/rv/monitors/wip/wip.h b/kernel/trace/rv/monitors/wip/wip.h
index 2e373f2c65ed7..c7193748bf369 100644
--- a/kernel/trace/rv/monitors/wip/wip.h
+++ b/kernel/trace/rv/monitors/wip/wip.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Automatically generated C representation of wip automaton
  * For further information about this format, see kernel documentation:
diff --git a/kernel/trace/rv/monitors/wwnr/Kconfig b/kernel/trace/rv/monitors/wwnr/Kconfig
index ee741aa6d6b89..d3bfc20037db9 100644
--- a/kernel/trace/rv/monitors/wwnr/Kconfig
+++ b/kernel/trace/rv/monitors/wwnr/Kconfig
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
 config RV_MON_WWNR
 	depends on RV
 	select DA_MON_EVENTS_ID
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.h b/kernel/trace/rv/monitors/wwnr/wwnr.h
index d0d9c4b8121b5..0a59d23edf610 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.h
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Automatically generated C representation of wwnr automaton
  * For further information about this format, see kernel documentation:
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index 7547eb290b7df..153cc14bcca45 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -160,6 +160,7 @@ class dot2k(Dot2c):
 
     def fill_model_h_header(self):
         buff = []
+        buff.append("/* SPDX-License-Identifier: GPL-2.0 */")
         buff.append("/*")
         buff.append(" * Automatically generated C representation of %s automaton" % (self.name))
         buff.append(" * For further information about this format, see kernel documentation:")
diff --git a/tools/verification/dot2/dot2k_templates/Kconfig b/tools/verification/dot2/dot2k_templates/Kconfig
index 90cdc1e9379e1..03100eda17075 100644
--- a/tools/verification/dot2/dot2k_templates/Kconfig
+++ b/tools/verification/dot2/dot2k_templates/Kconfig
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
 config RV_MON_%%MODEL_NAME_UP%%
 	depends on RV
 	select %%MONITOR_CLASS_TYPE%%
-- 
2.48.1

