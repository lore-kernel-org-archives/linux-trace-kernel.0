Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680642;
	b=M3vIn/1pEiVhLCPTepCw6zqLulxJZB92LFsNJcafHL3Lb6C2Y1XJyPPKoyey7rKbDTNA
	 y+lyn0RlA6Md7scKIzEEKM+QDQUpzpiHUKDYXuXD/Xc06Mqim0jQVMSPDF8F4xOmJbAKO
	 Bt+5ns74riMTEbeM/w2A+d39Sbg5OFvRbCGuVkklDeM6gyz5Y7GqTbL8P+MPg5b3KaMgn
	 Seztnl8Z/mkXB0yAUsCZyiXaNx2Y6Fk1aPq6mt7XPrwAqR56VNjVagT0W++iu9bH8mFnR
	 ti1eNGMqtTfoT9p8MnJVRydEQh9tkf5JLq0id9ie23bzWbf5oifeXH2peVj00iwqE9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680642;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UWeiiXU/CGZhT/IB9wANq5icufSPJ3/2vx8+tvdIqsU=;
	b=3cnbTo5ZIqHiSj/x3wK9hKXcMLjiH1ig6xn2ciFuon26J/3384xChPbr/5B4buxcIypi
	 ebl3kG+Vt4h3YOwxuXHU8B5Lr2e5s2imh3gKdGCuB4IeGedRYHTexsptlWlXUPv/9HHgC
	 2opHkBli25IYqtHnE9W9SJsGchBs/9pmp4rcs4sTrECtvResE2JEKGvp5+nIWoVrxS6pY
	 0MX8m0TTesnNITpZviRjnMqls+U4Z7p25nCxcU8Wfp8ojQfnEDURsXD3nttTBbIwD2ESE
	 YM++pQaQoVyAb7sgD541CiYd0oCVTQzihGF5anqGikP+9pP5E1NuH6izbc7cl/lwD2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ks5UunoI;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0C5606A31E;
	Thu, 26 Nov 2026 08:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F0C5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ks5UunoI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ks5UunoIwQG0c3kB3OBn3LgvmWS3OOJiDJ/CeJQJq0MUDA7xaKoLT9uUwvmwYddXPbYfMnv8dxbtd
	 nhRpRUJhCC5CDU5Bsjc9es2AA0NAx6xLXqtHnfoGXRK2NTgGMEnYas+kJU2Nz7Ru8zdY6gKnoJbt1C
	 B/UGPx8zXlBfuAIY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86b07e975b10-fa58c;
	Thu, 26 Nov 2026 16:10:31 +0800 (CST)
X-RM-TRANSID:2ee86b07e975b10-fa58c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from desktop-c950f82eaac8410e-20260515094303939 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36b07e97458c-62f80;
	Thu, 26 Nov 2026 16:10:30 +0800 (CST)
X-RM-TRANSID:2ee36b07e97458c-62f80
From: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/18] tracing/sched_switch: drop duplicated NO_CMDLINE_MAP check
Date: Thu, 26 Nov 2026 16:10:27 +0800
Message-ID: <20261126081028.4208-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.53.0.windows.1
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

NO_CMDLINE_MAP is defined as UINT_MAX, so "*ptr == -1" and
"*ptr == NO_CMDLINE_MAP" compare the same value: the signed -1
converts to UINT_MAX in the unsigned comparison.  gcc -Wlogical-op
flags the duplicated condition.  Drop the magic number and keep the
symbolic name, which is what the rest of the file uses.

Signed-off-by: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
---
 kernel/trace/trace_sched_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 1bd351c1f..de58ff104 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -526,7 +526,7 @@ static void *saved_cmdlines_next(struct seq_file *m, void *v, loff_t *pos)
 
 	for (; ptr < &savedcmd->map_cmdline_to_pid[savedcmd->cmdline_num];
 	     ptr++) {
-		if (*ptr == -1 || *ptr == NO_CMDLINE_MAP)
+		if (*ptr == NO_CMDLINE_MAP)
 			continue;
 
 		return ptr;
-- 
2.43.0



