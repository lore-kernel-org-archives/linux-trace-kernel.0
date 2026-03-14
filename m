Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B53386577;
	Sat, 14 Mar 2026 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524784; cv=pass; b=OGhTCzegPvMgqSgIOD0BzOjx8OHw6ncrp6XRtjodCpKCEO4UX8lzoWsx5Kp5giasuTBKfRemmb46nNz3lPkOMzfLM/utYPX7bkMPG2CNaOs7d2oQy+7lu6uu/NKd5uz1wFbL+kD7MlC3cRJjdA/TP9IkMxKmYWfA5ENkI1DPAlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524784; c=relaxed/simple;
	bh=DRP0bkR7bPm24iP6Lzhg3tEJBN+s2+Bet778OjDqUXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A03IzB7o1wPK3uQb3RPlTnFrysW2mL24tUjbA0sq0HDSPmm+gPAQqtnTJuOLc27EB5jCQj4jIVkjLBR/R4Xjyag+QzqR9CtEpxXP0YXy62ky6odDdJjzFEFAnWa/nifJ3j7cvSOFthnB/OMBkhaekaULH4BTVvWG4FWVOoAMJjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=oMrimjIB; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="oMrimjIB"
ARC-Seal: i=1; a=rsa-sha256; t=1773524763; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Sc1ygsYkZJF2dxJ6ltNvsD9opthRxJziY/mpv0eif90QSZasTq974TN+v5Js5ZeH+QEOGmEKp0JOB6r9hFnRnAV7KhzuLf2AwfKzaVj83JdxfY+0T0ZEFTsLM0G6K85aKTauJQMhqgNtT9efFHtqQcWA1MT288yhn9jboB08Zuo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524763; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xeupn9cKPxiPKbISrjkPHMR3deW24vI0PqVo9Jq/DYc=; 
	b=gJYESOtmHiojjIBH++HY6oQIdpbU1J9EONQnnedTqrFRXMgC4Wjh02tyLYVNCsI10MstClENY7Hm0Y6noCnowrRS1maOdjRnq9kdDtkHYj6RtTjqsjXNd0cFxWeyRHO8+Qu73s6dlE5at0L1BNxdvfCrUeyzSS+bAgFsxmzwOss=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524763;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Xeupn9cKPxiPKbISrjkPHMR3deW24vI0PqVo9Jq/DYc=;
	b=oMrimjIBfrZ1iENf6XGFzsFwJOXK/gcoWXXcwYkbkf46IgZlzQUTyqOBf94Zn/6r
	bvL+9ij8OyLXvkecDMcgHzPqgPjhSsbcAxZBzswDeJ0bDyDW368x14A+rjbGmQQNoz4
	I1zfIaddZRtpKRcMNSFGtSdGk/PtCb24gFFCwAyw=
Received: by mx.zoho.eu with SMTPS id 1773524761819259.98526413524905;
	Sat, 14 Mar 2026 22:46:01 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 06/15] lib/bootconfig: narrow flag parameter type from uint32_t to uint16_t
Date: Sat, 14 Mar 2026 21:45:46 +0000
Message-Id: <20260314214555.96217-7-objecting@objecting.org>
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

The flag parameter in the node creation helpers only ever carries
XBC_KEY (0) or XBC_VALUE (0x8000), both of which fit in uint16_t.
Using uint16_t matches the width of xbc_node.data where the flag is
ultimately stored.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 45db51bc9cc7..34bdc2d13881 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -408,7 +408,7 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 
 /* XBC parse and tree build */
 
-static int __init xbc_init_node(struct xbc_node *node, char *data, uint32_t flag)
+static int __init xbc_init_node(struct xbc_node *node, char *data, uint16_t flag)
 {
 	unsigned long offset = data - xbc_data;
 
@@ -422,7 +422,7 @@ static int __init xbc_init_node(struct xbc_node *node, char *data, uint32_t flag
 	return 0;
 }
 
-static struct xbc_node * __init xbc_add_node(char *data, uint32_t flag)
+static struct xbc_node * __init xbc_add_node(char *data, uint16_t flag)
 {
 	struct xbc_node *node;
 
@@ -452,7 +452,7 @@ static inline __init struct xbc_node *xbc_last_child(struct xbc_node *node)
 	return node;
 }
 
-static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, bool head)
+static struct xbc_node * __init __xbc_add_sibling(char *data, uint16_t flag, bool head)
 {
 	struct xbc_node *sib, *node = xbc_add_node(data, flag);
 
@@ -480,17 +480,17 @@ static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, boo
 	return node;
 }
 
-static inline struct xbc_node * __init xbc_add_sibling(char *data, uint32_t flag)
+static inline struct xbc_node * __init xbc_add_sibling(char *data, uint16_t flag)
 {
 	return __xbc_add_sibling(data, flag, false);
 }
 
-static inline struct xbc_node * __init xbc_add_head_sibling(char *data, uint32_t flag)
+static inline struct xbc_node * __init xbc_add_head_sibling(char *data, uint16_t flag)
 {
 	return __xbc_add_sibling(data, flag, true);
 }
 
-static inline __init struct xbc_node *xbc_add_child(char *data, uint32_t flag)
+static inline __init struct xbc_node *xbc_add_child(char *data, uint16_t flag)
 {
 	struct xbc_node *node = xbc_add_sibling(data, flag);
 
-- 
2.34.1

