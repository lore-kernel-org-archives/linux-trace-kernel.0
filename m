Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9E34752A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863062; cv=none; b=DLaZy0K0pto7JYxrk4Pn1azg/KdZZ8kkHXAf58NDrPJ7/6WvdJ1vgtpTrpNm5vnYKdC+9UFbs5gyo9AwiDXOiIUhMq2lQ9eP2pe4coT/C4CSeQFx6Qa1YipjqZLSiwO7Ue1BkY46PpsXEwg3DsEEgn4PE/v3hKqkbSk77A9nRAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863062; c=relaxed/simple;
	bh=BTzpTzJ08QU872+MH2u3Jn40ek6LGw/G1Kc1I1WaA3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SEnnHruvW/+tatesqhwfZ9hlCytCO27y87d/IZiw2tO4BOC8HRox4pOVa/yPzPBHGpU0kL0T0kXy7cQucSQU18jvvY3gbd65dweyOURCWPDXrZQxpLChD5q9bfTl4ihmKLQbPnGZxD11mlL4fz0EIZkitkSSK2OzqKxGfHeQRcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJIJpYY8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJIJpYY8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779863056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIHa1YBuPLeO03QUKPgMW16MNNm3YEqx/eZ3E2ynjTk=;
	b=jJIJpYY84/FlTGekPXnLnQpdxXa9KglONrn6PakdsxltADij9VqnWxGOc/jDw7w6kyK8mt
	PgxQWGVirY8E8ZUvEh2zQScMOTTMI2w9Ip2xIlrk4htpLt9FdyiO434pYUd0/lpchIVvXV
	X8mKhYpus47xk6v/IOkjHDriQXF/mUA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-otFvdVdkMqKJ37yA6KcG_w-1; Wed,
 27 May 2026 02:24:12 -0400
X-MC-Unique: otFvdVdkMqKJ37yA6KcG_w-1
X-Mimecast-MFC-AGG-ID: otFvdVdkMqKJ37yA6KcG_w_1779863051
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD4D0195608F;
	Wed, 27 May 2026 06:24:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74481180034E;
	Wed, 27 May 2026 06:24:09 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 11/12] verification/rvgen: Generate cleanup hook for per-obj monitor
Date: Wed, 27 May 2026 08:23:11 +0200
Message-ID: <20260527062313.39908-12-gmonaco@redhat.com>
In-Reply-To: <20260527062313.39908-1-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: ItQmYC11geFU0eaEGLGLjqqx2ceEqbCpDus-0A52L5c_1779863051
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Per-object monitors can allocate memory dynamically and such memory is
required for the lifetime of the object, then it should be freed with
the appropriate call.

Force the generation scripts to add a cleanup function the user will
need to wire to the appropriate event (e.g. sched_process_exit for
tasks). This can be safely removed if the object will never cease to
exist before disabling the monitor (e.g. if following only static
variables).

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2k.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index e6f476b903b0..a17294283a1f 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -17,6 +17,9 @@ from .automata import _EventConstraintKey, _StateConstraintKey, AutomataError
 class dot2k(Monitor, Dot2c):
     template_dir = "dot2k"
 
+    # only needed for the per-obj cleanup hook
+    cleanup_marker = "obj_cleanup"
+
     def __init__(self, file_path, MonitorType, extra_params={}):
         self.monitor_type = MonitorType
         Monitor.__init__(self, extra_params)
@@ -56,18 +59,30 @@ class dot2k(Monitor, Dot2c):
                 buff.append(f"\tda_{handle}({event}{self.enum_suffix});")
             buff.append("}")
             buff.append("")
+        if self.monitor_type == "per_obj":
+            buff.append("/* XXX: obj is being destroyed, remove if not required (e.g. obj is static) */")
+            buff.append(f"static void handle_{self.cleanup_marker}(void *data, /* XXX: fill header */)")
+            buff.append("{")
+            buff.append("\tint id = /* XXX: how do I get the id? */;")
+            buff.append("\tda_destroy_storage(id);")
+            buff.append("}")
+            buff.append("")
         return '\n'.join(buff)
 
     def fill_tracepoint_attach_probe(self) -> str:
         buff = []
         for event in self.events:
             buff.append(f"\trv_attach_trace_probe(\"{self.name}\", /* XXX: tracepoint */, handle_{event});")
+        if self.monitor_type == "per_obj":
+            buff.append(f"\trv_attach_trace_probe(\"{self.name}\", /* XXX: cleanup tracepoint */, handle_{self.cleanup_marker});")
         return '\n'.join(buff)
 
     def fill_tracepoint_detach_helper(self) -> str:
         buff = []
         for event in self.events:
             buff.append(f"\trv_detach_trace_probe(\"{self.name}\", /* XXX: tracepoint */, handle_{event});")
+        if self.monitor_type == "per_obj":
+            buff.append(f"\trv_detach_trace_probe(\"{self.name}\", /* XXX: cleanup tracepoint */, handle_{self.cleanup_marker});")
         return '\n'.join(buff)
 
     def fill_model_h_header(self) -> list[str]:
-- 
2.54.0

