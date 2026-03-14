Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D773921E3
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531138; cv=pass; b=K2cA+bmNlFjmoktaESe8sTVS/KEuxKIXnCXu1MepTQjfI6RoPFpE14hneYfkIctAOYvY27l1otXfCn2LRvad01flzKIsJxmJxQe7hsyuj3iomnFciUTcc87yihWR+2WL6lJZ0VLk8cjOnug154yY2J7f5OWkVnZoA52YOToFf6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531138; c=relaxed/simple;
	bh=BT2q2siZTg8dVM/8aVNchawHfLA2jp863lq7U7GCyhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fd1UooASYBiZ7I9HVo+/l7p0wja2JvVXOnRx9Rub8a5j1Bi/ymU1K1geC4Zd5Ee6wpJnboVPpfvEsr5Zfm0LvoOMMuLh7HYeCsFuBU4RiG3H3Ikv2s6AUM7TjzKb1hwJJHDKbkR5bel3Ctk0vYSw6N2K8R84jNBr5kNuxHiQkto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=ACs0/6J5; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="ACs0/6J5"
ARC-Seal: i=1; a=rsa-sha256; t=1773531116; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=BCIZ2pHVBLfalEkCBCp76qEXYr2rppve36JujtT+YN61dWCylZzq/BxwXO9YwtyJo1mdQoY8tUc+MVBAqU0X0A+xntz16jUT9DnGf1I4ujjECOkDZbn/Rcu+eiTJPobrplrp8ebjmoCWh+1chxEWuMGStn3Wk9I9oV45o554evQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531116; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2W9qWDSpL3vKX3csZlcWzL71BWBE3j2mAMm1BmTvlg8=; 
	b=NUvqP70bgKemvyC4krnzjC9Ls1qre1SW9dhwMvTyAMAlH2o7q1LZJQqzg4fojHVE7bHj7wnoVtytslxSibKDUxux5fhcrf7q4rTzssuBFFmtZ+uQ8RK4RadPkHAKG6mZ7J09nkEWjS6kQ7lsfrnYQqeWnXEWJ22IsiKvBRSruww=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531116;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=2W9qWDSpL3vKX3csZlcWzL71BWBE3j2mAMm1BmTvlg8=;
	b=ACs0/6J5dCtZoxQkHbOL2zVZMHzCLZyZk/ySP3FPvSIHiNNuqYX7VY/ln5pU2ZLp
	LsolkX8DeBQLzC8Iq5IG3vmUjbOSo8nfLhEPoRCCWW7eek1U4GrsPkzVgShhrhQv85I
	Ka45NKNTUBqj/jwU7dYEkw/PYUNPgFgFZxp+pAYA=
Received: by mx.zoho.eu with SMTPS id 1773531114749601.4293110619426;
	Sun, 15 Mar 2026 00:31:54 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 18/23] lib/bootconfig: fix signed comparison in xbc_node_get_data()
Date: Sat, 14 Mar 2026 23:31:39 +0000
Message-Id: <20260314233144.187273-19-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314233144.187273-1-objecting@objecting.org>
References: <20260314233144.187273-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

  lib/bootconfig.c:188:28: warning: comparison of integer expressions
  of different signedness: 'int' and 'size_t' [-Wsign-compare]

The local variable 'offset' is declared as int, but xbc_data_size is
size_t.  Using ~XBC_VALUE as the mask also involves integer promotion
rules that obscure intent.

Change the type to unsigned int and mask with XBC_DATA_MAX (which is
the 15-bit data mask) instead of ~XBC_VALUE, making the expression
self-documenting and eliminating the signed/unsigned comparison.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 182d9d9bc5a6..806a8f038d24 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -183,7 +183,7 @@ struct xbc_node * __init xbc_node_get_next(struct xbc_node *node)
  */
 const char * __init xbc_node_get_data(struct xbc_node *node)
 {
-	int offset = node->data & ~XBC_VALUE;
+	unsigned int offset = node->data & XBC_DATA_MAX;
 
 	if (WARN_ON(offset >= xbc_data_size))
 		return NULL;
-- 
2.34.1

