Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E7B3D954D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167265; cv=none; b=n9QxRFq9CtR9hdxcJ9nZcsL+ItkqTMO5zOPIF2pHfv00vJ+gBQa+tSDoB6jN4xhTpsdbVcLFHn+6qwWx5S2rGpoO3lpoENXaXUHd6PVzuGHVdX1UWTjw8JnUZW1RTOwr6nUUxtDsgJIKZAgy0qVf5QKq51uF1o+ybuv7lQRFIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167265; c=relaxed/simple;
	bh=9r5M4rIj4+hF+KtfQqrO2x8G++VULgRCMeD1ZgM3wHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Soxj000h8p9d+OsgGCx8ux8Z4Yjn7azOIzhDKbozcSWgiA7dWvxeqZ4+qdlp25fRmAYguApzVNQ50mjNj0Ivb3MRTx8G+job+741vVlM3VTgBm+riHDOSGzpyAkX/ouTAOzhYUjVKiv7EZVAPn4WsJHWUFJw2P1cqW8jtSrKCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqhk/oyZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqhk/oyZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KV/Vux23DHgPSLGlb27mR1UC4IHDhvUez5agcR2b54Q=;
	b=eqhk/oyZuNDKkyfQ0zmP++Rhr2bRVT5YbbIyqrTi5kxNkI0EAO0c2OF1Qdv3u5vkH6uko/
	A/ZF5dQ4Ayv8OIl01HfykXkOSzCPPSPwduK9gGoEnoVfQVBFvWbs3yG7tYYhVZyEqNCJoI
	HfIPDBROXnY0aBw/dfFfdHb/gQnZlIo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-Ia3uqnTqOHilvwHzV_fL7w-1; Mon,
 31 Aug 2026 05:07:37 -0400
X-MC-Unique: Ia3uqnTqOHilvwHzV_fL7w-1
X-Mimecast-MFC-AGG-ID: Ia3uqnTqOHilvwHzV_fL7w_1788167256
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77E6F1977536;
	Mon, 31 Aug 2026 09:07:36 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84EFD18005BB;
	Mon, 31 Aug 2026 09:07:33 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 10/20] tools/build: Add a feature test for bpftool-btf
Date: Mon, 31 Aug 2026 11:05:14 +0200
Message-ID: <20260831090524.106845-11-gmonaco@redhat.com>
In-Reply-To: <20260831090524.106845-1-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 8SQAobJyXU1Z_NdARrApDdfHEKgMM8duL8ebmJwe2KI_1788167256
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

RV can run bpf monitors and also build them, only the latter requires
the vmlinux.h from bpftool btf.

Add a feature so that RV can be built with BPF support without having to
build in-tree BPF monitors if not supported on the system.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/build/Makefile.feature | 1 +
 tools/build/feature/Makefile | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 99eb0ea09537..18e3a7ae893a 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -129,6 +129,7 @@ FEATURE_TESTS_EXTRA :=                  \
          libdebuginfod			\
          clang-bpf-co-re		\
          bpftool-skeletons		\
+         bpftool-btf			\
          libunwind			\
          libunwind-debug-frame		\
          $(foreach arch,$(LIBUNWIND_ARCHS),libunwind-$(arch) libunwind-debug-frame-$(arch))
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7d165018116a..2f01203dda5c 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -71,7 +71,8 @@ FILES=                                          \
          test-libpfm4.bin			\
          test-rust.bin				\
          test-libopenssl.bin			\
-         test-bpftool-skeletons.bin
+         test-bpftool-skeletons.bin		\
+         test-bpftool-btf.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -383,6 +384,10 @@ $(OUTPUT)test-bpftool-skeletons.bin:
 	{ $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons'; } \
 		> $(@:.bin=.make.output) 2>&1 && touch $@
 
+$(OUTPUT)test-bpftool-btf.bin:
+	$(SYSTEM_BPFTOOL) btf help \
+		> $(@:.bin=.make.output) 2>&1 && touch $@
+
 # Testing Rust is special: we don't compile anything, it's enough to check the
 # compiler presence. Compiling a test code for this purposes is problematic,
 # because Rust will emit a dependency file without any external references,
-- 
2.55.0

