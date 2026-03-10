Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086D6385524
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Mar 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140298; cv=none; b=lOBRdRF1WummGx9bqwHRsYLE55fikQXwtScFL7+q7BEQJ2CTKmdZyezDH57AOaPHpKhiANOniS5QcOqWTvE7OYwprsgxBPNcOWTxVlIcrHl0mWBcqu+upORowkBLltsXbMIZrn8bOOJ5MQOxZHlIZs1QtydAOG0V8gpOe5xvx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140298; c=relaxed/simple;
	bh=+BNtM9cqks5RwxZ+HvUjev6k5JA9FqBq5v82v3EpIV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FSq9CLz7V9nAoOS28+CmCY3mmDf/gLhgWv1osK8VBo6DcVkIer0D5AzMgu1ksfeDmW14HU1cXbRZ6j9lmKP3C2SF5eKejo3L2SdfSbTJd1eGGibi9FJtMxFSWFwqY8Mub/L6aN8ukE0CCuTn1/bIhfk4h+JHk0F2pr5JjVMRtQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVne9vv0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVne9vv0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773140296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbSAGnWv/4e/2vpP8YjNDv3hNfpRji8+tUptdjIeyDc=;
	b=gVne9vv0TayEqVuv/H4kvja38pPXKJXqFpmNljAgOx/FJXM7CzmMjFL+U20Tg51CaemKW6
	57yCr/8Cvpd1JsV66o1iq/FKWvLBv2DZdmttPfcZu77bIMNWkxKi9sj1Hqx2cW26dPzTE0
	cr3lei04WbQT8744mnS3eLjpZogfKJY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-Mbz2TsVOMWCLOqY1Hz98BA-1; Tue,
 10 Mar 2026 06:58:13 -0400
X-MC-Unique: Mbz2TsVOMWCLOqY1Hz98BA-1
X-Mimecast-MFC-AGG-ID: Mbz2TsVOMWCLOqY1Hz98BA_1773140292
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F16D419560B7;
	Tue, 10 Mar 2026 10:58:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.35.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C43DE1800759;
	Tue, 10 Mar 2026 10:58:07 +0000 (UTC)
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
Subject: [PATCH v7 11/15] verification/rvgen: Add support for per-obj monitors
Date: Tue, 10 Mar 2026 11:56:23 +0100
Message-ID: <20260310105627.332044-12-gmonaco@redhat.com>
In-Reply-To: <20260310105627.332044-1-gmonaco@redhat.com>
References: <20260310105627.332044-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: mkWNoDsOt9BVzWLPixFVohjcyYnjWvRZxjlFUb27NM0_1773140292
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The special per-object monitor type was just introduced in RV, this
requires the user to define some functions and type specific to the
object.

Adapt rvgen to add stub definitions for the monitor_target type and
other modifications required to create per-object monitors.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V6:
    * Use f-strings in newly added code and cleanup
    V3:
    * Add _is_id_monitor() in dot2k to handle per-obj together with per-task

 tools/verification/rvgen/rvgen/dot2k.py     | 17 +++++++++++++----
 tools/verification/rvgen/rvgen/generator.py |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index 3cdc8cfb6be5..e7ba68a54c1f 100644
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
+                buff.append("\tint id = /* XXX: how do I get the id? */;")
+                buff.append("\tmonitor_target t = /* XXX: how do I get t? */;")
+                buff.append(f"\tda_{handle}(id, t, {event}{self.enum_suffix});")
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
2.53.0

