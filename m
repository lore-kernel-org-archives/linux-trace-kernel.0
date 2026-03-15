Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE4133B6C2;
	Sun, 15 Mar 2026 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577230; cv=pass; b=ShLng6Nojc7d4lOgLt+/9wglBG4Wg3kVBK6qJbsRzXtrUagzi4odP+x6iCa7g0OC9bfWqR0fQ99gDUE6dETqOCUSdVBVCgW/ZgKHKtf8EfMU9l0QLCTSEK0kUg+5e7b2aY4ezoRFtThAvJEB8a8NWMf+iU2JxHg3GiL0dD27ig8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577230; c=relaxed/simple;
	bh=Tcy477qCr4zjwSxEbmUVpzCk/GlV5mimINv1mxGanLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fC+IF8BQml/Wz8EdJEf/LMTbQeaDIvpH5UI0tWgk9lZanqf5VeH1O+IeroqmuAmdAN/74xXPP8ruSsVhppeVRiwqQ3IgJfEOmI+OqndUbK/Nt/fNnkE7P7FNMh4kmSuhJyW6Kmm/s1A2h+W0BPKtuD28wYQu4ipE2CycVE0n2MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=fy9nxf60; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="fy9nxf60"
ARC-Seal: i=1; a=rsa-sha256; t=1773577220; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=AwnnNU3lP+QNx1SgpLdIB1riTS2b+b4HCZz/1zvofzzyyBa44OW1Au2Q30rOql81NR12jlNQebgy2URedGrp4/zAwO/XhdbEe8ImI2tOg23ga/JUj6p+B9DR07KnbCHfbtgZRbnr7HpvTc//fTJ/wT9i2EePtekAzaFToXufC2o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577220; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6J4Zdammh5fpr6R0/8dSlFL0Tel9zMDt6j0TaDyyePc=; 
	b=bD4SM28mXjfgPxFohgvPnnWGBiwjjHjyVDEwg8E5qkSd/wxg9p6QZhgHvkDnjnw9aq4E7qPDvJm0EL0xwMK+b84tyop+HtFkb5xVctkjHmxqCWpZYuKG2ypaR/bLWfnjzKWAoOtSV6QxKad9YoiMWqSeli+saNYF5Jjqtf3EGQE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577220;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=6J4Zdammh5fpr6R0/8dSlFL0Tel9zMDt6j0TaDyyePc=;
	b=fy9nxf6079BY1LHNowWk0zsVIwi0hJRJ8RaEtU3/OM1jSEr/rVlZwHqE7U4gThZl
	fS85mvLHOGtGhI9AVD+HHdBCWk7WE48QsejTi9+N7r4I+N58kYuma3KgzJ6iOy4O8Hv
	a4Xxmr21m+UgNLkh9O9q3EVVJ3UgcJVlpRCB94Sw=
Received: by mx.zoho.eu with SMTPS id 1773577219047692.3955522801289;
	Sun, 15 Mar 2026 13:20:19 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 04/17] lib/bootconfig: fix off-by-one in xbc_verify_tree() next node check
Date: Sun, 15 Mar 2026 12:20:02 +0000
Message-Id: <20260315122015.55965-5-objecting@objecting.org>
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

Valid node indices are 0 to xbc_node_num-1, so a next value equal to
xbc_node_num is out of bounds.  Use >= instead of > to catch this.

A malformed or corrupt bootconfig could pass tree verification with
an out-of-bounds next index.  On subsequent tree traversal at boot
time, xbc_node_get_next() would return a pointer past the allocated
xbc_nodes array, causing an out-of-bounds read of kernel memory.

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

