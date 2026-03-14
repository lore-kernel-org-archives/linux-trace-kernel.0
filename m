Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87F388361;
	Sat, 14 Mar 2026 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525345; cv=pass; b=GzT2YW8AHxY6RYey0ui5teIWupimy8deIr2LGqA3LcsHqoaP9bWHkG0dPcwc/NTGAxHAAW8pnHJCqyVWwx62S4rFb2uSwB8WKaJQaKIXZZ3fcZyAfrdw/tLGqRq9DLKL72MNtwH6kAsoiRSE6iedSVWg3Q1Hu5yD/E/rVC57d+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525345; c=relaxed/simple;
	bh=kDcgT5gXzTP1fqOGMdxALgedri0gVcD3is/FfzavjKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyQRWg0oRW0uJtEL9TyCMtoLxuul6+uCGJXBLQzN6Uj++jNLtiXGbpaO21aBnWhi+y1qiC46DMjVYBrWsyjoko9DtUeQmV3uJKCx/RT8M+ENuI2FGGWnbeDA6N1oVh9UYJDx2Auh8ZQEESSTtBrhyF1f6BTcU4O2JzYg6ijrTzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=KTRYQltc; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="KTRYQltc"
ARC-Seal: i=1; a=rsa-sha256; t=1773525335; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=em1Cl6iATnY8Jvn8SR2LOpKmQ19zTbwWCImQ1DzcxGREmhVdJnfgKmba0SN3jDLKLSFnubH+uJN7CawwAmC9IH8N6dAzKLZxRXud40AcQAkr+IIg6uy6dEV+8VKESJX/CwgkzXsUh/5NdjzbezAh7zKcNNfjv20HyCz/Y8djpLk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773525335; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7bmeZKaQTYKiPdWWEUmU4EJNbpBFQlYVqCIGyMl5PZg=; 
	b=MFrTMWF76wshT/3YmPXyiHfqOWNTxvnBSpdBlXsaat8lB55UcZ3ZD/6A5eQTsVZn83Xq0MhtcpTXxor1zMK5VAKULeEe3TuZ+wFnyWFDQbZshSksaPnI7GInnbB9zPLg/jPWZ4UkayWh0t+mKoNbAa9C6bE+/7jNAc3Vj1BdF8M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773525335;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=7bmeZKaQTYKiPdWWEUmU4EJNbpBFQlYVqCIGyMl5PZg=;
	b=KTRYQltc5adYiyA3hC65a7LjAPh1K67CTw4JHKYO8k67LWko2V6hBnb0DmJ6geOz
	9BzdPKmlAsKPfLAeTjvjL2zCgqLRk/Z5MINYE1f1gdkl3g0kETHKXfnx9AW917RihT2
	r4Dmh4dz24ft/eztMJPzSzopNBuHvzkHP5oxmdoA=
Received: by mx.zoho.eu with SMTPS id 1773525331915186.41809130320257;
	Sat, 14 Mar 2026 22:55:31 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 08/14] lib/bootconfig: fix off-by-one in xbc_verify_tree() next node check
Date: Sat, 14 Mar 2026 21:55:20 +0000
Message-Id: <20260314215526.108651-9-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314215526.108651-1-objecting@objecting.org>
References: <20260314215526.108651-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Valid node indices are 0 to xbc_node_num-1, so a next value equal to
xbc_node_num is out of bounds. Use >= instead of > to catch this.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 58d6ae297280..56fbedc9e725 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -816,7 +816,7 @@ static int __init xbc_verify_tree(void)
 	}
 
 	for (i = 0; i < xbc_node_num; i++) {
-		if (xbc_nodes[i].next > xbc_node_num) {
+		if (xbc_nodes[i].next >= xbc_node_num) {
 			return xbc_parse_error("No closing brace",
 				xbc_node_get_data(xbc_nodes + i));
 		}
-- 
2.34.1

