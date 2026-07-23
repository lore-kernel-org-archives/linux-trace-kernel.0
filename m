Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAE3233938
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792786; cv=none; b=WfxY1/a/1zTHM4piVpOiKWlpEywkO0wY7UWZGhR0sKzJ+G1BVmUblbBLKqy7032RaUENU6HCPuESdmmFK0RRPs1pM/YDntq2gduXm0sjY0D89pvvHiMW+loTClvOAXvb1ZRjoe4t4jd73gtZCD4gWN+KLzYnjH5RxPsSPsLNJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792786; c=relaxed/simple;
	bh=DGm9ZkHsAWX41PM618xr+/oZsh5ML37hVD3X1R8WMHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bSNgmb8jXrKujfCwcUsQgZ0YoY36Vj1W70Dh8Ykj8lLRygt2Gcitx69TO8wOLHbefplqXwvbAcHRDTblIreAzpUhGuJl0CkldZbzhsepcU6jIRYaTTdM3ycVNhgaCUxx9R6RQAS2I1x3XAw90D4PvBx/ROunnOjbf1iPfAz4Seg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeEVsvB8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeEVsvB8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784792780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uljRcLJYDvn4XROMEV+Mu/AmUKGVI0WCPtBXywCVYgA=;
	b=ZeEVsvB8/xHrTvERljghdCq8xMn0u+gXN7/lW+UaVHhOsRYZGLApQhOv0FO7K88ITWF85u
	WGSh+NxF0POtYuCu4ctk79H0X8Vec9ZWd5vjDvGGI9Hpo21AeeR4AaKpLCr5WLcYDpi/cB
	3IuyvuG/t6/QnC2YcdHgO50pxRlS/3I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-mHRZLjQwO5mHrgXwTnpJWQ-1; Thu,
 23 Jul 2026 03:46:16 -0400
X-MC-Unique: mHRZLjQwO5mHrgXwTnpJWQ-1
X-Mimecast-MFC-AGG-ID: mHRZLjQwO5mHrgXwTnpJWQ_1784792775
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1952319540DD;
	Thu, 23 Jul 2026 07:46:15 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AEF418002B4;
	Thu, 23 Jul 2026 07:46:11 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 04/17] verification/rvgen: Use pathlib instead of os.path
Date: Thu, 23 Jul 2026 09:45:21 +0200
Message-ID: <20260723074534.43521-5-gmonaco@redhat.com>
In-Reply-To: <20260723074534.43521-1-gmonaco@redhat.com>
References: <20260723074534.43521-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: QQD0agnxs2dCWDG5nPzM7w9aNqefsaMlw56qzavB_yE_1784792775
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Migrate to the newer patlib library, bundled with python since 3.4 to
increase readability over using os.path.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/generator.py | 22 +++++++++------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 1c20f7d1905c..f1b37d34b1e9 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -6,7 +6,6 @@
 # Abstract class for generating kernel runtime verification monitors from specification file
 
 import platform
-import os
 from pathlib import Path
 
 
@@ -17,7 +16,7 @@ class RVGenerator:
         self.name = extra_params.get("model_name")
         self.parent = extra_params.get("parent")
         self.abs_template_dir = \
-            os.path.join(os.path.dirname(__file__), "templates", self.template_dir)
+            Path(__file__).resolve().parent / "templates" / self.template_dir
         self.main_c = self._read_template_file("main.c")
         self.kconfig = self._read_template_file("Kconfig")
         self.description = extra_params.get("description", self.name) or "auto-generated"
@@ -60,12 +59,12 @@ class RVGenerator:
 
     def _read_template_file(self, file):
         try:
-            path = os.path.join(self.abs_template_dir, file)
+            path = self.abs_template_dir / file
             return self._read_file(path)
         except OSError:
             # Specific template file not found. Try the generic template file in the template/
             # directory, which is one level up
-            path = os.path.join(self.abs_template_dir, "..", file)
+            path = self.abs_template_dir.parent / file
             return self._read_file(path)
 
     def fill_parent(self):
@@ -136,7 +135,7 @@ class RVGenerator:
 
     def _patch_file(self, file, marker, line):
         assert self.auto_patch
-        file_to_patch = os.path.join(self.rv_dir, file)
+        file_to_patch = Path(self.rv_dir) / file
         content = self._read_file(file_to_patch)
         content = content.replace(marker, line + "\n" + marker)
         self.__write_file(file_to_patch, content)
@@ -190,22 +189,19 @@ obj-$(CONFIG_RV_MON_{name_up}) += monitors/{name}/{name}.o
         return f"  - Move {self.name}/ to the kernel's monitor directory ({self.rv_dir}/monitors)"
 
     def __create_directory(self):
-        path = self.name
+        path = Path(self.name)
         if self.auto_patch:
-            path = os.path.join(self.rv_dir, "monitors", path)
-        try:
-            os.mkdir(path)
-        except FileExistsError:
-            return
+            path = Path(self.rv_dir) / "monitors" / path
+        path.mkdir(exist_ok=True)
 
     def __write_file(self, file_name, content):
         with open(file_name, 'w') as file:
             file.write(content)
 
     def _create_file(self, file_name, content):
-        path = f"{self.name}/{file_name}"
+        path = Path(self.name) / file_name
         if self.auto_patch:
-            path = os.path.join(self.rv_dir, "monitors", path)
+            path = Path(self.rv_dir) / "monitors" / self.name / file_name
         self.__write_file(path, content)
 
     def print_files(self):
-- 
2.55.0

