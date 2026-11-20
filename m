Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155565;
	b=kHW3DvhBHEE4+1cBjI/asLePmNb7+/qjyIvriALAxguIWV+BoqzxJ5waJXGjWqF0WLVe
	 ZFIuPgWQRWcwT0eq3glbPepi32Skv1VjXf+lYiijPntvaozSAjJBId4cMqeprv5iZQWAU
	 zychu2lU7yj4DRAN6rahqO0tTgVtd9uCUd7Mj7PS5z5KV6+hmepDbFeS6l/Vy5hAfGJZ4
	 K/epwoWrG/86pqKzs/PX6STNlwLUkud9tLAy9xUvwoJld8MTIbbbigMKyBXHVKLFFZJNr
	 jU7e3IsCU7cC3a4+lXJ8ORgptOs3NBQaXxKV17xLsVNX5vxrPhEZvnARIsh4N3NDM1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155565;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o+3oz/RFIJNUAxTwaGf9HfTA/+CGFJ2Xdk3XeS8VxCg=;
	b=gHHWeNPx9EB8ad/UB22w+iQ/09wVy2PLnEv4uo1NmVdR8XVDFKqhI9f3zAqB2O6XDhYs
	 hkgqu7ndIfQR4X9UCuwJV8sWqFJmaBtJGO4e6sAva1MF40Lo+MGPVofumilrzSHDkV+lm
	 5pUbtt3a8TZVBP0UT1R5OVoXMkY2k+b/TaEAro5YeNrITe4BPGmjaz1fTBybQlnC7nGT0
	 vkIkmGtPnuNI0keHYU9g35s7OfUGjeexKM69S5bkiR1dgA0HfuvyuIySfWbRhdYIJNaQ3
	 Sz8uWeeoe9gOzm9c0LPilGleMEZmC5x2CJPxihqCkekt0DMqXb0XFDVLhC15RXBFbQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=SG9LkR3i;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF487606A51B;
	Fri, 20 Nov 2026 06:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF487606A51B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=SG9LkR3i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=SG9LkR3ilis2a6hvmb3dEBFuNxSrjFAx4s/uqhd3kxpSlWREePV3WdlgkU4mqbdzLy7jo3bIdMuDw
	 KwyKsj01+yJo31UNbhunVza9i0AsiBmZMIxwLd64KHNPvCkNzWcXAo2JL/cvEzisAg8zoSat5BWLPj
	 ftbVhGJDxT46x2Pg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56affe6664c4-220fb;
	Fri, 20 Nov 2026 14:19:19 +0800 (CST)
X-RM-TRANSID:2ee56affe6664c4-220fb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86affe66518d-80cb2;
	Fri, 20 Nov 2026 14:19:19 +0800 (CST)
X-RM-TRANSID:2ee86affe66518d-80cb2
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] tools/bootconfig: Report initrd append failures
Date: Fri, 20 Nov 2026 14:19:17 +0800
Message-ID: <20261120061917.98169-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The signed return value of write() is compared against a size_t.
A negative return becomes an unsigned value and bypasses the error
path, so applying a bootconfig can claim success without appending
it. Check for a negative return before comparing the byte count.

Fixes: e1cef2d4c379 ("tools/bootconfig: Align the bootconfig applied initrd image size to 4")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/bootconfig/main.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index a3935e1a8c6b..014fd04d2a61 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -503,14 +503,16 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	total_size = size + BOOTCONFIG_FOOTER_SIZE;
 
 	ret = write(fd, data, total_size);
-	if (ret < total_size) {
-		if (ret < 0)
-			ret = -errno;
+	if (ret < 0) {
+		ret = -errno;
 		pr_err("Failed to apply a boot config: %d\n", ret);
-		if (ret >= 0)
-			goto out_rollback;
-	} else
-		ret = 0;
+		goto out;
+	}
+	if ((size_t)ret != total_size) {
+		pr_err("Failed to apply a boot config: %d\n", ret);
+		goto out_rollback;
+	}
+	ret = 0;
 
 out:
 	close(fd);


