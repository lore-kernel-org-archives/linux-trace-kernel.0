Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA817F4EB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204161; cv=none; b=DDiwEvWRwjBUvJSC5PgNr9GZcB9zRiAroE82p//6TdNKM5pAb+RF5f1S+vCAzDGO4XSsuI599BtBGMhdJ+vTEmKRVkeQ4Qy9KTS7IT5gbe2JFrkwxTKLuIWjrLqg83ZwyrmZohOnvG1kNPPIhtkXMzMTQ2WWlvfCM6nb4k/8+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204161; c=relaxed/simple;
	bh=ajajUFoE4iRj8fvQD66lEvTBalCU4q4R+oGB47WiF9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nktaxYVUAf/vetOA9WNt9sJMwN2PcFuzNQEEE0I4KkuV07AwfUDC9OIqOFZvU3/tQ8SraZ/iYhQp5RzGlb5S30fCX2afHGGAWP+ykjRdWZW+ThclaEy3tvvGB26tK1HZAx3x7ETfKg5T5ILxAjJODOu4h6U7X65tzPkkpzyuXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TAUUoOaN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAUUoOaN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718204159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwCljioTH7fI0yuPGXTC32Cjw7d1FeSDSirSCWkDLho=;
	b=TAUUoOaNAApy2ec618QwowliOfryinXubgwL6jsa5XGlTtILg72X4TxU5OlAfzzc9MOTcA
	VBCe3nBpU1BQDsJj3oF02O+4Res2C1OTt39MBn48+A77XSVb66yxg17EQDbSWknWOnzhW+
	GmtLh/nnyIzYoousmjelgPUeiakybAE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-O0OCA3rtP2eszQJSmNDeqA-1; Wed,
 12 Jun 2024 10:55:55 -0400
X-MC-Unique: O0OCA3rtP2eszQJSmNDeqA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 046E91955E88;
	Wed, 12 Jun 2024 14:55:54 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.68])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C12811956087;
	Wed, 12 Jun 2024 14:55:51 +0000 (UTC)
From: tglozar@redhat.com
To: bristot@kernel.org,
	rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/5] rtla: Add dependency on libcpupower
Date: Wed, 12 Jun 2024 16:54:35 +0200
Message-ID: <20240612145439.206990-2-tglozar@redhat.com>
In-Reply-To: <20240612145439.206990-1-tglozar@redhat.com>
References: <20240612145439.206990-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Tomas Glozar <tglozar@redhat.com>

Add a test for libcpupower into feature tests and use it to add a
dependency on libcpupower to rtla.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/build/Makefile.feature           | 1 +
 tools/build/feature/Makefile           | 4 ++++
 tools/build/feature/test-libcpupower.c | 8 ++++++++
 tools/tracing/rtla/Makefile            | 2 ++
 tools/tracing/rtla/Makefile.config     | 9 +++++++++
 5 files changed, 24 insertions(+)
 create mode 100644 tools/build/feature/test-libcpupower.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 1e2ab148d5db..e4fb0a1fbddf 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -53,6 +53,7 @@ FEATURE_TESTS_BASIC :=                  \
         libslang-include-subdir         \
         libtraceevent                   \
         libtracefs                      \
+        libcpupower                     \
         libcrypto                       \
         libunwind                       \
         pthread-attr-setaffinity-np     \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index ed54cef450f5..c93d62afc1e8 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -38,6 +38,7 @@ FILES=                                          \
          test-libslang.bin                      \
          test-libslang-include-subdir.bin       \
          test-libtraceevent.bin                 \
+         test-libcpupower.bin                   \
          test-libtracefs.bin                    \
          test-libcrypto.bin                     \
          test-libunwind.bin                     \
@@ -212,6 +213,9 @@ $(OUTPUT)test-libslang-include-subdir.bin:
 $(OUTPUT)test-libtraceevent.bin:
 	$(BUILD) -ltraceevent
 
+$(OUTPUT)test-libcpupower.bin:
+	$(BUILD) -lcpupower
+
 $(OUTPUT)test-libtracefs.bin:
 	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtraceevent 2>/dev/null) -ltracefs
 
diff --git a/tools/build/feature/test-libcpupower.c b/tools/build/feature/test-libcpupower.c
new file mode 100644
index 000000000000..a346aa332a71
--- /dev/null
+++ b/tools/build/feature/test-libcpupower.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <cpuidle.h>
+
+int main(void)
+{
+	int rv = cpuidle_state_count(0);
+	return rv;
+}
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index b5878be36125..a6a7dee16622 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -32,8 +32,10 @@ DOCSRC		:= ../../../Documentation/tools/rtla/
 
 FEATURE_TESTS	:= libtraceevent
 FEATURE_TESTS	+= libtracefs
+FEATURE_TESTS	+= libcpupower
 FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
+FEATURE_DISPLAY	+= libcpupower
 
 ifeq ($(V),1)
   Q		=
diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
index 0b7ecfb30d19..8b6bc91e5dff 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -42,6 +42,15 @@ else
   $(info libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
 endif
 
+$(call feature_check,libcpupower)
+ifeq ($(feature-libcpupower), 1)
+  $(call detected,CONFIG_LIBCPUPOWER)
+  $(call lib_setup,cpupower)
+else
+  STOP_ERROR := 1
+  $(info libcpupower is missing. Please install libcpupower-dev/kernel-tools-libs-devel)
+endif
+
 ifeq ($(STOP_ERROR),1)
   $(error Please, check the errors above.)
 endif
-- 
2.43.0

