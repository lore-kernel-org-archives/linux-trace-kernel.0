Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015A3909B0
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531135; cv=pass; b=b/bH581CfSQ72jAicmeNx0pXIB3VviZEWiF4x6NLHp9xJ0HM8x7inVyOuHhp8ZUsdTRmh2Wf47OdwaES9psiYtNTKA+s7o1CAXpMJ+N5D2Qc/32f0zuj2R+4vj3WyYiLNCuKyoT16d3maHqYpjvsgGEI87oeDUBoEvycDD1w55A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531135; c=relaxed/simple;
	bh=os0B7i8CIWcvtr1f+9MFrDH43djYT4PHUh8qcbGqh3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OwOAAz7scW2OmsKSk3k8axxePpkSDQMr3joqTTQywxDp5UEM2qMW4OuoP0FuL53kQg3FnxiQ1+UIvSEqNbIpkWsz2WRKuEa22QosHZtnv4EwVwq9Wsc3bXs4bgObKwPnzD68KiAMgPCpxSDR2yWoF2zMTACkHrfUatemZsVgPjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=FfYRdYII; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="FfYRdYII"
ARC-Seal: i=1; a=rsa-sha256; t=1773531111; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PzSEk4ReaGsA8YpKLOme0uTletY+ycwljSvND+mh2jjga8kELt6ZFXyfO3YEIczJG/LJ6b+00YZNmoY+1Q2142YzQ+2NlieXQT0zdEiaF9CQogNUPZ2/8S84odUKYvQrTsiUBPx49irTSpxQhcmsSXNAcF+0awTjPX04YZ/xjFg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531111; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bT0v2u+9Dqz/pWmeHK/egM9RCBp55B7VxPnClMaL4Oc=; 
	b=kL9+dr2UfIG3ckWn3u0YCCHhhuXT6jy9H9meBO5f9JI3oW6kyuccBSrX1q4IqsrR2iyzv0Ko1RVkTZdSjLVhlfMRx4zRaaxPtdE5jbBpwJAhWtk6nfP/jwsN9Y52DKA2uzf8xB4S0w4yiLW1LTpQH5naSRCCZqKlzj6d61nlge0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531111;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=bT0v2u+9Dqz/pWmeHK/egM9RCBp55B7VxPnClMaL4Oc=;
	b=FfYRdYII08HyfVUdQpFjD8jArYnQvW2FgX5xSq9h/LRICGN21MctLqBfbLQoUIqy
	VyceXGJCZyRmm1ML8QVAsLH331dTO3Bv/tA7G5jgao0mYM5xILmZxmw94eed/63AZrl
	4rJ/zsq1knpGu7lqRqogcjobadQ+//fZZ2M/4KRQ=
Received: by mx.zoho.eu with SMTPS id 1773531109260908.2127530925259;
	Sun, 15 Mar 2026 00:31:49 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 07/23] lib/bootconfig: fix inconsistent if/else bracing in __xbc_add_key()
Date: Sat, 14 Mar 2026 23:31:28 +0000
Message-Id: <20260314233144.187273-8-objecting@objecting.org>
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

When one branch of a conditional uses braces, both branches should
use them per coding-style section 3.1.  Add the missing braces to
the if/else blocks in __xbc_add_key().

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

