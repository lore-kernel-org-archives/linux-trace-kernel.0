Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B471126B95A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890769; cv=none; b=ah43TQ/BXwo0uQsSpicXPqj2maE/wn+anww+3NkDlHJT7tdgOC52uF7MRwq3Y1YVo11vg/iY5UfS5TsNZLHjanJph9FeZ6kHbzKlzky53MKE1Yst/KmBh0dy4VZl33KOB2pTPA9XfPb4zhpdPW1mWPSkPrRq/M7uT1rpTCmYJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890769; c=relaxed/simple;
	bh=o2AvUBrQuQETVSMwOST7huI27DVQRD3JTB4bIwzBKnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ek802U6RBLc8W8q/lD/HinpuMWZzbVI2t9w3fNCB1hUPKGi60xVTWsbN+WVKOcNN5AsMGbGHOanLXk1TNKMwV8qrQQ38rruUmkWSaneSEXjcY0/4kM9a8iNiEEFmswuUxHhFXYV4WiLA8ezDwpEr0FgQTqeo/Uv/eSgw8SuDj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QejxDuE4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QejxDuE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739890766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rW4ZL0yUtGxGhkjR3a/nlukI0NQm+e6T3iu/MpUJ+oU=;
	b=QejxDuE46z6Fon2QhSyX3sV22t0SD6rNpEvaQrI/V63wCLhRjkkimtyhSvB6XvweycDBMV
	5+BOQm9mmAMlkvlXJ+HbkuSt5q2rXEcEIzJ3FPdJEa3svJWY8HgbYpJu9X2Y91imNIfNj/
	fGU00o5oiOg9wtXADlrco/+bG12pGTs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-UTcTh5fZN9yS9Jaoo-F5kA-1; Tue,
 18 Feb 2025 09:59:22 -0500
X-MC-Unique: UTcTh5fZN9yS9Jaoo-F5kA-1
X-Mimecast-MFC-AGG-ID: UTcTh5fZN9yS9Jaoo-F5kA_1739890762
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA5FD196E078;
	Tue, 18 Feb 2025 14:59:21 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 533F71800357;
	Tue, 18 Feb 2025 14:59:19 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/8] rtla: Add optional dependency on BPF tooling
Date: Tue, 18 Feb 2025 15:58:54 +0100
Message-ID: <20250218145859.27762-4-tglozar@redhat.com>
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

If tooling required for building BPF CO-RE skeletons is present (that
is, libbpf, clang with BPF CO-RE support, and bpftool), turn on
HAVE_BPF_SKEL flag.

Those requirements are similar to what perf requires, with the
difference of using system libbpf and bpftool instead of in-tree
versions.

rtla can be forcefully built without BPF skeleton support by setting
BUILD_BPF_SKEL=0 manually; in that case, a warning is displayed.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/Makefile        |  6 +++++
 tools/tracing/rtla/Makefile.config | 42 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 8b5101457c70..0aa116f7b355 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -33,9 +33,15 @@ DOCSRC		:= ../../../Documentation/tools/rtla/
 FEATURE_TESTS	:= libtraceevent
 FEATURE_TESTS	+= libtracefs
 FEATURE_TESTS	+= libcpupower
+FEATURE_TESTS	+= libbpf
+FEATURE_TESTS	+= clang-bpf-co-re
+FEATURE_TESTS	+= bpftool-skeletons
 FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
 FEATURE_DISPLAY	+= libcpupower
+FEATURE_DISPLAY	+= libbpf
+FEATURE_DISPLAY	+= clang-bpf-co-re
+FEATURE_DISPLAY	+= bpftool-skeletons
 
 ifeq ($(V),1)
   Q		=
diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
index 92a6e12e42d3..5f2231d8d626 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -53,6 +53,48 @@ else
   $(info Please install libcpupower-dev/kernel-tools-libs-devel)
 endif
 
+ifndef BUILD_BPF_SKEL
+  # BPF skeletons are used to implement improved sample collection, enable
+  # them by default.
+  BUILD_BPF_SKEL := 1
+endif
+
+ifeq ($(BUILD_BPF_SKEL),0)
+  $(info BPF skeleton support disabled, building without BPF skeleton support.)
+endif
+
+$(call feature_check,libbpf)
+ifeq ($(feature-libbpf), 1)
+  $(call detected,CONFIG_LIBBPF)
+else
+  $(info libbpf is missing, building without BPF skeleton support.)
+  $(info Please install libbpf-dev/libbpf-devel)
+  BUILD_BPF_SKEL := 0
+endif
+
+$(call feature_check,clang-bpf-co-re)
+ifeq ($(feature-clang-bpf-co-re), 1)
+  $(call detected,CONFIG_CLANG_BPF_CO_RE)
+else
+  $(info clang is missing or does not support BPF CO-RE, building without BPF skeleton support.)
+  $(info Please install clang)
+  BUILD_BPF_SKEL := 0
+endif
+
+$(call feature_check,bpftool-skeletons)
+ifeq ($(feature-bpftool-skeletons), 1)
+  $(call detected,CONFIG_BPFTOOL_SKELETONS)
+else
+  $(info bpftool is missing or not supporting skeletons, building without BPF skeleton support.)
+  $(info Please install bpftool)
+  BUILD_BPF_SKEL := 0
+endif
+
+ifeq ($(BUILD_BPF_SKEL),1)
+  CFLAGS += -DHAVE_BPF_SKEL
+  EXTLIBS += -lbpf
+endif
+
 ifeq ($(STOP_ERROR),1)
   $(error Please, check the errors above.)
 endif
-- 
2.48.1

