Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51D3F54A1;
	Wed, 18 Mar 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849579; cv=pass; b=Dnj6mx+RG+CFeYSb2aVgqNFyYFzOOafZctaOc16PmOiXQDrEoihflfVLD35qOmZmO6TwqSXnAYvXjcuUnOOK87g8e/SuykJJI6drznXr2NRGBO9S90FoKlbqbV4n7BT4qKYIVlKc+Jb1KCu/KQu+S8Z6kVnFvMKdv+3f88O4krM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849579; c=relaxed/simple;
	bh=mcfYTARZ9+qwn1715pM8kGZGCcYS4MRg74eXwnmMUjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDcDs/E6v4dDa2xht8GkwBid8hDg0Tm0pJq4t9Gy9ymT59juYoourqusjatFqwwGqI96QbodqggQzEBkphyfU6eQzh27ygR7LJPQ4no4K5wldrHyaPnF3Q2D2Sm3VKBXxv1om018NbW6dp1fiRBK4EdqNz5eTx8SXSA0ikGncwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=SZAIYLE7; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="SZAIYLE7"
ARC-Seal: i=1; a=rsa-sha256; t=1773849565; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=VVO2zorH2AyS1vMwuNjbZ654AmkmzuAbhXrvWXOrYda+G+PSmPffadZ5/k7H8UA75uweIeGFTBJgStDJbzY3MRjmUcZv628jv9lliE/P8pIwrWOHqr9q5rCnFpoEhjzJYRXh28p3qeX11JyLJMH1VPHYrBoiv5N1nY02fqkwiFE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849565; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xdisry/4Zni34uBuoGLJlIlObU1XusIYMD8aJlTO/98=; 
	b=i5cx1zOGYH8B1nKCc7r3qCnnnHMVgQ0vngYzZHN32ur+me3XSrFWRNVvu8aJP4ee+2QQv1vMRWttWFW8IXgaHSJCwlFoVGipxyO3sach+yYEWWh0zvlVKbcsr3C5sCHLoRruEXH0G4XW7/drjUxucX08oZQM9hIJctA0b7axlpM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849565;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=xdisry/4Zni34uBuoGLJlIlObU1XusIYMD8aJlTO/98=;
	b=SZAIYLE73AEIbBn9YhhmjYE3AStabKqw66cJMDvqPrnNGR59ARP7khfVCcDpWkVc
	s8q2IVkcy4A3FkxJBUzh/lS1ddEiTeOEW3PYEnJKCEmmOyZ3yKfzfI2TMq+wK421gc+
	qJP8K0b6YosTuC+XPqJktVlM7YzmT7p1zNBFdU88=
Received: by mx.zoho.eu with SMTPS id 1773849564239402.89581126211704;
	Wed, 18 Mar 2026 16:59:24 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 08/13] lib/bootconfig: validate child node index in xbc_verify_tree()
Date: Wed, 18 Mar 2026 15:59:14 +0000
Message-Id: <20260318155919.78168-9-objecting@objecting.org>
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

