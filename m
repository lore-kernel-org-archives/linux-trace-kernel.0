Received: from sender-of-o53.zoho.eu (sender-of-o53.zoho.eu [136.143.169.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CCC3890E7;
	Sat, 14 Mar 2026 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527681; cv=pass; b=pej4vfg9kd1hNFLjmgLn/czrtSlq5t1saqjEpvFipAzrI7/Jc903pIpFelfrxsJdogs4FIt9jho3Es+40wtv/m5wqoX+9+BMujtka7EgwwNgq5mlbvHx9Xky21GCgl6Xhq6K32FbjiPE3gI1gCO+Ny4hspPBDP48nwZD//7VRp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527681; c=relaxed/simple;
	bh=kDcgT5gXzTP1fqOGMdxALgedri0gVcD3is/FfzavjKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJcTLHJQa6xVdT5VRfnQCluNtkwnNp4sHlYsZKutLzYYI+Z6LROlMzA1g6XBDVxRWgH2j0IQSLUnhPOpKupooN1Cu0xYpfl5g9A6AL+/TJIPr89CWmQIWoBThO9Nfxd1qiakeTLrX9PIcqK7l6YvTaCfx+r27/yeWqPXdRRpiTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=hlUQX9Cf; arc=pass smtp.client-ip=136.143.169.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="hlUQX9Cf"
ARC-Seal: i=1; a=rsa-sha256; t=1773527672; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=GxdHUyYn+CwQ/6Y3A2/j7ELjdDSCq5R9gKCV2EU+afdiIAF/SXbb1xcAcNpktA6VHtMkO7Ebn5vpQU+mZlXOTKzfZAlDqjuFBZ7X8aJDK4hAlQ7UwwoEewsPGg/FVZcQuPhAPF+RSci5mcTlhKRRfBym1iBUBQd4ryRenwMa47U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527672; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7bmeZKaQTYKiPdWWEUmU4EJNbpBFQlYVqCIGyMl5PZg=; 
	b=IGmtg9jox5eIDRPtO4+dOHrpkjMB5Hz4FiHmrv3EtZRN77ErOFh5nIfUErdQgEKTSGkQ68GBKS6v8iPNVSJXXOQBhxB/oiwQsLlT13QfYYCSgkmkSQ2Hk4vLGeSoAHE18l9rqC36m7IzeET8vDWWLAnBhApqyvkuZCpENN9w2Iw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527672;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=7bmeZKaQTYKiPdWWEUmU4EJNbpBFQlYVqCIGyMl5PZg=;
	b=hlUQX9CfPnFFh0ZiKtcC7qdC2K3S6m77zmFsUdIX1fuw36ueY3OZ2UWocUI72H+t
	sZtTVltO9stGeRMUu6Uzv9hKyKwj0v2uKWZl/wrkEv9EEV5s6kmQuampZjv7YV9CG8U
	2P1TkqWycnplocqg0BodFNWAvzRVhcEyYjGG+L34=
Received: by mx.zoho.eu with SMTPS id 1773527670807699.9089571616523;
	Sat, 14 Mar 2026 23:34:30 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 08/17] lib/bootconfig: fix off-by-one in xbc_verify_tree() next node check
Date: Sat, 14 Mar 2026 22:34:16 +0000
Message-Id: <20260314223425.142966-9-objecting@objecting.org>
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

