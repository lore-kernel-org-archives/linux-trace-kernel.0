Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB95146000
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035464; cv=none; b=Fajyg6BqqrYO8McxsFxzB89uHPxuH1d8hIttUkr2lQDF09T5knke3KcMET434KvbqZEAdlQCMMfHwy52cdqpb1NjeSkkXcWCxL2N7PVlWFGYcK4QG/yIabR/Ozn+cP/b6ufo+u3O63ie0Tl+A9QIYIwPPQxZVRz5AVUMFRF61uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035464; c=relaxed/simple;
	bh=cr2IFsSaZDr0ZT003XZ79v6iN9wOCRZM5z5x/QRIzRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EI9FyGUKAmgPWhXVHE2581xEqSlxFrt32FWPHt6GI5TEJeGFu/dD0GJ4HY9+s/ygnp6BJi+ADw2I4s+JG0LmZ2tkNXqgUcu+pEZMJoq3378DUCcdhvE5v2tvvM1fjvHBgMMMNZETCMpjT9c3pPTXKQRWIlaVfMOA/tP3+XsAfm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPbAEAKc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPbAEAKc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728035461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZjz2KCPKJpIRIERaoUsMvI/8nFMFKm0cNSSMpMRGhk=;
	b=RPbAEAKc6GQnZzDt/I7VhcRMMohUNG43caeGa11qLhfLg5m9SEkjjv7PpSjubxlKU+boXM
	1nayc1UDdQkikmGTStH2vocePqW6RRQJg9lpgvmcJKT6G2tkOqf5toguYEPaIUMF9jA1s/
	vIsHCyBcljH9mllgHK9emyTdjQI0TXs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-dz6aS97BPTar6B8OOYi4_g-1; Fri,
 04 Oct 2024 05:50:58 -0400
X-MC-Unique: dz6aS97BPTar6B8OOYi4_g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A37A1955EA8;
	Fri,  4 Oct 2024 09:50:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.176])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 525DD3000198;
	Fri,  4 Oct 2024 09:50:54 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH RESEND v3 2/6] rtla: Add optional dependency on libcpupower
Date: Fri,  4 Oct 2024 11:50:10 +0200
Message-ID: <20241004095014.2492813-3-tglozar@redhat.com>
In-Reply-To: <20241004095014.2492813-1-tglozar@redhat.com>
References: <20241004095014.2492813-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
index 0b7ecfb30d19..5f6f537c9728 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -42,6 +42,16 @@ else
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
2.46.2

