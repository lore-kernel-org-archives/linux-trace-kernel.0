Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260743;
	b=bxZxW687gs79rQTTE1zfMDHSHoMKRVkWqAgtZsroZbctjCVp+nzFUPO/RzMIxVyFTWJp
	 cBBb2TwNZNC9VtSg/NK0xulUtzmi48/okxoye/auoJ8qtf5UbE70SJAwAYcnSvLPbMwiJ
	 EnL4lfMIQQJRKbhX3x6HI29eR/YERg0M58BT4FPFS7B/trV9wjUUvZFEsuyA9v8NdhOQD
	 z1nuehztE4lyEixLUgifsV5MrXJBddZKbog8REbpSEWWKT8re3HR3CJ4dF3QCwZ8VSaRA
	 cLIZhzpoKNzZVX7KWDecoXmaci3eWs+hD4BJ8S+YXK/zhnE17D/o4rS46pEhTDTo84Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZXuntybJT1A6GUEbL91LqiaVHs19KjdwrOYp+ImkAiY=;
	b=MPVLXaiG2hR8phArVS812NpVDjxsiUTs+ul0/w8gZhoRFHm8wqtC5LZ/3j6/if1nwszv
	 YcMTmjqwYNbh82l0CiXb/N/MbyBiAmnaqEcY1DXCyy7z1bgdaP2gOsS13GQuzSBZDJpFx
	 G6ocql+hsXC98lTl+r1cG7bqcqMZyKazVef/HbiccyvldAdH9yY6/eqDDupBLSzV4GfJr
	 bWuOQDMydiPldaNvCph7xqEznfmG1HC8Hicmlx1GrAonxwUDRjyzrUYJ/YgdejzMZmswi
	 9neTfAB+mu4Z6wnjlKLSL3RvmztK58TuZFPpvcOVax1WP8LiNiBOs2J8XtNG7knfJrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=awXHIMFU;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4862606A32A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 11:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4862606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=awXHIMFU
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so1359976b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 03:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795260742; x=1795865542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXuntybJT1A6GUEbL91LqiaVHs19KjdwrOYp+ImkAiY=;
        b=awXHIMFU2iGkBZe5K4YcymCQ39mQgTUowtrLC42Vg6JWNnGurpc57y9EQ5kW2qJO2G
         ycxwGQgRMLOWJ53Lo/YFyBjUXoyFGyF1490dIYY+rismXiSzV8jfoz9FYQXth0gqR8zr
         iJrkabmvUyY7aYE5E6QIsU2YSAX3gF6A0NbAVg7aA+BAyTiRn2+7NGQUeOOzcIUcoylm
         0YWhQcDYZOZIryPLNkXy+CD0C9TYUcAF2xhtxAO4Vjw6qOtr0/roLgvn9De/7vjSOPdV
         QgfG+sK3FyLTCftx8IslTww9d/iCzuwBD1pacPaEsd01I2pSqFRaMs7tR8uVi6bwuGo9
         oRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795260742; x=1795865542;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZXuntybJT1A6GUEbL91LqiaVHs19KjdwrOYp+ImkAiY=;
        b=bgP+VyswrcaMFIEfIoDwr53VUTOCVgy55aQY08cPu1PdfDF0Dr6pChDwcBIA49Jn03
         cWuwvMUywp1NdM3R04XQ6UTrth9EXw1nNjeU23UqTIuZ1Z12jsMr/4hUBptQbeNIzISy
         PrXYdMBsQaD8EY9CcVLtRvtZDQQ4oDFxvrBVbSgYprn+90IJbY+q1bGKqExwq72NaBOd
         vvrik/kbXWT3O7XNbmRg2R0ljamK+GuoToV89nHIKLY/WjmPGPrmwlIZ9DitreshG75c
         vdkZV6WXFFoGQfvoRv9daxF2xxDihzbqUy/LVqjDvJWuX0D8ZYyLkuG8wRrhdD7XvQeW
         OGbQ==
X-Gm-Message-State: APuU4Z80Xs4qr5m8g6moc9l5M3l4OfyG3wPDzrZGiSLvFFoca1jo8k2F
	duozTjkDI8/bQQ7pTlYT+SqDUHmxhL71cXGfp0YN3xkyoqCiBgccoCNIlijMOQ==
X-Gm-Gg: AZFdTZcu+X6Do9qgZ/lEKlJDIadhgMuWgNdyFKcasPUpu3wdY6t/eWkNHhSsItOdcgW
	ZzrRPWN/FI/blLGI5zj3vFz2AFdQ6thQMfU1QHwd7sqovynzM+hp7DUgLR5cLnjRr4TeoO0IIoR
	VMkpjqtqtu/MXmHOzN/i4IH+Sy1UMTOZUgMtPpW/YFhdrtjcc1S7B1oVkKdyWNfh7OkAWIvS+xK
	QQgyKDZpBKLEhEUDtX/ZNyvQm95prsbKwmQ0MaU98c+OsMAMz37ODHqZhhiXAUgVZbtDBqdennd
	oUNrmG9OddmDrNbVWk8X0DN/UePkY9qC8B24N6k9FFoj5qhmTD810FRP03eS7hw6f8V1WitNhZn
	Z4FkaTOLK9fT55K+hnBaedJpGCxPln4AX57YJFkf93ytYwyA0pYB9bNKOp9C63u9htsYkKc+QDx
	2xbxjhNdj0QbHuXjvI1TBvTy7N6xArHVJxDvGtKWXMpdWeAjVgT2oSxpNO0GUJ4ApiZ30o3oiv4
	KAFk+rDPQUVARm2k5Ox4q4xgRJMyGinJ1LOml8Ob4ZOQNSB64dXK/983KhzCmhwdtlT68WZHSUH
	Ws4kpd/YLvshbnDa4GLSyPBVUjKzl+gfOmBZc7OVzQ==
X-Received: by 2002:a05:6a00:1818:b0:899:67fe:3c52 with SMTP id d2e1a72fcca58-8c87b4efad8mr6004537b3a.15.1795260742071;
        Sat, 21 Nov 2026 03:32:22 -0800 (PST)
Received: from [127.0.1.1] ([220.196.193.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c908a56acfsm2149772b3a.23.2026.11.21.03.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:32:21 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] rtla: handle SIGTERM and test abnormal exits
Date: Sat, 21 Nov 2026 19:31:27 +0800
Message-ID: <cover.1795258353.git.chaosheng.qu.linux@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

v2 mixed the SIGTERM fix with fixes to the test harness and repeated the
commit summary at the top of the commit body.  v3 splits the test changes
into their own patch and writes both messages so that git am does not
duplicate the summary.

Patch 1 adds the handler that was missing.  SIGINT, the -d/--duration
timer and a failing --on-threshold action already reach the cleanup path;
SIGTERM terminates the process and leaves its tracefs instance behind.

Patch 2 adds the test for those paths.  Its content is unchanged from v2,
which was run against 7.3-rc7 in a guest for the SIGINT, SIGTERM, timer,
action-failure and repeated-interrupt cases.  Sashiko also pointed out that
a signal delivered between instance creation and set_signals() can still
escape cleanup.  That window is real and pre-existing; moving the handlers
earlier changes the cleanup ordering and is left out of this fix.

v2: https://lore.kernel.org/linux-trace-kernel/1794300001.11111.1234567890@gmail.com/
v1: https://lore.kernel.org/linux-trace-kernel/20261017122359.402696-1-chaosheng.qu.linux@gmail.com/

This replaces the v1 submission and the v2 series.

Changes since v2:
- split the test changes into a separate commit
- drop the repeated subject from the commit body; the harness changelog is
  gone from the commit message and the previous-version links are here
- no functional change to either patch

Testing: v2 was built and run in a 7.3-rc7 guest.  v3 only splits and
rewrites the commits, so the code under test is identical.

Chaosheng Qu (2):
  rtla: handle SIGTERM during a run
  rtla/tests: cover cleanup on abnormal exits

 tools/tracing/rtla/src/common.c               |   2 +
 tools/tracing/rtla/tests/cleanup.t            |  70 ++++++
 .../rtla/tests/scripts/check-cleanup.sh       | 211 ++++++++++++++++++
 3 files changed, 283 insertions(+)
 create mode 100644 tools/tracing/rtla/tests/cleanup.t
 create mode 100755 tools/tracing/rtla/tests/scripts/check-cleanup.sh

-- 
2.43.0


