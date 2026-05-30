Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449303C2B9C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150666; cv=none; b=LhVPTsdvOcfJBAzMmJFprD7IhWB4X6pOzadFL0e4Wycm2pIKzVnfWtsdUaWulJZ1MuVNb6yTQuV+N74fVxJh6P0fB9Gw9dk0OIhrE3DXtqOJFN/+QvrAEqdPooWOAP+ns89FNYU/RLVVy87r15VBjCXEhFfdBebmuf3qzUj6OmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150666; c=relaxed/simple;
	bh=v9Q52fnEGJvcPbiWONH0PwZhcDfz+qUXKqRJo/i1nhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=MdqskRknOtqB7FijGuGVn9gqqXEHe8SA4bU5xVmJTySyECM4/tCYjCh1T4qMLn09eJmNv9lgAHk8ND6Nnd2vtb0Uo1cKgbTIJM/zjFa5q611LeXw9reU3X5Y5etM9x3V45bfSP6U0e+q7mdk1tn1fVAxtNUQpwSwRSK7HUyXto0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9gweWz+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9gweWz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780150663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APqx5zgx+UWLkpKTsxBYfSqwUD6XZTNzSrSngpPoAvs=;
	b=E9gweWz+tpSza7RtFWVvl09hVYsYpxeUAbTsM6VRF/Zy1rF7OoS254kcT58DXi/Psv9H0X
	zEgZZauBkLSCLjqAJdS/6V6C1I/Q/OzTHMPVti/R0vg2Z8eGqifvfPusZ7ZPiZDq6oTxCa
	2R1KY1SHbrmAGaV6nbsvjkLsT6GjcxE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-mMKdVh2lPkCkfmcm70IQ8A-1; Sat,
 30 May 2026 10:17:39 -0400
X-MC-Unique: mMKdVh2lPkCkfmcm70IQ8A-1
X-Mimecast-MFC-AGG-ID: mMKdVh2lPkCkfmcm70IQ8A_1780150658
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A6531800359;
	Sat, 30 May 2026 14:17:38 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7981D30001BB;
	Sat, 30 May 2026 14:17:36 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 13/13] verification/rvgen: Generate cleanup hook for per-obj monitor
Date: Sat, 30 May 2026 16:16:52 +0200
Message-ID: <20260530141652.58084-14-gmonaco@redhat.com>
In-Reply-To: <20260530141652.58084-1-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 6LXsmfhd7Cw_pkiwppAhXeCLyk63mjVn_jEs6BP9oBk_1780150658
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

