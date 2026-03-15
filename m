Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166734F486;
	Sun, 15 Mar 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577237; cv=pass; b=H0dMwWb14Gl2O0gorH7JgPAoROBGyL7EC5LjGCTcKVbF4IR+GJIGt8eru1t6hxgBm0atsxrIGehozLQk2pouEfMzjsYh2FbjC76ifQPj2DI9rb6DLZMGkDtOBrcn1yeYJitmyuF07U/IQ7ZGMmY/hkgvgxvyVulxNJaz69jyTKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577237; c=relaxed/simple;
	bh=JDJDCRXv0WDR5QTOFLbH+ZVs0fEY0qu7uRZpAINLGYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HjbfIHR3j0RaBmZjR8+kVzKNi/x7rZnm/ycJGx9wcCoedIZcJ7Fiy9VoJTgVIBswYpGo8Ss04eRwTEFNG9+5y6NRhgXva7na/TMErQJFKXTOSUskJXqhacY65mYgg8hXF+ClEwr+IZ2zHZVymwkOdcXqhbOo8kQ9PpKw6Gz/dYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=NrlqaE4J; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="NrlqaE4J"
ARC-Seal: i=1; a=rsa-sha256; t=1773577228; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=AsIEWT8Q53VoaqgAZYChOEeNrjArPsZW6L8TS/hgxxB0C2MFZ0R64dQuH+DifZzrw10mcOqH64dIHOcb6sDzoivCSg1WCz7oE2qnye3UIzps2a/1Nqe7EfswZHVYYUeTsIENoYmE8MaVio/Q21Kze5smmz3HLI5Gu3PSQMzVg0U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577228; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=c0YHvSlmLDD7UQSPU1JDzf6Bfaf0j0xk6wf6t7LSyAU=; 
	b=Muj1eynKp+HDk0WE1OLiqJT9rTMDAO1ccV+ejPMpCq2tR1S9GvdBc35EvDD4M0Vv8JiEywGkeH28xr3uBuJ2vuYMHLbQI/qFIw05hWsPY/IDfi1jXi4jxoJWBABS1WEmy783dWNNkegVBdviEhw5bDf0zfDz5LOIC6rYFyLsxak=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577228;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=c0YHvSlmLDD7UQSPU1JDzf6Bfaf0j0xk6wf6t7LSyAU=;
	b=NrlqaE4J6FLp5gkcBoxLJDcXx9cm6aS6UgcTOcw+tGXYGIwAWr+1tYNJ1PdBmZXt
	B2/+ejgypFV0gC4MCfu6O0xNY9Q3F7XO8sPSKO4Do4h1oKRb2PVL3KdbtW2BatR9sI6
	F8FMbI6U5JPUydcXlPZPPvS+9ORLMGx8HPUAkQpI=
Received: by mx.zoho.eu with SMTPS id 1773577224820615.2709267436217;
	Sun, 15 Mar 2026 13:20:24 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 13/17] lib/bootconfig: use size_t for strlen result in xbc_node_match_prefix()
Date: Sun, 15 Mar 2026 12:20:11 +0000
Message-Id: <20260315122015.55965-14-objecting@objecting.org>
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

  lib/bootconfig.c:198:19: warning: conversion from 'size_t' to 'int'
  may change value [-Wconversion]
  lib/bootconfig.c:200:33: warning: conversion to '__kernel_size_t'
  from 'int' may change the sign of the result [-Wsign-conversion]

strlen() returns size_t but the result was stored in an int.  The value
is then passed back to strncmp() which expects size_t, causing a second
sign-conversion warning on the round-trip.  Use size_t throughout to
match the API types.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 806a8f038d24..995c2ec94cbe 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -195,7 +195,7 @@ static bool __init
 xbc_node_match_prefix(struct xbc_node *node, const char **prefix)
 {
 	const char *p = xbc_node_get_data(node);
-	int len = strlen(p);
+	size_t len = strlen(p);
 
 	if (strncmp(*prefix, p, len))
 		return false;
-- 
2.34.1

