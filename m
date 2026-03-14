Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C99390C91;
	Sat, 14 Mar 2026 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529338; cv=pass; b=Cfa3nGcUQ8dpKreD5pqebeCAWR44qNBWAzMGOnTSizo2ecnstc+cESMaj96Uwf1GFSteOp6SMDefwcdczGR/xgDty6gGRn7mUMOGq4XT7lDohdX5dIlC+CoTTSAtaK1je3B99RWlcRzN/RCH4Cl5Uinr0b+KjBJ19iuRSD3Exs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529338; c=relaxed/simple;
	bh=ZuUlVeCERGWi0kiPXUflzzixT8Dr5l8GMnBPX34kkGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=smyfpY7Ceu9MTwq86baqZBmYXc/pH+e2jZaRlxjH36ZfeJRK+gQtKVZuD/s3x+kcdOAitps9G7YVVZxkbRgVHPcaT4y15jjANTY2amvx78BaMRmz3CjyQMMrXhXxlaEW5WZrWRLl4DqkC3AVOSOLhoLDc6Xynz7KKEzQINyU+rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=hfwwwIXe; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="hfwwwIXe"
ARC-Seal: i=1; a=rsa-sha256; t=1773529328; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=DPWSjSWhe7hHUpZCpHxRDCLBabInn46gB+NWS0C2HNHHH1HifdY0W8zt2zReQANI4z66aWOrb2R+WWpWbLcdcnZkcA00tL9imOFxmoUO38vhO2z+FBwEQ0gXaObYufLMTyJgibWZTIPHpnLQP2Rq9UvYMEnCHjxkG54wmhG6aLk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529328; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jQa+d6xwRxy5WvG4jIfj7hMRpG3HkL2h6UH+aTlgbd4=; 
	b=SmFrXpaktJLjtqy1t8l3rtb37Q3L8tFRkrffZKECoRurbjg4GaGI7mm/UkydORPGMnFZC0Kh/RO75CFVfFnPIVoC4FPyjDVHRvWfT1rhR+Gj9Ia7HgxT2m8kJjdmyXhvSC860vhY+Oot0byK0m6uTRThAmAyQ2JvgaP+qE/Q3wY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529328;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=jQa+d6xwRxy5WvG4jIfj7hMRpG3HkL2h6UH+aTlgbd4=;
	b=hfwwwIXe3nKqGYcixLrRvff6SBB+WAjOfX47U9QfiUJpI3qUPMB5qp3bYtCAFob7
	I8f6r80n0Ri1Oj60lLXVVD//Cxox17R9/Vh1A/9EnkgXcNqbQNMBd8iRIaNBm/Bflg8
	erv8WvBc+muxuE1BruzMjOkx0inz5uncisErA9CA=
Received: by mx.zoho.eu with SMTPS id 1773529325618279.67470949743495;
	Sun, 15 Mar 2026 00:02:05 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 15/17] lib/bootconfig: validate child node index in xbc_verify_tree()
Date: Sat, 14 Mar 2026 23:01:53 +0000
Message-Id: <20260314230155.155777-16-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314230155.155777-1-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
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
index 0823491221f4..038f56689a48 100644
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

