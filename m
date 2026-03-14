Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B127B139D;
	Sat, 14 Mar 2026 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527677; cv=pass; b=Q3vUc3et98eVTCQMX24DkcoXCJLRMYabchEN1jCYCfFVROx51nL0kLHnzY3lOoEkEz3hyIM3TUzMQ30I7gRSw3RedM8n+bjv6MbZ65YXn9rxnqzDV/K53+ZkinLWEAj001QcZjEk20gyPB/Mtl5xvBquBeu7dX+GmqxSEwupIPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527677; c=relaxed/simple;
	bh=mOcA5NumuG5htRvRiYXxJV6Vjf0pzLdSrtjWwr+L0hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uW7fj/X3bKX6509z2dS1EWRXg630R+uq228UTcqNGKBVPSW4rmdZd3IU444YlfO8pOO+f9xDoU1PoEKrC56iEIgK5lO3vgZ9Gowfth1qJEy8PkcDei2ebtSZWg3GZ5Z8oRK8MgIqZJRHY8/2tNwpTVOX5N76j1pywijNYg2Ff+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=bIyXpJLk; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="bIyXpJLk"
ARC-Seal: i=1; a=rsa-sha256; t=1773527669; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=kUW56jMHh8l2967Lhrfy0b4rIhPQxmr403rB+Hgj+C7FF5Xk8Tje168wdJ+ViKsWTYB2vxEMFg6/RI3/2Z5P/NSEwYluGaK0Vqx48L6Oe7SNrtFNRPAQ5g1gjyipjaOM902VHOtM1AHhcS5FvrvXlwlAmntDQxYgna79KjA6lKw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527669; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RNVEZU5OMpS4t6chZVfYPFtX6E6ANKPvlBhC6PXo744=; 
	b=TAq2/jymz7fbXzOCyE2MXAOau37DaqMDOIFi9mxyDC7mSa2wmKNfRKj7xjFTBkijaPh016wBEpREp2WKapuT2kBOqwOTg7romYFHrHYKp3KwUWNV9gCUm6jG893ukw6gpT+i/4vO+LGWJDnpBFXU9Fva2bDcAyDbYloeZer/DB0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527669;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=RNVEZU5OMpS4t6chZVfYPFtX6E6ANKPvlBhC6PXo744=;
	b=bIyXpJLkK6/a9z1mg/dPNfkvkw0EaIl/rVgyGiWjwz75ATWcWyo44Bw9XaCHNZBt
	rQqq/tXuTMZPhEm+MTVfi9eTTGz4DMRRdXMBjdrcyc+Pe44yxkxltknQIXwrS+nHbJd
	mIBSxH74hjzIU2sZzy13BqABLPYCEdiKqOe1AdRA=
Received: by mx.zoho.eu with SMTPS id 1773527667498640.514927790007;
	Sat, 14 Mar 2026 23:34:27 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 02/17] lib/bootconfig: fix typo "initiized" in xbc_root_node() kerneldoc
Date: Sat, 14 Mar 2026 22:34:10 +0000
Message-Id: <20260314223425.142966-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314223425.142966-1-objecting@objecting.org>
References: <20260314223425.142966-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 51fd2299ec0f..53aedc042f6e 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -112,7 +112,7 @@ static int __init xbc_parse_error(const char *msg, const char *p)
  * xbc_root_node() - Get the root node of extended boot config
  *
  * Return the address of root node of extended boot config. If the
- * extended boot config is not initiized, return NULL.
+ * extended boot config is not initialized, return NULL.
  */
 struct xbc_node * __init xbc_root_node(void)
 {
-- 
2.34.1

