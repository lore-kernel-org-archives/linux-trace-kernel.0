Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747AD26AA9B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890764; cv=none; b=QHqSMLCsJD1CrYQmZ5Z7X+5GbdqAUZ9IdMxJknmEMkn+khZ0F+OOZJ23a5KG411mdNUGv/KwQU50MkyLrNe+p4mzBiBS4T9UKhVIZ6SIRHN4gRF7ZHJiBpowbxxp6AZjE+iMZDXJRCPG5d8QWb8BcRjxxmMIxZYNDdRsWUxMLCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890764; c=relaxed/simple;
	bh=q+K7SBLdREUGN10PaqJHOWL0mSxjc+7OAFYDwtafJ6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0QSIg4l82omAb6Zx3l0avTsUhaXNR9f6Gs/j4S+NAFuH9zIZ1nIWBrmXUGF3fsFsKjmtBdVrFlZi/A35bivgHqj3hcETQEkGGCmJ9l90EHRLTlH3h80Ik6lGLSQoVyVp8URAmCvXciGybOO6Gq52tHDq+zBcaD34Lf/GaviJD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fG+Rdqat; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fG+Rdqat"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739890761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MutaJ1T8FiM2gmghpIEBv1pTnM22TWTUmbkc8yLx1Vw=;
	b=fG+RdqatqeDhOwppJ/Y3IlVaYIn9yxCB8gjOeG6hFPwUtzCVS186Z19D/4tQSRPQwYSa+o
	ILiDmyJukblZvuLXQ9X+CgZs9v5jRQKeinWGiVZQ/jZOL1SkqV+wKRZRNgM/KoRb4GNek3
	IbeQAa+SDfXK6+WMeSdHPJ9W/eHZTOA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-ac1YrbtiMtG58K9LfBhTzQ-1; Tue,
 18 Feb 2025 09:59:19 -0500
X-MC-Unique: ac1YrbtiMtG58K9LfBhTzQ-1
X-Mimecast-MFC-AGG-ID: ac1YrbtiMtG58K9LfBhTzQ_1739890759
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA3A51801A10;
	Tue, 18 Feb 2025 14:59:18 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9319D1800361;
	Tue, 18 Feb 2025 14:59:16 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/8] tools/build: Add bpftool-skeletons feature test
Date: Tue, 18 Feb 2025 15:58:53 +0100
Message-ID: <20250218145859.27762-3-tglozar@redhat.com>
In-Reply-To: <20250218145859.27762-1-tglozar@redhat.com>
References: <20250218145859.27762-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add bpftool-skeletons feature test, testing the presence of a bpftool
capable of generating skeletons.

This is to be used for tools that do not require building their own
bootstrap bpftool from the kernel source tree.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/build/Makefile.feature   | 3 ++-
 tools/build/feature/Makefile   | 3 +++
 tools/scripts/Makefile.include | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 1931b6321314..1f44ca677ad3 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -135,7 +135,8 @@ FEATURE_TESTS_EXTRA :=                  \
          libbpf-bpf_create_map		\
          libpfm4                        \
          libdebuginfod			\
-         clang-bpf-co-re
+         clang-bpf-co-re		\
+         bpftool-skeletons
 
 
 FEATURE_TESTS ?= $(FEATURE_TESTS_BASIC)
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index cb1e3e2feedf..4f9c1d950f5d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -418,6 +418,9 @@ $(OUTPUT)test-file-handle.bin:
 $(OUTPUT)test-libpfm4.bin:
 	$(BUILD) -lpfm
 
+$(OUTPUT)test-bpftool-skeletons.bin:
+	$(BPFTOOL) version | grep '^features:.*skeletons' \
+		> $(@:.bin=.make.output) 2>&1
 ###############################
 
 clean:
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 0aa4005017c7..71bbe52721b3 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -91,6 +91,9 @@ LLVM_CONFIG	?= llvm-config
 LLVM_OBJCOPY	?= llvm-objcopy
 LLVM_STRIP	?= llvm-strip
 
+# Some tools require bpftool
+BPFTOOL		?= bpftool
+
 ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS += -Wstrict-aliasing=3
 
-- 
2.48.1

