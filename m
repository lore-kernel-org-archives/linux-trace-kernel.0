Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9455421F0A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217003; cv=none; b=tBJ4M/4RGTSUYiN9fOu24/yt9nVtiBTCWHoGOUr+9hkIzVs5o+n2qmWAC+TsuEXRWhei1cJcZnMcDmuByQUZj8poONDgCASSw8Psf9dtgBvk9P+MBblfOpR5+2PWdLzHhJ6qrSrPKZ1ccSb3OudVu5V/MK7wG2qXkUuqwylh/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217003; c=relaxed/simple;
	bh=DV+ljg4jPxQHDu6W3jpHwJ/SKvcrfpAyqxkIxDbiEGs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=nhkEjjMRkIiWE/fI2bzbWg6mT/3R7qd5LSPmwO8c21t492CA/rLgmKiIM93rQZE1Ia3CFo0WsMleYh50Uv/VSd5bO1BgL6k3wSJwYfVIlrVSfqvHr1uD2WUCsQz5UOAwYRJjOV9znIdMewQsog0cezWf3RJUMk5OkLlkcseVu1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZ4/yhye; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZ4/yhye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770217001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJYUJUBqACQiwbA6NS0AnI6UANj6h3zKYhThJ+2C8VI=;
	b=IZ4/yhye0WXcOYWJ9LtJVfWRxvq5U1fC/ShP/nP0tY3ObsfBicxepJ5qD3fmw6wEVMYu2Y
	xHN+ss4VC2HF7MPmj9qxQwXG0vMHRTmf5nEMiuw+y0NDaBBJ+imigd6cifw4lrcJUgDwUl
	5+EciHBl7GYoY0xgI2DfELB4STFjcZU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-CnhVrsWUMGWkAUZqzA5XXQ-1; Wed,
 04 Feb 2026 09:56:35 -0500
X-MC-Unique: CnhVrsWUMGWkAUZqzA5XXQ-1
X-Mimecast-MFC-AGG-ID: CnhVrsWUMGWkAUZqzA5XXQ_1770216994
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEAF6180034D;
	Wed,  4 Feb 2026 14:56:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 482D030001A5;
	Wed,  4 Feb 2026 14:56:32 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 20/20] rv/rvgen: add missing return type annotations
Date: Wed,  4 Feb 2026 11:42:46 -0300
Message-ID: <20260204144914.104028-21-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: kp1udZENzrCxeX_OOWddHNofSBFoPlwPFxvVJVLRk1c_1770216994
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add missing `-> str` return type annotations to code generation
methods in RVGenerator. These methods return strings, and the missing
hints caused errors with static analysis tools.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/generator.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index ef6c9150f50c6..4b984869a7b3d 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -73,13 +73,13 @@ class RVGenerator:
             return f"#include <monitors/{self.parent}/{self.parent}.h>\n"
         return ""
 
-    def fill_tracepoint_handlers_skel(self):
+    def fill_tracepoint_handlers_skel(self) -> str:
         return "NotImplemented"
 
-    def fill_tracepoint_attach_probe(self):
+    def fill_tracepoint_attach_probe(self) -> str:
         return "NotImplemented"
 
-    def fill_tracepoint_detach_helper(self):
+    def fill_tracepoint_detach_helper(self) -> str:
         return "NotImplemented"
 
     def fill_main_c(self):
@@ -100,19 +100,19 @@ class RVGenerator:
 
         return main_c
 
-    def fill_model_h(self):
+    def fill_model_h(self) -> str:
         return "NotImplemented"
 
-    def fill_monitor_class_type(self):
+    def fill_monitor_class_type(self) -> str:
         return "NotImplemented"
 
-    def fill_monitor_class(self):
+    def fill_monitor_class(self) -> str:
         return "NotImplemented"
 
-    def fill_tracepoint_args_skel(self, tp_type):
+    def fill_tracepoint_args_skel(self, tp_type) -> str:
         return "NotImplemented"
 
-    def fill_monitor_deps(self):
+    def fill_monitor_deps(self) -> str:
         buff = []
         buff.append("	# XXX: add dependencies if there")
         if self.parent:
-- 
2.52.0

