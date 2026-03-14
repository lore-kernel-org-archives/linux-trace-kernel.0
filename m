Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA3385536;
	Sat, 14 Mar 2026 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524776; cv=pass; b=rUhgKodLSH3puGhPYXiNnegOYLE+TDVcbXgc0nDxFdTAJzFq0cSE/Um0R7RQKkr6YxWOCKlnWkMQ5NV+9Dj0ozSi9uGPhB5hDxyODU5KKRP7uIIo5fWnCVyfGGqjpkT1w1T2XVCXiIX2oMaLD0FINGxN9lb8sQ2gDDzI5EaAPDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524776; c=relaxed/simple;
	bh=6svVtZsg6MEUjaimzvi33uip35p+FZFQJNiBWVQzsKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMr/MuMGPktvA8LunrDCk+y5qaebVGdCD/8VVbFMWA/FCrCaAL2LRDSDhF+zXfY7TPehHoKOcK2N+Gf05hNv62t4maQCwhB6FFq8nrntCiVV722wOggDD53MrngYSCsNjLDD4I77dnRyzCxS7dfuMhteq1nh2wMLiPpdJ4Vs7Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=KfmS1RdQ; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="KfmS1RdQ"
ARC-Seal: i=1; a=rsa-sha256; t=1773524761; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=JxebKwoqawuNWPcFGpGQDMYf3kIEu+ixnySc74yy6GaSYg3HZg7Z+jWFUpfkDTpzOzTh267Pgx9JnwnisDdaDanPaTZQpRFDPZhuPLwkUnqJ8qY0Cil+U1cplEmBU/oriRcmlLQYJKE29LGup+WW6oJr5v0mZwev0hpC7xQ5nLk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524761; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fWLmQp+E+iKxPqtXRglbvpsORXtw/1BYKl9r2jjl73I=; 
	b=U5xksHDTW2R0uQrKbk4xJQmoVV0+DZm02kxZOOLquOM2dix+Clq+VhHhelRDKTmyOBXhx+jT5+M6ul8Nmdt/rT4T3t2weilq5q3L7faesUtr2hycljZX1WcYbDwqkE0dOwl13vnY8baEVet/2yU7Xp5v8ahZEQCz6psPaOIpxSA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524761;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=fWLmQp+E+iKxPqtXRglbvpsORXtw/1BYKl9r2jjl73I=;
	b=KfmS1RdQ9D0z4L88NwJy+x2kZa1UWZThOF/Ofi8gc08TQGicV76V12jjdKKqpm8p
	Ppda9lK2ccKEcVzNribp+CniYrLsCVQg38ih5Ha4lVdCeZNrKkoJi+WnON9tQ6wKO1n
	+sQ1r35IzKtyhcuDPctxQYr82jDIhNUvOUUsq9uc=
Received: by mx.zoho.eu with SMTPS id 1773524759836201.83145947128344;
	Sat, 14 Mar 2026 22:45:59 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 04/15] lib/bootconfig: add blank line before xbc_get_info() kerneldoc
Date: Sat, 14 Mar 2026 21:45:44 +0000
Message-Id: <20260314214555.96217-5-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314214555.96217-1-objecting@objecting.org>
References: <20260314214555.96217-1-objecting@objecting.org>
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

