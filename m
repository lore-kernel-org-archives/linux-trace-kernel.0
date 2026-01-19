Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FAE276050
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820418; cv=none; b=BrEigmM/3r0IfD/9sYJ75zoPsxV4qYnYChQZ+V/EWrxz8+zs9yxSqhWJ6Ta2MentUVFCnL139taLxa90nr7kaE1WOkCP/xa5HTEcENhrtsvxU3Sjfb1Y6NhcDKVZXbiXW+RO3pxMEj+b1AjkUQbG2aW+UTaC+GqT1bWPiffMuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820418; c=relaxed/simple;
	bh=C7LlKKxPaInK97dctAhIdjMR4Rk3uZG8IPeYUOu5kko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UJlMTTrj2OyBL9Ueae4aDCX/H/DqLtWA7pQU8sW2hW8R2/d5Edev23pneC5C+bsdkWTggPPhNvBu6jfrQEjIxaMrKOFEf3guD/ly/yGq2TFj60IGR9A2kj6xJ5IusreKegSxIHnute2LlHZkVTfeUq2XdjL2H04QswudMJtp8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ryjxkz4U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ryjxkz4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768820416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzmmta4c/LhOX/TptbSfeprx1BTimlzvuF68nBD+iX0=;
	b=Ryjxkz4UfJrTaoZOciRNqnt6WZszaMuFwnWoaMBBHMscrxQLm3USBPBcopillfzyQy3/XZ
	+AH6jjcn5MqYkItZ+P0dVYY28yKvPSwXmcNA4qZFZ2G7/nH2DPvnOcw9LUTbT5Zs9r7ijl
	DNKrRgi21u4V+r8RzYOK4VlKz0qu2rw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-2rAuu4upMQeHWeC5kU8iZw-1; Mon, 19 Jan 2026 06:00:14 -0500
X-MC-Unique: 2rAuu4upMQeHWeC5kU8iZw-1
X-Mimecast-MFC-AGG-ID: 2rAuu4upMQeHWeC5kU8iZw_1768820414
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47ed980309aso24000555e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 03:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768820413; x=1769425213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dzmmta4c/LhOX/TptbSfeprx1BTimlzvuF68nBD+iX0=;
        b=jkpxen2/3SKwWSS1xLKkNHKa/aMbybR6pBQMgbdc/ykGVd4TFJwY9pu4sT0YP5aElU
         r+PRGOYL5+1mHb6LHdIb+EF/z2/Z1RdcEH6oehnxBXEC2tbQ7QlSt0y1C++YEY7GGaAs
         YPtPyy//lq9nD+h6xgD196Hw93M83c9BKtSiPPx24TScefiMpNGE+eMob5RZ9+PHFhyd
         F+WILAgPmFmSfhlZM19vgkzbxSPUJfv9zJ9Ilo3WgIqk90fckpumVVk8VKsghwfcZ/zE
         bzq2VEk9wKP7sYUud2x1mgUaBngOHjSuYnQNyEe7ApKuEPoTrkufTMuZvfG9dkGFOk/E
         FZ3w==
X-Forwarded-Encrypted: i=1; AJvYcCXkll8xZ0aD8KJEVXAxTIRqZP+tk9KH/7sbSZxVmiF2ckaSfD8x91dsQ/hN1OX4vyJZNNXFhiA5yfuPFwnVnEXZ/CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+yvPW3dsG90rt8IdrYoKbRUaGcm/2NvH6Rnucvl2inpFs1B4
	jI0eAbUyQqIbjclNkguuzwuye0VTddv3XHUcfgJGlb6Nwo2sGWoUKqwKp/pXkfdaIHJfL86hXP9
	O1ptkrAei9rWT6q6Am+O4MIVkXV3kB6RYwDm8pn6/PMS5oFPrhlnhwDMxUiu2EU+fchf4sywfLw
	==
X-Gm-Gg: AY/fxX5NEjwXTVeGOrHOK+yQuctLZNhxeJWS1jx99LSWsFLBxWI06sipcL1MOQ+7e+p
	BjmpUg8qQrWoMWAZywizZNpT6C2/E023K9+t1kuy3rdaGzXNipaYfbfXuX0fVHtb2ZjsfqvAuoM
	HonZrVrvcJ6v8+eXXmsiJWiAzfAnWu4sTF3J31hAsbpx/O3NVVD4t/QOdERIXpGqsenpZjRKfhi
	VyRzo1JPDQ5KczMNsHYrnQi6NeumQG1XNzDFUh0eBFDntpNZLYjldR6bpQKzJK9d8G2+gLKm9YD
	+65meb+7B2fyO6T3wyYoMsccCOaafjJeOod7m9Tag7oftlsCFnJlGu+dzG3P8p2uhO/CPxYTigg
	OCZCMYHcy7/6Bt0Jgzrbr/A==
X-Received: by 2002:a05:600c:3785:b0:47e:e0b3:2437 with SMTP id 5b1f17b1804b1-47f428ae03cmr121552225e9.5.1768820413527;
        Mon, 19 Jan 2026 03:00:13 -0800 (PST)
X-Received: by 2002:a05:600c:3785:b0:47e:e0b3:2437 with SMTP id 5b1f17b1804b1-47f428ae03cmr121551855e9.5.1768820413000;
        Mon, 19 Jan 2026 03:00:13 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e23c:600:cadf:120:2b7f:a706])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569922032sm23320735f8f.8.2026.01.19.03.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:00:12 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Blake Jones <blakejones@google.com>,
	Yuzhuo Jing <yuzhuo@google.com>,
	Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] tools/build: Add feature test for libcheck
Date: Mon, 19 Jan 2026 12:58:56 +0200
Message-ID: <20260119105857.797498-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119105857.797498-1-costa.shul@redhat.com>
References: <20260119105857.797498-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2U8pOCUDeNT2eb1dyQqpQBs1oJPRpC0SeEUavoEcJqM_1768820414
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Enable support for unit tests in rtla.

Note that the pkg-config file for libcheck is named check.pc.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/build/Makefile.feature        | 3 +++
 tools/build/feature/Makefile        | 4 ++++
 tools/build/feature/test-libcheck.c | 8 ++++++++
 3 files changed, 15 insertions(+)
 create mode 100644 tools/build/feature/test-libcheck.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 362cf8f4a0a0..ec0b21207fab 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -115,6 +115,7 @@ FEATURE_TESTS_EXTRA :=                  \
          hello                          \
          libbabeltrace                  \
          libcapstone                    \
+         libcheck                       \
          libbfd-liberty                 \
          libbfd-liberty-z               \
          libopencsd                     \
@@ -175,6 +176,8 @@ ifneq ($(PKG_CONFIG),)
   $(foreach package,$(FEATURE_PKG_CONFIG),$(call feature_pkg_config,$(package)))
 endif
 
+FEATURE_CHECK_LDFLAGS-libcheck = -lcheck
+
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
 # mentioned in this list we need to refactor this ;-).
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0d5a15654b17..15d8cce9f52a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -50,6 +50,7 @@ FILES=                                          \
          test-timerfd.bin                       \
          test-libbabeltrace.bin                 \
          test-libcapstone.bin			\
+         test-libcheck.bin			\
          test-compile-32.bin                    \
          test-compile-x32.bin                   \
          test-zlib.bin                          \
@@ -306,6 +307,9 @@ $(OUTPUT)test-libbabeltrace.bin:
 $(OUTPUT)test-libcapstone.bin:
 	$(BUILD) # -lcapstone provided by $(FEATURE_CHECK_LDFLAGS-libcapstone)
 
+$(OUTPUT)test-libcheck.bin:
+	$(BUILD) # -lcheck is provided by $(FEATURE_CHECK_LDFLAGS-libcheck)
+
 $(OUTPUT)test-compile-32.bin:
 	$(CC) -m32 -Wall -Werror -o $@ test-compile.c
 
diff --git a/tools/build/feature/test-libcheck.c b/tools/build/feature/test-libcheck.c
new file mode 100644
index 000000000000..cfb8d452e9ef
--- /dev/null
+++ b/tools/build/feature/test-libcheck.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <check.h>
+
+int main(void)
+{
+	Suite *s = suite_create("test");
+	return s == 0;
+}
-- 
2.52.0

