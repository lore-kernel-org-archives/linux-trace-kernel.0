Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA510A23;
	Fri, 17 May 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937307; cv=none; b=Ug9xYYoSnk9MMewXuaW8Je4XAx21Az6voujwkaxqZfDMLPOwN5jNez+9BlB/1WodFYzIALUd0bO+M1hsXQmLgdoOpEv9mrNwaUDQm9W9GzsZjHLnT+Baxu/zVEEDYBuI2GyLffyAQboB1jKW35jiyn1pS/BlbsqV7gS4t0RPyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937307; c=relaxed/simple;
	bh=rrxj5CDV8a5jl8H9LjuyaHtxC6maznMOSsHg2w6e7YE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dd2XYjRwfSKnbbPWLdnpN6DL6vOdr84tf/SNj9Qvl5DPsIKn0VHVD225vZ8NxMLSeL6RFEC4S9QWPmgbYJz9MHBfvMAIE5hJoWr1UMxe03KG836ZE6bvdOiH79pDcv60EGM3i6oh55rGBmEp6BPy9sjDiK5QpVOUeuIqXY9J4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lKkmfUNd; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lKkmfUNd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715937296; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZrUDAK+83eL96IhjYRDyrFMUNm5nZQ72ww7sHH7Xvro=;
	b=lKkmfUNdMmkrrzyQXpUPDsP8ueUHP5oO9NR8tgOvBCRaWFbN12X0o0nrCXoSHIacPZi28DYkoAXSPXvY0NNYVKgNeDkArolYR0XSilisQKa6n2xekAuL3ZJSXYW4S/aXGUyCYQjS6PJeFcDJPh5WSaONSqfKCbahkEViUURXQCg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W6eCM6Z_1715937294;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W6eCM6Z_1715937294)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 17:14:55 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: bristot@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] rv: Update rv_en(dis)able_monitor doc to match kernel-doc
Date: Fri, 17 May 2024 17:14:52 +0800
Message-Id: <20240517091452.47703-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch updates the function documentation comment for
rv_en(dis)able_monitor to adhere to the kernel-doc specification.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/trace/rv/rv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 2f68e93fff0b..df0745a42a3f 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -245,6 +245,7 @@ static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
 
 /**
  * rv_disable_monitor - disable a given runtime monitor
+ * @mdef: Pointer to the monitor definition structure.
  *
  * Returns 0 on success.
  */
@@ -256,6 +257,7 @@ int rv_disable_monitor(struct rv_monitor_def *mdef)
 
 /**
  * rv_enable_monitor - enable a given runtime monitor
+ * @mdef: Pointer to the monitor definition structure.
  *
  * Returns 0 on success, error otherwise.
  */
-- 
2.20.1.7.g153144c

