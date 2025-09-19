Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2662E3195F4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291124; cv=none; b=rg/VZAeagcVnO08cjLouEXIJ64lsUQnTsIK4Cv16d/Mmwu0lgllQZ68OrxU5cXUEpkD+9fpZSi6I8UOsbPJO14PVE6Z2gN/mrXp2gpVmeeq4hvRGENVevJlsv7BbTwGozWAy5jSXZWPcH13GUfsus8TU3kI9zqfpk6FNT+UWwNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291124; c=relaxed/simple;
	bh=UnlmkwHq9wdqXd/ylMaJgsY/prPvQTVCELQgh3Wx0oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnMkItKO3Tq8QL3ozBxsEmSYVJ6ieeoqc8XavcNrBKwbyO6bMUqFIF0gFERO0ufIxSCDWdeeawaZBTTAJpxMF7FL9sFkPuGh4NRN7EzK6Pjaz7F6wt4KJA20vep2mRBLn1hVO7Gatvx7Zs+COQkF4qhhczSNQv6tA+bODd8smM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MI0RFjI6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MI0RFjI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjIy4+nvM4KC0gKC5lRHqvF5pGSQy5/g+nkLInNuoVw=;
	b=MI0RFjI62ZZrYnWB1ZTlrwTVPE//ZE7tt+XrvRxD5qNvt5Kp6S9Z/oR7su4ymSL6ZRA+Qx
	aIghvHtTT3/xM8Qaba/hC1FFgRk7P7qt/yf4hbi8ZpytdICGz+PjEIoaSorN+pRtYRlRGS
	iZ2C3b86XBTwaPO/Sqsnz/5GANoVCeo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-pFu-6ofQN9CFERQd07GrfA-1; Fri,
 19 Sep 2025 10:11:58 -0400
X-MC-Unique: pFu-6ofQN9CFERQd07GrfA-1
X-Mimecast-MFC-AGG-ID: pFu-6ofQN9CFERQd07GrfA_1758291118
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2A12195605A;
	Fri, 19 Sep 2025 14:11:57 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4B2A1956045;
	Fri, 19 Sep 2025 14:11:53 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v2 19/20] verification/rvgen: Add support for per-obj monitors
Date: Fri, 19 Sep 2025 16:09:53 +0200
Message-ID: <20250919140954.104920-20-gmonaco@redhat.com>
In-Reply-To: <20250919140954.104920-1-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The special per-object monitor type was just introduced in RV, this
requires the user to define some functions and type specific to the
object.

Adapt rvgen to add stub definitions for the monitor_target type, the
da_get_id() function and other modifications required to create
per-object monitors.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2k.py     | 6 ++++++
 tools/verification/rvgen/rvgen/generator.py | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index 627efaec3a59..fe05bdc09861 100644
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
2.51.0

