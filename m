Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B406386C0C;
	Sat, 14 Mar 2026 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525343; cv=pass; b=H7NGTxj9tP4tiZR6+vGcgIUBRM03/23AXSWL8MWMaQiKwXyFEMgT778bHqbdZpYRwEoPE0TEDCSkkLWfqXZYeI+4O9QoqDRg7GNiMO7T7cnoW8s3dl9hp3DG/NLLtcvDKPze726XZ0tkCIH1o5AEeFOTf1rTpOcfAOe3faXLdpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525343; c=relaxed/simple;
	bh=MjX+L5BkroUgaRrcSwrGDKK9It5hNznJ9Ds+whNCQGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qA/K+e67Mmy2Q2tEA0Vsg3H4giLOw6RqW6VbWh3AQa+0QUXxTNQed/i6KylE3Ggj6iyc/NeGuay4HOfC4L3DMKV5lKv5YxNZl0GW8zuIqARYNJk+yh+Ong5In1FMk0m7n9UBT0wnBR4xDR43RebKfOtcr4G3CUFQJ4pqmC/INBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=FZyorZzV; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="FZyorZzV"
ARC-Seal: i=1; a=rsa-sha256; t=1773525333; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Rfd9vyfh/fds/mMv+yo6R0DTrExSkP5d31FqmmgjD2NRHzKZnEyDu6WPXqQkFwOhJUm9IZujjvZxcnF8xyUOJdfw8h3yASFsL4Tk16RiGeF97ijjYuuy2FNbvvVH9saVuuIqsOqWHAX2wBRLb8skvhQTL385WaYcaakZN+m5nV0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773525333; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6vqu+catdL+p5SuHEICmEvrCdVO4BKlL3X6/JARWFjI=; 
	b=GovuVFBSwD/zOIFpG1y5DajKbyiJ9sxtS96ljCmWeFBlGNxNmt38ufpu6hM204m1KCDg1KZLFR5vgxl+kvqMSsuwNiMwwALJK3I13ET3B8+Q/3Key1u0t1cAFy6yWHNyyXU7b7tkv+zwd+uiZ4wQMJKVxSYvXMXn4iTrLcD68ms=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773525333;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=6vqu+catdL+p5SuHEICmEvrCdVO4BKlL3X6/JARWFjI=;
	b=FZyorZzVrpI+FGKswIrWOFUPkCA6+5GerBfKbjsLoLND9BdqQF3LEpxQnfJw+qWA
	m1+gvBZiTgkeHqI+63aWxZxEIolUXNQP41BW6VAFEp1XCXWrs/GvxIIIFuvsUqJBCWC
	LYkkeIxSEwQjbGn9VmXErmvQWpO1ZJTYYflI2+mY=
Received: by mx.zoho.eu with SMTPS id 1773525331339673.1430768261707;
	Sat, 14 Mar 2026 22:55:31 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 07/14] lib/bootconfig: fix inconsistent if/else bracing in __xbc_add_key()
Date: Sat, 14 Mar 2026 21:55:19 +0000
Message-Id: <20260314215526.108651-8-objecting@objecting.org>
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

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 34bdc2d13881..58d6ae297280 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -657,9 +657,9 @@ static int __init __xbc_add_key(char *k)
 	if (unlikely(xbc_node_num == 0))
 		goto add_node;
 
-	if (!last_parent)	/* the first level */
+	if (!last_parent) {	/* the first level */
 		node = find_match_node(xbc_nodes, k);
-	else {
+	} else {
 		child = xbc_node_get_child(last_parent);
 		/* Since the value node is the first child, skip it. */
 		if (child && xbc_node_is_value(child))
@@ -667,9 +667,9 @@ static int __init __xbc_add_key(char *k)
 		node = find_match_node(child, k);
 	}
 
-	if (node)
+	if (node) {
 		last_parent = node;
-	else {
+	} else {
 add_node:
 		node = xbc_add_child(k, XBC_KEY);
 		if (!node)
-- 
2.34.1

