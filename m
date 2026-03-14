Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE338838B;
	Sat, 14 Mar 2026 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524783; cv=pass; b=Y7NlM+vNu85S+6wSpWo/m3bT/dPcznIBbmZ8/4b6WiTRXNtoBrLc2DHyOMRp7OzjtyyWdOfi7LYNQF48aU138jHjZYbjzAZyRCUBvHGEsP4RsypMLh2L2wYS8EHnrvSxAzdB0Je3FDXXUHzGihFGgpI4S3xtUEpwPmhrMAJqP84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524783; c=relaxed/simple;
	bh=6I0hpTbxvzM0MrqqhLwejv2QuzQNDU3b1q7ISIjV9Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oXhFEY97FfmqMNf6ui48K4GHP2Pk30BwSdSzLda461Pqhx1E0wBXniAG1eYFMUC9GqTM71Fp8U4TCCGstwLbkWCUdImXe5JDW4vGQZNuiBiwg3zvtPrQLERZ8FWhPQlXSQSd50guSWgjyYABFzjM1WBEP88C9CI9aSHM7n+5+1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=muUJOtZm; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="muUJOtZm"
ARC-Seal: i=1; a=rsa-sha256; t=1773524769; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Wd2iI0UeHDdXxt6guo6ySu2ok5OO7vmFLeA28Wv3fG0Eur1IRt2UJJ5gXTH0HVlgkGCO6cwc+usqnt+bc0njDk8/BVjAVt1tm35VdB62vot1M48bTtQBiRruBw+LUANSWz0igl43EHv+9EikzNIbnSNqJXHVgneoTTvXpgf1+ks=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524769; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1AD6D9MidV6Fkfxyg/iT9A9sDWNhqE7cnbV+HIFl0WI=; 
	b=acfLOrG7RcVxXMh9paUpenAg7dqqMXexMjhAT3iXys+2jFW1c1a+UQFTqLxZd7AYq7TFGISIoYxGJbYrz023mTo0HYQ8c/QmTl6szWBlq3DKvGo5QQ9IQeRieTPLKuOIsafQNS07+MSSSOQhGXIaA6UHbX4i0KkzhwDxSIAb/Qs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524769;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=1AD6D9MidV6Fkfxyg/iT9A9sDWNhqE7cnbV+HIFl0WI=;
	b=muUJOtZm4MwAGqpaOz+3yxUHkpyjNP8uCq/dmFMvqrU1E6Ck+qHMFDHFzsfgTbGN
	s+Qzwr4mYCpdTPeMjr5SRvuZBpM9/yFcsBt8gDIecWZXM3bgIZMz5DsxwyImld5Wj5y
	bSQMdhHmYVCWLBjlId/bor6AZO39W/qbk4kP8ozo=
Received: by mx.zoho.eu with SMTPS id 177352476656732.248834389593526;
	Sat, 14 Mar 2026 22:46:06 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 14/15] bootconfig: add __packed definition to tools/bootconfig shim header
Date: Sat, 14 Mar 2026 21:45:54 +0000
Message-Id: <20260314214555.96217-15-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314214555.96217-1-objecting@objecting.org>
References: <20260314214555.96217-1-objecting@objecting.org>
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

