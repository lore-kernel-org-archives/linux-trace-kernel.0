Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975358;
	b=2R9dpQN9ZLbkJRSM9QErRpR3dZ4ZooFJHUr/zjwTlj5kzkP8D5syLILA5HgyJH8O8stk
	 NLaC+5KW02mBhvm30Ti20wsHp8juJodCpHRnSTqxW5qYenxX95GlUPk9lDQilRLzEL/NQ
	 zXJoznwqOG1+C+ZfwhWGEJnTv3ZGuaXiimlya+y81wyySGIhUhb+IjkOZoSTl/pav5sBa
	 J/ZSQhHDsr1Fkoibs/VWql2G1CS8a10iBDhWinrZphewFreBy7WTW8b64cFjYT6YwYpPB
	 kxxVTtuxGsp179m7fZVCP1JoOTg5x7k1hA0oBb/prqs2oJ5Z0H1/MWeFCEopH2ppP2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975358;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WqAWscfL3r9BujgfFktP9SElrvjPmWkmFgsU+wf24R0=;
	b=13fH1/Dl7h+nhch/puRILpXGU9yeMo5ihq0t0iLE5iyskiew5e2YJR3RxoJmOv8SVDZF
	 8cHg6+bdRqYd9W1ppMJ5TfPcDwCcQXWae1bkiKFjMwjMS73V3dFFeskjPNwe+bbi7Xza9
	 jAHu+ZLc1iJJXktdtwF19lGTCv2u2pTpVPSf2sZfJ0xHkAJiv34SjXvjXp5mHyDINwSSR
	 VZqJTYbA9XT0+DUg6YwMJ37NV1N0yVT5iCATaGFAmz4HmZ3E2q/UqJtV2szSjRzU641po
	 NOvnUgEU1APdeYyJNIQk2rX8hs382WtvhViofU54PFd7sQOxHa2G40QZoVjB1epavxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gNUFi5iE;
	arc=none smtp.remote-ip=95.215.58.132
Received: from mta1.migadu.com (out-132.mta1.migadu.com [95.215.58.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE04E606A333
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 14:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE04E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gNUFi5iE
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5EItJb1QeIxAtpcdoUd4dtj8OkZ5yQ/SrQWV8LNAh6Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793975356; v=1; x=1794580156;
 b=gNUFi5iEcHfcXJ+8QgF1PYXYgDNv1GFHTnIHIirJUGTx4mP1hI1MxFDnQInuwAe4gD3+ryXp
 Jzi3PQH3yfmnU+mKYihpFt+NxaRQbV++OdTM6G9nG2iqbU8/+7npnQW38RzmoP90sWaBD6kaxnv
 VCuBT5tuWfkVVVOf2g5CMVVo=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9dbca7f61e34c06a;
	Fri, 06 Nov 2026 14:29:16 +0000
X-Mizu-Trace-ID: 9dbca7f61e34c06a
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] blktrace: require CAP_SYS_ADMIN for the BLKTRACE ioctls
Date: Fri,  6 Nov 2026 22:28:52 +0800
Message-ID: <20261106142852.3233950-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
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

From: Tao Cui <cuitao@kylinos.cn>

BLKTRACESETUP allocates user-sized relay buffers and sets up a trace
that outlives the creating fd.  Every command of the interface,
BLKTRACESETUP, BLKTRACESETUP2, BLKTRACESTART, BLKTRACESTOP,
BLKTRACETEARDOWN and the 32-bit variant, can be issued by anyone who
can open the block device node.  The sg passthrough path
(sg_ioctl_common) reaches the same code with an sg char device, so a
container that is handed either node can hold trace state and relay
memory on shared devices.  The trace data itself stays root-only: the
debugfs relay files are not readable past root.

Gate the whole family behind CAP_SYS_ADMIN.

Verified on next-20261104 under qemu: with the patch, BLKTRACESETUP
with all capabilities dropped is rejected with EPERM; without the
patch the same call succeeds.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/trace/blktrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8cd2520b4c99..c1bf8ca350fe 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -927,6 +927,9 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	int ret, start = 0;
 	char b[BDEVNAME_SIZE];
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	switch (cmd) {
 	case BLKTRACESETUP2:
 		snprintf(b, sizeof(b), "%pg", bdev);
-- 
2.43.0

