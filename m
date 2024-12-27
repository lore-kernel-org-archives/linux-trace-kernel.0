Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391C31F5425
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310953; cv=none; b=Ezp31Z4TGO1iv/2jAy/EKLaP+aQsfNBreOqfKbpZVT2Gq71VVk9p0IYk36K1Ayy73AYL+NO0Tjr/JoUo+VrgtXzchz/Q7IU3HdzcqM723N8QTnFFv7A8gIHDfEIC0aXghy5AkqXMjemKLIW+hA6Ft2bTn6Oa9c931fFSvPnQcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310953; c=relaxed/simple;
	bh=qCUGPNeXrbxOPItOh8o5ANWkcP2aOtS8WqzbY70o8/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGD/Z70tqeDwyAL6GpLJ+stSLtQqgSIQYLKrghQc+bhhOPqRPLzt2ZNRQSow/GBiEuFfm5FmfnD7smva7CaAWwi1BsqQb8SxQkPSPNMpq+3/6PPHzpqm+TeHLK9mGxSWfW0gUvdv3mRhTVZ/FA8rk46i1R+C5yt72fFZnO2twcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtHsDOit; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtHsDOit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735310950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=peZKMn+y5rY6YVB5NBZ0l85jgt5NQ1bgoGjwNFZ0kMI=;
	b=gtHsDOitVHVSjqVdhys+zGl7oqjixDLsl2DnYBnhrq4sKe1l4QI1Wabbe7fpzoe4cCU+/i
	l7fI6Mc3BAXNO6gqHSmfMgg7bMu2dwrez7KJMelNh4CJO/1mCPc3uRY1azBWF2Khw2Rv39
	nnpv1lBnaQQpVqZUSY5QOwKIcbPG5n8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-rE1iFWykNmKuGFx5qeAWNg-1; Fri,
 27 Dec 2024 09:49:08 -0500
X-MC-Unique: rE1iFWykNmKuGFx5qeAWNg-1
X-Mimecast-MFC-AGG-ID: rE1iFWykNmKuGFx5qeAWNg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B2DB19560A3;
	Fri, 27 Dec 2024 14:49:07 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 755F33000197;
	Fri, 27 Dec 2024 14:49:04 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 1/8] verification/dot2k: Fix template directory detection
Date: Fri, 27 Dec 2024 15:47:45 +0100
Message-ID: <20241227144752.362911-2-gmonaco@redhat.com>
In-Reply-To: <20241227144752.362911-1-gmonaco@redhat.com>
References: <20241227144752.362911-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

dot2k can be run as installed (e.g. make install) or from the kernel
tree. In the former case it looks for templates in a known location; in
the latter, the PWD has to be `<linux>/tools/verification` to properly
import python modules. The current version looks for the template
in a wrong directory in this latter case.

This patch adjusts the directory where dot2k looks for templates if run
from the kernel tree (i.e. not installed).
Additionally we fix a few simple pylint warnings in boolean expressions.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/dot2/dot2k.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index 016550fccf1f2..f6d02e3406a32 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -14,14 +14,14 @@ import os
 
 class dot2k(Dot2c):
     monitor_types = { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
-    monitor_templates_dir = "dot2k/rv_templates/"
+    monitor_templates_dir = "dot2/dot2k_templates/"
     monitor_type = "per_cpu"
 
     def __init__(self, file_path, MonitorType):
         super().__init__(file_path)
 
         self.monitor_type = self.monitor_types.get(MonitorType)
-        if self.monitor_type == None:
+        if self.monitor_type is None:
             raise Exception("Unknown monitor type: %s" % MonitorType)
 
         self.monitor_type = MonitorType
@@ -31,7 +31,7 @@ class dot2k(Dot2c):
 
     def __fill_rv_templates_dir(self):
 
-        if os.path.exists(self.monitor_templates_dir) == True:
+        if os.path.exists(self.monitor_templates_dir):
             return
 
         if platform.system() != "Linux":
@@ -39,11 +39,11 @@ class dot2k(Dot2c):
 
         kernel_path = "/lib/modules/%s/build/tools/verification/dot2/dot2k_templates/" % (platform.release())
 
-        if os.path.exists(kernel_path) == True:
+        if os.path.exists(kernel_path):
             self.monitor_templates_dir = kernel_path
             return
 
-        if os.path.exists("/usr/share/dot2/dot2k_templates/") == True:
+        if os.path.exists("/usr/share/dot2/dot2k_templates/"):
             self.monitor_templates_dir = "/usr/share/dot2/dot2k_templates/"
             return
 
@@ -98,7 +98,7 @@ class dot2k(Dot2c):
     def fill_main_c(self):
         main_c = self.main_c
         min_type = self.get_minimun_type()
-        nr_events = self.events.__len__()
+        nr_events = len(self.events)
         tracepoint_handlers = self.fill_tracepoint_handlers_skel()
         tracepoint_attach = self.fill_tracepoint_attach_probe()
         tracepoint_detach = self.fill_tracepoint_detach_helper()
@@ -160,8 +160,8 @@ class dot2k(Dot2c):
 
     def __get_main_name(self):
         path = "%s/%s" % (self.name, "main.c")
-        if os.path.exists(path) == False:
-           return "main.c"
+        if not os.path.exists(path):
+            return "main.c"
         return "__main.c"
 
     def print_files(self):
-- 
2.47.1

