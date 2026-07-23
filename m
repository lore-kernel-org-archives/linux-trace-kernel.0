Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0BD2EEE69
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792779; cv=none; b=hV0sFrSGNl2BabGk63Ptfr+VEe9kQUxKZNyfE5Mau4GR6oAgfIIFdRYbtPu1aARPearrpXwbRzChcZvSll1LQrHpiA4mpd5A07vvEmtBCF78PV7Iw5Hdq+bZ3pv+TlDk8WIz//T8tAmA19NkSiVhGL2pJnLhgfIrHV0GuVlan3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792779; c=relaxed/simple;
	bh=Cum0QqU8Sg1+ObZ8D8XOaDmDfbRlz/6RuQyxIG8Mgdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kbSmNyhHtpaHkENiRF+9ih2iKBQqzGfZhhFJWeRSQjIawVXIlceEU99xhNQGZ50+ymxlrBk0uMBg6/+NOh5Yyxjkba8CrCcWtSPPFQrkl67sXp/dgmV5UlCCWWmCcWopgQhWLyS67s2xzHM5DXDr+mUvnHKRpYMdm+uo8LOC7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETdwqqb4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETdwqqb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784792777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ju7llNIicTz9FkVPfQxMT1c3/C73QaL40X9t/IZ06cI=;
	b=ETdwqqb44jteQm+Eofc8H3ybUte6ZppTasY15bxJXsMOVlx6zBVjX7EcuFYnAexvgFQwrW
	8rj9HZBU03o882s2q+hXvm+EZd+3YNCd3L6MWEUtq1SldTqg0lrlwFCK3+Rr8vw366Jcts
	gsit0Q3PDKoGcxUENFLcj2gUJ5qHfR8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-BITVSBFsP3SSTi2mQGxlQA-1; Thu,
 23 Jul 2026 03:46:12 -0400
X-MC-Unique: BITVSBFsP3SSTi2mQGxlQA-1
X-Mimecast-MFC-AGG-ID: BITVSBFsP3SSTi2mQGxlQA_1784792771
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A6F31805F20;
	Thu, 23 Jul 2026 07:46:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB32318002B5;
	Thu, 23 Jul 2026 07:46:07 +0000 (UTC)
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
Subject: [PATCH v5 03/17] verification/rvgen: Improve rv_dir discovery in RVGenerator
Date: Thu, 23 Jul 2026 09:45:20 +0200
Message-ID: <20260723074534.43521-4-gmonaco@redhat.com>
In-Reply-To: <20260723074534.43521-1-gmonaco@redhat.com>
References: <20260723074534.43521-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: N3ElTNl6VBl1aMxbQDkB0fnePQx4HVk_rbwuVkM0TOw_1784792771
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The RVGenerator class can find the RV directory (kernel/trace/rv) in the
kernel tree to do some auto patching. This works by assuming PWD is
either the kernel tree or tools/verification, which isn't always the
case (e.g. when running from selftests).

Make discovery more robust by relying on the absolute path of the
current script and traversing backwards the right number of times.
This should work from any location if rvgen is in the kernel tree.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V4:
    * Use pathlib's parents array to climb up directories

 tools/verification/rvgen/rvgen/generator.py | 29 ++++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 56f3bd8db850..1c20f7d1905c 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -7,6 +7,7 @@
 
 import platform
 import os
+from pathlib import Path
 
 
 class RVGenerator:
@@ -25,27 +26,29 @@ class RVGenerator:
             self.__fill_rv_kernel_dir()
 
     def __fill_rv_kernel_dir(self):
-
-        # first try if we are running in the kernel tree root
-        if os.path.exists(self.rv_dir):
-            return
-
-        # offset if we are running inside the kernel tree from verification/dot2
-        kernel_path = os.path.join("../..", self.rv_dir)
-
-        if os.path.exists(kernel_path):
-            self.rv_dir = kernel_path
+        # find the kernel tree root relative to this file's location
+        resolved_path = Path(__file__).resolve()
+        if len(resolved_path.parents) > 4:
+            kernel_root = resolved_path.parents[4]
+            kernel_path = kernel_root / self.rv_dir
+
+            if kernel_path.exists():
+                self.rv_dir = str(kernel_path)
+                return
+
+        # best effort if rvgen is installed and we are at the root of a kernel tree
+        if Path(self.rv_dir).exists():
             return
 
         if platform.system() != "Linux":
             raise OSError("I can only run on Linux.")
 
-        kernel_path = os.path.join(f"/lib/modules/{platform.release()}/build", self.rv_dir)
+        kernel_path = Path(f"/lib/modules/{platform.release()}/build") / self.rv_dir
 
         # if the current kernel is from a distro this may not be a full kernel tree
         # verify that one of the files we are going to modify is available
-        if os.path.exists(os.path.join(kernel_path, "rv_trace.h")):
-            self.rv_dir = kernel_path
+        if (kernel_path / "rv_trace.h").exists():
+            self.rv_dir = str(kernel_path)
             return
 
         raise FileNotFoundError("Could not find the rv directory, do you have the kernel source installed?")
-- 
2.55.0

