Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD53F0AA0;
	Wed, 18 Mar 2026 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849548; cv=pass; b=Y4dV48Gh6isDPyy4jDLe5hMnv/B+bKbxL9rTwpFnGv1Gnzd6+kwgI8PKJpNSdGw/wHNoxk5e1e363Qb+UZfur7ZnI7p7OZTNWDoNBUaHTDk1JWCqcULEQeyRLM1aG5OLRPxd1cFb27fnaKg1rFa8SjN13Gwikw0MBnjckVStXfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849548; c=relaxed/simple;
	bh=rE2/Tnj0TIqrB4UMNwQFMx/RojWYdnLFDtQSyF22ZKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLqQzLUa21ZD+2N1zDaeAPgbwZh3NUL5lZFcPLqi3eMVGTnBWqoz2YX3OAHD1KIod7C4jVqwiDJzNLUJwAngkyKeRjuiDQTgB0Do6eojzNeAYvNpQwGDaNdYOnfi0ND5plKcOWGW1bHds/3+7DjpaDHClubWkWsP3MeJy5vuJLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Q2h12E4x; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Q2h12E4x"
ARC-Seal: i=1; a=rsa-sha256; t=1773849531; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=kJOVOBUiUQCR64oKl80zjGY5H/FcWBF57lATURxtSppsrYpwT2Mc1AgV6r1z1aqDDgPdfU4IBRN9s4YPpfqujA7hZv8gjVm8ofKstjRRE4pikW0IB5579wnl2cosc0Hh4rmZQJTt31Nbt6vFann5wOInRsBfr3plHJMyJCqcTOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849531; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nG+a8XwxykTG22ppFE4Xm1p8EJcF589vrbNMwy0/cPg=; 
	b=GAu+iJbYfXbts768cAzbC8CUzMnvDPnzGp1ECsobsJpqII/jbEj2pdQCUVkjFK9qYMgslY+6yfq8MAIZngfIu2/iG3n2vFecXEAo1h0UnRngvY8vbfbC2pxZ7PsFuc/wQpLQiQyglK6vAHfvEdJxhyC44t7U/zNxkgaLbgvMuQo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849531;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=nG+a8XwxykTG22ppFE4Xm1p8EJcF589vrbNMwy0/cPg=;
	b=Q2h12E4xc3SpnDvnXj9dpY/ii7+wWmxd5OLA7Xpj0O3um/N661ANV8Sk3NIwfMdO
	xs6JYz76JdplE4C5OpZ20bt9WdtjQ7NKs2Y5e/if0GTxFwKL8ETgRYV0oU3xz2lL440
	tmRBxmMcEEtPnrLqluEWl+7TXgrbDcr9y4fv5SDQ=
Received: by mx.zoho.eu with SMTPS id 1773849529942558.3067205742504;
	Wed, 18 Mar 2026 16:58:49 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 2/2] tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure
Date: Wed, 18 Mar 2026 15:58:47 +0000
Message-Id: <20260318155847.78065-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318155847.78065-1-objecting@objecting.org>
References: <20260318155847.78065-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

If fstat() fails after open() succeeds, the function returns without
closing the file descriptor. Also preserve errno across close(), since
close() may overwrite it before the error is returned.

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Signed-off-by: Josh Law <objecting@objecting.org>
---
 tools/bootconfig/main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 55d59ed507d5..643f707b8f1d 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -162,8 +162,11 @@ static int load_xbc_file(const char *path, char **buf)
 	if (fd < 0)
 		return -errno;
 	ret = fstat(fd, &stat);
-	if (ret < 0)
-		return -errno;
+	if (ret < 0) {
+		ret = -errno;
+		close(fd);
+		return ret;
+	}

 	ret = load_xbc_fd(fd, buf, stat.st_size);

--
2.34.1

