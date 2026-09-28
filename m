Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160D440A19
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584893; cv=none; b=A19OhaRmqyIECg7FVsxT7C+6lqd4oMC5Bl61X5kOb3xl4vG+NP0MrsADyl3l2X64Lie7i3gUG6JyP2sujBtSrKojSdPGTFzgK+/KrjIk21FlZ2oL+lPsVrWjdJocVAcqkkYXAFyBV6YWo+ndZ2QPFgQpdE5Qjl5JwG7s9bEv7Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584893; c=relaxed/simple;
	bh=K1Yni322xZT2PO+NL+7Fd5sUV/yFCSq83+mHZlhJgFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iky/G9Y2jpYhkh1M9HXPawTKObmGY5U8lYr74M6EN2kvuzSTja0rcNnHKhun3kqM87OzWOb92IYgliaZkCfm6wbgTtOIc7Ff45ov0LPTSaQmZYd2LsMKerT/TfHn/pW3LqeNG9/6p8B0WXfnVB/ZHVOXV/kJD22ZBAINidKqo7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGTah3cO; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGTah3cO"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd025d06so1928286c88.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 01:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790584890; x=1791189690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y5+bY8P7iUZoJNRvZBqsGNqkac2ewq0b9ge66lTDXtg=;
        b=nGTah3cObZ7nl+g5jCdNWyn1IEcyQYOJSOZ25DjBMB9uG+uzNCKVso3MPW9jPqKMgl
         BOrywyatcAImi5wjEPJJ7UhebwQVF9LRgRIVA4U1FBd+E7dUyYEVZ9xKoclWSG3vcHX5
         ZOZeJToy6aUOggE7lRMfjibjj6gOvucRf9Pd4Y82XDxw7nHY46US4yjk00y/fzbUQOsd
         LsGsmU7h1PySD8sMAlAmir1QztJVflH9kTdouLUzbm5lIrPqBIBg26qCu0xFn/xpPFeP
         p90CuP4NwXe9jd+v7xFNkA31zQz/eyiuobQCsp7Xbzg6d7nwWmrF0wxeZAKiCLp5GtUf
         8raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790584890; x=1791189690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y5+bY8P7iUZoJNRvZBqsGNqkac2ewq0b9ge66lTDXtg=;
        b=AbNDY5aMa2pgzj3nD94KDWfRuXtNeyhrdLCmG9ODpk+N/pAKXqHFj65/AacSicyyhr
         W2qIAuzIYe3OM/AqttGMmo0ruWl4BtXSVK07ygnf2tGafByf6ksj45gJs9NzQhY9yjOh
         l5P0rVaQh01BqK2U48jeXoxrL2DSKI3q69EOSPTKvtBUj7K4+R0yU5SHzmI19r9Ph7UK
         ghYW4Q1jithGMtE33P+9AV6gSrxTiB4H94CnF7OfH8fjAY+xYRYIU1q3babwoszXchEJ
         TBTD4orJs5LhLGQNsZ7gL416hM8U6Ha7VkJjOKsbNLyb5MLK1U+NV88LlSe1jnPzpK8t
         zKAg==
X-Forwarded-Encrypted: i=1; AKwUvBwVF8krcaV0N0yKETAz17M6gLrVkMDGX570V/Vdx8XqVK36xcZJb+8UrIajlIJ9IFEEXeeTqTBEw773rOfA5k8UF2E=@vger.kernel.org
X-Gm-Message-State: AFuF++miuqtuwKJ4fB9xmAxrloSM/oaBSLD527sp3aRByMJ9HOAYayY0
	Rp5eG+EWV9PUZxibgYv0necEvipCYtcmoXcd6Hjuwa/cwUAR3eYG6UGi
X-Gm-Gg: AYBFou2UEEBN3/nyZyTBXY1dj0BCNNIcWbRVWPQYAfX3uxuUsfshfgU3gELFoF8V8Ih
	D+wrnzrH4355poeR1e9tESaSg2E4WPSC45ArdICu4IBnpvlxd+lSHFvMvAbsdQv3bGSIWPtl49h
	4mIILBNH3RRhJOM+rfL8PIrS5oXwjOKUD2Xn5XQ5/by4s6kcx9yxT76Y0BA00WBUBUolY/WOSFC
	jFhgcx2Bj3uOGDLMBVIzRVhVs2NP7R87KXYjbTqWLLIdGOBEey15NAJKLNUZOWJ1m/6ciYZFm7A
	wsBFzKvcsae8N2Ai7WX86aBDQqo3gurEGmP4YpESh7zpnsL23mRTau2wRli5E0M6nFOR1k+1M+m
	tkDDSOXu6uOJ06wzKEr6l5kGQaq4ERhRlbBTT3I7k11YDwmM30mYhbSobVi0LfyNshfcFPKl4N6
	c0KeXAH8rzDY29zjDeVoCbJG0pEA2oTElpGHpK56sgWQuyMUjeTKPARmpvxwvWKwyzVZjEMbs2Z
	ex4nvWud/ybcHgpGZ6dU0U8LLsOSFENj1MtjX5rVcsjzuyjvBtwWyPNQATy/W+VZ9siHl/EuGkg
	6Y0KGuVAM0qwq5yQXuw+vL/GP766ECP4iuPb2NI8Idg/llmP+aaT7HW0tl980JBC451ESz587g=
	=
X-Received: by 2002:a05:701b:2313:b0:145:9a2a:3716 with SMTP id a92af1059eb24-146cfec8543mr9661134c88.28.1790584890348;
        Mon, 28 Sep 2026 01:41:30 -0700 (PDT)
Received: from FT6N242TWK ([223.181.116.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ac67c505sm22947647c88.5.2026.09.28.01.41.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 01:41:29 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] objpool: fix nested pushes from NMI context
Date: Mon, 28 Sep 2026 14:11:23 +0530
Message-ID: <20260928084125.67104-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

objpool_push() runs with interrupts disabled, but a kretprobe that
returns in NMI context can push to the same per-CPU slot in the middle
of it. With rethook-based kretprobes (and, before v6.14, fprobe) this is
reachable since kretprobes moved to objpool in v6.7. The nested push
publishes slot->last past the unwritten entry of the interrupted push,
so a pop on another CPU can take a NULL or stale pointer, which hands
an object out twice and loses another, and slot->last can move
backwards, after which a pop on the owning CPU spins with interrupts
disabled.

Patch 1 publishes the entries in order with a cmpxchg() on slot->last.
Patch 2 adds a KUnit test in which a pinned hard hrtimer stands in for
the NMI. It fails without patch 1 and passes with it.

The race was found with a TLA+ model of __objpool_try_add_slot() and
__objpool_try_get_slot() on one slot: a task push that an NMI push can
interrupt at every step, pops on another CPU, and recycled objects.
Memory is sequentially consistent, with one level of nesting. TLC finds
the bug in current code, no violation with patch 1 (up to five objects,
four task pushes, three nested pushes, five remote pops), and shows that
a plain-store version of the fix lets last fall behind head. The model
(Objpool.tla and its .cfg files) can be posted if that is useful.

No earlier report of this was found: searches of patchwork (objpool,
rethook, kretprobe, objpool_push) and of the linux-kernel archive on
marc.info (objpool NMI, objpool_push, rethook NMI, kretprobe NMI) turned
up nothing related. lore was not searched.

Testing is described under "---" in each patch. In short: KUnit on UML
x86_64 (4 CPUs, 3 runs before and after, plus 1 CPU and CONFIG_SMP=n),
W=1 builds for x86_64 and i386, checkpatch --strict. Not tested: real
NMIs through a kretprobe on hardware, weakly ordered architectures, and
performance in the kernel.

This series was prepared with Claude Code (Anthropic), model Claude
Opus 5.5 (claude-opus-5-5). The code, the test, the changelogs and this
cover letter were written with the assistant; the TLA+ model checker
TLC found the race.

Shashank Mohan Jain (2):
  objpool: keep objpool_push() correct when a push from NMI nests in it
  lib/tests: add KUnit test for nested objpool pushes

 MAINTAINERS               |   1 +
 include/linux/objpool.h   |  37 ++++-
 lib/Kconfig.debug         |  13 ++
 lib/tests/Makefile        |   1 +
 lib/tests/objpool_kunit.c | 329 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 373 insertions(+), 8 deletions(-)
 create mode 100644 lib/tests/objpool_kunit.c

-- 
2.43.0

