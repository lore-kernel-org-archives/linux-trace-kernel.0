Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B4C28382;
	Tue,  5 Nov 2024 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769281; cv=none; b=DGNA+OrzOY8Yn++fmx8vwGbQZN1J0UyckMTzELSHAT3Z88vVhJkeUN2Wfz+dy3LLXA1Ngk0qhc2WenCdTkPv4xS7iQaXa4qqlSI/a6HCkgS5/opW1ciaxZHFM5l6RunLSbAGK84e/GTVaXuptqajZuaYXdBPl38NG6qS/95oP0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769281; c=relaxed/simple;
	bh=pUYQyTocEQqu8+T1sJirl/QVBneAR8JBzeQWgDui8SU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QFojbqNW3voXedhuTN9x+oFJJBTR4XeMQfna/n3vKHXpZvuK2xj+R5NwDIAj6tndegieonDpudg8xVW1pC3DKlI7hQ2qqdSd1LBlv35HZsE1uNDQcBPBs/JKGxoNiRW8E/FzR9dNGSF0AjdQV7XIteo2oUfaz1hgwvJNw3DjlMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3672970bdb58-9e376;
	Tue, 05 Nov 2024 09:11:26 +0800 (CST)
X-RM-TRANSID:2ee3672970bdb58-9e376
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8672970bd9a0-c3f2a;
	Tue, 05 Nov 2024 09:11:26 +0800 (CST)
X-RM-TRANSID:2ee8672970bd9a0-c3f2a
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	trivial@kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] tools/bootconfig: Fix the wrong format specifier
Date: Tue,  5 Nov 2024 09:10:48 +0800
Message-Id: <20241105011048.201629-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use '%u' instead of '%d' for unsigned int.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/bootconfig/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 156b62a16..8a48cc253 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -226,7 +226,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	/* Wrong Checksum */
 	rcsum = xbc_calc_checksum(*buf, size);
 	if (csum != rcsum) {
-		pr_err("checksum error: %d != %d\n", csum, rcsum);
+		pr_err("checksum error: %u != %u\n", csum, rcsum);
 		return -EINVAL;
 	}
 
@@ -395,7 +395,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	xbc_get_info(&ret, NULL);
 	printf("\tNumber of nodes: %d\n", ret);
 	printf("\tSize: %u bytes\n", (unsigned int)size);
-	printf("\tChecksum: %d\n", (unsigned int)csum);
+	printf("\tChecksum: %u\n", (unsigned int)csum);
 
 	/* TODO: Check the options by schema */
 	xbc_exit();
-- 
2.27.0



