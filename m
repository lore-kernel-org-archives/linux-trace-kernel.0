Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4DC3B19CC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765905; cv=none; b=AoaZOYxavhC46m2wh0wpZxmGcKHbzaQ8V5tWmOcB7NXf6GiX3UTvO91k25nDgCcuApUTSRP+BTMJMXL+Cyc643/wu+j4wZAXY8Da1fGL5XK/kzL1SPYtSTBOJon9QC6rUWBDdF5GjVNYgIo8gbSWb4C3PKaHzvpzMvxCPJ3dfb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765905; c=relaxed/simple;
	bh=yfBmJxKFE2B8sFZRFT6pz/Bmzuj/HOGPpJ9ua1lUQAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=gXZ6KsEEF5iubu9VuZRYOR10tkx3elJxcKBOfbyNWMoXa8XeOImeQc9B/95ukdAc2S6EktkCwgYze/7N3ROlSJUSKPN6Bsrb8FDuanu2qJgs1gPoAPGi0W7Tin1C6mJGS0fkmjdpKpR/P6xsihlPN2O32wJo2vzKMXa8cEJvY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrIjtzy5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrIjtzy5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776765902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gLpMq3bvSknPmfM0Vr8rolbKX4splOg+Lf8VMaqkFw8=;
	b=JrIjtzy58tWNx8iH81oKU8Bw3VJN4enT299DywL4BRUfaG9n18N8CzJ+jBbv4SLLByrN9c
	mi9wD/G5YsUcaxa48xsOLhpyTahc/H6Mh7irixeoGsmSNXkf4N1DOsE5qBo92ZaWS+w6+6
	33queT2e5zCsanDlurydNDxy3SX3MO8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-putkV_2gPyiao6H0nilvQA-1; Tue, 21 Apr 2026 06:05:01 -0400
X-MC-Unique: putkV_2gPyiao6H0nilvQA-1
X-Mimecast-MFC-AGG-ID: putkV_2gPyiao6H0nilvQA_1776765900
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488be33b7a6so28911925e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 03:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776765900; x=1777370700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLpMq3bvSknPmfM0Vr8rolbKX4splOg+Lf8VMaqkFw8=;
        b=cJfC3st3hf8BzyMh4M7plRc7hFOJI1t+tv+s+e50JY7p2AACQypAlEa1F939kMmF3n
         7rx219swIEtt4HQVNuZx4XaoiXs2886HZAsA5Jbr9jyOXJr9bh8Buad0r3vRwuWTwN38
         NO70zjN2v/UqMUzJzxaipT5pDihEJcqtHfZ7tqPZ847isMaoJEneo5ra5TFnHyI8lgKT
         yfhgA7FDE2J2Kwuvbs+zWj7xXFfSDdFcJeLCsDmHlGwmthJ7hbjAj4y5KbWh0YOB6di4
         cDiKqynPFK0WRW27RYh+aqvjmR8TJqt06yUtD4Dr2SD9HyLOs8+G8421UGY153FFLF0Z
         OxEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NKW9FnojLnZBYrdrLPp8FfCC1pJfWPcQipTBaCOkGnPkOv2SWOvfRFGqbaPS+4GWHfVenmdvFPKthj+45c11MkME=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8SVJurAAR4n0julVdpM5m22wI+uqZBK3OSWY+tk7kWYvOIzT
	xUtVUpqqoLPHrkJX7I0jeptKBW3lp26K0SOl/V78yMVe31vACdjtYlI485KypvpTOBOnwYpX6je
	qijBBe3UdDx6BpgrlYvBtSrQ6uxRjBFYwWsInggSvou8L51IkMG5Kckf3Vul1oYPKt7iJLe5DiA
	==
X-Gm-Gg: AeBDievKhUfIKZ8hzbQq1G77dVLubJvrVDHzfLHYDgGETAyPDgKqHPrPnlFH1PO/vhB
	oafzqlknXeNuRX8J7lCdQxvmwmSZ8TUcmsEwz6HFk46uro8MQM7tHSJ3xju87hDUqmABC+zRTNe
	G5VF5/qKfwHS32vZeLgO9bc67KPd1N5pY2XtA1t5AzMvbP5v1OzeYRA6oxmVuaa+icPhPg8hFB4
	BCfJ3nhk/dRbkpSF/0nTGwCkdiPhMAto1CEtWQ+8G7dSLM8TDNfT8EblYqUPibMcpa0nBIOII5o
	b2lPwQB/oqZaLyKa+QpQ3+zuw0ncedgXZAlszg+3gWtY1phgGyrSIHsKFBjE8RAk0NyM6qh7bYv
	2uOnoUSXvJ5zwe2QX/81G4MEm46hrOqXM2kxsb9TyZSWy9zJ55htJmQ/6Chf2woSuRyMFMFUcmt
	G29mPFSTV4Czs0YlH9AUkQziHZH+TQXmXPVb0=
X-Received: by 2002:a05:600c:a00c:b0:488:c51f:e04e with SMTP id 5b1f17b1804b1-488fb765e65mr233926785e9.13.1776765899879;
        Tue, 21 Apr 2026 03:04:59 -0700 (PDT)
X-Received: by 2002:a05:600c:a00c:b0:488:c51f:e04e with SMTP id 5b1f17b1804b1-488fb765e65mr233926275e9.13.1776765899402;
        Tue, 21 Apr 2026 03:04:59 -0700 (PDT)
Received: from [172.20.57.158] ([129.41.46.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm172202905e9.1.2026.04.21.03.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:04:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	rostedt@goodmis.org,
	Marc Zyngier <maz@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] kernel: trace: do not generate undefsyms_base.c
Date: Tue, 21 Apr 2026 11:04:55 +0100
Message-ID: <20260421100455.324333-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mtUHMH_aSsfV8Ip29QP0lgfWDio6Ysy13l3UPkE8FN8_1776765900
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The code to autogenerate undefsyms_base.c in the Makefile is larger
than the file itself.

Remove the "echo" indirection that creates the file, which keeps
the build system sane and makes it much easier to edit it if/when
new situations arrive.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 kernel/trace/.gitignore       |  1 -
 kernel/trace/Makefile         | 35 ++++-------------------------------
 kernel/trace/undefsyms_base.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 32 deletions(-)
 delete mode 100644 kernel/trace/.gitignore
 create mode 100644 kernel/trace/undefsyms_base.c

diff --git a/kernel/trace/.gitignore b/kernel/trace/.gitignore
deleted file mode 100644
index 6adbb09d6deb..000000000000
--- a/kernel/trace/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/undefsyms_base.c
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 4d4229e5eec4..1decdce8cbef 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -133,41 +133,14 @@ obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
 obj-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o
 obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
 
-#
 # simple_ring_buffer is used by the pKVM hypervisor which does not have access
 # to all kernel symbols. Fail the build if forbidden symbols are found.
-#
-# undefsyms_base generates a set of compiler and tooling-generated symbols that can
-# safely be ignored for simple_ring_buffer.
-#
-filechk_undefsyms_base = \
-	echo '$(pound)include <linux/atomic.h>'; \
-	echo '$(pound)include <linux/string.h>'; \
-	echo '$(pound)include <asm/page.h>'; \
-	echo 'static char page[PAGE_SIZE] __aligned(PAGE_SIZE);'; \
-	echo 'void undefsyms_base(void *p, int n);'; \
-	echo 'void undefsyms_base(void *p, int n) {'; \
-	echo '	char buffer[256] = { 0 };'; \
-	echo '	u32 u = 0;'; \
-	echo '	memset((char * volatile)page, 8, PAGE_SIZE);'; \
-	echo '	memset((char * volatile)buffer, 8, sizeof(buffer));'; \
-	echo '	memcpy((void * volatile)p, buffer, sizeof(buffer));'; \
-	echo '	cmpxchg((u32 * volatile)&u, 0, 8);'; \
-	echo '	WARN_ON(n == 0xdeadbeef);'; \
-	echo '}'
-
-$(obj)/undefsyms_base.c: FORCE
-	$(call filechk,undefsyms_base)
-
-clean-files += undefsyms_base.c
-
-$(obj)/undefsyms_base.o: $(obj)/undefsyms_base.c
 
+# Basic compiler and tooling-generated symbols that can safely be left
+# undefined. Ensure KASAN is enabled to avoid logic that may disable
+# FORTIFY_SOURCE when KASAN is not enabled. undefsyms_base.o does not
+# automatically get KASAN flags because it is not linked into vmlinux.
 targets += undefsyms_base.o
-
-# Ensure KASAN is enabled to avoid logic that may disable FORTIFY_SOURCE when
-# KASAN is not enabled. undefsyms_base.o does not automatically get KASAN flags
-# because it is not linked into vmlinux.
 KASAN_SANITIZE_undefsyms_base.o := y
 
 UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __x86_indirect_thunk \
diff --git a/kernel/trace/undefsyms_base.c b/kernel/trace/undefsyms_base.c
new file mode 100644
index 000000000000..e65baf58e6ff
--- /dev/null
+++ b/kernel/trace/undefsyms_base.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * simple_ring_buffer is used by the pKVM hypervisor which does not have access
+ * to all kernel symbols.  Whatever is undefined when compiling this file is
+ * compiler and tooling-generated symbols that can safely be ignored for
+ * simple_ring_buffer.
+ */
+
+#include <linux/atomic.h>
+#include <linux/string.h>
+#include <asm/page.h>
+
+void undefsyms_base(void *p, int n);
+
+static char page[PAGE_SIZE] __aligned(PAGE_SIZE);
+
+void undefsyms_base(void *p, int n)
+{
+	char buffer[256] = { 0 };
+
+	u32 u = 0;
+	memset((char * volatile)page, 8, PAGE_SIZE);
+	memset((char * volatile)buffer, 8, sizeof(buffer));
+	memcpy((void * volatile)p, buffer, sizeof(buffer));
+	cmpxchg((u32 * volatile)&u, 0, 8);
+	WARN_ON(n == 0xdeadbeef);
+}
-- 
2.53.0

