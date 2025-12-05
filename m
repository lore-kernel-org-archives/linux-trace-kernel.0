Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F8232FA17
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764940676; cv=none; b=RhWkxOy7MENiLmyFJmIBgat5/IgJ1fWExrUd8jcJ3ykcwNqSUT/77B1DJ1A6RLjuvbk3GawlGxbVJzFCHceQckmIaGVC/T6LU3QZp9wfZp9tRVA33PcTWl3PQbX3io8c+bFPzy4FWE/gWAhtEVM27HZp98V/pBE+7DL7jFQIGdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764940676; c=relaxed/simple;
	bh=BjyFbWOLnAMDRRTwhFDhqlbnNvzF0hdM49UKapjXlbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJn1lecYBa5gUdc0TQh+T4wkbzTCR5l7v++13LE2w19psqCSI7JCSd11Fd9AvVuHMXrW9XkP40uc6hPt64tNGgKYMFfLQyfzMQ5KxB5GSmu8foJ/nfLeQZ/X7EHGTxFjDNIsdYxRVcisIh0chBMLbOoOwU0DxTfPhZCMQESV05s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MhLaKYtJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhLaKYtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764940668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAoPUIzAik8RD9AhaF+rfLnULWVNshaDs6FrjHeeJZM=;
	b=MhLaKYtJnRx5shaDqzMiI4rwaO1lJAveTaH8GukZ4DY4tYzhVxZ9jA+SmZWdeOYawiyGz+
	Rv6mu4kIp9HU6cKxZSg1AdMgR8IptJEuVwKGpIKgS+mS+VTRjSMXF3T46EUmKcd9B02u3f
	wn8YfEXGuWdWeUhsVI7QrtUNenMeNY8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-iUv49K3YOrCXth5IBRTioA-1; Fri,
 05 Dec 2025 08:17:43 -0500
X-MC-Unique: iUv49K3YOrCXth5IBRTioA-1
X-Mimecast-MFC-AGG-ID: iUv49K3YOrCXth5IBRTioA_1764940663
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFF1E18002DE;
	Fri,  5 Dec 2025 13:17:42 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2796D180029B;
	Fri,  5 Dec 2025 13:17:38 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 11/13] verification/rvgen: Add support for per-obj monitors
Date: Fri,  5 Dec 2025 14:16:19 +0100
Message-ID: <20251205131621.135513-12-gmonaco@redhat.com>
In-Reply-To: <20251205131621.135513-1-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
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

 tools/verification/rvgen/rvgen/dot2k.py     | 17 +++++++++++++----
 tools/verification/rvgen/rvgen/generator.py |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

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

