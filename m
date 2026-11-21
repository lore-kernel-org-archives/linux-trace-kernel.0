Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795262609;
	b=ZCmWAgHgTpk67FHd8H68Pla2VqE1JD0TaT1+k7+/62iG85+bI7XfoblsNFyKOaaOQU7C
	 3PB/EDxUbL6lgSDYouHHgJ3eahiMr8hhR6VQh3Lez59UDa1akTuY8a/FG5KpieizKgpyK
	 ziTlorPp8Tz5X802VspMNTg0Z2HrYOggli6bs8Pn+1JoCmvARvOH5AzoP5/bnNM0Ii1e7
	 XbhTBDz5OVADtGECQ5D5evQIdYChpEt5WKehFB5rQu4CzgNERDa+CEax+HUXlDLYe8LQC
	 LZ84M70juOP3pR8KYkUH54GwVShiT0vw/gMor6ntglAe+9DTsKKKIkR1NSKMXle/wXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vPA6qcxIxzfcfFCB423ZCb64SHQJPAgmU9OFUPgc7HE=;
	b=bHtHyZIguZc6KvF9IhnhHNfow5Iin0kQNuq5aFbLgmylnhJbbTUg4/ZwfbnGYq8WmQ1Q
	 9bAhFqdPe4zCMaWs64hImbCHt8eEPyxjX57NY9r4Y0MA3zK8o+L7OtkOM/vonTvFE3hF+
	 ajk2AzKcqtrbLi3HWwQ2w//0claiIVchDn3xKcWvd7VmO3fSB+WRpS4TH2rmlMyJpO6Am
	 P9rr/K3NRTHmjL4ATQ8vzBHnlr4+mFvNZI9d7pVa7oea6yNzwnNuySJ2R5xftIMSvB67j
	 YgcdzqeTs0BM0GmSiNfQAvM9R8B46oblM048ScPlbbIab+NQ59LDk/+azsYCwHY7+Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZDAdsEjx;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D609606A32A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 12:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D609606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZDAdsEjx
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b413997581so1632302a91.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 04:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795262608; x=1795867408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vPA6qcxIxzfcfFCB423ZCb64SHQJPAgmU9OFUPgc7HE=;
        b=ZDAdsEjxlM5KAW3sIXGD7VaXwb32RltnO4d33r25eBtmGYJgqDeTnuefzeYZShjpKu
         U1BWk9ye9ApCfPvuORkg7OBigwKMcJDockUnfmRTHk6JQooPhQmRcl8ygO6J8oq9IUDJ
         ziCOkVgdqC/QBb03jJRTT+pnIZvtawwp75Ppm89rnKwcKvQMZhXgcsemnS01FZ8T3d8i
         ojcI9o9JsYmepqn/fLjFPGRNg7EOSaEce2UlDWqgCXan6rLfFJmigq/ifvFsyXodEcbC
         5LRI+IR0tsUntUDln+IjF8ihIwSbno4lEePqTm5r7mmZq2AQiTaPEBqJk1hkx/HRrFJA
         +p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795262608; x=1795867408;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vPA6qcxIxzfcfFCB423ZCb64SHQJPAgmU9OFUPgc7HE=;
        b=ifpfOAjzRxY1C3oVMX8P9mNRNGAKZD0TK2mfYlBfxJkPXIhL1pmQ7emPwui/ZnSuGN
         lrIxh+GOkUBciyQXCmC8Ous13QtCSd+hK4IuYvqtU2FVDIlI1OYx1p1XM7An08U8qjPO
         UL38G9zk9ItPQroWJQGudINk4Mth8P9B4l4xPkg7CXtiXRftT0EwkQcUEmnuc9OfAXQg
         2HiYI1b+7g2kU84Vhzd0XelRxZ+HBpkiQFpgrGqGlSYNV9ILBqe78cxyukd5kvPadvnk
         Et+lXqvPKYfVVbkDNCnb5XxgNjIU7bB4aTsvMiumlQ8OeudZOQ6E7Q1VjoHj3DKQE3CD
         TZgg==
X-Gm-Message-State: APuU4Z8h92ysWzodlbqBuMTCevt4ziBS3J64UGphmDWsD6PNUK1oXc86
	Ry0lKJah3mK5KjIt+y2tanvbdibQKx0GCCtv8RWSHrUGW8YpEqx5ooNmxH8/FDVr
X-Gm-Gg: AZFdTZclNbwcsdcYWy76JO1LzEyed3mt/hvWoACZuanB1G0h6jpEFPLpWyireirA3Sh
	J+ond9CA81Ka7wzahOW6EhUWMumrqg4qV4jlYDfEV8Js59Px/7wcjTgYojBnYn/4ynFsHSj9eSf
	Ukx2EaGBzFZ5S5az090PwUZ/0dv9GJlQ5mcsXOcFzYVsRYVJKo45fsMuHpom/k8R4duaP7wmTCm
	2sYhqzYCdpWZip32eNLj5/b7WhbcY8qjUssiZmKYfmDw7oybga++ybfOzfm8wpwV5pwpgefCg3K
	Ail9UIl/z/r34Fz1QicjIUs4ZCbmf8w8J9PmnTCyQqSj1Fl3N2hPsCFJrM5+tnUYNA0SWVvpnNB
	gDR1x04SwDMoZFCp2e1f3TRWfWHod8ZERqKWx2Yf5oO+iMS5icTfm1NM7DyzPPyL9PEoeaiPKdp
	TuHA+VVE+ZXwE3e6nm/QKkR7oKPUM/LCBmXa/TWJUhmjfOZWvunCHuCYswGj/QuftGWkz1riQEK
	rflO9o+0PJcvLRWqMe5p3jryCDjFp5Q+impfI8U/nb4WnZ6FjltmKGwKNoKVyJIapI0CHlgrmRr
	bToogQuji0JWyO/54fgwhhh/DIi9cCUSOzZW/x7I4g==
X-Received: by 2002:a17:90b:2c84:b0:3a5:c08:4c41 with SMTP id 98e67ed59e1d1-3b41c98a138mr5054210a91.50.1795262608391;
        Sat, 21 Nov 2026 04:03:28 -0800 (PST)
Received: from [127.0.1.1] ([220.196.193.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d97356sm11171339a91.13.2026.11.21.04.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:03:27 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] rtla: handle SIGTERM and test abnormal exits
Date: Sat, 21 Nov 2026 20:03:22 +0800
Message-ID: <cover.1795262546.git.chaosheng.qu.linux@gmail.com>
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

v3 split the test changes into their own patch and fixed the commit
messages, but the test still signalled as soon as the instance directory
appeared plus one second.  On a slow guest that can beat set_signals(),
which is the startup race sashiko described.  v4 waits until
/proc/<pid>/status reports SIGTERM in SigCgt before signalling.

Patch 1 is unchanged: it adds the SIGTERM handler that was missing.
SIGINT, the -d/--duration timer and a failing --on-threshold action
already reach the cleanup path; SIGTERM terminated the process and left
its tracefs instance behind.

Patch 2 is the test, now with the readiness check.  With it, cleanup.t
passes all five cases on a 7.3-rc7 guest, including SIGTERM; without the
handler, SIGTERM leaves the instance behind and the test fails.

v3: https://lore.kernel.org/linux-trace-kernel/cover.1795258353.git.chaosheng.qu.linux@gmail.com/
v2: https://lore.kernel.org/linux-trace-kernel/1794300001.11111.1234567890@gmail.com/
v1: https://lore.kernel.org/linux-trace-kernel/20261017122359.402696-1-chaosheng.qu.linux@gmail.com/

This replaces the v1 submission, the v2 series and v3.

Changes since v3:
- wait for the SIGTERM handler instead of a fixed sleep in the test
- no change to patch 1

Testing: cleanup.t on 7.3-rc7, 4 vCPU QEMU guest -- SIGINT, SIGTERM,
-d timer, action failure and repeated interrupts all pass.  With the
handler removed, the SIGTERM case fails as expected.

Chaosheng Qu (2):
  rtla: handle SIGTERM during a run
  rtla/tests: cover cleanup on abnormal exits

 tools/tracing/rtla/src/common.c               |   2 +
 tools/tracing/rtla/tests/cleanup.t            |  70 ++++++
 .../rtla/tests/scripts/check-cleanup.sh       | 219 ++++++++++++++++++
 3 files changed, 291 insertions(+)
 create mode 100644 tools/tracing/rtla/tests/cleanup.t
 create mode 100755 tools/tracing/rtla/tests/scripts/check-cleanup.sh

-- 
2.43.0


