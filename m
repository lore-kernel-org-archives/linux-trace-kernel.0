Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2A221577
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567239; cv=none; b=FWuZN9bKnrBTq8tDxFPsC1WXkyEtp1mCShz3NNsUH90+p6Ulkcs8erwnYt1MAEnUoZLFL6+y8NSZBacSNVQDPrg1whT/8uPGptgTDRPxu0N9BsnutfFaDQOHVkHlfCm6lvC710KAS9YjADXAr6hZjyqd6dXUZESYUhStFvk7MlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567239; c=relaxed/simple;
	bh=o4ZyPrixhb3phx1jWaDmhty4FCBLChbs9DxkVjYAEyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaG73JzEal3sKk2QmJoZkM5gUnBFqng3zkWIy3qzxnKlTSLFHVJN07KSqYBeSgoc5J2+M6etpR6xoSDZhZqm3WLEvA8egHEWZb7TivhtTd42BPvbwfpABXx7MuFbh2qwpP1Y23TnauHhRkIR2IX18YaLvFDq3/LclyZ3IgN/sOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlfzwOTj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlfzwOTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768567236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVJPHf+v4bSMqmOdHWhSOHt1sO3MsnSR9Rd2QqLLQ6s=;
	b=ZlfzwOTjQOSpZC1/iNpOkN4MUeC+JvihBraU5rFp9o4LskZ19aQHZNcvQlA/Yd2LQHvKFJ
	8dMhsZI3YCJhpdtLOIbBxPZaaisTl/8GY9GGSzDMAEr8uXr3J2h7Px6Y81Orjh9Z5g5qJL
	jW3pIhkR++elB+hXRpnT3uqhlt5I0h8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-wOkvMG4jNZOx9yoSvppDUg-1; Fri,
 16 Jan 2026 07:40:35 -0500
X-MC-Unique: wOkvMG4jNZOx9yoSvppDUg-1
X-Mimecast-MFC-AGG-ID: wOkvMG4jNZOx9yoSvppDUg_1768567234
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C2841800614;
	Fri, 16 Jan 2026 12:40:34 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C62EB1955F22;
	Fri, 16 Jan 2026 12:40:30 +0000 (UTC)
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
Subject: [PATCH v4 12/15] verification/rvgen: Add support for per-obj monitors
Date: Fri, 16 Jan 2026 13:39:08 +0100
Message-ID: <20260116123911.130300-13-gmonaco@redhat.com>
In-Reply-To: <20260116123911.130300-1-gmonaco@redhat.com>
References: <20260116123911.130300-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

