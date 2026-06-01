Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1C3DEAD5
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328377; cv=none; b=L3OV6Eon/FWC5NfBt9KcK5AkvGZt2iukGHf+T2v0pVwbsuhKE714sbwKU0eJn3GHEUbUh53cs//fas8fOarsjyjqIrfrBM+fX4giUNE2lAAZqvZ4u4vI4pASs60OfOqXL7vjbcniNzEftH5v9qhSfX/G37A9BhmHw+5Qz1V1P/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328377; c=relaxed/simple;
	bh=tzcu2+zu8QYCWC1tbwf+18i2ydrhQ2My10Q6OmGHjDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pU3oVbFIgeo/jRPKG1w88Ka9YuM7T43mWOLPeHvRFzhSyvVA6nlCB3lG9DKeEhrjo2GVSRfiQmjESzL/B01Nu40FhtfT4nJ2wi3xtzZMIcfXpzEGQA85ad7tX3fph62a6WIswbHNZm/nzwNfST88UyHI82aK4pWJR5OEliSFfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYZ3Vbqu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYZ3Vbqu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780328372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21S+YDnCmGTIiaS+PRcKDrsm0i5RlvfONkwHhgcE6OM=;
	b=gYZ3VbquyxFua0jhjQpqKjEdaTLzJPwh4hkLCTUW6JURnfhyGwFKwkbbYqLDkMvXtnz4dg
	WYv7QT7Z4vRhBVSQr2lpvYQ1hdTRu95eZLy2y93LRTLQd0MCvFlC2j6P7PtxwrQMpGINLA
	ZshQ2BVv3aID2PN9Rz+fv6OrLlcMkak=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-RQTcRJkXN32--ZXbO_Z_pA-1; Mon,
 01 Jun 2026 11:39:29 -0400
X-MC-Unique: RQTcRJkXN32--ZXbO_Z_pA-1
X-Mimecast-MFC-AGG-ID: RQTcRJkXN32--ZXbO_Z_pA_1780328368
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F8DA19560AB;
	Mon,  1 Jun 2026 15:39:28 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 854E618004A3;
	Mon,  1 Jun 2026 15:39:26 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 13/13] verification/rvgen: Generate cleanup hook for per-obj monitor
Date: Mon,  1 Jun 2026 17:38:40 +0200
Message-ID: <20260601153840.124372-14-gmonaco@redhat.com>
In-Reply-To: <20260601153840.124372-1-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: xteotSFQVCA4T4DnTc5Ig5qt21V94oFcJNwgcMgzUhQ_1780328368
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

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2k.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index 110cfd69e..3060aa4b9 100644
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

