Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C10938839C;
	Sat, 14 Mar 2026 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529338; cv=pass; b=ApBy5ktNFzHGu41GKFYDxBRZpq0VpiKhmjiRiNpHu+BYOeeW7omF/fJur+PuvQxRossEde4zH/O9lgVXJUFjcb6E0PFZbwGK37uv/o8B0TVmw8uSelXFgrQtXcz/tn1ponhDBtiFfYwqMM/qoBl9EEvc/sZ48QuFB5thSYBTZ68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529338; c=relaxed/simple;
	bh=6I0hpTbxvzM0MrqqhLwejv2QuzQNDU3b1q7ISIjV9Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WS2odPHyc53Dd2OEEIAxhU8TS9dkWnBuul/EGm5OdC/ql3wZsTgthOmMxgLJ4vAf0NKMMfMw/W7kJ1Mk3in0cVTlRONRe0TUgvmQLgmYiGvCtR//NKv7/bQepekMbAH54Xsebk3dWFzruOfKnEEfZuAwwTMn7F3KrMnDfZdVq/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=RFU1dNgS; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="RFU1dNgS"
ARC-Seal: i=1; a=rsa-sha256; t=1773529327; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=EyKnvh8/G/FvOvb1WM4zCzdgRjO0v5frsFbJTSy8jvTzp0qViYBuOjpLth8kMSKho9aRWruGaf3nERI3+sE6sqLWhYbgxWROT22q0QeebIIJUhjwa9LhIqwdXAZuUSHSBJQBs5zkMoDW4ffYuYxf3XhAkD1+bQQ3l4BhUGV/goQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529327; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1AD6D9MidV6Fkfxyg/iT9A9sDWNhqE7cnbV+HIFl0WI=; 
	b=Z4HdrJurjsVGd674ORDgumdreQ7JVqloiWd5AxAwqV6zKb0zG2Pjng5pebEI3LxiW2dDA86eqN9ryamnS97qXnAq3I76HfqGuneBHZ+GL4bdoPRNKh7fpQe1vPn9/5CTxM4qaFD1EiLGFrlxynTsRNLeZMGjQwb8iE/4hadcTyE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529327;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=1AD6D9MidV6Fkfxyg/iT9A9sDWNhqE7cnbV+HIFl0WI=;
	b=RFU1dNgSaQbKkfVY4R5eYrAMjAGRkHV0PV8KfPPNlVeMAdxcgKr/WSQxZbNgl/WB
	rQ9f7BKBdT9ApqMQGT1Bg2fVTF5bj+7x41Hki401HcEnLQ83jsKuIpsMBZ/+m2OIhi8
	2hwyp9m+8qJvPOGtCTpyLOvzTATOzVlWvqNbt+Gc=
Received: by mx.zoho.eu with SMTPS id 1773529325080225.05753336855594;
	Sun, 15 Mar 2026 00:02:05 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 14/17] bootconfig: add __packed definition to tools/bootconfig shim header
Date: Sat, 14 Mar 2026 23:01:52 +0000
Message-Id: <20260314230155.155777-15-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314230155.155777-1-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The tools/bootconfig userspace build includes the main bootconfig.h
via a shim header that defines kernel macros for userspace. Add the
__packed macro so the struct xbc_node declaration works after the
conversion from open-coded __attribute__((__packed__)).

Signed-off-by: Josh Law <objecting@objecting.org>
---
 tools/bootconfig/include/linux/bootconfig.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bootconfig/include/linux/bootconfig.h b/tools/bootconfig/include/linux/bootconfig.h
index 6784296a0692..41c50ab95ba5 100644
--- a/tools/bootconfig/include/linux/bootconfig.h
+++ b/tools/bootconfig/include/linux/bootconfig.h
@@ -48,6 +48,7 @@ static inline char *strim(char *s)
 
 #define __init
 #define __initdata
+#define __packed	__attribute__((__packed__))
 
 #include "../../../../include/linux/bootconfig.h"
 
-- 
2.34.1

