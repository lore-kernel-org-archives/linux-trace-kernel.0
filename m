Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6B43E4BA
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514281; cv=none; b=EjNQOVOGwnmpUcZlTIoTOv4V7Ymarz8xFrLDlOCpxpAZL26s/uE2tmuEaHHAsUzIW3xaCsK8RpQv6IJWbrC0qurCXPWodpnX5WGQkCS8yuljZMNeBjH6uXKMQFe2mSXBHcUgFIAzdTIk87fQTzQRF108g4PQa5KRmhQiD4o2Dm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514281; c=relaxed/simple;
	bh=F3i8e5c8Pz3nk/LDzq7on6y7fFu51hS94kn2FxNM5tI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 References; b=NhRn/DlfBH8Tejx+JY4zrSDGdRw78DZf7LZr8ullNeC8diGHtKSya6ZwYXCakQlUD4rH0FavpWUjsfG6d9HW0fRLgZNkhmf/tqUbL8Xp9HeQXOcYrZtZCNHesgY94XLWoVZjzGy+6MbrbAabcbYAke4xnBShvhG4jQzO/JoI2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZzcA4xIO; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZzcA4xIO"
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260708123756epoutp028bb41cac100a478398102acfc8c18797~AUMj0myNd3172231722epoutp02Z
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 12:37:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260708123756epoutp028bb41cac100a478398102acfc8c18797~AUMj0myNd3172231722epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783514276;
	bh=tQ7iIwXaV/cf5SdO/YJZVhX4eexgB2lkXF21YEhK/bE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ZzcA4xIOgwvRU8zkCN/rKhbO0abBCh3hVZhWPFIymAoC0ujQcqSQBBk6OQaPZlD0o
	 73kNGZDEet3gcC8z5dVOg4PyQ8aZ5elcg7/K6lRUIT3rr3L2GKySaP2zA2nfFKZwi7
	 6GQ0VfK+Nt1uXgjx+vRLvo9Dg+Bh9+KGLIHLHEHw=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20260708123755epcas2p125f0a0e2cb0d934634253eb3621b8d19~AUMiusE2x0790807908epcas2p1y;
	Wed,  8 Jul 2026 12:37:55 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.208]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4gwHgQ72B4z6B9m4; Wed,  8 Jul
	2026 12:37:54 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20260708123754epcas2p1f15cc305ddb09f97164491d750769ef7~AUMh01tMF0789207892epcas2p18;
	Wed,  8 Jul 2026 12:37:54 +0000 (GMT)
Received: from KORCO121415.samsungds.net (unknown [12.80.207.147]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260708123754epsmtip285b80b86d227e9d15485954f7a5fc98d~AUMhxUHC-3186531865epsmtip2k;
	Wed,  8 Jul 2026 12:37:54 +0000 (GMT)
Date: Wed, 8 Jul 2026 21:37:53 +0900
From: Jeongho Choi <jh1012.choi@samsung.com>
To: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org
Cc: ji2yoon.jo@samsung.com, minki.jang@samsung.com, hajun.sung@samsung.com
Subject: [BUG] tracing: Too many tries to read user space
Message-ID: <20260708123753.GB1386@KORCO121415.samsungds.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CMS-MailID: 20260708123754epcas2p1f15cc305ddb09f97164491d750769ef7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----3ueMPXygkF8lCfPZyGi1PuNl7RkiyUtEnKn9EYq-CAibR79o=_19e38f_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260708123754epcas2p1f15cc305ddb09f97164491d750769ef7
References: <CGME20260708123754epcas2p1f15cc305ddb09f97164491d750769ef7@epcas2p1.samsung.com>

------3ueMPXygkF8lCfPZyGi1PuNl7RkiyUtEnKn9EYq-CAibR79o=_19e38f_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hello,

We are seeing a reproducible kernel panic related to the tracing code
when it fails to read user-space memory.

The issue was originally reported through the Android/Google Issue
Tracker, and we were advised to report it to the upstream trace mailing
list because the affected code is upstream.

Environment:

Architecture: arm64
Kernel: Linux 6.18.21
Base: Android Common Kernel (android17-6.18)
Affected area: kernel/trace/

The relevant error/panic log is:
[48916.569148] [9:           lmkd:  536] Error: Too many tries to read
user space
[48916.569156] [9:           lmkd:  536] WARNING: CPU: 9 PID: 536 at
kernel/trace/trace.c:7374 trace_user_fault_read+0x334/0x360
[48916.569443] [9:           lmkd:  536] CPU: 9 UID: 1069 PID: 536 Comm:
lmkd Tainted: G           OE       6.18.21-android17-5-ga1a8e8cab9ec-4k
#1 PREEMPT  25372cd4750dcac3c0fe86b57d47c665f97a6046

[48916.569450] [9:           lmkd:  536] pstate: 63402005 (nZCv daif
+PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[48916.569452] [9:           lmkd:  536] pc :
trace_user_fault_read+0x334/0x360
[48916.569454] [9:           lmkd:  536] lr :
trace_user_fault_read+0x330/0x360
[48916.569456] [9:           lmkd:  536] sp : ffffffc096993cc0
[48916.569457] [9:           lmkd:  536] x29: ffffffc096993cd0 x28:
0000000000000065 x27: ffffff8817e45200
[48916.569461] [9:           lmkd:  536] x26: 0000000000000000 x25:
000000011616c082 x24: 0000000000000000
[48916.569463] [9:           lmkd:  536] x23: 0000000000000009 x22:
000000000000002b x21: ffffff880597f740
[48916.569466] [9:           lmkd:  536] x20: 0000007fc42dd940 x19:
ffffff8817e45770 x18: ffffffd5947ce240
[48916.569468] [9:           lmkd:  536] x17: 2073656972742079 x16:
6e616d206f6f5420 x15: 3a726f727245205d
[48916.569471] [9:           lmkd:  536] x14: 36333520203a646b x13:
6563617073207265 x12: 0000000000000001
[48916.569473] [9:           lmkd:  536] x11: 6f74207365697274 x10:
0000000000000001 x9 : 4bd9ad4516d75100
[48916.569476] [9:           lmkd:  536] x8 : 4bd9ad4516d75100 x7 :
205d383431393635 x6 : 2e36313938345b0a
[48916.569479] [9:           lmkd:  536] x5 : ffffffc080fa5998 x4 :
ffffffd591707202 x3 : 0001360a00000000
[48916.569481] [9:           lmkd:  536] x2 : ffffffc096993af4 x1 :
00000000000000c0 x0 : 0000000000000028
[48916.569484] [9:           lmkd:  536] Call trace:
[48916.569486] [9:           lmkd:  536]
trace_user_fault_read+0x334/0x360 (P)
[48916.569488] [9:           lmkd:  536]  tracing_mark_write+0x84/0x174
[48916.569491] [9:           lmkd:  536]  __arm64_sys_write+0x2a0/0x5c0
[48916.569494] [9:           lmkd:  536]  invoke_syscall+0x58/0xe4
[48916.569498] [9:           lmkd:  536]  do_el0_svc+0x48/0xdc
[48916.569500] [9:           lmkd:  536]  el0_svc+0x3c/0x98
[48916.569503] [9:           lmkd:  536]
el0t_64_sync_handler+0x20/0x130
[48916.569505] [9:           lmkd:  536]  el0t_64_sync+0x1c4/0x1c8
[48916.569508] [9:           lmkd:  536] Kernel panic - not syncing:
kernel: panic_on_warn set ...


The code at the WARN location mentioned in the log above is as follows.

7374                 if (WARN_ONCE(trys++ > 100, "Error: Too many
  tries to read user space"))
7375                         return NULL;


Our current analysis is as follows:

In the Gmail process, during a low memory situation, LMKD writes strings
to /sys/kernel/tracing/trace_marker for systrace recording. At the same
time, it broadcasts a sigkill due to low memory, which is causing the
LMKD trace marker operation to stall.


Please review this issue.
Thanks,
Jeongho Choi

------3ueMPXygkF8lCfPZyGi1PuNl7RkiyUtEnKn9EYq-CAibR79o=_19e38f_
Content-Type: text/plain; charset="utf-8"


------3ueMPXygkF8lCfPZyGi1PuNl7RkiyUtEnKn9EYq-CAibR79o=_19e38f_--
