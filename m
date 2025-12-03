Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB435BDC3
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779015; cv=none; b=B5/7HIRBwWX6d6UnahQprzd5xCPiPlj2HkxbVIEbxFdjVsF8lWVcdkETZsI6uVve1+q3Z4pDPUhKiS2/V/zxzpV05VwK7aZYaeUxftoej0csTjVO9LLMLTT01UlVc0o+9N/9Vqqf7mGKTOft0qwMo2cbyJcMm3PUfZSXIBTC1mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779015; c=relaxed/simple;
	bh=pFGWtKByXQ3u7eMAhDSlWJy1f35qFFoQOyuWawl0PUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fEei1B6Chb11A2QIwtzqJpCLk1k6mcTxivl3RcGDAufBuoQGTLNlfU7P/x5Ck5EnTJJ3TRdTdMspgcnQCvZSR8tJpyKt49FU5u1OhAkyvU0J4MSSuYuxyKYneSXEnH/I+dUqtwZjSegod4ODT02d1N1OehKITK6BlEFjBtsycpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dktGQeVm; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dktGQeVm"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6443b62daf6so416174d50.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 08:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779011; x=1765383811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mNK//JpS9hirQN90oXpJD1gUxWiQ6E+9iQMheM4lBcw=;
        b=dktGQeVmOgyEON9ioVWral7IIoQdr9grSWAzFBOqImj2AzC5tTsfrL0D5sMd2gyDFu
         yT2plDQmBD600lwrVnhuDuTcbWJ3T/LdeeScV82CaXXNVAHzbBH5ivjOqbxYBO2OJ/11
         cE8/b171WDPHSmjPXBeGSQH4yBeInPJF/edbq2GxB9ot+uBOG3YEGsuGuxB/FYzc/PmE
         TVA6YLAEWKTbFZapBZjO+gXR+wTzvbyxCXFWIWi1nAfQyB9j9K1Vb2MjdURpdcM36TC0
         XpOyPTzUPkHI3CNMnmVKim1Zi14sSAtOapZFD8+/r17SOl8ai1ykPNzH/0CORnMLAB4t
         7wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779011; x=1765383811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNK//JpS9hirQN90oXpJD1gUxWiQ6E+9iQMheM4lBcw=;
        b=IqDZZ5lCzEVLO3O5ATMIwajFVVZ7mvRe4zEnz5Bg4gcTMnLC1UomY2aRBkqRGKFcS3
         UEwvXMR2r0vrLISLcr4XQ+d0UN5yKgJDsvYeS7O6tOH+Yk1qxsC0xyiX9tYJOcBOknRp
         Fb9xGIOtm8vxs0lZ3gTpm8Mc5tS13s39EteP7Xq3SkOgCG9eI5191VNgSETPeQPU9Im3
         enXmC+JNW0t/LnyJHliNMEW+c23MUyqBwBZD2DzgOXR/LM4RjguCxvbvIFCwunf6GnX3
         1FHOQlQExqBTAPWwdAzUnkgcTxNMz6oHvSBypbgcLjmCdxpur7/dCwHGZqvaB1RWTXhh
         GHhw==
X-Forwarded-Encrypted: i=1; AJvYcCWMsUVnJBhr+IkPLDdiDO8GNfT//KLyG8C7KlDVLR09x27UfasENpjkJMQIlcAdtf//bBfRL3G09AxJIROPcroP95Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDAAuEH/FmxYu7Pj0QTihkuJVoBHQA0qQTEc+QzQzBZVDQU9ET
	01+TGdGKal4PMMFb//g9W5PoxG1tz3c0RecblXIJI/nzfXuSCNSItDoi
X-Gm-Gg: ASbGncvE7tbUdtahhfeKlBv8Mil5NuDMI19948lLPoJ64Mjlb48KLNmMHQb9H+16NqJ
	ZIBd9olW5sZz3kQ2YM3xOQjuFt3dfU/mzaORlgJtHqU8uwirY/bbzeht6dffUFn3QguSD0ippno
	uw0NML3BJADjosk2ZwIj+oo3mdc2aTe7KX/Y8BDVKs1V7AMhUr84yHlyO3keO7fp6N+tf53BB6n
	hbhCo0LQaiEUqRG6XK8f4//5ZClT7YFcRz8+rB/cqqbiv8D9PzJ36IZVG3Yv3mWqiHA4QK1ia7i
	R/V0dWD+rFYZTOn4xRb9LpH3nuiunlPbI1LViGu5rmOmPQOJjqXaYM7hqbejHyuoX4brqr+tUyg
	VWkbAq5P2I5GLzPbuHFFSB1bqbazgSeb9ZTVkt3ekaOz0Yu43PYqIkXX1ptZLzRj3+gf1sZR8ms
	3dghKJ4eI=
X-Google-Smtp-Source: AGHT+IFbqbKS7r+NlCXK/8J98hJM3a/US0gzPftZwuaa3JUY2EfeVswum0kC2L5AoZFpIWqi7rzeVg==
X-Received: by 2002:a05:690e:e8d:b0:63f:af64:ae5a with SMTP id 956f58d0204a3-6443704b94amr2258748d50.58.1764779011007;
        Wed, 03 Dec 2025 08:23:31 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:3422:8bf9:97bc:b085])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d3f600sm75866767b3.9.2025.12.03.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:23:30 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH v2 0/4] Unload linux/kernel.h
Date: Wed,  3 Dec 2025 11:23:21 -0500
Message-ID: <20251203162329.280182-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel.h hosts declarations that can be placed better.

Testing (0-Day):
alpha                               defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251202    gcc-8.5.0
arc                   randconfig-002-20251202    gcc-12.5.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251202    clang-17
arm                   randconfig-002-20251202    clang-22
arm                   randconfig-003-20251202    clang-22
arm                   randconfig-004-20251202    gcc-14.3.0
arm                       spear13xx_defconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251202    clang-22
arm64                 randconfig-002-20251202    clang-22
arm64                 randconfig-003-20251202    clang-16
arm64                 randconfig-004-20251202    clang-22
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251202    gcc-13.4.0
csky                  randconfig-002-20251202    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251202    clang-22
hexagon               randconfig-002-20251202    clang-22
i386                             allmodconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251202    clang-20
i386        buildonly-randconfig-002-20251202    gcc-14
i386        buildonly-randconfig-003-20251202    clang-20
i386        buildonly-randconfig-004-20251202    clang-20
i386        buildonly-randconfig-005-20251202    clang-20
i386        buildonly-randconfig-006-20251202    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251202    clang-20
i386                  randconfig-002-20251202    gcc-14
i386                  randconfig-003-20251202    gcc-14
i386                  randconfig-004-20251202    clang-20
i386                  randconfig-005-20251202    gcc-14
i386                  randconfig-006-20251202    clang-20
i386                  randconfig-007-20251202    clang-20
i386                  randconfig-011-20251202    clang-20
i386                  randconfig-012-20251202    clang-20
i386                  randconfig-013-20251202    gcc-14
i386                  randconfig-014-20251202    gcc-14
i386                  randconfig-015-20251202    gcc-14
i386                  randconfig-016-20251202    clang-20
i386                  randconfig-017-20251202    clang-20
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251202    gcc-15.1.0
loongarch             randconfig-002-20251202    clang-22
m68k                                defconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251202    gcc-8.5.0
nios2                 randconfig-002-20251202    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20251202    gcc-9.5.0
parisc                randconfig-002-20251202    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251202    clang-22
powerpc               randconfig-002-20251202    gcc-10.5.0
powerpc64             randconfig-001-20251202    clang-22
powerpc64             randconfig-002-20251202    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                    nommu_k210_defconfig    clang-22
riscv                 randconfig-001-20251202    gcc-9.5.0
riscv                 randconfig-002-20251202    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251202    clang-17
s390                  randconfig-002-20251202    gcc-13.4.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251202    gcc-15.1.0
sh                    randconfig-002-20251202    gcc-12.5.0
sh                          rsk7269_defconfig    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251202    gcc-8.5.0
sparc                 randconfig-002-20251202    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251202    gcc-8.5.0
sparc64               randconfig-002-20251202    gcc-10.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251202    clang-17
um                    randconfig-002-20251202    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251202    gcc-14
x86_64      buildonly-randconfig-002-20251202    gcc-14
x86_64      buildonly-randconfig-003-20251202    clang-20
x86_64      buildonly-randconfig-004-20251202    gcc-13
x86_64      buildonly-randconfig-005-20251202    gcc-14
x86_64      buildonly-randconfig-006-20251202    gcc-13
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251202    clang-20
x86_64                randconfig-012-20251202    gcc-13
x86_64                randconfig-013-20251202    gcc-14
x86_64                randconfig-014-20251202    clang-20
x86_64                randconfig-015-20251202    clang-20
x86_64                randconfig-016-20251202    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251202    gcc-11.5.0
xtensa                randconfig-002-20251202    gcc-11.5.0

v1: https://lore.kernel.org/all/20251129195304.204082-1-yury.norov@gmail.com/
v2: 
 - more historical context for STACK_MAGIC removal (Christophe);
 - place STACK_MAGIC in i915_selftest.h (Jan);
 - new patch #2: moduleparam: include required headers explicitly (Petr);
 - align Documentation/filesystems/sysfs.rst (Andy);
 - more motivation for linux/tracing.h (Andy, Steven);

Yury Norov (NVIDIA) (4):
  kernel.h: drop STACK_MAGIC macro
  moduleparam: include required headers explicitly
  kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
  tracing: move tracing declarations from kernel.h to a dedicated header

 Documentation/filesystems/sysfs.rst           |   2 +-
 MAINTAINERS                                   |   1 +
 .../drm/i915/gt/selftest_ring_submission.c    |   1 +
 drivers/gpu/drm/i915/i915_selftest.h          |   2 +
 include/linux/kernel.h                        | 209 +-----------------
 include/linux/moduleparam.h                   |   7 +-
 include/linux/sysfs.h                         |  13 ++
 include/linux/tracing.h                       | 203 +++++++++++++++++
 8 files changed, 228 insertions(+), 210 deletions(-)
 create mode 100644 include/linux/tracing.h

-- 
2.43.0

