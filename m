Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045617;
	b=Yf+0r8eR0WtOe3l9c9BTj29oqUAzNjTmoK/43CwfMLMng8fBY6bCgvbUq4/tbMUeZjiD
	 mRkvLlYBo2ns0LXaM5arBjhaS3zRQncEwbmYNBZXesD/3RDNMO2Cysm+rR55cNEX1QjUb
	 dDgjmNdXp6UBp86gk1x9wnZBAuvGuQMlG1sPod+e+fyHBB6EVPgaMo5PBa4h+Pi/DQqVB
	 +JVLrWkFLxU7VTylhDXnpio+2lo1frhPoS6K6eWdnOn4uW1LJh7N+uo2ddD8eGL0nnBOP
	 GhmBG1JrPPy0mvOq9UyBSaAL1YGeclE9+Uw+TXKbkgALUK/j4iK6PO5oJZr/fdSvGug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=29PYuZcMuk+6BqVhsEf3/8y855sPSJj2J3ONQETVxCk=;
	b=fp7KBb2tjb0sxHFnZPGO6O1pTAa1mtf3PlDltJH3vmEYZLswaWiqkiRQo5iaTticcg5/
	 rbYRB0OEt6KYz2SmM8VQuMSzWchS0A4r/4ostbknbPy6hpeezkcauWrs5faJdUSsRptEw
	 xtZE8L7Fj/yujRjLq9qovjVSluFfg6H+TkBwW+G3Ld0BpyG4Z7FE1980E07Do3b5MrpHm
	 Zsd96DqJpl2k8h9J+zYX8w2MCYY3qzRDNJpea3AbeA8XmMnV7As8uXxcuexAZ1j6KSN6r
	 qHVeH1oimcUIqVXDvvyvx1l4QLhIbLXwD7qYr0Twid7ib+RHvhErrEv5i+JNTE7njPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lgqiTZBv;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7376606A31F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 20:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7376606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lgqiTZBv
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so5921056c88.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 13:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793045616; x=1793650416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=29PYuZcMuk+6BqVhsEf3/8y855sPSJj2J3ONQETVxCk=;
        b=lgqiTZBvuwBsm/QD6Q04dpuwb3hT5D0KF0Iidza14BSZtsryM3FuxPGAxoRcl1+aHU
         Wum0veb4k29fmNZUzA6I5nsDRMm8/ROiICgggJyWWxqY8841k3ihr20RjfaXuPNcjyK3
         +pvcvDJcn6hdr93DZn6xuLytaLaJ1JpcjEIdCHOgVqhv3tOKwmxl0d2zhxgX7aXhP/9s
         9DP8cQO6iot5Sfrln4aAaFfi/qTJFVGtDlokuQxrSr/TzgMEOo+yqiGUlU5c4xWdpSr+
         ZdSX/HFPTLJD+C0FjK6rfj+Gib3kmVSlDvHdlQ/zrLNSeHC4L9bCWAfn5ltoKwImxREK
         7O9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793045616; x=1793650416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=29PYuZcMuk+6BqVhsEf3/8y855sPSJj2J3ONQETVxCk=;
        b=0BVgruNPuopsM38Vd3xNxCXy31BGODLTI9cz/9HJNCC6Pp+D3TED1r6uxa29upuJCZ
         uJCw9S5ebm+Auqw33osEGzIFD2VjB+G1cgIpFgBtD0qapuK/HHwLa4TwOimPCOfufzPI
         wlTB3vrVq1YBcS5pU6PZcCxeBS0OLAHFGSN4Ut1ILL7oD0dqz/Xxq7musv3CPJBHJ5eN
         +cF2w+cp0VQoVrGIUIKhPQgY6ZLvf9/TApn+DvwZE6FSy31NKyxAdJeE5i0p7BCbgzl0
         oU7OAKnrm1/r2laK8fbQzh26gOC9T1+s3ccwed2JudHG8QViQGkqtzJ2zbweJyvPubKi
         pbLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIZngdOrg2M4Ck5guiX54KHExEjhyHmviQpbJ4iNbJdq2IAmQ72dUdYDZU8HodHHu70/aHXa5BN/UqcvorCj3EKQQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6tJJXcCZKL5YaEM4TP0NWH9TXNrT6F6JyrVIS3LFzxO2gfGCL
	TVdlcT8/0ZyefqQwMcRcxF2OPvE/uAVQSDjA57lUQ3vrsEBYoY5hBFAa
X-Gm-Gg: AYBFou0y+FT0MtSerpgLxFW1jdNgX8yPU9jU48fnzhKq9WOqOI9ka2kvM1McXBXTcy9
	fpephi2KxkvybpeAKkiVAZOgFrDoJYd0LISZpEZPZLQeFIS6yuM1V+qM9ZSGtbpMmff0U1I7Ks1
	v++FwuP3EJz1orLdK87cFms6TEhIowTI16Tqw7teRz2wZwt0T4tzQEXpUkUNNZO4G/UGWmXLeHO
	g5JCQV2F/a5tMstBbusA4zcdYC9T0mTIRPKBSZjyrPyAgPJard9NqA9LmMh6QL+f8GuhRxK5tJm
	SzvbSsoS8/UqX/WuhXst4/ZWjeGOq/qvoxuh2+pPTTFfm3bKtkzpcChHKofHcxI407vr58rbQS6
	JOaO4TKwuy6YDdZP4ZG6Yg88+kiH6Rf1HqwEIEIYUfSE56RAqY0KwUix0kq1M44YHwvPEIykyLH
	3W+z+fIcc+xIowvzHivoER+LJcEJmA5wy/7zz6VUglVLTxfgZGvTfyUOwgL71WtNFfipZ4DDc/n
	VnPG22oE6C8d5dOo0uSFMfzEHa7IvLBt9itsfkWBtWMYIuIgKI3E6rqfH4PC5MJEu08rjtCrmHG
	YAfknS0W9p7efvPs3Tesvtwuo2VPY3FrVCfK
X-Received: by 2002:a05:7023:885:b0:136:b50c:c0e9 with SMTP id a92af1059eb24-19934a96fffmr13762865c88.21.1793045615364;
        Mon, 26 Oct 2026 13:13:35 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c44:61b8:f26f:bd5b:b550:7a07])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a020df20sm31730486c88.6.2026.10.26.13.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 13:13:34 -0700 (PDT)
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
Subject: [PATCH v3 3/4] openrisc: Add unit tests for KProbes on branch instructions
Date: Tue, 27 Oct 2026 01:42:39 +0530
Message-ID: <20261026201240.107462-4-sahilcdq0@gmail.com>
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

Tests already exist lib/tests to verify the generic functionality of
KProbes. Add unit tests to verify that KProbes work on instructions
that require simulation in the OpenRISC ISA, and that the corresponding
delay slots are handled correctly.

Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
---
Changes v2 -> v3:
- arch/openrisc/kernel/tests/test_kprobes_asm.S:
  - (test_kprobes_*): Set value in r11 register to 0 prior to running tests
  - (test_kprobes_adrp):
    Place function at page-aligned address
    Use PAGE_SIZE macro instead of magic number
    Move value in r13 to r11 before exiting

Changes v1 -> v2: New commit

 arch/openrisc/Kconfig.debug                   |  30 +++-
 arch/openrisc/kernel/Makefile                 |   1 +
 arch/openrisc/kernel/tests/Makefile           |   3 +
 arch/openrisc/kernel/tests/test_kprobes.c     |  59 +++++++
 arch/openrisc/kernel/tests/test_kprobes.h     |  24 +++
 arch/openrisc/kernel/tests/test_kprobes_asm.S | 157 ++++++++++++++++++
 6 files changed, 273 insertions(+), 1 deletion(-)
 create mode 100644 arch/openrisc/kernel/tests/Makefile
 create mode 100644 arch/openrisc/kernel/tests/test_kprobes.c
 create mode 100644 arch/openrisc/kernel/tests/test_kprobes.h
 create mode 100644 arch/openrisc/kernel/tests/test_kprobes_asm.S

diff --git a/arch/openrisc/Kconfig.debug b/arch/openrisc/Kconfig.debug
index 295942fe3fd5..54110f3a111f 100644
--- a/arch/openrisc/Kconfig.debug
+++ b/arch/openrisc/Kconfig.debug
@@ -1,2 +1,30 @@
 # SPDX-License-Identifier: GPL-2.0-only
-# dummy file, do not delete
+menu "openrisc Testing"
+
+menuconfig RUNTIME_KERNEL_TESTING_MENU
+    bool "openrisc kernel runtime testing"
+    default y
+    help
+      Enable openrisc kernel runtime testing. With this option, one can
+      build and run tests to verify the correctness of relevant components
+      in the kernel at runtime.
+
+if RUNTIME_KERNEL_TESTING_MENU
+
+config OR_KPROBES_KUNIT
+    tristate "KUnit test for kprobes on openrisc"
+    depends on KUNIT
+    depends on KPROBES
+    default KUNIT_ALL_TESTS
+    help
+      Enable testing of KProbes in OpenRISC for instructions that
+      require simulation. When further changes related to probes or
+      tracing are added to OpenRISC's port, these tests can help
+      verify that instruction simulation and processing of delay slots
+      continue to work as expected.
+
+      If unsure, say N
+
+endif # RUNTIME_KERNEL_TESTING_MENU
+
+endmenu # "openrisc Testing"
diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
index 2ac824867963..0c1cade09e0c 100644
--- a/arch/openrisc/kernel/Makefile
+++ b/arch/openrisc/kernel/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_OF)		+= prom.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_OR_KPROBES_KUNIT)	+= tests/
 obj-y	+= patching.o
 
 clean:
diff --git a/arch/openrisc/kernel/tests/Makefile b/arch/openrisc/kernel/tests/Makefile
new file mode 100644
index 000000000000..9e9693fd3550
--- /dev/null
+++ b/arch/openrisc/kernel/tests/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_OR_KPROBES_KUNIT)	+= openrisc_test_kprobes.o
+
+openrisc_test_kprobes-objs := test_kprobes.o test_kprobes_asm.o
diff --git a/arch/openrisc/kernel/tests/test_kprobes.c b/arch/openrisc/kernel/tests/test_kprobes.c
new file mode 100644
index 000000000000..a41bdec662e1
--- /dev/null
+++ b/arch/openrisc/kernel/tests/test_kprobes.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * KProbe unit tests for OpenRISC
+ *
+ * Unit tests borrowed liberally from similar work of RISC-V. All
+ * original copyrights apply as per the original source declaration.
+ */
+
+// #include <linux/kernel.h>
+#include <linux/kprobes.h>
+#include <kunit/test.h>
+#include "test_kprobes.h"
+
+static void test_kprobe_openrisc(struct kunit *test)
+{
+	unsigned int num_kprobe = 0;
+	unsigned long (*func)(void);
+	struct kprobe *kp;
+	int i;
+
+	while (test_kprobes_addresses[num_kprobe])
+		num_kprobe++;
+
+	kp = kcalloc(num_kprobe, sizeof(struct kprobe), GFP_KERNEL);
+	KUNIT_EXPECT_TRUE(test, kp);
+	if (!kp)
+		return;
+
+	for (i = 0; i < num_kprobe; ++i) {
+		kp[i].addr = test_kprobes_addresses[i];
+		KUNIT_EXPECT_EQ(test, 0, register_kprobe(&kp[i]));
+	}
+
+	for (i = 0;; ++i) {
+		func = test_kprobes_functions[i];
+		if (!func)
+			break;
+		KUNIT_EXPECT_EQ_MSG(test, KPROBE_TEST_MAGIC, func(), "function %d broken", i);
+	}
+
+	for (i = 0; i < num_kprobe; ++i)
+		unregister_kprobe(&kp[i]);
+	kfree(kp);
+}
+
+static struct kunit_case kprobes_testcases[] = {
+	KUNIT_CASE(test_kprobe_openrisc),
+	{}
+};
+
+static struct kunit_suite kprobes_test_suite = {
+	.name = "kprobes_openrisc",
+	.test_cases = kprobes_testcases,
+};
+
+kunit_test_suites(&kprobes_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit test for OpenRISC KProbes");
diff --git a/arch/openrisc/kernel/tests/test_kprobes.h b/arch/openrisc/kernel/tests/test_kprobes.h
new file mode 100644
index 000000000000..26c26920d430
--- /dev/null
+++ b/arch/openrisc/kernel/tests/test_kprobes.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Unit tests borrowed liberally from similar work of RISC-V. All
+ * original copyrights apply as per the original source declaration.
+ */
+
+#ifndef TEST_KPROBES_H
+#define TEST_KPROBES_H
+
+#define KPROBE_TEST_MAGIC          0xDEADC0DE
+#define KPROBE_TEST_MAGIC_LOWER    0x0000C0DE
+#define KPROBE_TEST_MAGIC_UPPER    0x0000DEAD
+
+#ifndef __ASSEMBLER__
+
+/* array of addresses to install kprobes */
+extern void *test_kprobes_addresses[];
+
+/* array of functions that return KPROBE_TEST_MAGIC */
+extern unsigned long (*test_kprobes_functions[])(void);
+
+#endif /* __ASSEMBLER__ */
+
+#endif /* TEST_KPROBES_H */
diff --git a/arch/openrisc/kernel/tests/test_kprobes_asm.S b/arch/openrisc/kernel/tests/test_kprobes_asm.S
new file mode 100644
index 000000000000..bc87a5fb00d5
--- /dev/null
+++ b/arch/openrisc/kernel/tests/test_kprobes_asm.S
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * KProbes unit tests for OpenRISC
+ *
+ * Unit tests borrowed liberally from similar work of RISC-V. All
+ * original copyrights apply as per the original source declaration.
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+#include <asm/page.h>
+
+#include "test_kprobes.h"
+
+SYM_FUNC_START(test_kprobes_j)
+test_kprobes_j_addr1:
+	l.addi	r11,r0,0
+	l.j	2f
+	l.nop
+1:	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
+	l.addi	r11,r13,0
+	l.jr	r9
+	l.nop
+2:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
+test_kprobes_j_addr2:
+	l.j	1b
+	l.nop
+SYM_FUNC_END(test_kprobes_j)
+
+SYM_FUNC_START(test_kprobes_jal)
+	l.addi	r11,r0,0
+	l.addi	r15,r9,0
+test_kprobes_jal_addr1:
+	l.jal	2f
+	l.nop
+1:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
+	l.jr	r9
+	l.nop
+test_kprobes_jal_addr2:
+2:	l.jal	1b
+	l.nop
+	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
+	l.addi	r11,r13,0
+	l.addi	r9,r15,0
+	l.jr	r9
+	l.nop
+SYM_FUNC_END(test_kprobes_jal)
+
+SYM_FUNC_START(test_kprobes_jr)
+	l.addi	r11,r0,0
+	l.movhi	r15,hi(2f)
+	l.ori	r15,r15,lo(2f)
+test_kprobes_jr_addr1:
+	l.jr	r15
+	l.nop
+1:	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
+	l.addi	r11,r13,0
+	l.jr	r9
+	l.nop
+2:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
+	l.movhi	r15,hi(1b)
+	l.ori	r15,r15,lo(1b)
+test_kprobes_jr_addr2:
+	l.jr	r15
+	l.nop
+SYM_FUNC_END(test_kprobes_jr)
+
+SYM_FUNC_START(test_kprobes_jalr)
+	l.addi	r11,r0,0
+	l.addi	r15,r9,0
+	l.movhi	r17,hi(2f)
+	l.ori	r17,r17,lo(2f)
+test_kprobes_jalr_addr1:
+	l.jalr	r17
+	l.nop
+1:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
+	l.jr	r9
+	l.nop
+2:	l.movhi	r17,hi(1b)
+	l.ori	r17,r17,lo(1b)
+test_kprobes_jalr_addr2:
+	l.jalr	r17
+	l.nop
+	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
+	l.addi	r11,r13,0
+	l.addi	r9,r15,0
+	l.jr	r9
+	l.nop
+SYM_FUNC_END(test_kprobes_jalr)
+
+SYM_FUNC_START(test_kprobes_branch)
+	l.addi	r11,r0,0
+	l.addi	r15,r0,1
+	l.addi	r17,r0,0
+	l.sfgts	r15,r17
+test_kprobes_branch_addr1:
+	l.bf	2f
+	l.nop
+1:	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
+	l.addi	r11,r13,0
+	l.jr	r9
+	l.nop
+2:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
+	l.sfeq	r15,r17
+test_kprobes_branch_addr2:
+	l.bnf	1b
+	l.nop
+SYM_FUNC_END(test_kprobes_branch)
+
+	.align	PAGE_SIZE
+SYM_FUNC_START(test_kprobes_adrp)
+	l.addi	r11,r0,0
+	l.addi	r13,r0,0
+	l.addi	r15,r9,0
+	l.addi	r17,r0,-PAGE_SIZE
+	l.jal	1f
+	l.nop
+1:	l.and	r19,r9,r17
+test_kprobes_adrp_addr:
+	l.adrp	r21,0
+	l.sfeq	r21,r19
+	l.bnf	2f
+	l.nop
+	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
+	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
+	l.addi	r11,r13,0
+2:	l.addi	r9,r15,0
+	l.jr	r9
+	l.nop
+SYM_FUNC_END(test_kprobes_adrp)
+
+    .section .rodata
+SYM_DATA_START(test_kprobes_addresses)
+	.word test_kprobes_j_addr1
+	.word test_kprobes_j_addr2
+	.word test_kprobes_jal_addr1
+	.word test_kprobes_jal_addr2
+	.word test_kprobes_jr_addr1
+	.word test_kprobes_jr_addr2
+	.word test_kprobes_jalr_addr1
+	.word test_kprobes_jalr_addr2
+	.word test_kprobes_branch_addr1
+	.word test_kprobes_branch_addr2
+	.word test_kprobes_adrp_addr
+	.word 0
+SYM_DATA_END(test_kprobes_addresses)
+
+    .section .rodata
+SYM_DATA_START(test_kprobes_functions)
+	.word test_kprobes_j
+	.word test_kprobes_jal
+	.word test_kprobes_jr
+	.word test_kprobes_jalr
+	.word test_kprobes_branch
+	.word test_kprobes_adrp
+	.word 0
+SYM_DATA_END(test_kprobes_functions)
-- 
2.55.0

