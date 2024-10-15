Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529914EC47
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999376; cv=none; b=jYM2af16GY8putrLuFlol+9PpjLT7VeLDkDeg3CG81QiYZT5rkMk8DDIf8SLqbGx6NKzjYgGoz8LzD7zTNOfNKmz0Z5lRVdc9AbMCNt+GnkhfFFVj8QMayKqe0kdVtO/pw92vR5SA8UbgAcv2i0tW1N61fWfRGNDK01SmJpFSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999376; c=relaxed/simple;
	bh=ZffEOjIFLf6elKPZJwnRawB2g4HaEPHGJv/NviW4q0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lX3/JuBW6Zvowio6TbMP1pCsGKuVSuHSeh7m8Eo+x0NCebsUeHttuXhQgHuNmUivS2IFqqYRGfaW9Wx2sF5+UAmUtsvDdHsvpen8bO81PHKBCQfWE7PBv6vgXGb6uBGEpvAXTXS8Jq9LeiEsdS3ypQPSGmPsUQoxD5TUOqzYKyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGUxFtcc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGUxFtcc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728999374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3iWpJmXXb2Ifv4l2T8pQRfmJ24RIoE36q9B2/qALvfM=;
	b=XGUxFtccbJwVK+HpuL9PzwfyR0QxCxvj9izI3EHpBDYGe8BnDrchqGcGb4bDj2VgPpQfiq
	FccxAneWFXX4rAq5Bu5zTuP/ay+0SYf+bzEBH9nOvao/yC/jFFRjqg0cWRWsZZYlApC2UB
	HqKi8l/WCmOZbsRzRTs41JOwHzUjDyI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-9ARMGhT7OTmm-9j1Qbrfeg-1; Tue,
 15 Oct 2024 09:36:13 -0400
X-MC-Unique: 9ARMGhT7OTmm-9j1Qbrfeg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC54C1955BE5;
	Tue, 15 Oct 2024 13:36:11 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF6B719560A2;
	Tue, 15 Oct 2024 13:36:09 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v4 2/6] rtla: Add optional dependency on libcpupower
Date: Tue, 15 Oct 2024 15:35:48 +0200
Message-ID: <20241015133552.3043040-3-tglozar@redhat.com>
In-Reply-To: <20241015133552.3043040-1-tglozar@redhat.com>
References: <20241015133552.3043040-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Tomas Glozar <tglozar@redhat.com>

If libcpupower is present, set HAVE_LIBCPUPOWER_SUPPORT macro to allow
features depending on libcpupower in rtla.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/Makefile        |  2 ++
 tools/tracing/rtla/Makefile.config | 10 ++++++++++
 2 files changed, 12 insertions(+)

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
index 5f8c286712d4..ccbb380e70d8 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -43,6 +43,16 @@ else
   $(info libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
 endif
 
+$(call feature_check,libcpupower)
+ifeq ($(feature-libcpupower), 1)
+  $(call detected,CONFIG_LIBCPUPOWER)
+  $(call lib_setup,cpupower)
+  CFLAGS += -DHAVE_LIBCPUPOWER_SUPPORT
+else
+  $(info libcpupower is missing, building without --deepest-idle-state support.)
+  $(info Please install libcpupower-dev/kernel-tools-libs-devel)
+endif
+
 ifeq ($(STOP_ERROR),1)
   $(error Please, check the errors above.)
 endif
-- 
2.47.0

