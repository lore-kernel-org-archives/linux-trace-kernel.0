Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31709376475
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097395; cv=none; b=VeAxzh6ZqSN7zTJbNpG42mWlqL8OZ28WfzAwmBE7JRgxF+ZtwRKrrbdjADZZTAX9waphLxATPG+Zw+f+KAWHyZMJtPOzVVMkUE3fbRXHOwIOnq5aTonqGeELgv/Rjqqkuo7C9WB0wzEFdzI2pqRQyso6pIxlqPgSp7/Q2390dbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097395; c=relaxed/simple;
	bh=o4ZyPrixhb3phx1jWaDmhty4FCBLChbs9DxkVjYAEyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfkwowOHrc9ozkhS9hpzrZK/J1/zvmCmNrRkxIuEPPJVXD2IAdZ+LRIyNfeaS1Wv0ec3IrBE2Aqd1UkHPY7HW6z+lPAgDtwRggdBlMO6ukHwMUS6TSOm124P02QhuNcZFmziZH6kVeS+N6IdXs0LBumX7pDMkLriXzWOFMQkDIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pxnrs8zc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pxnrs8zc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769097385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVJPHf+v4bSMqmOdHWhSOHt1sO3MsnSR9Rd2QqLLQ6s=;
	b=Pxnrs8zckXJJ8AgMziycPopLLnjBMcb8K9vsi4n76XRJH6pB5ATrximCo5+dsWTGg+p7pK
	gRElYYO3V0C8tbqT3Bsl/wX8DWT72uLQVASilnhnb1ghXm52Frkynl2KMyh4kT61+LNH46
	9EvfwRSGLBDacSoeiS9QD2mMoH87hF8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-ngHx3vGDMEmDJcT32FTjNw-1; Thu,
 22 Jan 2026 10:56:22 -0500
X-MC-Unique: ngHx3vGDMEmDJcT32FTjNw-1
X-Mimecast-MFC-AGG-ID: ngHx3vGDMEmDJcT32FTjNw_1769097381
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30C2D1956050;
	Thu, 22 Jan 2026 15:56:21 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.47])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8AA81800240;
	Thu, 22 Jan 2026 15:56:17 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v5 12/15] verification/rvgen: Add support for per-obj monitors
Date: Thu, 22 Jan 2026 16:54:57 +0100
Message-ID: <20260122155500.362683-13-gmonaco@redhat.com>
In-Reply-To: <20260122155500.362683-1-gmonaco@redhat.com>
References: <20260122155500.362683-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The special per-object monitor type was just introduced in RV, this
requires the user to define some functions and type specific to the
object.

Adapt rvgen to add stub definitions for the monitor_target type and
other modifications required to create per-object monitors.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V3:
    * Add _is_id_monitor() in dot2k to handle per-obj together with per-task

 tools/verification/rvgen/rvgen/automata.py  |  1 +
 tools/verification/rvgen/rvgen/dot2k.py     | 17 +++++++++++++----
 tools/verification/rvgen/rvgen/generator.py |  2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 252c9960ee1c..b7330044d4be 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -66,6 +66,7 @@ class Automata:
         self.events_start, self.events_start_run = self.__store_init_events()
         self.env_stored = sorted(self.env_stored)
         self.constraint_vars = sorted(self.constraint_vars)
+        self.self_loop_reset_events = sorted(self.self_loop_reset_events)
 
     def __get_model_name(self) -> str:
         basename = ntpath.basename(self.__dot_path)
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index e72369ec1ad7..42111b477847 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -27,6 +27,8 @@ class dot2k(Monitor, Dot2c):
     def fill_monitor_type(self) -> str:
         buff = [ self.monitor_type.upper() ]
         buff += self._fill_timer_type()
+        if self.monitor_type == "per_obj":
+            buff.append("typedef /* XXX: define the target type */ *monitor_target;")
         return "\n".join(buff)
 
     def fill_tracepoint_handlers_skel(self) -> str:
@@ -45,6 +47,10 @@ class dot2k(Monitor, Dot2c):
             if self.monitor_type == "per_task":
                 buff.append("\tstruct task_struct *p = /* XXX: how do I get p? */;");
                 buff.append("\tda_%s(p, %s%s);" % (handle, event, self.enum_suffix));
+            elif self.monitor_type == "per_obj":
+                buff.append("\tint id = /* XXX: how do I get the id? */;");
+                buff.append("\tmonitor_target t = /* XXX: how do I get t? */;");
+                buff.append("\tda_%s(id, t, %s%s);" % (handle, event, self.enum_suffix));
             else:
                 buff.append("\tda_%s(%s%s);" % (handle, event, self.enum_suffix));
             buff.append("}")
@@ -92,13 +98,16 @@ class dot2k(Monitor, Dot2c):
 
         return '\n'.join(buff)
 
+    def _is_id_monitor(self) -> bool:
+        return self.monitor_type in ("per_task", "per_obj")
+
     def fill_monitor_class_type(self) -> str:
-        if self.monitor_type == "per_task":
+        if self._is_id_monitor():
             return "DA_MON_EVENTS_ID"
         return "DA_MON_EVENTS_IMPLICIT"
 
     def fill_monitor_class(self) -> str:
-        if self.monitor_type == "per_task":
+        if self._is_id_monitor():
             return "da_monitor_id"
         return "da_monitor"
 
@@ -122,7 +131,7 @@ class dot2k(Monitor, Dot2c):
                 }
         tp_args_id = ("int ", "id")
         tp_args = tp_args_dict[tp_type]
-        if self.monitor_type == "per_task":
+        if self._is_id_monitor():
             tp_args.insert(0, tp_args_id)
         tp_proto_c = ", ".join([a+b for a,b in tp_args])
         tp_args_c = ", ".join([b for a,b in tp_args])
@@ -169,7 +178,7 @@ class ha2k(dot2k):
         self.__parse_constraints()
 
     def fill_monitor_class_type(self) -> str:
-        if self.monitor_type == "per_task":
+        if self._is_id_monitor():
             return "HA_MON_EVENTS_ID"
         return "HA_MON_EVENTS_IMPLICIT"
 
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index b80af3fd6701..5eac12e110dc 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -243,7 +243,7 @@ obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o
 
 
 class Monitor(RVGenerator):
-    monitor_types = { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
+    monitor_types = { "global" : 1, "per_cpu" : 2, "per_task" : 3, "per_obj" : 4 }
 
     def __init__(self, extra_params={}):
         super().__init__(extra_params)
-- 
2.52.0

