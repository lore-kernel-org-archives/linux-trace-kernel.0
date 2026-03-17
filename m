Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CE2F744F;
	Tue, 17 Mar 2026 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763786; cv=pass; b=CGrmFI7lzr/NPSMRYdaPdGCsn/EvBAu1k4sR76ifBZUYLsRqrVvYMeha0HZd5eHsr9zlwH2Taz2cCO/iWnKWfbAoZrFESTbTVJDbzYTIt4we2oUkabsdQ+K4ZqM/xvK8uOf1NVHEIzQbauP1mNjuuXL4nND9cv2WvnersCxFsD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763786; c=relaxed/simple;
	bh=mcfYTARZ9+qwn1715pM8kGZGCcYS4MRg74eXwnmMUjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ULfllHa6+YnzMbOGkpzP9JSkK/a1siS01hv0MEYquQDzRDQwsvZUhGxNDIC5IS9jNScO7UBCLRFbq4AjWjjf2KmUFIYGVy1UvtmsCM/xO3Ib06YfVHWdBOdh6sh8D/icHfrsR4SgAGxnQMaQz+vy8P6Q68R9cf20tVhum4gPZvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=cNTc5q1O; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="cNTc5q1O"
ARC-Seal: i=1; a=rsa-sha256; t=1773763763; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Z5ahiPTB95FaY4IkOFaBY9YpGB6R+RI0u4FQNr0TrbD3lVpZFMzWWcNFZEVBTkYZ5n0WtPhM5fyI1baCMPwvDY9ABHt+5E5BNJoZk2f7ytKdLsjSugC+xR5c1IRC9wqFNXM/iUjLuYh5VhNTlNcf2N97fU4nRvnDSQn459Ta5p0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763763; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xdisry/4Zni34uBuoGLJlIlObU1XusIYMD8aJlTO/98=; 
	b=BCW9m+griJetR8LR/l4yGGIJejr3wW1dFUWrPfq0zsGUxiZa587vIHwKQbySIgFfS6aPl+y59HN/CW9GLSN1TLMwQuTtycHVszkKDAbnBaOQY585UoZF3a2nAMwP3XIFzpGYpIwccc9Vvlje7IfOJfDgW7mRsUbfmIILI93ONP0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763763;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=xdisry/4Zni34uBuoGLJlIlObU1XusIYMD8aJlTO/98=;
	b=cNTc5q1OdOUJ5uEV/OuELe1CkN3pisbP8tcxzErsPF1km+hE2JRqO+nrh8FRuuGY
	Y3KccmOi7FcYq/vSAmulYNXxOkGWRMWRcccYiZli7f3jGIszr9gb84l5BY0oaaBhSSD
	vuzBMTeurYQbgMb08UIIGLoQCHBuTCO54/Jk9V0A=
Received: by mx.zoho.eu with SMTPS id 1773763761911215.23154651182222;
	Tue, 17 Mar 2026 17:09:21 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 08/15] lib/bootconfig: validate child node index in xbc_verify_tree()
Date: Tue, 17 Mar 2026 16:09:09 +0000
Message-Id: <20260317160916.33576-9-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317160916.33576-1-objecting@objecting.org>
References: <20260317160916.33576-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

xbc_verify_tree() validates that each node's next index is within
bounds, but does not check the child index.  Add the same bounds
check for the child field.

Without this check, a corrupt bootconfig that passes next-index
validation could still trigger an out-of-bounds memory access via an
invalid child index when xbc_node_get_child() is called during tree
traversal at boot time.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index d7e2395b7e83..1adf592cc038 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -823,6 +823,10 @@ static int __init xbc_verify_tree(void)
 			return xbc_parse_error("No closing brace",
 				xbc_node_get_data(xbc_nodes + i));
 		}
+		if (xbc_nodes[i].child >= xbc_node_num) {
+			return xbc_parse_error("Broken child node",
+				xbc_node_get_data(xbc_nodes + i));
+		}
 	}
 
 	/* Key tree limitation check */
-- 
2.34.1

