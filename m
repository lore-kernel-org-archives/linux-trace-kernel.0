Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B659E3B960F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885686; cv=none; b=Pcu62NSv/keKTk5m9m6YZCOUlosgaTE0sYPRcas7zIhytU3gbaWRkrvSWCom7D7d1PlhY3mHtvF6gQf8ObRfF0hZyY99uccl/+G1jOYIRxv+avNPs5WN6aO7CFdocCsG501kbe7rVESeRtrsmHfwqvsXZi1a5MivpAjHDO7LWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885686; c=relaxed/simple;
	bh=CciQhVZkdMjQeQurwPQlK3eA3fJ1BEEhkxvOiJb2L9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=iG3ufwvdp7vVuLf7lFJwW4JDvsqja4Zh/0xVvbmkh45Xwvvd6oUp/O3mK5pRX9b1no8E7FyIImlB1iBOUqY+v8XZfIQXzy3+17MPEWzaoixZ+cvRb1cwBCyI/XqJQMI59X1L+UcOWJtLNcx2k9Dz5ksHhRbkCP82zy0Hcdf51o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUVM2KLq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUVM2KLq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781885683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qjdJl/aIjLBeqeT1ey7cLdIZICtMkB44mhPgkeKrWdY=;
	b=SUVM2KLqweJl3LZouX9Uv46ECboI+QgpWa5Yj6QU6eWsQnWIiof4AkA0bcQ0Q5gORxFxhR
	IDMgl1NqdW9U33Plf7SKJSYz0D6vZRFUDBbYoZpo/WDR3ifDYwJpFgJ5bm+VMJYqZMW/5d
	FB6TLx0iSKPBByEbRAmTNIaDRvL7xSo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-8hx6TyT-Okexek8-hjIhyg-1; Fri,
 19 Jun 2026 12:14:39 -0400
X-MC-Unique: 8hx6TyT-Okexek8-hjIhyg-1
X-Mimecast-MFC-AGG-ID: 8hx6TyT-Okexek8-hjIhyg_1781885678
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC0AF1944D45;
	Fri, 19 Jun 2026 16:14:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C46C418005B7;
	Fri, 19 Jun 2026 16:14:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH] kprobes: Replace __ASSEMBLY__ with __ASSEMBLER__ in header file
Date: Fri, 19 Jun 2026 18:14:34 +0200
Message-ID: <20260619161434.88270-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: YWzLy6nBIIjeaA0iTzvy5mvBXFpGgDy0mC26amk8ekE_1781885678
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Thomas Huth <thuth@redhat.com>

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This can be very confusing when switching between userspace
and kernelspace coding, or when dealing with uapi headers that
rather should use __ASSEMBLER__ instead. So let's standardize now
on the __ASSEMBLER__ macro that is provided by the compilers.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: This patch has been split from an earlier bigger patch of
 mine to ease reviewing.
 
 include/asm-generic/kprobes.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/kprobes.h b/include/asm-generic/kprobes.h
index 5290a2b2e15a0..16f16963d503d 100644
--- a/include/asm-generic/kprobes.h
+++ b/include/asm-generic/kprobes.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_GENERIC_KPROBES_H
 #define _ASM_GENERIC_KPROBES_H
 
-#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#if defined(__KERNEL__) && !defined(__ASSEMBLER__)
 #ifdef CONFIG_KPROBES
 /*
  * Blacklist ganerating macro. Specify functions which is not probed
@@ -21,6 +21,6 @@ static unsigned long __used					\
 # define __kprobes
 # define nokprobe_inline	inline
 #endif
-#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
+#endif /* defined(__KERNEL__) && !defined(__ASSEMBLER__) */
 
 #endif /* _ASM_GENERIC_KPROBES_H */
-- 
2.54.0

