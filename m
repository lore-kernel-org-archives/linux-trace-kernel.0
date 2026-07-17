Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA9A36A004
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303243; cv=none; b=BmpE9/2aOmZFvFN13axA2AZbO1Z63BMTBmCOEe9YiMiM8bfnCs+a/GxAO19J98J14x8+X6k0viWVee+THXOwSOwD+uhjds9/Jnoa0CGpgAruLQw/0VW3h/NYFkzfZ8SmAMB/5J1iS/xA5fe6pQhCEb60GbU82BHnn7R+wWFz4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303243; c=relaxed/simple;
	bh=vLrv8hNmvzjz92qZ+ug+QLWnF4+wGp6/Tu3vG2FC8XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=YyguFULegTp3sbCjQNlLdJYYZLkwWL2yrun2Fq74usotdbSawAWFY5MR/G4mSLUnzzpZEcZYQ+/TF+ZKfLuyHbYA8aB2myzll3Vs3AsxgUhIHOzSo7DYzWpt+0r888jSyO5JUxOBLhKizGuIsqxOHPhrstG4YVpXHVgcYNlgLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnmDVZgl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnmDVZgl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784303241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LycfC4kXURBnas9ZVnfR5zxW1Nk3dgj0R6zCJp+NCU=;
	b=VnmDVZglo8ty0CTfPCp5ZJgZKLRiqJBHAibWAwPWYTltjgS5+maFlNup7WUa8AfCn3iaxV
	vqLrttqTf7G2Zl1hyPgp/NOXflgsszFIKDW+pxcN9s/tosmKj77x6jgslZz+9F0A2fezQm
	ST9r92HNLbnYML56c7HRH+GduX9pc3s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-c6nkmnBNP_q_Mx5YSFpaIQ-1; Fri,
 17 Jul 2026 11:47:17 -0400
X-MC-Unique: c6nkmnBNP_q_Mx5YSFpaIQ-1
X-Mimecast-MFC-AGG-ID: c6nkmnBNP_q_Mx5YSFpaIQ_1784303236
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E3F91800A33;
	Fri, 17 Jul 2026 15:47:16 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD4FC30040BF;
	Fri, 17 Jul 2026 15:47:13 +0000 (UTC)
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
Subject: [PATCH v4 04/17] verification/rvgen: Use pathlib instead of os.path
Date: Fri, 17 Jul 2026 17:46:25 +0200
Message-ID: <20260717154638.220789-5-gmonaco@redhat.com>
In-Reply-To: <20260717154638.220789-1-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: RNC6YSHimG6CpplU6WVlzm9a7VpVoGucCc3L93wfBes_1784303236
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Migrate to the newer patlib library, bundled with python since 3.4 to
increase readability over using os.path.

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

