Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF77738F926
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531134; cv=pass; b=WhGJtP8tuj+k6APSlOIP0LqJl75X82q3Q5pwHzpCC5bIRV+3E9WmGyEReTtKICsQHjx0+was9MiP0xw39XHBCntRAb2wV1JiW2eHEVFRtUBSa/A5/Tk5lDsYAnkpJTQl0wJqbAYiAGcMsJaHsn+bn+DoadypnadxLYTJtxZS5Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531134; c=relaxed/simple;
	bh=6I0hpTbxvzM0MrqqhLwejv2QuzQNDU3b1q7ISIjV9Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2IzI0nHRh5crdCOe5okmPFUYYVTuIJlBYV8m1kcFL2F6Ajq6umujUcIx4TcK0LG5m45Pgl1uMM1bpfPHjLkXTJXpIcGSJILiwAnox4MVdCakJgFB8ohgvnRl2uKPgvpJatFm3KFNbucSVMIOpikJjY+aZeaRHrw9DwktC/f27M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=WTrft1Cr; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="WTrft1Cr"
ARC-Seal: i=1; a=rsa-sha256; t=1773531114; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=FeDbs7bBmA/Wm/tjvsz3aexsZHuEf0+CRyE1HnqsNS/3TEHqgwxk9Iuio4J+RJ7bc7GPysnerxfJs+yGAe55/1sYYTHiH6IpER2OEwhXNbZ7f291Z6n4AzOKISyfQdNQdO7tIi8yyFPCbANQEXovO3HuryqsOehXd3uv3tlQmJA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531114; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1AD6D9MidV6Fkfxyg/iT9A9sDWNhqE7cnbV+HIFl0WI=; 
	b=howIif/ds/RHh4IH0qYMKx3KvNAbODmaFt9K5i6rJyNqBdf53+PiDeNt/PSzPfe+/OVFbIB30S6cJg/x7oDLN+f3rDhfSXDew3bR3SWVe1w7O+Lxs3oCB1Yyy3MvF36WFLBNsYAFaOdfBxxKei13cMHIX0+hNul/Hzoi6im9Zgs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531114;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=1AD6D9MidV6Fkfxyg/iT9A9sDWNhqE7cnbV+HIFl0WI=;
	b=WTrft1CrAHNxvr2Vw1Tl3h0VHu6y1Jg/s9NPZgG39t9skrbuhPIQh5okXTSAY1n/
	WGoq0NL6VvX6tvVpe8NClIsKDjrwXfwfsyqcJahFS+wtH08BWB75mlJVjVT5j+k//3P
	tJcDC1/pavSSwmXAboi5Bd4oXplE9BnzkvPxUfHU=
Received: by mx.zoho.eu with SMTPS id 1773531112775550.8326207466157;
	Sun, 15 Mar 2026 00:31:52 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 14/23] bootconfig: add __packed definition to tools/bootconfig shim header
Date: Sat, 14 Mar 2026 23:31:35 +0000
Message-Id: <20260314233144.187273-15-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314233144.187273-1-objecting@objecting.org>
References: <20260314233144.187273-1-objecting@objecting.org>
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

