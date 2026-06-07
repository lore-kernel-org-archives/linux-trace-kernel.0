Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F1308F0A
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Jun 2026 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848901; cv=none; b=POhJ5pCZYPCUJ7JRr1rnLC2iRjZJqsN8SiXcbtJt91kimiEdqatetIeDTvNo44d5ZVWvUo7+pNAvQiwT9oriZx4ug8Gs2O4NPqZ7IssDmakvntNhD1rvWdLw+fs+yG/d78TwqjSDeRww9O1SpQCxGGGJRrqiy04Q7YVJDK9J/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848901; c=relaxed/simple;
	bh=Vg/iR48x/WN9060AFuRErf8v044VdtLiDHgZVNSCrtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8mmwUVVmOKMHWbycleHjMIJ4cFzxqvjCpO6RW2qCjiWoxm4Gn77LSy7zTYBZz639hQGrA3VDYPMA32h3eg+gDJZNq5hU/5t2WUZMX45Zyxw3bT7LrXyA14wT3539Sk2pWHfdiDT4hiu4VkxWdV838V0/ydbCGcgerShATkVzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iBaqPHpa; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iBaqPHpa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780848896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1c2hfIM5TBI8R1lNRBSdVRSneWCvCte2DyNY5bgq4Fs=;
	b=iBaqPHpafuuTc9E0tzdusClXveZTAMWZ+D9EpbVJLQo6tME5772Y3+D1SI9SJrAXX5kfSd
	kxxh3bHswKIocERDs7+1Xhy9+0jK2E/B05SdzA0cm4ES8TpIXdzAmmCN4FD34K/FtdeTT1
	ZlIZk1WY5+q5nXowecfguCpUJPewhK0=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 9/9] selftests/verification: add tlob selftests
Date: Mon,  8 Jun 2026 00:13:57 +0800
Message-Id: <4aeb668c8446a9f6366d92e218df386bef7bc965.1780847473.git.wen.yang@linux.dev>
In-Reply-To: <cover.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Add selftest coverage for the tlob uprobe monitoring interface under
tools/testing/selftests/verification/.

test.d/tlob/ contains both the helper sources (tlob_target, tlob_sym)
and the seven test scripts so the test suite is self-contained.
tlob_target provides busy-spin, sleep, and preempt workloads; tlob_sym
resolves ELF symbol offsets for uprobe registration.

Seven test scripts exercise uprobe binding management, budget violation
detection, and per-state time accounting (running_ns, waiting_ns,
sleeping_ns).

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 .../testing/selftests/verification/.gitignore |   2 +
 tools/testing/selftests/verification/Makefile |  19 +-
 .../verification/test.d/tlob/Makefile         |  20 ++
 .../verification/test.d/tlob/test.d/functions |   1 +
 .../verification/test.d/tlob/tlob_sym.c       | 189 ++++++++++++++++++
 .../verification/test.d/tlob/tlob_target.c    | 138 +++++++++++++
 .../verification/test.d/tlob/uprobe_bind.tc   |  37 ++++
 .../test.d/tlob/uprobe_detail_running.tc      |  51 +++++
 .../test.d/tlob/uprobe_detail_sleeping.tc     |  50 +++++
 .../test.d/tlob/uprobe_detail_waiting.tc      |  66 ++++++
 .../verification/test.d/tlob/uprobe_multi.tc  |  64 ++++++
 .../test.d/tlob/uprobe_no_event.tc            |  19 ++
 .../test.d/tlob/uprobe_violation.tc           |  67 +++++++
 13 files changed, 722 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/Makefile
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/test.d/functions
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/tlob_target.c
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc

diff --git a/tools/testing/selftests/verification/.gitignore b/tools/testing/selftests/verification/.gitignore
index 2659417cb2c7..cbbd03ee16c7 100644
--- a/tools/testing/selftests/verification/.gitignore
+++ b/tools/testing/selftests/verification/.gitignore
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 logs
+test.d/tlob/tlob_sym
+test.d/tlob/tlob_target
diff --git a/tools/testing/selftests/verification/Makefile b/tools/testing/selftests/verification/Makefile
index aa8790c22a71..0b32bdfdb8db 100644
--- a/tools/testing/selftests/verification/Makefile
+++ b/tools/testing/selftests/verification/Makefile
@@ -1,8 +1,25 @@
 # SPDX-License-Identifier: GPL-2.0
-all:
 
 TEST_PROGS := verificationtest-ktap
 TEST_FILES := test.d settings
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
+# Subdirectories that provide binaries used by the test runner.
+# Each entry must contain a Makefile that accepts OUTDIR= and
+# deposits its binaries there.
+BUILD_SUBDIRS := test.d/tlob
+
 include ../lib.mk
+
+all: $(patsubst %,_build_%,$(BUILD_SUBDIRS))
+
+clean: $(patsubst %,_clean_%,$(BUILD_SUBDIRS))
+
+.PHONY: $(patsubst %,_build_%,$(BUILD_SUBDIRS)) \
+        $(patsubst %,_clean_%,$(BUILD_SUBDIRS))
+
+$(patsubst %,_build_%,$(BUILD_SUBDIRS)): _build_%:
+	$(MAKE) -C $* OUTDIR="$(OUTPUT)" TOOLS_INCLUDES="$(TOOLS_INCLUDES)"
+
+$(patsubst %,_clean_%,$(BUILD_SUBDIRS)): _clean_%:
+	$(MAKE) -C $* OUTDIR="$(OUTPUT)" clean
diff --git a/tools/testing/selftests/verification/test.d/tlob/Makefile b/tools/testing/selftests/verification/test.d/tlob/Makefile
new file mode 100644
index 000000000000..29b3519b255f
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+# Builds tlob selftest helper binaries in the directory of this Makefile.
+#
+# Invoked by ../../Makefile via BUILD_SUBDIRS; outputs tlob_sym and
+# tlob_target alongside the .tc scripts so they are self-contained.
+
+CFLAGS += $(TOOLS_INCLUDES)
+
+.PHONY: all
+all: tlob_sym tlob_target
+
+tlob_sym: tlob_sym.c
+	$(CC) $(CFLAGS) -o $@ $<
+
+tlob_target: tlob_target.c
+	$(CC) $(CFLAGS) -o $@ $<
+
+.PHONY: clean
+clean:
+	$(RM) tlob_sym tlob_target
diff --git a/tools/testing/selftests/verification/test.d/tlob/test.d/functions b/tools/testing/selftests/verification/test.d/tlob/test.d/functions
new file mode 100644
index 000000000000..0b4c5e4344d2
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/test.d/functions
@@ -0,0 +1 @@
+. "${TOP_DIR%/*}/functions"
diff --git a/tools/testing/selftests/verification/test.d/tlob/tlob_sym.c b/tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
new file mode 100644
index 000000000000..1b7ba1c6d95b
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tlob_sym.c - ELF symbol-to-file-offset utility for tlob selftests
+ *
+ * Usage: tlob_sym sym_offset <binary> <symbol>
+ *
+ *   Prints the ELF file offset of <symbol> in <binary> to stdout.
+ *
+ * Exit: 0 = found, 1 = error / not found.
+ */
+#include <elf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+static int sym_offset(const char *binary, const char *symname)
+{
+	int fd;
+	struct stat st;
+	void *map;
+	Elf64_Ehdr *ehdr;
+	Elf32_Ehdr *ehdr32;
+	int is64;
+	uint64_t sym_vaddr = 0;
+	int found = 0;
+	uint64_t file_offset = 0;
+
+	fd = open(binary, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "open %s: %s\n", binary, strerror(errno));
+		return 1;
+	}
+	if (fstat(fd, &st) < 0) {
+		close(fd);
+		return 1;
+	}
+	map = mmap(NULL, (size_t)st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (map == MAP_FAILED) {
+		fprintf(stderr, "mmap: %s\n", strerror(errno));
+		return 1;
+	}
+
+	ehdr = (Elf64_Ehdr *)map;
+	ehdr32 = (Elf32_Ehdr *)map;
+	if (st.st_size < 4 ||
+	    ehdr->e_ident[EI_MAG0] != ELFMAG0 ||
+	    ehdr->e_ident[EI_MAG1] != ELFMAG1 ||
+	    ehdr->e_ident[EI_MAG2] != ELFMAG2 ||
+	    ehdr->e_ident[EI_MAG3] != ELFMAG3) {
+		fprintf(stderr, "%s: not an ELF file\n", binary);
+		munmap(map, (size_t)st.st_size);
+		return 1;
+	}
+	is64 = (ehdr->e_ident[EI_CLASS] == ELFCLASS64);
+
+	if (is64) {
+		Elf64_Shdr *shdrs = (Elf64_Shdr *)((char *)map + ehdr->e_shoff);
+		Elf64_Shdr *shstrtab_hdr = &shdrs[ehdr->e_shstrndx];
+		const char *shstrtab = (char *)map + shstrtab_hdr->sh_offset;
+		int si;
+
+		for (int pass = 0; pass < 2 && !found; pass++) {
+			const char *target = pass ? ".dynsym" : ".symtab";
+
+			for (si = 0; si < ehdr->e_shnum && !found; si++) {
+				Elf64_Shdr *sh = &shdrs[si];
+				const char *name = shstrtab + sh->sh_name;
+
+				if (strcmp(name, target) != 0)
+					continue;
+
+				Elf64_Shdr *strtab_sh = &shdrs[sh->sh_link];
+				const char *strtab = (char *)map + strtab_sh->sh_offset;
+				Elf64_Sym *syms = (Elf64_Sym *)((char *)map + sh->sh_offset);
+				uint64_t nsyms = sh->sh_size / sizeof(Elf64_Sym);
+				uint64_t j;
+
+				for (j = 0; j < nsyms; j++) {
+					if (strcmp(strtab + syms[j].st_name, symname) == 0) {
+						sym_vaddr = syms[j].st_value;
+						found = 1;
+						break;
+					}
+				}
+			}
+		}
+
+		if (!found) {
+			fprintf(stderr, "symbol '%s' not found in %s\n", symname, binary);
+			munmap(map, (size_t)st.st_size);
+			return 1;
+		}
+
+		Elf64_Phdr *phdrs = (Elf64_Phdr *)((char *)map + ehdr->e_phoff);
+		int pi;
+
+		for (pi = 0; pi < ehdr->e_phnum; pi++) {
+			Elf64_Phdr *ph = &phdrs[pi];
+
+			if (ph->p_type != PT_LOAD)
+				continue;
+			if (sym_vaddr >= ph->p_vaddr &&
+			    sym_vaddr < ph->p_vaddr + ph->p_filesz) {
+				file_offset = sym_vaddr - ph->p_vaddr + ph->p_offset;
+				break;
+			}
+		}
+	} else {
+		Elf32_Shdr *shdrs = (Elf32_Shdr *)((char *)map + ehdr32->e_shoff);
+		Elf32_Shdr *shstrtab_hdr = &shdrs[ehdr32->e_shstrndx];
+		const char *shstrtab = (char *)map + shstrtab_hdr->sh_offset;
+		int si;
+		uint32_t sym_vaddr32 = 0;
+
+		for (int pass = 0; pass < 2 && !found; pass++) {
+			const char *target = pass ? ".dynsym" : ".symtab";
+
+			for (si = 0; si < ehdr32->e_shnum && !found; si++) {
+				Elf32_Shdr *sh = &shdrs[si];
+				const char *name = shstrtab + sh->sh_name;
+
+				if (strcmp(name, target) != 0)
+					continue;
+
+				Elf32_Shdr *strtab_sh = &shdrs[sh->sh_link];
+				const char *strtab = (char *)map + strtab_sh->sh_offset;
+				Elf32_Sym *syms = (Elf32_Sym *)((char *)map + sh->sh_offset);
+				uint32_t nsyms = sh->sh_size / sizeof(Elf32_Sym);
+				uint32_t j;
+
+				for (j = 0; j < nsyms; j++) {
+					if (strcmp(strtab + syms[j].st_name, symname) == 0) {
+						sym_vaddr32 = syms[j].st_value;
+						found = 1;
+						break;
+					}
+				}
+			}
+		}
+
+		if (!found) {
+			fprintf(stderr, "symbol '%s' not found in %s\n", symname, binary);
+			munmap(map, (size_t)st.st_size);
+			return 1;
+		}
+
+		Elf32_Phdr *phdrs = (Elf32_Phdr *)((char *)map + ehdr32->e_phoff);
+		int pi;
+
+		for (pi = 0; pi < ehdr32->e_phnum; pi++) {
+			Elf32_Phdr *ph = &phdrs[pi];
+
+			if (ph->p_type != PT_LOAD)
+				continue;
+			if (sym_vaddr32 >= ph->p_vaddr &&
+			    sym_vaddr32 < ph->p_vaddr + ph->p_filesz) {
+				file_offset = sym_vaddr32 - ph->p_vaddr + ph->p_offset;
+				break;
+			}
+		}
+		sym_vaddr = sym_vaddr32;
+	}
+
+	munmap(map, (size_t)st.st_size);
+
+	if (!file_offset && sym_vaddr) {
+		fprintf(stderr, "could not map vaddr 0x%lx to file offset\n",
+			(unsigned long)sym_vaddr);
+		return 1;
+	}
+
+	printf("0x%lx\n", (unsigned long)file_offset);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc != 4 || strcmp(argv[1], "sym_offset") != 0) {
+		fprintf(stderr, "Usage: %s sym_offset <binary> <symbol>\n", argv[0]);
+		return 1;
+	}
+	return sym_offset(argv[2], argv[3]);
+}
diff --git a/tools/testing/selftests/verification/test.d/tlob/tlob_target.c b/tools/testing/selftests/verification/test.d/tlob/tlob_target.c
new file mode 100644
index 000000000000..0fdbc575d71d
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/tlob_target.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tlob_target.c - uprobe target binary for tlob selftests.
+ *
+ * Provides three start/stop probe pairs, each designed to exercise a
+ * different dominant component of the detail_env_tlob ns breakdown:
+ *
+ *   tlob_busy_work    / tlob_busy_work_done    - busy-spin: running_ns dominates
+ *   tlob_sleep_work   / tlob_sleep_work_done   - nanosleep: sleeping_ns dominates
+ *   tlob_preempt_work / tlob_preempt_work_done - busy-spin: waiting_ns dominates
+ *                                                (needs an RT competitor on the same CPU)
+ *
+ * Usage: tlob_target <duration_ms> [mode]
+ *
+ * mode is one of: busy (default), sleep, preempt.
+ * Loops in 200 ms iterations until <duration_ms> has elapsed
+ * (0 = run for ~24 hours).
+ */
+#define _GNU_SOURCE
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+
+#ifndef noinline
+#define noinline __attribute__((noinline))
+#endif
+
+static inline int timespec_before(const struct timespec *a,
+				   const struct timespec *b)
+{
+	return a->tv_sec < b->tv_sec ||
+	       (a->tv_sec == b->tv_sec && a->tv_nsec < b->tv_nsec);
+}
+
+static void timespec_add_ms(struct timespec *ts, unsigned long ms)
+{
+	ts->tv_sec  += ms / 1000;
+	ts->tv_nsec += (long)(ms % 1000) * 1000000L;
+	if (ts->tv_nsec >= 1000000000L) {
+		ts->tv_sec++;
+		ts->tv_nsec -= 1000000000L;
+	}
+}
+
+/* stop probe; noinline keeps the entry point visible to uprobes */
+noinline void tlob_busy_work_done(void)
+{
+	/* empty: uprobe fires on entry */
+}
+
+/* start probe; busy-spin so running_ns dominates */
+noinline void tlob_busy_work(unsigned long duration_ns)
+{
+	struct timespec start, now;
+	unsigned long elapsed;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	do {
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		elapsed = (unsigned long)(now.tv_sec - start.tv_sec)
+			  * 1000000000UL
+			+ (unsigned long)(now.tv_nsec - start.tv_nsec);
+	} while (elapsed < duration_ns);
+
+	tlob_busy_work_done();
+}
+
+/* stop probe; noinline keeps the entry point visible to uprobes */
+noinline void tlob_sleep_work_done(void)
+{
+	/* empty: uprobe fires on entry */
+}
+
+/* start probe; nanosleep so sleeping_ns dominates */
+noinline void tlob_sleep_work(unsigned long duration_ms)
+{
+	struct timespec ts = {
+		.tv_sec  = duration_ms / 1000,
+		.tv_nsec = (long)(duration_ms % 1000) * 1000000L,
+	};
+	nanosleep(&ts, NULL);
+	tlob_sleep_work_done();
+}
+
+/* stop probe; noinline keeps the entry point visible to uprobes */
+noinline void tlob_preempt_work_done(void)
+{
+	/* empty: uprobe fires on entry */
+}
+
+/*
+ * start probe; busy-spin so an RT competitor on the same CPU drives
+ * waiting_ns (prev_state==0 -> preempt event, task stays runnable off-CPU).
+ */
+noinline void tlob_preempt_work(unsigned long duration_ms)
+{
+	struct timespec start, now;
+	unsigned long elapsed;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	do {
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		elapsed = (unsigned long)(now.tv_sec - start.tv_sec)
+			  * 1000000000UL
+			+ (unsigned long)(now.tv_nsec - start.tv_nsec);
+	} while (elapsed < duration_ms * 1000000UL);
+
+	tlob_preempt_work_done();
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned long duration_ms = 0;
+	const char *mode = "busy";
+	struct timespec deadline, now;
+
+	if (argc >= 2)
+		duration_ms = strtoul(argv[1], NULL, 10);
+	if (argc >= 3)
+		mode = argv[2];
+
+	clock_gettime(CLOCK_MONOTONIC, &deadline);
+	timespec_add_ms(&deadline, duration_ms ? duration_ms : 86400000UL);
+
+	do {
+		if (strcmp(mode, "sleep") == 0)
+			tlob_sleep_work(200);
+		else if (strcmp(mode, "preempt") == 0)
+			tlob_preempt_work(200);
+		else
+			tlob_busy_work(200 * 1000000UL);
+		clock_gettime(CLOCK_MONOTONIC, &now);
+	} while (timespec_before(&now, &deadline));
+
+	return 0;
+}
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
new file mode 100644
index 000000000000..1ac3db6ca7bb
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
@@ -0,0 +1,37 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor uprobe binding (visible in monitor file, removable, duplicate rejected)
+# requires: tlob:monitor
+
+RV_BINDIR="${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
+UPROBE_TARGET="${RV_BINDIR}/tlob_target"
+TLOB_SYM="${RV_BINDIR}/tlob_sym"
+[ -x "$UPROBE_TARGET" ] || exit_unsupported
+[ -x "$TLOB_SYM" ]      || exit_unsupported
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/dev/null)
+stop_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work_done 2>/dev/null)
+[ -n "$busy_offset" ] || exit_unsupported
+[ -n "$stop_offset" ] || exit_unsupported
+
+"$UPROBE_TARGET" 30000 &
+busy_pid=$!
+sleep 0.05
+
+echo 1 > monitors/tlob/enable
+echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=5000000000" > "$TLOB_MONITOR"
+
+# Binding must appear in monitor file with canonical hex-offset format.
+grep -qE "^p ${UPROBE_TARGET}:0x[0-9a-f]+ 0x[0-9a-f]+ threshold=[0-9]+$" "$TLOB_MONITOR"
+grep -q "threshold=5000000000" "$TLOB_MONITOR"
+
+# Duplicate offset_start must be rejected.
+! echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=9999000" > "$TLOB_MONITOR" 2>/dev/null
+
+# Remove the binding; it must no longer appear.
+echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR"
+! grep -q "^p .*:0x${busy_offset#0x} " "$TLOB_MONITOR"
+
+kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+echo 0 > monitors/tlob/enable
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc
new file mode 100644
index 000000000000..2814caa34902
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc
@@ -0,0 +1,51 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor detail running (running_ns dominates when task busy-spins between probes)
+# requires: tlob:monitor
+
+RV_BINDIR="${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
+UPROBE_TARGET="${RV_BINDIR}/tlob_target"
+TLOB_SYM="${RV_BINDIR}/tlob_sym"
+[ -x "$UPROBE_TARGET" ] || exit_unsupported
+[ -x "$TLOB_SYM" ]      || exit_unsupported
+TLOB_MONITOR=monitors/tlob/monitor
+
+start_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/dev/null)
+stop_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work_done 2>/dev/null)
+[ -n "$start_offset" ] || exit_unsupported
+[ -n "$stop_offset" ] || exit_unsupported
+
+"$UPROBE_TARGET" 5000 &
+busy_pid=$!
+sleep 0.05
+
+echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 1 > /sys/kernel/tracing/tracing_on
+echo 1 > monitors/tlob/enable
+echo > /sys/kernel/tracing/trace
+
+# 10 µs budget; task busy-spins 200 ms per iteration -> running_ns dominates.
+echo "p ${UPROBE_TARGET}:${start_offset} ${stop_offset} threshold=10000" > "$TLOB_MONITOR"
+
+found=0; i=0
+while [ "$i" -lt 30 ]; do
+	sleep 0.1
+	grep -q "detail_env_tlob" /sys/kernel/tracing/trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR" 2>/dev/null
+kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 0 > monitors/tlob/enable
+
+[ "$found" = "1" ]
+
+line=$(grep "detail_env_tlob" /sys/kernel/tracing/trace | head -n 1)
+running=$(echo "$line" | sed 's/.*running_ns=\([0-9]*\).*/\1/')
+waiting=$(echo "$line" | sed 's/.*waiting_ns=\([0-9]*\).*/\1/')
+sleeping=$(echo "$line" | sed 's/.*sleeping_ns=\([0-9]*\).*/\1/')
+# Busy-spin keeps the task on-CPU: running_ns must exceed sleeping_ns.
+[ "$running" -gt "$sleeping" ]
+
+echo > /sys/kernel/tracing/trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc
new file mode 100644
index 000000000000..0a6470b4cadb
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor detail sleeping (sleeping_ns dominates when task blocks between probes)
+# requires: tlob:monitor
+
+RV_BINDIR="${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
+UPROBE_TARGET="${RV_BINDIR}/tlob_target"
+TLOB_SYM="${RV_BINDIR}/tlob_sym"
+[ -x "$UPROBE_TARGET" ] || exit_unsupported
+[ -x "$TLOB_SYM" ]      || exit_unsupported
+TLOB_MONITOR=monitors/tlob/monitor
+
+start_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_sleep_work 2>/dev/null)
+stop_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_sleep_work_done 2>/dev/null)
+[ -n "$start_offset" ] || exit_unsupported
+[ -n "$stop_offset" ] || exit_unsupported
+
+"$UPROBE_TARGET" 5000 sleep &
+busy_pid=$!
+sleep 0.05
+
+echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 1 > /sys/kernel/tracing/tracing_on
+echo 1 > monitors/tlob/enable
+echo > /sys/kernel/tracing/trace
+
+# 50 ms budget; task sleeps 200 ms per iteration -> sleeping_ns dominates.
+echo "p ${UPROBE_TARGET}:${start_offset} ${stop_offset} threshold=50000000" > "$TLOB_MONITOR"
+
+found=0; i=0
+while [ "$i" -lt 30 ]; do
+	sleep 0.1
+	grep -q "detail_env_tlob" /sys/kernel/tracing/trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR" 2>/dev/null
+kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 0 > monitors/tlob/enable
+
+[ "$found" = "1" ]
+
+line=$(grep "detail_env_tlob" /sys/kernel/tracing/trace | head -n 1)
+running=$(echo "$line" | sed 's/.*running_ns=\([0-9]*\).*/\1/')
+waiting=$(echo "$line" | sed 's/.*waiting_ns=\([0-9]*\).*/\1/')
+sleeping=$(echo "$line" | sed 's/.*sleeping_ns=\([0-9]*\).*/\1/')
+[ "$sleeping" -gt "$((running + waiting))" ]
+
+echo > /sys/kernel/tracing/trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
new file mode 100644
index 000000000000..ef22fce700fc
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
@@ -0,0 +1,66 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor detail waiting (waiting_ns dominates when task is preempted between probes)
+# requires: tlob:monitor
+
+RV_BINDIR="${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
+UPROBE_TARGET="${RV_BINDIR}/tlob_target"
+TLOB_SYM="${RV_BINDIR}/tlob_sym"
+[ -x "$UPROBE_TARGET" ] || exit_unsupported
+[ -x "$TLOB_SYM" ]      || exit_unsupported
+TLOB_MONITOR=monitors/tlob/monitor
+
+command -v chrt    > /dev/null || exit_unsupported
+command -v taskset > /dev/null || exit_unsupported
+
+start_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_preempt_work 2>/dev/null)
+stop_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_preempt_work_done 2>/dev/null)
+[ -n "$start_offset" ] || exit_unsupported
+[ -n "$stop_offset" ]  || exit_unsupported
+
+cpu=0
+
+echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 1 > /sys/kernel/tracing/tracing_on
+echo 1 > monitors/tlob/enable
+echo > /sys/kernel/tracing/trace
+
+# Register probe before the target starts so the start uprobe fires on the
+# first entry to tlob_preempt_work. Budget: 500 ms.
+echo "p ${UPROBE_TARGET}:${start_offset} ${stop_offset} threshold=500000000" > "$TLOB_MONITOR"
+
+# Target starts; start probe fires on tlob_preempt_work entry.
+taskset -c "$cpu" "$UPROBE_TARGET" 5000 preempt &
+busy_pid=$!
+sleep 0.05
+
+# RT hog on the same CPU preempts the target; target stays in waiting state
+# (runnable, off-CPU) until the budget expires -> waiting_ns dominates.
+chrt -f 99 taskset -c "$cpu" sh -c 'while true; do :; done' 2>/dev/null &
+hog_pid=$!
+
+found=0; i=0
+while [ "$i" -lt 30 ]; do
+	sleep 0.1
+	grep -q "detail_env_tlob" /sys/kernel/tracing/trace && { found=1; break; }
+	i=$((i+1))
+done
+
+# Kill the RT hog first so tlob_target can release any in-flight SRCU read
+# section from uprobe_notify_resume; otherwise probe removal blocks in
+# synchronize_srcu with the hog monopolising the CPU at FIFO-99.
+kill "$hog_pid" 2>/dev/null || true; wait "$hog_pid" 2>/dev/null || true
+kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR" 2>/dev/null
+echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 0 > monitors/tlob/enable
+
+[ "$found" = "1" ]
+
+line=$(grep "detail_env_tlob" /sys/kernel/tracing/trace | head -n 1)
+running=$(echo "$line" | sed 's/.*running_ns=\([0-9]*\).*/\1/')
+sleeping=$(echo "$line" | sed 's/.*sleeping_ns=\([0-9]*\).*/\1/')
+waiting=$(echo "$line" | sed 's/.*waiting_ns=\([0-9]*\).*/\1/')
+[ "$waiting" -gt "$((running + sleeping))" ]
+
+echo > /sys/kernel/tracing/trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
new file mode 100644
index 000000000000..f1bd6c955f1d
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
@@ -0,0 +1,64 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor multiple uprobe bindings (different offsets fire independently)
+# requires: tlob:monitor
+
+RV_BINDIR="${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
+UPROBE_TARGET="${RV_BINDIR}/tlob_target"
+TLOB_SYM="${RV_BINDIR}/tlob_sym"
+[ -x "$UPROBE_TARGET" ] || exit_unsupported
+[ -x "$TLOB_SYM" ]      || exit_unsupported
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/dev/null)
+busy_stop=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work_done 2>/dev/null)
+sleep_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_sleep_work 2>/dev/null)
+sleep_stop=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_sleep_work_done 2>/dev/null)
+[ -n "$busy_offset" ]  || exit_unsupported
+[ -n "$busy_stop" ]    || exit_unsupported
+[ -n "$sleep_offset" ] || exit_unsupported
+[ -n "$sleep_stop" ]   || exit_unsupported
+
+"$UPROBE_TARGET" 30000 &       # busy mode: tlob_busy_work fires every 200 ms
+busy_pid=$!
+"$UPROBE_TARGET" 30000 sleep & # sleep mode: tlob_sleep_work fires every 200 ms
+sleep_pid=$!
+sleep 0.05
+
+echo 1 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 1 > /sys/kernel/tracing/tracing_on
+echo 1 > monitors/tlob/enable
+echo > /sys/kernel/tracing/trace
+
+# Binding A: 5 s budget on the busy probe - must not fire in 200 ms loops.
+echo "p ${UPROBE_TARGET}:${busy_offset} ${busy_stop} threshold=5000000000" > "$TLOB_MONITOR"
+# Binding B: 10 µs budget on the sleep probe - fires on first invocation.
+echo "p ${UPROBE_TARGET}:${sleep_offset} ${sleep_stop} threshold=10000" > "$TLOB_MONITOR"
+
+# Wait up to 2 s for error_env_tlob from binding B.
+found=0; i=0
+while [ "$i" -lt 20 ]; do
+	sleep 0.1
+	grep -q "error_env_tlob" /sys/kernel/tracing/trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR" 2>/dev/null
+echo "-${UPROBE_TARGET}:${sleep_offset}" > "$TLOB_MONITOR" 2>/dev/null
+kill "$sleep_pid" 2>/dev/null || true; wait "$sleep_pid" 2>/dev/null || true
+kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+
+echo 0 > monitors/tlob/enable
+echo 0 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+
+[ "$found" = "1" ]
+# error_env_tlob payload: clock variable must be present.
+# The event field can be "budget_exceeded" (hrtimer path) or the DA event
+# name ("sleep", "preempt") depending on which fires first; don't constrain it.
+grep "error_env_tlob" /sys/kernel/tracing/trace | head -n 1 | grep -q "clk_elapsed="
+# detail_env_tlob must appear alongside the error.
+grep -q "detail_env_tlob" /sys/kernel/tracing/trace
+
+echo > /sys/kernel/tracing/trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
new file mode 100644
index 000000000000..a143635a60ce
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor no spurious events without active uprobe binding
+# requires: tlob:monitor
+
+TLOB_MONITOR=monitors/tlob/monitor
+
+echo 1 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+echo 1 > /sys/kernel/tracing/tracing_on
+echo 1 > monitors/tlob/enable
+echo > /sys/kernel/tracing/trace
+
+sleep 0.5
+
+! grep -q "error_env_tlob" /sys/kernel/tracing/trace
+
+echo 0 > monitors/tlob/enable
+echo 0 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+echo > /sys/kernel/tracing/trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
new file mode 100644
index 000000000000..d210d9c3a92d
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
@@ -0,0 +1,67 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test tlob monitor budget violation (error_env_tlob and detail_env_tlob fire with correct fields)
+# requires: tlob:monitor
+
+RV_BINDIR="${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
+UPROBE_TARGET="${RV_BINDIR}/tlob_target"
+TLOB_SYM="${RV_BINDIR}/tlob_sym"
+[ -x "$UPROBE_TARGET" ] || exit_unsupported
+[ -x "$TLOB_SYM" ]      || exit_unsupported
+TLOB_MONITOR=monitors/tlob/monitor
+
+busy_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/dev/null)
+stop_offset=$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work_done 2>/dev/null)
+[ -n "$busy_offset" ] || exit_unsupported
+[ -n "$stop_offset" ] || exit_unsupported
+
+"$UPROBE_TARGET" 30000 &
+busy_pid=$!
+sleep 0.05
+
+echo 1 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+echo 1 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 1 > /sys/kernel/tracing/tracing_on
+echo 1 > monitors/tlob/enable
+echo > /sys/kernel/tracing/trace
+
+# 10 µs budget - fires almost immediately; task is busy-spinning on-CPU.
+echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=10000" > "$TLOB_MONITOR"
+
+# wait up to 2 s for detail_env_tlob
+found=0; i=0
+while [ "$i" -lt 20 ]; do
+	sleep 0.1
+	grep -q "detail_env_tlob" /sys/kernel/tracing/trace && { found=1; break; }
+	i=$((i+1))
+done
+
+echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR" 2>/dev/null
+kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+echo 0 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+echo 0 > /sys/kernel/tracing/events/rv/detail_env_tlob/enable
+echo 0 > monitors/tlob/enable
+
+[ "$found" = "1" ]
+
+# error_env_tlob must carry the clk_elapsed environment field.
+# The event label is "budget_exceeded" when detected by the hrtimer callback,
+# or the triggering sched event name when detected by the constraint path on a
+# preemption that races with the timer (common on PREEMPT_RT / VM).  Both are
+# valid detections; check the env field instead of the label.
+grep "error_env_tlob" /sys/kernel/tracing/trace | head -n 1 | grep -q "clk_elapsed="
+
+# detail_env_tlob must have all five fields with the correct threshold
+line=$(grep "detail_env_tlob" /sys/kernel/tracing/trace | head -n 1)
+echo "$line" | grep -q "pid="
+echo "$line" | grep -q "threshold_ns=10000"
+echo "$line" | grep -q "running_ns="
+echo "$line" | grep -q "waiting_ns="
+echo "$line" | grep -q "sleeping_ns="
+
+# Busy-spin keeps the task on-CPU: running_ns must exceed sleeping_ns.
+running=$(echo "$line" | sed 's/.*running_ns=\([0-9]*\).*/\1/')
+sleeping=$(echo "$line" | sed 's/.*sleeping_ns=\([0-9]*\).*/\1/')
+[ "$running" -gt "$sleeping" ]
+
+echo > /sys/kernel/tracing/trace
-- 
2.43.0

