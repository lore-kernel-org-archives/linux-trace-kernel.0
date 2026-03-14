Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1893246F0;
	Sat, 14 Mar 2026 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524773; cv=pass; b=IWo7vAhBjnk4OUyavVFBh4w5mbDlz98/mEkM+pQOR8FMWO3fkCGFvq5Fg0ZnNrG17s3/mdXz2ubsb4cBdlBs+xriQp/wihnfdCRn0iRBkuTvPX6rSS8ZgA7oLHTdE8x+x/gdCzlSE/jUMRpPbyMEkB7lUHRWSX8g/a1cCZhvf7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524773; c=relaxed/simple;
	bh=mOcA5NumuG5htRvRiYXxJV6Vjf0pzLdSrtjWwr+L0hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AlWrg7tFb9DHwVPM+LYGf9LWaEyYUhwdcKN1SKYhoSxX9R6aNJnhtHNIvWxq4nMkPAAyrKPnz3m4sWes1CrVMZieyhFYrpBa5orPysxX0zA1AbBsFUAAAvOvWT3IHuYZYxjEhlbvn+SKWnGwF+ROsoM+PeRBfRrrT7vr/ieV5Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=F0d2qFzW; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="F0d2qFzW"
ARC-Seal: i=1; a=rsa-sha256; t=1773524759; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=L0JdAFptlufiKnS5g5xhAg0zszJqP6jVtOX/46L4GeCPH1nXQuJxRq5LN+V2YRhfubGOd1gVt8F/HnIrgy1ZoMiZYah+Cp50um3E5O2wkcc1UIYoz/WAB8EmQjY/AGWXIRb7ILG1lrQABKZSjH7DrnQG8keQfiYioZrcOR4rOGM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524759; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RNVEZU5OMpS4t6chZVfYPFtX6E6ANKPvlBhC6PXo744=; 
	b=QN+RTiTTJqhfVV4CLreAmcIUpe6U1kj0UwINxOHzy5Cyi+WJwXEJiDhtQU0oDsOUSvLD3mcq7vId785IoULP51mj7mxj59FtHseqx3h/lAun4L/+r3EWhPqdpLSgmMlO0t+91TRbdp7JpL+jtEcM2sfoF2XphhiDSInqUcGzWF0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524759;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=RNVEZU5OMpS4t6chZVfYPFtX6E6ANKPvlBhC6PXo744=;
	b=F0d2qFzWdBeyM2LKZSaeptKUW2/UMDHWa0qO98VqlxZgBrizXoTUqi001VrkJUoj
	Ge5pQ5NFq8y4vb6oXuQXhuJgqBOcn21w0e+Q0+zPN3Rr5CwJ7iO+k0qFUWpJJ09QQcn
	XXByHt/82D6fsIcrYmnwrKb31cs/xLWKpOQ5ifFY=
Received: by mx.zoho.eu with SMTPS id 1773524758686449.92300632525917;
	Sat, 14 Mar 2026 22:45:58 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 02/15] lib/bootconfig: fix typo "initiized" in xbc_root_node() kerneldoc
Date: Sat, 14 Mar 2026 21:45:42 +0000
Message-Id: <20260314214555.96217-3-objecting@objecting.org>
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

