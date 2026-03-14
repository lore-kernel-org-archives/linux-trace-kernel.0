Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0138837C;
	Sat, 14 Mar 2026 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527681; cv=pass; b=feWKztPDJqLhx4q61C6E+wq2n+dNVHiagExMiz6qipgAfIFL5SkVif3Lyf6t3usikRzYrlFyg/z4BKkX87MM+JvCUdedAajkHdQSud1JA2WHoCpbC5B4pA/uZabyYXvxu3Rr6qxIPDlCvv83bENDRoO3/t7l3OLtLqa1GhhjKNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527681; c=relaxed/simple;
	bh=MjX+L5BkroUgaRrcSwrGDKK9It5hNznJ9Ds+whNCQGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GIzwg9opZVATAkd4D/4OkfHkPGfAiEZseMGSRUJamAX5rQSFqlkv5PawBEiIsQjxSYMRsm4ft55h63Cm4/My8DmnFqHA/y7frLVATRwLMdJkmnGmlz4qGbJaTfuLNctI5zNbfgL+aGT7TL+kEN+sJSVRxODCehAWkE/2NPJ3bQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=kB3EJ9k/; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="kB3EJ9k/"
ARC-Seal: i=1; a=rsa-sha256; t=1773527672; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=D2CZOAHgdbNhzWdxaJmYuXWJ89p1NXl9gAZyKPbO/bClG3nNfQPXj3reNULQfd4teuGiKFl11RnU+Usvaslu/KyURMWis9ccOrmK/LtOzKbLLbjVsvvG+LUyastRvJfqEVTz6pYbl59z8PJuu+QCEGk7G2LYNivRh6fVnVyDfSA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527672; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6vqu+catdL+p5SuHEICmEvrCdVO4BKlL3X6/JARWFjI=; 
	b=cinVIvmg8Gx+6i8Kic3BmJHrK9NRr0aAAT4CTl37n/KtLKC0L6G/5+kWB1sVoUxhd45x6+6GTXix66+tOHu/ZF9aKP9lvKtDvHa7nDTrdpaaueZ9aVj1jID70gDWsfdBCJG5yfxhz6nFXPHKZuwO2tv+vgBhWM7Pzqs2QQ1kYA8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527672;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=6vqu+catdL+p5SuHEICmEvrCdVO4BKlL3X6/JARWFjI=;
	b=kB3EJ9k//29P4FQrdR69zm8/+0K2EnndPrAnKipun66Kw9IUmz6izGxatihlcQYw
	thrfSJ1cmkaQpNJc0rI0rgrXYdvcuuo2csgkxpomKyltwN7nm2XgmpV3Yn+6B1JM3/V
	iM9HAzqXF8A5AgzQR1FBzCSOA/zS0nCaufUocM78=
Received: by mx.zoho.eu with SMTPS id 177352767023938.11398809248021;
	Sat, 14 Mar 2026 23:34:30 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 07/17] lib/bootconfig: fix inconsistent if/else bracing in __xbc_add_key()
Date: Sat, 14 Mar 2026 22:34:15 +0000
Message-Id: <20260314223425.142966-8-objecting@objecting.org>
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

