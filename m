Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46152509EF9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800346; cv=none; b=CpnKxFCGdRwa6BiiNZOdXHcgKbT/HGa7dWzT73zst8c9QXfkXFmuWuZIYn7+lAV7cRVvBzEk88m6xxs0A1NDEUuM++xGwQXPEK8MolvlpE45DJstscnDU1XLRURVi3Q+LLZM8R+3KX10chQ41SXDIQxFsrjAhsJQsOUNaUoRkI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800346; c=relaxed/simple;
	bh=ULdlPVVKMBfooiLHYbgJkl0xhVprxp0n0YDaU8aVqZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQ6bvq+lchHbUbSttjpLitCE2I6YN779UtxP1r6gtsFjde+lkothJ3z1eS41TdDlSQImYg9bxF0tiEpQWZ+DHRtgcmBli6jNp3pyQtG2ub1kiykJUylfXQuy80CuKvhS4m2PcxlaWMYPX2nvZqHyOFC/Sz6l6leMDCcE8UeMBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnAFZAlP; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnAFZAlP"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso8901158eec.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790800343; x=1791405143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A7opcYYX2GpMGNUV1W+wGn51W364ttIM/bgNWuY80qA=;
        b=CnAFZAlPaiDuhAJotPcWjCekIhDczfsx8mmyIXEsFtha2BYkdPyGEiY9V5EHeE9kuC
         yBxTdz1eFuL6HNK5qazj33hIpPKYtF0MDzaTtgB4UkvzUE4/TKO0PcyARGbK1GtCFYT5
         Xr56bpL8vyjbEtLOwBSq35sZBFiTp0OGHz4S8gQYMq1t9nRsr9TkICtLOZpChT6VMbX/
         pJCJBvj8zyps9E83vlzlnoVV7nyGC1bi4dCv8XDuHw63R5wxZXsy4eWuzWUDQmCP5VHM
         EQDyhrZRk4zrbHmaEIBReQTWlQTyVjvu0APxIbz7KHot8wxVtIZV/uflIdcC8yElhUTA
         8ePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790800343; x=1791405143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A7opcYYX2GpMGNUV1W+wGn51W364ttIM/bgNWuY80qA=;
        b=mtKXM7aQLjfVrA7zChG5ZPOkOlDUyXhvuQd5MB6Zykh5QCrdMapnIknM9wK+HtrkQd
         e9esHeCo4tf4iWbtKpvDcPrtTLDIDiSb6vMTpe4LGYXsOrpeVY2Wj7WgHLooICzEbU2W
         RYXs8ECUxXYQSe54pvZ1WsfR2axuMtVIRtNapyBMM/Hi4bzThen6pwYNSzwT5iGhbtNj
         S31UpGPS/bJEd2CaFWpAQjTZ0LbL7+3xq2wmW+fiYNzj5CShJB53EtpGMsBdPuW9zro0
         gZ+MB6M3WbV3GcWv7Lx8BQwdi5mhe2VBkqGFWoGH9ziEFByKshgy3HdmVnmk2zZjMupf
         hsSA==
X-Forwarded-Encrypted: i=1; AKwUvBxRfCm5VDfAx6kM7Rm72ohTA8lNRkaQB6lxHcz9HylcUipxdAbs5M9LStvFpCFBDCuwOXvGyqgkJHn+iMB2ETmVbr0=@vger.kernel.org
X-Gm-Message-State: AFuF++k6h6Y1QIxw9p1Wzz7tzQzRUsITowJsrU773mAnut/2UMhODSox
	UkPo7VzQeF2YmuGhhfOiSOC5kV6DIVLuOeV6LTCyWKuaQQP+U93U0hJU
X-Gm-Gg: AYBFou2M3iTdrhnfW4o0yGkiypzvB983luqjset1C7SA+Hrg5JTqN0d7xvP22SUtvct
	11htxdZH6TK9p0CGHIb+DhUp73CZV9/85JAk6FMGZJqH8xLPZG9UJ4O9kdwj8+hvvk9wn+9nYww
	iBEoSrPmTmVsnQv6HdaPH5420+OpuFUrDCe4ZtxqxVGQhjFRlGg8ftpWyIQwQl+Z7ar+6eoGybi
	B5CpyoivsJtMFVXbWKgvabJ8cRO07h8w/dTs8pYMcp0LR2WQpcZ/FnnKqhFVbgB7YYOaU/53t2c
	Ajrc9BN6zdFmustU3DAEyVQCQm/cc2OBp4PKSbF0+NWWSjOf8wwVvkTLIa7jXRCs9PGm0yFupPx
	I6tmpt/YYPrdGBu26lKfF/Oa71PsvObaNoNI1LxoMk0P9WBbERNJ5CIBc+p0n7bhae4E/K9xeh+
	0rBEanfNQF6hdeRtM/kTmHxwYSp2YHLqGjPXfwXNlqJaHT+j4/Onrt7JRtfGC2ISvkuSQ2jWt4v
	5C3KyFZDMK0BWeN
X-Received: by 2002:a05:7301:a0a:b0:328:643d:4f80 with SMTP id 5a478bee46e88-34cdc4cdf88mr2448755eec.20.1790800343219;
        Wed, 30 Sep 2026 13:32:23 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c44:2e39:63b8:ea3c:fa28:7091])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db4d1d560sm1162411eec.29.2026.09.30.13.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:32:22 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	naveen@kernel.org,
	davem@davemloft.net,
	mhiramat@kernel.org
Cc: tytso@mit.edu,
	wangruikang@iscas.ac.cn,
	namcao@linutronix.de,
	pjw@kernel.org,
	kees@kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [PATCH v2 3/4] openrisc: Add unit tests for KProbes on branch instructions
Date: Thu,  1 Oct 2026 02:01:28 +0530
Message-ID: <20260930203129.51048-4-sahilcdq0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260407185650.79816-2-sahilcdq0@gmail.com>
References: <20260407185650.79816-2-sahilcdq0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests already exist lib/tests to verify the generic functionality of
KProbes. Add unit tests to verify that KProbes work on instructions
that require simulation in the OpenRISC ISA, and that the corresponding
delay slots are handled correctly.

Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
---
 arch/openrisc/Kconfig.debug                   |  30 +++-
 arch/openrisc/kernel/Makefile                 |   1 +
 arch/openrisc/kernel/tests/Makefile           |   3 +
 arch/openrisc/kernel/tests/test_kprobes.c     |  59 +++++++
 arch/openrisc/kernel/tests/test_kprobes.h     |  24 +++
 arch/openrisc/kernel/tests/test_kprobes_asm.S | 147 ++++++++++++++++++
 6 files changed, 263 insertions(+), 1 deletion(-)
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
index 000000000000..a9fcf99b55ae
--- /dev/null
+++ b/arch/openrisc/kernel/tests/test_kprobes_asm.S
@@ -0,0 +1,147 @@
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
+#include "test_kprobes.h"
+
+SYM_FUNC_START(test_kprobes_j)
+test_kprobes_j_addr1:
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
+SYM_FUNC_START(test_kprobes_adrp)
+	l.addi	r13,r0,0
+	l.addi	r15,r9,0
+	l.addi	r17,r0,-8192
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

