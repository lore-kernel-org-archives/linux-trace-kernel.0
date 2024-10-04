Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78755148849
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035462; cv=none; b=WO3t9XtY2V4Pmfo6HsOY1yEqDQR3cDe11+wnggsO6b7OsYItS/MzJGuQ0NbNg8+IINzaGYbGJq8NCJmwglAZoKD+XLtHrZbn0EzZhSa6m47uaXU1Yx0CjvhzGFuCE6ysNCKtBeWdmJNEYweQ3ukLyFkL9CDdzRTd/ThZ2SltwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035462; c=relaxed/simple;
	bh=DCoa0KRdef5mO7XLREuz4nWpWsvYJi7I4SfoHo0KQZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guUe6yrYorfcdgNMtIYh4xOyJlERRLAuZ1TOltXd0/ZAt7EW5g+O7BCkNhrQBYtCae/dezUgQxGEWG8zFSu46XVdr4jdqWz+ARyhXYg5BkhzvsAPQfsQoaalV1zFi+BV0SAhCj86umc4CI1vqWMRG/VPH37Qr4ph5IbNthPLo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CaF4jHSA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaF4jHSA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728035459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCoxHrwouUdbHIkCb3mhY3vFHlQ3Z2Jdm9w3tsAQYXc=;
	b=CaF4jHSASOgNAZLKvtWv2NFAYv5zuXHO1sgJF4HuDzArqNgio2/qyeiOaHm74mghgajuIS
	yn5O9UsT6dUPtEulRzEfgs/GtwpjWPkILnu0NgyJhbhadv2UHCDPfbgOU0aHQj7hqphCf9
	l/xWVAR5yk3pUbG8U3eAZXWXa9woIQk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-nkvJZfuuOY-cH3V1PkWyQQ-1; Fri,
 04 Oct 2024 05:50:55 -0400
X-MC-Unique: nkvJZfuuOY-cH3V1PkWyQQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C10501955F42;
	Fri,  4 Oct 2024 09:50:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.176])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C1CA3000198;
	Fri,  4 Oct 2024 09:50:51 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH RESEND v3 1/6] tools/build: Add libcpupower dependency detection
Date: Fri,  4 Oct 2024 11:50:09 +0200
Message-ID: <20241004095014.2492813-2-tglozar@redhat.com>
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

Add the ability to detect the presence of libcpupower on a system to
the Makefiles in tools/build.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/build/Makefile.feature | 1 +
 tools/build/feature/Makefile | 4 ++++
 2 files changed, 5 insertions(+)

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
index 489cbed7e82a..c4a78333660b 100644
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
 	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtracefs 2>/dev/null) -ltracefs
 
-- 
2.46.2

