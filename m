Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5AC38B128
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531133; cv=pass; b=VZvUXZ6GF7rpf1ltVicNXBGa4h3htAQNunjVTcaYx+pulJ6qu3yvnXTtxoviVDYOtzifQYExa1jCP4aNQ/mjTTTQcHVLqYIwj5dn5YiTlkjJKiDcrQsKM35BJ08vFZAd8qK4CYp9IZ1M1orkaSinURQahQchhfzEItiFgfi2om4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531133; c=relaxed/simple;
	bh=4hvIdsyU/LaVH9Cl+UZr7yonHlF2t2i6TR6b+vGdeIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRMIMUfvIP3VJ/wNJ5Cj8FaxVBAjc/AZeq07brpUhitz/25vBUtHuzHlPhVYNge4QWfWrV5775Ea4iEbeKswrtXijfWhu8yo8gZCQ+VguCwUAXPRacPOxrF5eSWdXgMUdKGFOSZQRSp8gLHyPZdI2aRZQYSkZHOA+ORz+94TGrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=V3MCeogC; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="V3MCeogC"
ARC-Seal: i=1; a=rsa-sha256; t=1773531115; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Uq6QWo/wAMZAKBQR81cXyLXZHv+sitQRUlqnvN8AJ3FcYsUpU/vL1+PO8wOIVxR6tAYVFAPEPeggR87GvZwAR4yhXBHUEGsrCvvNp93LtyX6BjMyjoic15r2cI8nG9mbUJvnwEZS1UCXvYvwOA72BPmR8/ouL6I5vEnpDJkEITo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531115; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZmbCE6oHGMaPEvykEN4WTjS/8fklO687Fi9eR6U7ss0=; 
	b=QgSHfwVkbUuIUDRPAptHXJ+tAUBFEYuhkLjQNaWxrKgo/JhNI3ivRiRIF3xUGkdjY+O6OxsFt8Uw7+DJQHe/TW8fq7+8EuAKgUWqMjDag+8ZqJNYclYe2APCqWRwg4022A6A4M8yUr8tpHWKm74lsXby594fXYC4WFVuE7vwGME=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531115;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ZmbCE6oHGMaPEvykEN4WTjS/8fklO687Fi9eR6U7ss0=;
	b=V3MCeogCJJpkk12dbqjmRjcYKxqMuyPCyCqNGsFN8PIpzFAypNJ5hsPgVe5AHIWE
	lCGcRD4tkDoi7OtPYlvCt7a1uMDLP0Qw1UEEiOKwcJOAV0fmrLcW3a43dpclOo28fxg
	wa6IEdFFvDfEsSEA9o0eq5ByTaNPwSwq1x958RTI=
Received: by mx.zoho.eu with SMTPS id 1773531114266430.4311543275114;
	Sun, 15 Mar 2026 00:31:54 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 17/23] tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure
Date: Sat, 14 Mar 2026 23:31:38 +0000
Message-Id: <20260314233144.187273-18-objecting@objecting.org>
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

If fstat() fails after open() succeeds, load_xbc_file() returns
-errno without closing the file descriptor.  Add the missing close()
call on the error path.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 tools/bootconfig/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 55d59ed507d5..8078fee0b75b 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -162,8 +162,10 @@ static int load_xbc_file(const char *path, char **buf)
 	if (fd < 0)
 		return -errno;
 	ret = fstat(fd, &stat);
-	if (ret < 0)
+	if (ret < 0) {
+		close(fd);
 		return -errno;
+	}
 
 	ret = load_xbc_fd(fd, buf, stat.st_size);
 
-- 
2.34.1

