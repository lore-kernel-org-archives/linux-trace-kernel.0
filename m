Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E88386434;
	Sat, 14 Mar 2026 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525339; cv=pass; b=EzqZ2IPUC9eWxVp7j3QW3HtAYs4sDmnWkOuBn3WAgOdM7NjDqO646z7hYsCqVeZ2B/JJhZSFl7G90aMAf+WRTWY+i4VSRcUr7Lzq9J4ZTSR9KdI1rCaBLIVTDAF9ng2wwuPyT942lTqEPXe+1EVuP8/QfspHn2yKmLLnO7HoXXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525339; c=relaxed/simple;
	bh=mOcA5NumuG5htRvRiYXxJV6Vjf0pzLdSrtjWwr+L0hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kxi4emL4Sf0VbS5qcMR6kA7R4xQbE8VLSCZUWty+i3apCuh596u20HurZpJbAGE1fKh/Qh6/6sdhZkxI0VWoXWoxk9ySgFCCYNolVC7VSIVwtQ4RiCkwflIU9riH5Ira4on1d261xLpQGqtWrLOHk3wCW23xvTwaTeA0tyTttxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=R1KdWIMu; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="R1KdWIMu"
ARC-Seal: i=1; a=rsa-sha256; t=1773525330; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=bereKoItcpkYektrbOwzkeWtTS2OWTvGXO/VMucZDqzcei3kutak1rAPOuzopFRRs9izzez/XDw/siVIJhRHJjo33yJ3/SkapZoa1BiToIm/Ct81ExIyvP1T9Nfu2OdWyroI1bfhJifgfum78YmU+piLAAgLPleqOZAfdsEEyGY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773525330; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RNVEZU5OMpS4t6chZVfYPFtX6E6ANKPvlBhC6PXo744=; 
	b=TTFrOLTRIwudjB6fyHGfETXXtoE/BMPkHjKSoexT6gV/yv8ctFsqeF1mhKALUdWTP/tp3Luq9djHqGKWWTzZ2QnZ4L6ebKGNnDWuUS3A1tAUZWdfW0eC5s+QYpQEy+/gZEBdsCIQJQtwzLU/iXMAkLDFpMQ9xR6uAM39xPXEfTI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773525330;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=RNVEZU5OMpS4t6chZVfYPFtX6E6ANKPvlBhC6PXo744=;
	b=R1KdWIMutACdfYwFZfMMwBJwbvrHkM0OLTr+tPGSvFotnWVadvY4ZLIkcbTj/xNb
	897RUGzjOe1UlxZIRKNvGooAXyK0O6MMYbEONvQl8/NKhZk6VcDzH7Nl9cW5kMk2u+r
	OnUSbvEQoE4ejeA5Aw/WQIAI0GFNvvje02olhm6o=
Received: by mx.zoho.eu with SMTPS id 1773525328647370.8991259590367;
	Sat, 14 Mar 2026 22:55:28 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 02/14] lib/bootconfig: fix typo "initiized" in xbc_root_node() kerneldoc
Date: Sat, 14 Mar 2026 21:55:14 +0000
Message-Id: <20260314215526.108651-3-objecting@objecting.org>
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
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 51fd2299ec0f..53aedc042f6e 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -112,7 +112,7 @@ static int __init xbc_parse_error(const char *msg, const char *p)
  * xbc_root_node() - Get the root node of extended boot config
  *
  * Return the address of root node of extended boot config. If the
- * extended boot config is not initiized, return NULL.
+ * extended boot config is not initialized, return NULL.
  */
 struct xbc_node * __init xbc_root_node(void)
 {
-- 
2.34.1

