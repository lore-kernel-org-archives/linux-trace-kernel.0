Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7D3F23D4;
	Wed, 18 Mar 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849578; cv=pass; b=Gydbz9A1sHveSyrXcYqoVjJ2QXD8CHNvwZR64eJ+VLMpxnOfogByHH9itCn9Qqdnw/a4yuynkhGnawD2LC/SqwKR/PcjCc5OmS/RH/Y34uo2AKiaFlYhwXJhdh+qZ/2A6mRnwG8knDmYZrgkdBUu6gFOweIGFAYhx1Aq/o5tu7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849578; c=relaxed/simple;
	bh=6Fo6RSQQSEkzHn7Jh8Smo8YsAtoTRq1YRco2C0K7n18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnHpJtoRH90A15N1tIK+cGIIsAdqPh9c31iJqmLIvNAJDYnvVOGQcZbyjMzlCiejsfvJpWLeiF4cbPOTdltsNsiI7CKJAi/6ar+vVRgZBiUVu8CnmLBt1x/9j1X23Qq6IaHmdfaDYLWFvkCBcRaJ75jkMHG+mA/oOLGtbJGvPsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=IGPSqvM/; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="IGPSqvM/"
ARC-Seal: i=1; a=rsa-sha256; t=1773849564; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=EtA5AF5BD0khFAK4UxgofTjCtmJ6w6gTSwtKBRI9hzlgqE7Fo8wN0Fy0MjL6F9q1vsQW13kUm+AqkLY10aVtyXMiKmy1GDA+nV4yzjpnoGqDXdQ/khmt7KhX7X87nD21hYH70B6NJ+JsoYtIrBUT8A/+zlYUdK9XQnEaRopiSnk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849564; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vtmO6u/jqqPXfSKF2EgGWY5wmzpnk5cpwQL3qgwBYG4=; 
	b=AfbOdwf+WGIC/hfYb9/jeyx8XcmgBr00/477nYVe5hSBh/K5kBhPCMprjqZUo0T8i7UrDjl4Gcl9EgRiAFO31o8WhpBxwtv6ZyDRGAuYQREb70d+ghpTbH6vEMbo4hYNduhSGGZhXkBjLY8Phu/kGMSGJ6gzZzMy3a/rzRhetmQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849564;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=vtmO6u/jqqPXfSKF2EgGWY5wmzpnk5cpwQL3qgwBYG4=;
	b=IGPSqvM/vh+MMc6Nmpx1J75JaWkgl6/I+wLxNvN9TqjNWt8V6EOJpw6u6fDFeyni
	NQOwbeP4HxjQInK3d8npLb7IJbttXXrSM2xipJcU6tl+Ti6hU0Z5CSG/0QON2yKm7bj
	dXAuhptdYWz8gYF2a4cFtprBftnBCq3vPBkZGQrs=
Received: by mx.zoho.eu with SMTPS id 1773849561111381.26346423146117;
	Wed, 18 Mar 2026 16:59:21 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 02/13] lib/bootconfig: narrow flag parameter type from uint32_t to uint16_t
Date: Wed, 18 Mar 2026 15:59:08 +0000
Message-Id: <20260318155919.78168-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318155919.78168-1-objecting@objecting.org>
References: <20260318155919.78168-1-objecting@objecting.org>
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
index d77b6533ac00..d69ec95d6062 100644
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

