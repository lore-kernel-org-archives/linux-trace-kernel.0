Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F3355020;
	Sun, 15 Mar 2026 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577249; cv=pass; b=C+CUopcmHfdlWslvB6KSXxkTdWE9zdFUoYRD4HWGhgDm1zBnX/Hoo0py7dyLJdHhxDY5w/rR16BzHd9Vg4qC8iZhVnxbDnKNpaX2ThUTZVteyzIyKo6hAMbc/8XA0lsvbJw1WiHhkQsBzr/aBpmbzPm8g9gxhFLDuPax5J0PRtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577249; c=relaxed/simple;
	bh=aXdlizYwRg/M1AMKSbsJalT/nUfz1oUAK6W0OZTfMtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ceiBVjKrT+4sVPc6+9dCua+6aK0xu36oREqQXOAovQEHika8jqzg68fkW9QD6Y19PpsH8lrFqsWe38u6yieyT/PXW3703KlSHIpIji0QKcJIyxq97bxnW4/kTotp200wj4HiJXf3OPTe4mYL3+ITs/J4EfbWrSw0zJfEhb//AdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=PlV2aN0u; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="PlV2aN0u"
ARC-Seal: i=1; a=rsa-sha256; t=1773577228; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=lQwd2M/j5sNJNBL8ODObs3jvcMRsh3qzosnphDM+Hq4eOgXfsnBUHeYKN4QwewHan4fWZrLly42pyz9RJbQncFEOVekTGq4Z19+y31OvbeWQdX2qnkZpqkIyQdLEQtxvGHxkJnGdza7pK4i81lygqsB7EmcvvYUfziorTNiU3Vw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577228; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ga7f0GX5euej9Ul7YTpyJfwhI+upMhqgl4lvCxDD7gQ=; 
	b=G8Rvs450FTnttialIXv6RdM+SJHi5NSvgNpeQFDhSFMtd/cmuieCOhjPaobDd+3SjOTLwaobYI0EnpdzNV5CD/VCglH3v+lHVRrbPz2Rkr90uVibSy+LgalTLXqZg88k4ejk0iphgN5VROw/WMLdbrDVqDcR5sBPU9UrbBJ6L+k=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577228;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ga7f0GX5euej9Ul7YTpyJfwhI+upMhqgl4lvCxDD7gQ=;
	b=PlV2aN0ufHep8p8kRNCXohC/qxHBHsIY9lzH0xv7dda3v9v9+oap6IyvxmsCVdJT
	ZgWvI7ryB6UH91sRfMydRlCgbNbT3ULlvSFZuHIFV+w3Rd79Iok3P2HcnzQEJf6dH4J
	p/+XCtYS95e70A3IqSBWCDD6HfkAqhUoetJ69GSg=
Received: by mx.zoho.eu with SMTPS id 1773577226489970.3035499984228;
	Sun, 15 Mar 2026 13:20:26 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 16/17] lib/bootconfig: fix sign-compare in xbc_node_compose_key_after()
Date: Sun, 15 Mar 2026 12:20:14 +0000
Message-Id: <20260315122015.55965-17-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315122015.55965-1-objecting@objecting.org>
References: <20260315122015.55965-1-objecting@objecting.org>
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

