Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB293859CB;
	Sat, 14 Mar 2026 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525340; cv=pass; b=XjgbW950peY8SYDFZ7rwQMyZSG3AiB15988ULPc2l52fPrVOjlaMTCbsEAqJTKIJuxYWINmgUavvAOdgrzfSNYZpaIk1nP0tWLmEzH3mx07C4uHIJMne8Zm/iczXT/NgI8AtUnh/v0x8bRAY3iTx8Y1yFN466syzi2bD6G2rV7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525340; c=relaxed/simple;
	bh=6svVtZsg6MEUjaimzvi33uip35p+FZFQJNiBWVQzsKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cF2I0ipGBaOC61IduwKajLchw99xfXnrU9KL5Z3LVD85ONhTN+t2vfVq8QeM8lpnkNHvvYHW8/ElRsNN1BZgqJePOJlDaVGKw0YJPoG+Z+3zU3o+Y4mCDIdMPu11uQ4bOMF1Rlj8lAeoaYEMCW9fmFNN7OODoHbIqZrlhKFRou0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=FJ/H6GSh; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="FJ/H6GSh"
ARC-Seal: i=1; a=rsa-sha256; t=1773525331; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=BIV1u2WoYhFoIR5FmK5UkZdLqpxsFqGRFzBxPGBZeJxrEv9eza4hoIfpMiQv4vvLiYUeh8kezv7oy+4cy1mHwSAE0BNGKsCOWN2zMJOcsBS3PHB9LYLwycGiCTDEe8KHJ5Fs/Ki/1yr6Ut+HnM/WUrHJtiMEr7XJWiUe2iVQS98=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773525331; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fWLmQp+E+iKxPqtXRglbvpsORXtw/1BYKl9r2jjl73I=; 
	b=gtyGOya/1IKS/Pd5SGiZVtGyuRxaQu6AQMq1bWrAcob5ge2nQe5MKTHtBbBOSAOmxNtr9CPEbLV3C14Hd9Vqz/nyC/YLI/Tmq6UMs7XK1tgB8t6z+3hV6s3cSzXh1sb0C6hMXEWtiGxdULQA53YNrjEx5J3x6ZNhZIWABNP3Ie0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773525331;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=fWLmQp+E+iKxPqtXRglbvpsORXtw/1BYKl9r2jjl73I=;
	b=FJ/H6GShLNpox7RBuyWmn4OCTsoZ+U++7tahoX4dn5TIdtjz2oJy922Mj/8Htxjv
	9KS+sU3cgefXsz+lUWKxEbUHJ8k94rRLmeqpbtQfH9I7yZE+Q/Jfif5ztOiacnuJXCR
	2p22R57HZFUgYqlIdh8g6bHTHhnXlqYvxLy/9y6I=
Received: by mx.zoho.eu with SMTPS id 1773525329731332.48671757054876;
	Sat, 14 Mar 2026 22:55:29 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 04/14] lib/bootconfig: add blank line before xbc_get_info() kerneldoc
Date: Sat, 14 Mar 2026 21:55:16 +0000
Message-Id: <20260314215526.108651-5-objecting@objecting.org>
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
 lib/bootconfig.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 35091617bca5..e955d2f7e7ca 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -79,6 +79,7 @@ static inline void xbc_free_mem(void *addr, size_t size, bool early)
 	free(addr);
 }
 #endif
+
 /**
  * xbc_get_info() - Get the information of loaded boot config
  * @node_size: A pointer to store the number of nodes.
-- 
2.34.1

