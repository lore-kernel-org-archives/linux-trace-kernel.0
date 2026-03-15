Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22E34D90C;
	Sun, 15 Mar 2026 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577233; cv=pass; b=rYP1raDyN+pSBabWq8AlFTIYW9wl4ZwBBmimykHY11pkoNKBJS6dma2DNtAzWTPENoUDj9LRHlrH2i2kURplhJIQD1rZ8Qx0xy5yMghj3M+9PyP/sb3Ypj3RRqtFAoK+4YpmlqLWx6MbUAg8d1ny9gYTRhmw9RIL9xIyo7KBscM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577233; c=relaxed/simple;
	bh=vcSmVPwd5atv4aQqUiSSsIWmabtFEECei8nDhBxO4fo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWFnaTvQOqTrG6fYDiX2K634IxKzza1ACX0sRcJWudjh+fxxFLDpqn3xYplm5TyujRi7V+tubdBpq8t8KvkYZd3brsfjZmcWMerHvhwtDPKNntoxplBCgHyaFFvhLBvrpUR7iLXEeILicl7Q6ETIzMocTXV90Mg/v0QvGCnn47Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Rq8zi744; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Rq8zi744"
ARC-Seal: i=1; a=rsa-sha256; t=1773577224; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=OQtTEOPxK2C9+XWZfDsll7t13itgHEnWOG/1CBUZWBaXGiTBZJ851ZEjd6lQYwKvPb1aJN671dis+d41xbXlCON+HcsWB+2HEv5LhNfP7axAg1ZyNxT5tEbi9xiGZYDnUEbNXyg//s0ex2nt5jx5THmvmEAUJeBhkpYp5U9budQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577224; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YdQAiEyDpvbZ5I8fQtAjbQ+JeayCjZ3yazt4egZHOB4=; 
	b=Gefjvlf/Kwbwl2fCdaGBDuI018PZfePNyXfLIHO0ya41PVMsYuIQVuO/kDnOp5S4O/meadCf3T9bnKW248P9frFYh8roA4NPwrXQsFWrRS6u6g1Z+ScEBJof6D79/YsQyFU1Rm6Y6j7tA6lLyjL4wVBbkFRXFHgbSmDXYQcDVMY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577224;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=YdQAiEyDpvbZ5I8fQtAjbQ+JeayCjZ3yazt4egZHOB4=;
	b=Rq8zi744kkDoSfapYn1Hdz6PjIvuGoP2HjAsJln/DryltKl/yVBh2qeG9mqZpxQG
	/WPOdlcFWCg+HbAkqJTR0jAzoiQXKR7OQBbTzPirNx0evoPQyrqMDKQ9AEKUvtnZfwX
	8KccAhfoSIzNFTcKEjsXEtsTabXiYoLsm9/FPXP4=
Received: by mx.zoho.eu with SMTPS id 177357722367761.91944581690507;
	Sun, 15 Mar 2026 13:20:23 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 11/17] tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure
Date: Sun, 15 Mar 2026 12:20:09 +0000
Message-Id: <20260315122015.55965-12-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315122015.55965-1-objecting@objecting.org>
References: <20260315122015.55965-1-objecting@objecting.org>
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

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
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

