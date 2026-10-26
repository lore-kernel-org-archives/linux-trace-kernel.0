Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045586;
	b=4aO8tkLvxMe/v7zxiv7qodiLsu6Pxzma16A4YsWrvyt77k53yEv79KnL7nq7G600Wnxm
	 9iNxJsN9fR+57RALfXODl/AQoDM/fij3N/2/djUyUUooluro/9jReyn5H5tKQzegpGgNl
	 jaYVTSULQrEe/vXzrUVTCYxGAPSQ5NyTfhatTTUqasoquSrfSvDVDVUWvnfKR1cz8v9B2
	 iUYx+/TlTgl071B5Ikqw61jWJjFp0IkLbXRhDUBxb89EnphxpCfnvNxIgP0EpB+VV4p3m
	 ab76v8HWQ1EaJjdlZ++ghU1SilSSSUVhIuuIAIx+k+gO8NkklMHce1TecjEuSJTLJmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OhPw/t0thuE42MTIauI/9M1hfWP2vTijxdRJ7K4XEvs=;
	b=5atyX6BZrNqjAEmeFOPXDxlpDtFwPJCtSOX1EfwSXgM5XYuYRw35xoIqCdhuOCNODysd
	 xHHMH+d0z4igalAmB9u/uFcb5AOVoBw7ZabQVvfPMpBX1EMcp7f115wXurRBzpZvNhr4O
	 d0fyIdgyYWS8fOZt+xHr2MtvM4hyXuP4aULqPIm96FSe1hZA5w5RKEGM1E74rdhaw6OdO
	 gyKKnE9iWjETzNpwzm7kfbfevxMsfHz6Cq/lZwO9al1P4o/edivqgX89glT5ADFOz7NHx
	 U0m2DK5gkutwwrXNz6IFmGU5RurppZx5Kslfun48pxodWM4NMnMiJnbt/29wR8N6khg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iZSsD+ok;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3D606A31D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 20:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4D3D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iZSsD+ok
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-188406bb948so2745463c88.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793045585; x=1793650385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OhPw/t0thuE42MTIauI/9M1hfWP2vTijxdRJ7K4XEvs=;
        b=iZSsD+okZX18+3aGlEEq+hrifywxlF+ayNIFWPYkXfUfeicP+QMQxYoPQpVYlPmeHW
         CaJAqC7rEasA4dwARNd/OP1qMMIVfQQ0HzB8B5MNi1ifdXtm5z6nJ442aIMV7Wf9qUDR
         phvu17dVAUBGvOgrvNwUzIeN1+oldfWwzDBZYJM3nBeUP2bWYC/3GECn2bgEwciGGM6x
         cWr7rn/QDiI7Y5BUmN6MslQyPMLidK9lJFM1uu+mkaK0impzNwhrP5OTN6y2Lt70vDAe
         nsgDg3qpU4TNoYx8M3cRjcXZFYSDjfO9eyxccJZG03nlpnncC1KrqXvXLD1nqIIcqn88
         zfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793045585; x=1793650385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OhPw/t0thuE42MTIauI/9M1hfWP2vTijxdRJ7K4XEvs=;
        b=nC/Xf2/mx0J635Ha3F51rlyc3nfMU9lnhhxU/w6kZf9S2k79xp8/RaFasyrOVhPgAT
         1ccaXCCKLDpl/LwcZQm0Q2Jij8Fiovpc9PxMJweip7pqel2iDYAsxqgglaKZQTZ6Css+
         OXqOJOifma0YBipTWAHpBN0vVtqihpwECLVkqrJr2L8pU41R83mC1BOAkNv7byJXhUVU
         Q0dkyoZJVGlHzO6B5cggdXN/ZxtQP+Gti53WPiu2kvDJtjbVyMskXOl9PgSNVeyccPre
         3c0S/FUeZ0hEjXN3hpu88gxmNcVHbpE/HPLvepO6GR9G0hO/l8goTslVqGcUidi0HRV3
         SiZg==
X-Forwarded-Encrypted: i=1; AKwUvBzo2ziZkEg4UDJnIBpvPkxkZg7OzC2jnyZFGdfK0KBTO2BM9oLRz5MYPv0cmBfujyp9/cZxHyRI37LcikrVFMzrqwE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLETBibjwdeRRrQayseSF3XdXtLv2A5rZyXTt7hXJ3T4EWA1ZgA
	6QQH85K9kYp7DhTiQBzzckvJq+JxK3D+IR/JoBlZNGwCXl7Ph3cekhOE
X-Gm-Gg: AYBFou2dvfYf6dv0sUektSTnP0He1TPwbfbRbKJQ0cdr7/1Bt9oJH+/xY+7fudGZT+o
	OGL+Wmgub0OS7agLQfNzqP7Pb4U2RVxMKAU3w42Y9POLWEC4ybdHJllLx/XSBRJktPSKuQxls2w
	bvmHR15XZqSUgbolW5vAdiJZdD3UIm7/uPD6dpuKYEvM7ZH5htFFIarsxettYMZTY/+TwyDTliF
	Qb8kBr/VKx2VIKWltGXU2xf6HK9AwmclkOfJBe1zjLDzMRklt+x+k3J9XT5XZOSo029ywfHZrRq
	d7ldkgXfd8G9k5Bu4xHHW066mBKpiqm0Ds69PIFZnRPXaLubj0N/HUH/HfotRrZZDqqkyzTGNJj
	X3MJX44NXlUe45IyKgvMF5k/Rbn10mxDTGqkcPgEQv4D052bAtQwAgf4H9QRKoGSBm7n/t3eSZD
	Faz/NOhmhlfeClcI90L5Epys9jl86hRf5ozYigC6i1hrD6d/+9Pm51bffdLPbc9Mpvw98Jl082F
	IssUuedEpx6iRWbNhNle0oGriVrKgnPmNG79E7jJajLZDAAVEdsy3t8SLuE4dY=
X-Received: by 2002:a05:7022:7f14:b0:16e:c820:b20d with SMTP id a92af1059eb24-19929009cfamr10703365c88.5.1793045584456;
        Mon, 26 Oct 2026 13:13:04 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c44:61b8:f26f:bd5b:b550:7a07])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a020df20sm31730486c88.6.2026.10.26.13.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 13:13:04 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	naveen@kernel.org,
	davem@davemloft.net,
	mhiramat@kernel.org
Cc: pjw@kernel.org,
	wangruikang@iscas.ac.cn,
	namcao@linutronix.de,
	kees@kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [PATCH v3 0/4] openrisc: Add support for KProbes and Kretprobes
Date: Tue, 27 Oct 2026 01:42:36 +0530
Message-ID: <20261026201240.107462-1-sahilcdq0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930202744.50489-1-sahilcdq0@gmail.com>
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
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

Hi,

This is v3 of the patch series to add KProbe and Kretprobe support for
OpenRISC. KProbes was introduced in v1 [1] while Kretprobes was introduced
in v2 [2].

In order to build the kernel with Kprobes and Kretprobes enabled, the
following config options are required:
1. CONFIG_HAVE_KPROBES=y
2. CONFIG_KPROBES=y
3. CONFIG_RETHOOK=y
4. CONFIG_KRETPROBES=y

I tested the generic functionality of Kprobes and Kretprobes using the
tests located at "lib/tests" [3], samples located at "samples/kprobes" [4],
as well as a few test modules that I have published here [5]. The following
options are required to build the samples and tests:
1. CONFIG_SAMPLES=y
2. CONFIG_SAMPLE_KPROBES=m
3. CONFIG_SAMPLE_KRETPROBES=m
4. CONFIG_KPROBES_SANITY_TEST=m

I have also added unit tests at "arch/openrisc/kernel/tests" to verify
that Kprobes work properly when inserted at branch instructions, and
that delay slots are handled correctly. The tests are based on the Kprobe
testsuite added for RISC-V. The following options need to be enabled to
build the tests:
1. CONFIG_KUNIT=y
2. CONFIG_RUNTIME_KERNEL_TESTING_MENU=y
3. CONFIG_OR_KPROBES_KUNIT=m

Below are the results of the tests and sample modules when run in my
environment.

- kretprobe_example:

/home # insmod kretprobe_example.ko 
Planted return probe at kernel_clone: (ptrval)
/home # ls >/dev/null
kernel_clone returned 35 and took 1302450 ns to execute
/home # rmmod kretprobe_example.ko 
kernel_clone returned 36 and took 1121200 ns to execute
kretprobe at (ptrval) unregistered
Missed probing 0 instances of kernel_clone

- test_kprobes:

/home # insmod test_kprobes.ko 
KTAP version 1
1..1
    KTAP version 1
    # Subtest: kprobes_test
    # module: test_kprobes
    1..5
    ok 1 test_kprobe
    ok 2 test_kprobes
    ok 3 test_kprobe_missed
    ok 4 test_kretprobe
    ok 5 test_kretprobes
# kprobes_test: pass:5 fail:0 skip:0 total:5
# Totals: pass:5 fail:0 skip:0 total:5
ok 1 kprobes_test

- openrisc_test_kprobes:

/home # insmod openrisc_test_kprobes.ko 
KTAP version 1
1..1
    KTAP version 1
    # Subtest: kprobes_openrisc
    # module: openrisc_test_kprobes
    1..1
    ok 1 test_kprobe_openrisc
ok 1 kprobes_openrisc

v3 adds a few fixes to the patch series based on Sachiko's review comments [6]. I
have listed out the differences introduced in each iteration in the following emails.

Thanks,
Sahil

[1] https://lkml.org/lkml/2026/4/8/21
[2] https://lkml.org/lkml/2026/10/1/28
[3] https://github.com/torvalds/linux/tree/master/lib/tests
[4] https://github.com/torvalds/linux/tree/master/samples/kprobes
[5] https://github.com/valdaarhun/or-dev
[6] https://sashiko.dev/#/patchset/20260930203129.51048-1-sahilcdq0%40gmail.com

Sahil Siddiq (4):
  openrisc: Add utilities and clean up simulation of instructions
  openrisc: Add KProbes
  openrisc: Add unit tests for KProbes on branch instructions
  openrisc: Add Kretprobes

 arch/openrisc/Kconfig                         |   3 +
 arch/openrisc/Kconfig.debug                   |  30 +-
 arch/openrisc/configs/or1ksim_defconfig       |   2 +
 arch/openrisc/configs/virt_defconfig          |   2 +
 arch/openrisc/include/asm/asm.h               |  22 +
 arch/openrisc/include/asm/break.h             |  19 +
 arch/openrisc/include/asm/cpuinfo.h           |   3 +
 arch/openrisc/include/asm/insn-def.h          |  64 ++-
 arch/openrisc/include/asm/kprobes.h           |  77 ++++
 arch/openrisc/include/asm/spr_defs.h          |   1 +
 arch/openrisc/kernel/Makefile                 |   5 +-
 arch/openrisc/kernel/entry.S                  |  16 +
 arch/openrisc/kernel/insn.c                   |  88 ++++
 arch/openrisc/kernel/kprobes.c                | 426 ++++++++++++++++++
 arch/openrisc/kernel/rethook.c                |  32 ++
 arch/openrisc/kernel/rethook.h                |   8 +
 arch/openrisc/kernel/rethook_trampoline.S     | 111 +++++
 arch/openrisc/kernel/setup.c                  |   4 +
 arch/openrisc/kernel/tests/Makefile           |   3 +
 arch/openrisc/kernel/tests/test_kprobes.c     |  59 +++
 arch/openrisc/kernel/tests/test_kprobes.h     |  24 +
 arch/openrisc/kernel/tests/test_kprobes_asm.S | 157 +++++++
 arch/openrisc/kernel/traps.c                  |  82 ++--
 arch/openrisc/lib/memcpy.c                    |   2 +
 arch/openrisc/lib/memset.S                    |   4 +
 arch/openrisc/mm/fault.c                      |   5 +
 samples/kprobes/kprobe_example.c              |   8 +
 27 files changed, 1206 insertions(+), 51 deletions(-)
 create mode 100644 arch/openrisc/include/asm/asm.h
 create mode 100644 arch/openrisc/include/asm/break.h
 create mode 100644 arch/openrisc/include/asm/kprobes.h
 create mode 100644 arch/openrisc/kernel/insn.c
 create mode 100644 arch/openrisc/kernel/kprobes.c
 create mode 100644 arch/openrisc/kernel/rethook.c
 create mode 100644 arch/openrisc/kernel/rethook.h
 create mode 100644 arch/openrisc/kernel/rethook_trampoline.S
 create mode 100644 arch/openrisc/kernel/tests/Makefile
 create mode 100644 arch/openrisc/kernel/tests/test_kprobes.c
 create mode 100644 arch/openrisc/kernel/tests/test_kprobes.h
 create mode 100644 arch/openrisc/kernel/tests/test_kprobes_asm.S

-- 
2.55.0

