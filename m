Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF82DA769;
	Tue, 17 Mar 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763783; cv=pass; b=KeVtRcNbTrcU1gyk+/BP2aHSQdmHuB23mqerNCEiIQ4pOeC+KIP0jWc3z1anZuIIvBVTIib6e2Ibm8hFbb7+aR0XYH05zwlhA8J5GZnoUhZSOiDArSTZmv6S/70HCjGdp07WSL276d9G4tHh1nButydgCf01bgueFhFtirs5sC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763783; c=relaxed/simple;
	bh=1d2TzSzyIPMrAlnmm/L3w5ldSBuILvytBNaGCNG8nEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IzMpYnFzTqz2IWRxpTi48WfrgCT3+zT8xIke3RwWHZnIoZBWCWBluE6l9/rfp1muHUIeTeT/ONw8gXA+dvGQyzx0QKSVlZErF+0Gm3w8Bo88pNqSii2w4SZc2KYQJrM+okyOLTiqW0EHYwX6cp5Xy/y4/Za5MkYDpin21otzwA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=JUJ4HRtm; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="JUJ4HRtm"
ARC-Seal: i=1; a=rsa-sha256; t=1773763766; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PLXLcGElZ7TOZU8IuZOL6zj8AmISxQ1SNO16gvGJE9qKa1oUyjf1Zac4Uca0ma1aw2JyoACdFV3t4ZUhC3iq+1xEWZ4uiKEFmyUVVR/jtYkNcQ8Y0nHOy2QSzeodeRPCPUo8OfFX7fibkYNBbXT7y0oPmNZAilnJkU/JE3llcZo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763766; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nG+a8XwxykTG22ppFE4Xm1p8EJcF589vrbNMwy0/cPg=; 
	b=Nq7zrsTNhe2mj8p8wDYvMF/dqz44bEMf+bkFHQVBN6gLV+5WkoB5qb03p9YDJsH62oj/wIC8umsp0o5h0aIjiu2W23iX//CuUTpKPNBTca6KmzFAUE+D/gneHsigGdQI+Pr4T/QLUMieE9dxD958oaW2cqhatzX0LeHlO3/Hzo4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763766;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=nG+a8XwxykTG22ppFE4Xm1p8EJcF589vrbNMwy0/cPg=;
	b=JUJ4HRtmNghVmS34bLhcs75Yp799lwnl74c4XRLtNdMcNUUUnklJVTl13w2yUHHc
	jRpJj3dg7i5kYJZD7pfDdjQKhO9nLXlX5V7WwVxaFcgyBXKwG9JRMli0tQWHnUF1bVN
	lKv822npo6YvhD0woq/IAr9DLkxasH3SEjT4HCkc=
Received: by mx.zoho.eu with SMTPS id 1773763762975503.8071820235392;
	Tue, 17 Mar 2026 17:09:22 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 10/15] tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure
Date: Tue, 17 Mar 2026 16:09:11 +0000
Message-Id: <20260317160916.33576-11-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317160916.33576-1-objecting@objecting.org>
References: <20260317160916.33576-1-objecting@objecting.org>
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

