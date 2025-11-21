Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59330C34A;
	Fri, 21 Nov 2025 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763548; cv=none; b=f30p9FVvgiGCeKrVi7JC8gyq4JQEkkqTh7QwcFcFHJ3Q0GcHy7UcRq+2EQ1MR0a20qdLZ/EAZGNXS3GX+lhNMRhxTJA4j0qCR7odvITLipHx/naO4aOGdsemtFWidVUny66jAaR4x0GDfsi73B+e6QurBOx5mFk1hPkLjWa7dcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763548; c=relaxed/simple;
	bh=3MvgU+TMha+P0B+w6d+vPMdEdESgh7wjU9tzb2qZDgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIL7PJRZIQV5EKdFW/pqL8YbmVjUp/qjQFUski0IliZlDT12NuJzWMChYhGa36AbeAtCSb2Pkory9Q9g9be8oUzMlZaH+uAt4tWvc8NzTE6t/XgZRF/lulD1xWGDM3JBWHCMTXDMjjMsB/1KGofEdvP7fISqvBP5VgrRRNqA1gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wXftT/+C; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wXftT/+C; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wXftT/+C";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wXftT/+C"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dCqPf3jCvz9tKb;
	Fri, 21 Nov 2025 23:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EUt7o6zNb9WnDNJz4yNux/YsId1UC+KZ030H+FORpkQ=;
	b=wXftT/+CZVnX32R34+2S1CLXV4O6uxbJ2bkYvlMT9NjsFxbGhn5VwP/5rbLGeBC3ETcORz
	Z7X5kmIs+TQHuRrCxxv7TgoI9Cx0bO2CmCydDroz2rvQOty0FKn2DkSLv8XAW8Ct5xlyw8
	EyIoAPxK/QLC29yPjiCWNNgtEnVrxwjZXX3Df5eyU861+kLEQBLikV+7usmL/9djwhLFKy
	q8wAAQldFa64AELBFMq+1rSqTD3w8E1m45ktms++95oAHVZDDWLzOmNgbIf0rbIOwpIpGU
	IrBgY8o6vOz4PEMzOLaUckH+m+OZDvU7pbGnnoKRQ3nv2Z1pKLvHMqEmBQbU1w==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="wXftT/+C";
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EUt7o6zNb9WnDNJz4yNux/YsId1UC+KZ030H+FORpkQ=;
	b=wXftT/+CZVnX32R34+2S1CLXV4O6uxbJ2bkYvlMT9NjsFxbGhn5VwP/5rbLGeBC3ETcORz
	Z7X5kmIs+TQHuRrCxxv7TgoI9Cx0bO2CmCydDroz2rvQOty0FKn2DkSLv8XAW8Ct5xlyw8
	EyIoAPxK/QLC29yPjiCWNNgtEnVrxwjZXX3Df5eyU861+kLEQBLikV+7usmL/9djwhLFKy
	q8wAAQldFa64AELBFMq+1rSqTD3w8E1m45ktms++95oAHVZDDWLzOmNgbIf0rbIOwpIpGU
	IrBgY8o6vOz4PEMzOLaUckH+m+OZDvU7pbGnnoKRQ3nv2Z1pKLvHMqEmBQbU1w==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 02/13] tracing: Fix typo in fprobe.c
Date: Fri, 21 Nov 2025 23:18:24 +0100
Message-ID: <20251121221835.28032-4-mhi@mailbox.org>
In-Reply-To: <20251121221835.28032-1-mhi@mailbox.org>
References: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 05c5ab855a3abc9ca0c
X-MBO-RS-META: rwr8dnj9dxjms4ekosif46x5dmfintj1
X-Rspamd-Queue-Id: 4dCqPf3jCvz9tKb

Fix typo "funciton" to "function".

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 kernel/trace/fprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 0b1ee8e585f2..1188eefef07c 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -30,7 +30,7 @@
  * fprobe_table: hold 'fprobe_hlist::hlist' for checking the fprobe still
  *   exists. The key is the address of fprobe instance.
  * fprobe_ip_table: hold 'fprobe_hlist::array[*]' for searching the fprobe
- *   instance related to the funciton address. The key is the ftrace IP
+ *   instance related to the function address. The key is the ftrace IP
  *   address.
  *
  * When unregistering the fprobe, fprobe_hlist::fp and fprobe_hlist::array[*].fp
-- 
2.50.1

