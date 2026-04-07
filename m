Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2374D19CCF7
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Apr 2026 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588293; cv=none; b=eWfh7r0npqUZmrwuDBDSykWHh2n+h0NJh7iqnFmiOJk02CnGCT00ssgTLgFiSlDFA41HoB/K+4Ftd6SIhxJoQx1jFiLbv+m5EcxrWv/zGABvyGEfqiHSTiSA4rivb9jygYHAGAmSxWUGiGciaZb/2OMyn2bBwUa90UWbBQKoNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588293; c=relaxed/simple;
	bh=GR45AI0o78Ytejg5IdSf+fIb6OLzz6uoIIPfDIjeIWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3BqVv3inck6KdfgsaTzN6g/EIk02bVzhWY3e0Bkal/RE28DWAD3l/aqVAGNcUVOeHVm9HDRg57FDwwANBVdRN4UOxi8WsqFKSk6Bnoh8Hp+xOARfxfZn4h6Cjo4tZVQJ/AjV1HewTND2NXu2MFRk4tJU6zXnXX1v0ur1JrMzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqzCghp1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqzCghp1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b256a4c6b5so32555325ad.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Apr 2026 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775588291; x=1776193091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=55j8IddnRN/mRx9o2IbvUofVTQLK3O2pOkhg4YsKhUY=;
        b=TqzCghp1D07Nx9ZaCp8ExzNn+ctR7LJEXe0LvE82b5XZkCOvFt7Q+ioGY82mDH/wWD
         Zd3/aJu9CSCKQ5AbDWkbROC2/I7xNnmZHVeTdGu3DL3gITuDiB0BgFyJkDnTLvy8jYG/
         e/0FDW93NOC8Qjo8jvlBu69oDUGRFSfrq4nZVBaVAe85UnCYsCtgtYKdeP6CkJ79rn0U
         lRCOHny/o2ZqtoEbuss8SlGVxHWym9o/VQfG1Hh1Rq7R9Ix12tHlDYQdkAGqaikPpDCP
         q/XpYe4z7SEcYFQb67VDjNGU1DIffnqA7Hc3ICEc+/oMTv5rjYL+efaF3CxWeOCL8VUi
         p09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588291; x=1776193091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55j8IddnRN/mRx9o2IbvUofVTQLK3O2pOkhg4YsKhUY=;
        b=EnilgfdPyenOYhAyLaeUk/OMbL5UdbZgKI5Nofm+NavO90D8OFifhbugL1V953r4lW
         5kAV5+PaVRyshmcsnkFkPRKuUm3yVEecGtlGH/msKtEsDG2WG6ZPdi3jR6aaGt4B6VP+
         UCT52eUFwWLSNd9dI3IGUzoHFH9Vi0ZDxvf+ZB0wrFGBLrwwk8vFRaryROCrk1TtgTUD
         hGWGEFIRpV7QCzbEg88mesurAGJEY5/2nUArYmxB/Y7zvYgLN49LRo81ZdWnmV2J7ilQ
         uQZYElW0dzTBVWAlWij8deIwEOaPhHxcZ/DqPQdEUd+Ei7Tmabm0xTFhqMWxo519kXEr
         Rc4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhiQW+Bs2e0S5lhDELgNKOo0Gem9bhvIGeF2VtFBVv1n6Hjmw3WlevNhG6qU5CsWlu8vJavhV6OpUPy58EnzhTxoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNmkwWmjwIhksDbA3Fus34N88bh4mcek2oAMLZ4caizr3IOBGX
	L0ZaDSg/zEah81I90NPfNObNJ4Zqp8xsg4jQvLOBvpaXlMeQpXLcaSmM
X-Gm-Gg: AeBDiet2QZj+393ylO0xq/K0M0D2EjEhyJaq4i1zXL0f7Im/Cu8mHtAtSKxUb4MJVst
	r3ZxrgrLFRD8EPh1G+kbfznVRZyWQ3eWts92qNZp6U0L2gPeTBoGbn/QVduQxIUWkH+HwiSi/SV
	VJsWG3zlqxJK2v9pZ6nuEcNtHz+2dim8QugPT4aZgGRmCPlKxJvgSoXR/AnQdppEn8YXp0LaRXF
	PAfA6FYOv0H79soEEYhy7u+xf0RNY2PPn0aT11hoYD8l7258nIpao6Sm4t7iIpekXrPAxKRpPxm
	R9RhoWE+MYnw8lMXX43WfEkLyPhQamN6vE1GToF/2aT6UwxDgZpNBh0/pBZQLageGfZbiwK0yca
	L2BMjTbX1u8dzyTHn3JNodSi3VRcDg5kGWqBRoadnee1hYzJTsZdEchR7+xmXOfD1NacfbDYmBt
	1Cp+bNV59uEtNhyNUeHuJmb3/A1Ld8rSo=
X-Received: by 2002:a17:903:22c5:b0:2b2:a6a2:c8ca with SMTP id d9443c01a7336-2b2a6a2ca50mr73961255ad.13.1775588291250;
        Tue, 07 Apr 2026 11:58:11 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c45:a41c:c2d5:268a:232e:d07e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749ce29esm193486145ad.81.2026.04.07.11.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:58:10 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	naveen@kernel.org,
	davem@davemloft.net,
	mhiramat@kernel.org
Cc: peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	chenmiao.ku@gmail.com,
	johannes@sipsolutions.net,
	nsc@kernel.org,
	masahiroy@kernel.org,
	tytso@mit.edu,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [RFC 0/2] openrisc: Add support for KProbes
Date: Wed,  8 Apr 2026 00:26:48 +0530
Message-ID: <20260407185650.79816-1-sahilcdq0@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds basic support for KProbes on OpenRISC. There are
a few changes that I would still like to add and test before this
can be considered for merging. I was hoping to get some feedback on
the changes made so far. The implementation in this series is based
on KProbes for LoongArch, MIPS and RISC-V. 

The current state of the series allows traps to be inserted dynamically
in the kernel. A KProbe can be inserted via a kernel module whose
init/exit functions are used to register/unregister a KProbe. A pre-
handler and post-handler can also be provisioned in the module, which
are associated with the KProbe and triggered when the probe is hit. See
the documentation on KProbes for a detailed explanation [1].

The following are yet to be implemented for OpenRISC:
1. kretprobes
2. kprobe-based event tracing
3. ftrace, and kprobe features that depend on ftrace (particularly,
dynamic tracing)

I hope to submit a patch for kretprobes soon (possibly in a revision of
this series).

I wrote a couple of kernel modules to test these changes. They can be found
here [2]. I also ran test_kprobes located at ./lib/tests/ against these
changes [3]. The results are as shown below:

/home # insmod test_kprobes.ko 
KTAP version 1
1..1
    KTAP version 1
    # Subtest: kprobes_test
    # module: test_kprobes
    1..3
    ok 1 test_kprobe
    ok 2 test_kprobes
    ok 3 test_kprobe_missed
# kprobes_test: pass:3 fail:0 skip:0 total:3
# Totals: pass:3 fail:0 skip:0 total:3
ok 1 kprobes_test
/home # 

When compiling the kernel, the following options should be enabled:
1. CONFIG_HAVE_KPROBES=y
2. CONFIG_KPROBES=y

Also ensure that CONFIG_KPROBE_EVENTS is disabled.

To compile /lib/tests/test_kprobes.c, add the following to .config:
1. CONFIG_KUNIT=y
2. CONFIG_DEBUG_KERNEL=y
3. CONFIG_KPROBES_SANITY_TEST=m

The first commit cleans up and reorganizes existing functions, fixes
a few issues with instruction simulation, and introduces new structures
and macros that will be used by KProbes and other tracing facilities
in the future.

The second commit adds support for KProbes. Currently, I have
implemented this in such a way that KProbes can't be used to probe
a few "blacklisted" instructions. Probes can't be inserted in a delay
slot either (similar to MIPS). I have also added a few asm functions
to the blacklist that I think should not be probed. For e.g., "memset"
and "_trap_handler" have been blacklisted because probing them causes
the kernel to hang. However, I am not sure if other functions in "entry.S"
need to be added as well to the blacklist.

Thanks,
Sahil

[1] https://www.kernel.org/doc/html/latest/trace/kprobes.html
[2] https://github.com/valdaarhun/or-dev/tree/main/home
[3] https://github.com/openrisc/linux/blob/for-next/lib/tests/test_kprobes.c

Sahil Siddiq (2):
  openrisc: Add utilities and clean up simulation of instructions
  openrisc: Add KProbes

 arch/openrisc/Kconfig                   |   1 +
 arch/openrisc/configs/or1ksim_defconfig |   2 +
 arch/openrisc/configs/virt_defconfig    |   2 +
 arch/openrisc/include/asm/asm.h         |  22 ++
 arch/openrisc/include/asm/break.h       |  19 ++
 arch/openrisc/include/asm/insn-def.h    |  61 +++-
 arch/openrisc/include/asm/kprobes.h     |  76 +++++
 arch/openrisc/include/asm/spr_defs.h    |   1 +
 arch/openrisc/kernel/Makefile           |   3 +-
 arch/openrisc/kernel/entry.S            |  16 +
 arch/openrisc/kernel/insn.c             |  74 +++++
 arch/openrisc/kernel/jump_label.c       |   2 +-
 arch/openrisc/kernel/kprobes.c          | 381 ++++++++++++++++++++++++
 arch/openrisc/kernel/traps.c            |  67 ++---
 arch/openrisc/lib/memcpy.c              |   2 +
 arch/openrisc/lib/memset.S              |   4 +
 arch/openrisc/mm/fault.c                |   5 +
 samples/kprobes/kprobe_example.c        |   8 +
 18 files changed, 701 insertions(+), 45 deletions(-)
 create mode 100644 arch/openrisc/include/asm/asm.h
 create mode 100644 arch/openrisc/include/asm/break.h
 create mode 100644 arch/openrisc/include/asm/kprobes.h
 create mode 100644 arch/openrisc/kernel/insn.c
 create mode 100644 arch/openrisc/kernel/kprobes.c

-- 
2.53.0

