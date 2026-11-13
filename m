Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558892;
	b=BCmQLY8Cwfvl7P6sg327Ti3FShgC4NG+1xy9zrXAy4LjdawzrFLIWI+myAU97RL5NoKq
	 1BDGBPxh2fr273Nm1aPd4cDqt1ADvOOFexpWyEtYJe6qYvBLbFurbe/1n0BH01+kt3ZkB
	 1PN919nlF5fyQeCUWZk7vH05YyzWCcwkp/CVNCa54Ql0GUfgrLMCALIs68gLeNsHubeBQ
	 SNGHey10e8M5MJB96up8jncwN/HqsFu7cQTKKKfmTujXv5UFzj9OUpKkeHcUHTOv5FFXS
	 USWeR7P4ctw0vijR3vqyvjfZAqtbJGF4r6Pnx+JX73jycS3y+cHEjdhCnc7r/tuEynw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558892;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qJUhahjYxSxQSjcMRLMidLIYmQnKPYEISxd4xBB/oKU=;
	b=n+yQzP1JFZrdFQ+SWrVgB7JJBvQMYrQTkKkATEfohSPeO4QMXkqhkaU2szros+YXclmr
	 DxVRnSbex+5Co8nAsnK/whcZAD+o+RQDgIj5cQKsCuMotGPZ4+4vGFQH2W/tQdMr8LMYm
	 qi98M657Mrh5q3u2Aq+1EG9RMP1sRSJFFFYaqLCVuJk/ZdFzx0Ve4j6TIu7AtKRZHjeci
	 lSKVWshRhW9S72cmeRwUAUHf8cYhZtQtY87zIhPBFvnVEU6QdePv9XLrs4drZUOvZ0VGJ
	 7vKy2a21+ySCErQRARWmCNDQEBQzfbJmM9Te2KXXVt1+fLNxu+L5mqwuwjZvy09Cebg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ip6TbRnT;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F94606B1DA;
	Fri, 13 Nov 2026 08:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62F94606B1DA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ip6TbRnT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ip6TbRnTx2iXAHM4sNmfYX/WMMi3wvafFYcpMFePLwOKwD6gzuRTepAa+LU5i9aCHvFSWNbIQc3gR
	 +WB01AxUbaxoejploAfNKNV1vmmAs7NbOjFTwyy8wE0D8c3p7N+FOgtakrDsWcvq9qC/euAWdcWI0l
	 t8waT2D/R1/50wUA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af6cba7584-efa45;
	Fri, 13 Nov 2026 16:34:48 +0800 (CST)
X-RM-TRANSID:2ee96af6cba7584-efa45
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66af6cba759a-1ed71;
	Fri, 13 Nov 2026 16:34:48 +0800 (CST)
X-RM-TRANSID:2ee66af6cba759a-1ed71
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: vdonnefort@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v2] ring-buffer: Annotate the speculative iterator event copy
Date: Fri, 13 Nov 2026 16:34:46 +0800
Message-ID: <20261113083446.177306-1-zhujun2@cmss.chinamobile.com>
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

A non-consuming iterator speculatively copies an event while a writer
may overwrite its page. The reader lock excludes other readers, but not
writers, so KCSAN reports the concurrent memcpy() and event reservation
accesses.

The iterator already validates the page stamp and committed size after
the copy and retries if the page changed. This makes the race intentional
and the KCSAN report a false positive. Mark the speculative copy with
data_race() to document the allowed access and suppress the report.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
Changes in v2:
- Describe this as an intentional-race annotation suppressing a KCSAN
  false positive.
- Drop the Fixes tag; the existing iterator validation already handles
  concurrent writers correctly.
- No code changes.

 kernel/trace/ring_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 75cd8df23c1b..950c42f1e849 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3566,7 +3566,8 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 		/* Writer corrupted the read? */
 		goto reset;
 
-	memcpy(iter->event, event, length);
+	/* The page stamp below detects a concurrent overwrite of this copy. */
+	data_race(memcpy(iter->event, event, length));
 	/*
 	 * If the page stamp is still the same after this rmb() then the
 	 * event was safely copied without the writer entering the page.
-- 
2.51.0



