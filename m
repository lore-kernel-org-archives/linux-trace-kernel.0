Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155559;
	b=S/gij5Viz7uMbxg6ZZcVtIBcUSon/o1uofSSxe5ccfHFKO+XUqKi8bCLdAaKBh+LWgww
	 7MXq36KoSWmt6TNXETslT839xdl6rvgChk5Xmw4KEXwVhUQbS5BZ9OypMlno+/HgTjmEh
	 SCsyT81c7skwwucpFD7F6P30FwB/rKpvS6is8978/rVEbSK5vNmFQMi0EOrq8TvArp24V
	 HDMwT8iu2j++Dzjw29nqm4ECkIqj2y3dldjfZIAf8Ab/7BU4ut3WEzKvZMrBCyINCCPax
	 3Hg2t3H57SdF+lN5W5xAMo0kOxK3LtzGRBhNUSdQB2DqFAO5t4oU8Zh0gUEtT0/gG2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155559;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zd+EaouGcR++ck6Oh3JEio4Xvpq3BIZcbnEjowmKgCY=;
	b=Z6SN20nEelJ+0hcgj+CdlKgfBBE7g/d0IOQlHzprI88hZ7LQlmfKbThPjNuPUxcOcY1U
	 C8xZBbKuhJg4YHArYV2hry7bt7Q27Y3RenxR1u7vRP5+iPpWYBP5RgeOJM+HKNTbxsiTf
	 /Bkvo5x2nnWpeSNYkIB06R59IkPQdHm3WAyHlxa8eikP4vrkm+ChEYWvycgYIfq3xPfbQ
	 tracoupnkGCrhFlLXVMOEvt74L/5FzPE9w55MzttD4tv1KpBJc2Ziix9eMStcSJ4qh739
	 HI0e98gNpTpAsB4Rn564gf4m76ZsfoUs9kOvzZh633ax3tZgAfl/KJwPs77E3klJCRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=jDZpO8zr;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04A606A518;
	Fri, 20 Nov 2026 06:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A04A606A518
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=jDZpO8zr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=jDZpO8zrdgRccoiOA51wdWHxw9yd1SxiIKXFQ79qMNEz4DFXAh3SYc7gnPOmAyOzAStvVOM1QfcPH
	 epN1SzjAb8V3xP/RA/F21oAstqzP1M+LxNzsouAyOxKBlgDXJXynGeNNTtwB5JbfyWOEsH1YHFNAgE
	 vD8eT3qJ9Bec34W4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76affe65ea9d-25ae0;
	Fri, 20 Nov 2026 14:19:13 +0800 (CST)
X-RM-TRANSID:2ee76affe65ea9d-25ae0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76affe660183-18173;
	Fri, 20 Nov 2026 14:19:13 +0800 (CST)
X-RM-TRANSID:2ee76affe660183-18173
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] tools/bootconfig: Reject short reads of configuration data
Date: Fri, 20 Nov 2026 14:19:12 +0800
Message-ID: <20261120061912.98156-1-zhujun2@cmss.chinamobile.com>
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

load_xbc_fd() places the terminator at the requested size even when
read() returns less. Its initrd caller then computes a checksum over
bytes that were never read, while the plain file callers can parse a
partial configuration. Reject a short read and release the allocated
buffer on both read failure paths.

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/bootconfig/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index d3f840c5adce..a3935e1a8c6b 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -190,8 +190,12 @@ static int load_xbc_fd(int fd, char **buf, int size)
 		return -ENOMEM;
 
 	ret = read(fd, *buf, size);
-	if (ret < 0)
-		return -errno;
+	if (ret != size) {
+		ret = ret < 0 ? -errno : -EIO;
+		free(*buf);
+		*buf = NULL;
+		return ret;
+	}
 	(*buf)[size] = '\0';
 
 	return ret;


