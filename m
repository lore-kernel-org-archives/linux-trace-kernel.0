Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF1414AD19
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999374; cv=none; b=QiYq/cD+fngnRRMksp/HO0er4G9Fgm6QzJJ8ieD5yg3NUMLEQIqUGod+wcsQXTNpZ5sHn1mc3WM3rIJ9GrUCbbg8d+txM5qMX7RdowBWJRxaYQczfLSpA5XSNzMuzLLGmOx3leBvII1/rYjKjr7ux5egfn9G4i+HNhDSLZrpTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999374; c=relaxed/simple;
	bh=WJCEQMOAoY4332qR6uEjRNyhheW56HM+3+6KsYXw8A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X545ha7tjob5UT2kOWNcpNsLFBjjCBCNUnmhAW2ghks/cT1NcxBZSY9Xa8FSv+oDO2O2nN2xogkxDNOoOLlU/NukCrd26XNay87y21Oq0gd5EC5zpZ0ycq9kQsiYK5NeybdtAD3IAUlv58WKcwkCcqKIWlLdcdf+xiAy9vWtdJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDjnlP+W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDjnlP+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728999371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XNM8/scQMJ4T7XpJMlHqS/H8+k2VunSmH7Ji1tBrMc=;
	b=gDjnlP+WlHQ3aJsuriO0B81aBo2+t4UdjO8S6s+JS+HrRBodwv8wCRe5wdnzPRCUz7ob4s
	e+TLFyFJaKe8x3spFawsXOgkXSbFLQkz+EGElPAcHyngaUOf4HPXe70+kVGgQgeNbgukrf
	tZPAG3WvGU3DDsLjgsP/kSt8OOYTJ0E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557--os0K-AlPnq8phv0xdYvmw-1; Tue,
 15 Oct 2024 09:36:10 -0400
X-MC-Unique: -os0K-AlPnq8phv0xdYvmw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 886CC1955D5F;
	Tue, 15 Oct 2024 13:36:09 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E9CE19560A3;
	Tue, 15 Oct 2024 13:36:07 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v4 1/6] tools/build: Add libcpupower dependency detection
Date: Tue, 15 Oct 2024 15:35:47 +0200
Message-ID: <20241015133552.3043040-2-tglozar@redhat.com>
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

Add the ability to detect the presence of libcpupower on a system to
the Makefiles in tools/build.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/build/Makefile.feature | 1 +
 tools/build/feature/Makefile | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index ffd117135094..2ebfb826dcea 100644
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
index 5938cf799dc6..6ef3e1ca583e 100644
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
@@ -245,6 +246,9 @@ $(OUTPUT)test-libslang-include-subdir.bin:
 $(OUTPUT)test-libtraceevent.bin:
 	$(BUILD) -ltraceevent
 
+$(OUTPUT)test-libcpupower.bin:
+	$(BUILD) -lcpupower
+
 $(OUTPUT)test-libtracefs.bin:
 	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtracefs 2>/dev/null) -ltracefs
 
-- 
2.47.0

