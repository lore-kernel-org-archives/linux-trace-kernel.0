Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655C03921E3
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531140; cv=pass; b=XyDFcckQVoeEtNjL80FMQLF1hAV3dG42oerIo1+lU+8O51E0nmkPvp3U15vb1wmHNWKRSkR4QOCEdgIMc63VDXear4wiWcKaDGvZ7HMVbq5543Q46HUfTLEsC+zL9XVwnZuiplpSLloUNKYK+Fnr2q99tfiWRwcL331+K3yUtCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531140; c=relaxed/simple;
	bh=aXdlizYwRg/M1AMKSbsJalT/nUfz1oUAK6W0OZTfMtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FfJrnhGiSNsXp87WXv6cZrAWQ6HR+qhIwfeot2O/6MRQuJPL91S5ofZEJLZjizKIh4mTClhBoxuEwi8H5p53KXADaDRFCZtW0kkoFaa+oKtK8cEgGlH3jkI0RpVjaTfBZxAGNerCdpZN4p0lbbtaxQoCLRdotpGlzeLXhAZ0ihw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=calelIUx; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="calelIUx"
ARC-Seal: i=1; a=rsa-sha256; t=1773531118; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ItuO7o+c2ms26nNF4bw2ECtzmncFSiJTbbeGIUJf1ckGtnya98tFrWdyhKHJVU0SaiX8OH6M3AVIQtPoDNq8TpbhKGq8RUi9V3cA5fx3w6wWldZ1Q7c8BbG1Kb/UyvcVcHpM7QUP/L30rGvABWOMtiarxNiCbJKVSTeI5UlEuio=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531118; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ga7f0GX5euej9Ul7YTpyJfwhI+upMhqgl4lvCxDD7gQ=; 
	b=h7BW3R6HPl44kDgHXrEWtugnLNpzypF3YcUQp9I8UWlGy4IPJA08eMZCzXQIRaFgV7pI9U6xGTHiHmwhA9AL8gA5+nmH/63qxLDQ9lpMGddEIDZcABHuSC4EAbAM/5dc0YD7Q1lrhku7Bum8SxTXgWPC4FfXoOlNTnuAkNRmruw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531118;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ga7f0GX5euej9Ul7YTpyJfwhI+upMhqgl4lvCxDD7gQ=;
	b=calelIUxnZdz9jwrEhvJX/P9zV+UpAxB0et8eljE+95D8ZlnSE2SzB+Aq6BlVy8T
	rRN0Bx7GyDEwtAFXc0zrk1KFvO3FAvGOn92WcONeVyBApIEmXPOTs5Ls2hnLtLQ6Sk8
	mRn88Ula3lYlS43xSDESKtftEnF9ivl+HK9828H0=
Received: by mx.zoho.eu with SMTPS id 1773531116718381.2769720153352;
	Sun, 15 Mar 2026 00:31:56 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 22/23] lib/bootconfig: fix sign-compare in xbc_node_compose_key_after()
Date: Sat, 14 Mar 2026 23:31:43 +0000
Message-Id: <20260314233144.187273-23-objecting@objecting.org>
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

  lib/bootconfig.c:322:25: warning: comparison of integer expressions
  of different signedness: 'int' and 'size_t' [-Wsign-compare]
  lib/bootconfig.c:325:30: warning: conversion to 'size_t' from 'int'
  may change the sign of the result [-Wsign-conversion]

snprintf() returns int but size is size_t, so comparing ret >= size
and subtracting size -= ret involve mixed-sign operations.  Cast ret
at the comparison and subtraction sites; ret is known non-negative at
this point because the ret < 0 early return has already been taken.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index e318b236e728..68a72dbc38fa 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -319,10 +319,10 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 			       depth ? "." : "");
 		if (ret < 0)
 			return ret;
-		if (ret >= size) {
+		if (ret >= (int)size) {
 			size = 0;
 		} else {
-			size -= ret;
+			size -= (size_t)ret;
 			buf += ret;
 		}
 		total += ret;
-- 
2.34.1

