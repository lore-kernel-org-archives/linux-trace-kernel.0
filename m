Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6043859C8;
	Sat, 14 Mar 2026 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527684; cv=pass; b=fomLFL2EWOhTSSXbu7Z7+3g0RHVS3hKTiJn6CKmXqAZrPYUVtS44/TdcGfYArlxbk2LVGB6o0uv7YOxrjkKFrPEH4zGyiqoW9yr0JhX+dFFzHomwPoh8VeHSoUDWs8XxtPM5ov2QaNAcVNxBxKfHq0bC4hcJUvMnMxwcyDuxfFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527684; c=relaxed/simple;
	bh=EyQa2yiCR3sisK7A/Krl1IC09X8Q7RdNked45ipt3G0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=teDDiV2dtSL0TMTpHNdCwLfQ2I/JAsP3WTsKtPjrO9BlJTqie4du+9bW4/kKZNLQ9BxxPzwXc9R2+U/7VELHVwlTp5Q928mlqXfmS7DCimdKP1SZqL0dd0ujAyVrEEbrIU4B4a3rFlyp+2Y5qgLqfbSIy06XP/YwE+svrXxYDaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=nhwuJKvi; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="nhwuJKvi"
ARC-Seal: i=1; a=rsa-sha256; t=1773527676; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=bydEujns4hDvrdxEs7PzqaGuhQVpqTmbfqVOdog8puCogiKGZ31j6y4Fw0EN97HkAocpBH6RBMSyxPABL6lDu6Wyj2o9exHrcLnR3jHklM8XqgfOSvYsZ5LOdmmka88GyZ7n08bCSSkq8d9uWRLH9FlKcZ8OaMGmUwt91f2lRRk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527676; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q+C7ggGoU4QHs0Fn4FuoB2kR86tEhBwFbzmCOlWlA0A=; 
	b=M8A7OjmSgsE9EIbuzdj/AAFM5WYbT9gFfNF2pQhls2DQ7ETTWOzL55gNvwZgt0ufiU/auRlDheSKgmOhO7OYvFPym33xgEWsn9f7WDnkHE+bSG1RgMmkzT//f/9CKh3xH3c5EvxNc6NbGd2hMKRAItOSZTLlIUXReBTxsJraKGQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527676;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Q+C7ggGoU4QHs0Fn4FuoB2kR86tEhBwFbzmCOlWlA0A=;
	b=nhwuJKviRtwMwkAqm782ObXqT3ITKEZzyDw5oWr07EApv/lwtCQeLPDhh4YaEToK
	bsUVIdJz36W7lmTrD7t2vWEzgv2edHLGeXuQhNF95jmO1+l8Gmkj/VqyBHKz+k70CuP
	Al7UTUJAsWNLlexZGiK9ZNcv/rO5iGQNf1MSxgno=
Received: by mx.zoho.eu with SMTPS id 1773527674466602.1923633326625;
	Sat, 14 Mar 2026 23:34:34 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 15/17] lib/bootconfig: validate child node index in xbc_verify_tree()
Date: Sat, 14 Mar 2026 22:34:23 +0000
Message-Id: <20260314223425.142966-16-objecting@objecting.org>
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

xbc_verify_tree() validates that each node's next index is within
bounds, but does not check the child index.  If a parser bug ever
sets an out-of-bounds child value, xbc_node_get_child() would return
a pointer outside the xbc_nodes array.  Add the same bounds check
for the child field.

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

