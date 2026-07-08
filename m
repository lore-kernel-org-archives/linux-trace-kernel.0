Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0243079F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525175; cv=none; b=hfR/25u5Afqsl/BCiCpu3tdrAPziIF0tYVqVXND7jwOyISFQOSiWUhUZdC7hq3En9F4yqsqWHX/wcNjmp9bVFV3zYfOgzGIO5+xJ5cuY5zbcedxqmvBzNz8sqkEs+3BnYiq8z5yo4iX1OXnqPRYjZ2amVe5v/FmDnI6tnOJulIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525175; c=relaxed/simple;
	bh=67I4upehHSmBR2ATzvirosBiYXNttTvdju/HzHURgd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6iwH7XR7fyYusT0TBEgXSiZFH6oGSUvhV20znOghvVdPb8BXk1DWwDf8BRLsYy9fiNZEJniaHLAi6OB5Cug3lM1SbkhOg8LXL7y/SdxVjaCwbPSec0iwN/KmvAFAgk+PLD0qxnIIbhY7Zy+GqbnPjIUxmyVrmtKk76kTLsJXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iqA9BS2x; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iqA9BS2x"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783525171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GwE92WeJSH8qKsz85avHeTfGL+kk5Nnqat6KWct5A0=;
	b=iqA9BS2xRGlCROOUSNhs2CVsPz7SrKYBP+iv8Cl4mZfQ+HoGGTqYeHS2tL7V5TeLRLk5PW
	ktZ5ihLGmGXZ/c7flAWjUClfxsLT5WdEujwnIX2x5AH3X1jFZVXQ1mu6VuhhIRfgoB3z3L
	5WcW6RyWgfBNr4NpuAtKX801eSePAxg=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 8/8] selftests/verification: add tlob selftests
Date: Wed,  8 Jul 2026 23:38:34 +0800
Message-Id: <4eb9a676efe90de8dfc1a9188d6ea81336e65e63.1783524627.git.wen.yang@linux.dev>
In-Reply-To: <cover.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Add seven ftrace-style test scripts for the tlob RV monitor under
tools/testing/selftests/verification/test.d/tlob/.  The tests cover
uprobe binding management, budget violation detection, and per-state
time accounting.

Helper binaries tlob_target and tlob_sym are included in the same
directory so the suite is self-contained.  tlob_sym resolves ELF
symbol offsets for uprobe registration; tlob_target provides busy-spin,
sleep, and preempt workloads.

ftracetest is updated to walk up the directory tree when searching for
test.d/functions, so monitor subdirectories can be passed as the test
directory without placing a dummy functions shim in each new directory.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 tools/testing/selftests/ftrace/ftracetest     |  18 +-
 .../testing/selftests/verification/.gitignore |   2 +
 tools/testing/selftests/verification/Makefile |  19 +-
 .../verification/test.d/tlob/Makefile         |  28 +++
 .../test.d/tlob/run_tlob_tests.sh             |  90 ++++++++
 .../verification/test.d/tlob/tlob_sym.c       | 209 ++++++++++++++++++
 .../verification/test.d/tlob/tlob_target.c    | 138 ++++++++++++
 .../verification/test.d/tlob/uprobe_bind.tc   |  37 ++++
 .../test.d/tlob/uprobe_detail_running.tc      |  51 +++++
 .../test.d/tlob/uprobe_detail_sleeping.tc     |  50 +++++
 .../test.d/tlob/uprobe_detail_waiting.tc      |  66 ++++++
 .../verification/test.d/tlob/uprobe_multi.tc  |  64 ++++++
 .../test.d/tlob/uprobe_no_event.tc            |  19 ++
 .../test.d/tlob/uprobe_violation.tc           |  67 ++++++
 14 files changed, 854 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/Makefile
 create mode 100755 tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/tlob_target.c
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
 create mode 100644 tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 0a56bf209f6c..91c007b0a74a 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -159,9 +159,21 @@ parse_opts() { # opts
   if [ -n "$OPT_TEST_CASES" ]; then
     TEST_CASES=$OPT_TEST_CASES
   fi
-  if [ -n "$OPT_TEST_DIR" -a -f "$OPT_TEST_DIR"/test.d/functions ]; then
-    TOP_DIR=$OPT_TEST_DIR
-    TEST_DIR=$TOP_DIR/test.d
+  if [ -n "$OPT_TEST_DIR" ]; then
+    # Walk up from OPT_TEST_DIR to find the nearest ancestor containing
+    # test.d/functions, allowing monitor subdirectories to be passed directly.
+    dir=$OPT_TEST_DIR
+    while [ "$dir" != "/" ]; do
+      if [ -f "$dir/test.d/functions" ]; then
+        TOP_DIR=$dir
+        TEST_DIR=$TOP_DIR/test.d
+        break
+      fi
+      dir=$(dirname "$dir")
+    done
+    if [ -z "$TOP_DIR" ]; then
+      errexit "no test.d/functions found above $OPT_TEST_DIR"
+    fi
   fi
 }
 
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
index 000000000000..05a2d2599c4e
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/Makefile
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+# Builds tlob selftest helper binaries in the directory of this Makefile.
+#
+# Invoked by ../../Makefile via BUILD_SUBDIRS; outputs tlob_sym and
+# tlob_target alongside the .tc scripts so they are self-contained.
+
+CFLAGS += $(TOOLS_INCLUDES)
+
+# For standalone execution via vng
+FTRACETEST := ../../../ftrace/ftracetest
+LOGDIR ?= ../../logs
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
+.PHONY: run_tests
+run_tests: all
+	@./run_tlob_tests.sh
+
+.PHONY: clean
+clean:
+	$(RM) tlob_sym tlob_target
diff --git a/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
new file mode 100755
index 000000000000..cd949756e713
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
@@ -0,0 +1,90 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Standalone runner for tlob selftests
+# Usage: ./run_tlob_tests.sh [options]
+#
+# Options:
+#   -v, --verbose    Verbose output
+#   -k, --keep       Keep test logs
+#   -l, --logdir DIR Log directory (default: ../../logs)
+#   -h, --help       Show this help
+
+set -e
+
+SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+FTRACETEST="$SCRIPT_DIR/../../../ftrace/ftracetest"
+LOGDIR="$SCRIPT_DIR/../../logs"
+VERBOSE=""
+KEEP=""
+EXTRA_ARGS=""
+
+# Parse arguments
+while [[ $# -gt 0 ]]; do
+    case $1 in
+        -v|--verbose)
+            VERBOSE="-v"
+            shift
+            ;;
+        -k|--keep)
+            KEEP="-k"
+            shift
+            ;;
+        -l|--logdir)
+            LOGDIR="$2"
+            shift 2
+            ;;
+        -h|--help)
+            echo "Usage: $0 [options]"
+            echo ""
+            echo "Options:"
+            echo "  -v, --verbose    Verbose output"
+            echo "  -k, --keep       Keep test logs"
+            echo "  -l, --logdir DIR Log directory (default: ../../logs)"
+            echo "  -h, --help       Show this help"
+            echo ""
+            echo "Examples:"
+            echo "  $0                           # Run all tlob tests"
+            echo "  $0 -v                        # Run with verbose output"
+            echo "  $0 -v -l /tmp/tlob-logs      # Custom log directory"
+            echo ""
+            echo "With vng:"
+            echo "  vng -v --rwdir $LOGDIR -- $0"
+            exit 0
+            ;;
+        *)
+            EXTRA_ARGS="$EXTRA_ARGS $1"
+            shift
+            ;;
+    esac
+done
+
+# Build test helpers
+echo "Building tlob test helpers..."
+make -C "$SCRIPT_DIR" all
+
+# Check ftracetest exists
+if [ ! -x "$FTRACETEST" ]; then
+    echo "Error: $FTRACETEST not found or not executable"
+    echo "Make sure you're running from the correct directory"
+    exit 1
+fi
+
+# Create log directory
+mkdir -p "$LOGDIR"
+
+# Run tests
+echo "Running tlob selftests..."
+echo "Log directory: $LOGDIR"
+echo ""
+
+# Export RV_BINDIR so test scripts can find tlob_target and tlob_sym
+export RV_BINDIR="$SCRIPT_DIR"
+
+# Pass the test directory, not individual .tc files
+# ftracetest will discover all .tc files in the directory
+"$FTRACETEST" -K $VERBOSE $KEEP --rv --logdir "$LOGDIR" \
+    "$SCRIPT_DIR" $EXTRA_ARGS
+
+echo ""
+echo "Tests completed. Logs saved to: $LOGDIR"
diff --git a/tools/testing/selftests/verification/test.d/tlob/tlob_sym.c b/tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
new file mode 100644
index 000000000000..a92fc49d1304
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
@@ -0,0 +1,209 @@
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
+		Elf64_Shdr *shdrs;
+		Elf64_Shdr *shstrtab_hdr;
+
+		if (ehdr->e_shnum == 0 || ehdr->e_shstrndx >= ehdr->e_shnum ||
+		    (uint64_t)ehdr->e_shoff +
+		    (uint64_t)ehdr->e_shnum * sizeof(Elf64_Shdr) > (uint64_t)st.st_size) {
+			fprintf(stderr, "%s: malformed ELF section table\n", binary);
+			munmap(map, (size_t)st.st_size);
+			return 1;
+		}
+		shdrs = (Elf64_Shdr *)((char *)map + ehdr->e_shoff);
+		shstrtab_hdr = &shdrs[ehdr->e_shstrndx];
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
+		Elf32_Shdr *shdrs;
+		Elf32_Shdr *shstrtab_hdr;
+
+		if (ehdr32->e_shnum == 0 || ehdr32->e_shstrndx >= ehdr32->e_shnum ||
+		    (uint64_t)ehdr32->e_shoff +
+		    (uint64_t)ehdr32->e_shnum * sizeof(Elf32_Shdr) > (uint64_t)st.st_size) {
+			fprintf(stderr, "%s: malformed ELF section table\n", binary);
+			munmap(map, (size_t)st.st_size);
+			return 1;
+		}
+		shdrs = (Elf32_Shdr *)((char *)map + ehdr32->e_shoff);
+		shstrtab_hdr = &shdrs[ehdr32->e_shstrndx];
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
index 000000000000..adf4c2397fb3
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
+ *   tlob_preempt_work / tlob_preempt_work_done - busy-spin + RT competitor:
+ *                                                waiting_ns dominates
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
+noinline void tlob_busy_work(unsigned long duration_ms)
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
+			tlob_busy_work(200);
+		clock_gettime(CLOCK_MONOTONIC, &now);
+	} while (timespec_before(&now, &deadline));
+
+	return 0;
+}
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
new file mode 100644
index 000000000000..4a1c18c7485a
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
+! echo "p ${UPROBE_TARGET}:${busy_offset} ${stop_offset} threshold=9999000" > "$TLOB_MONITOR" 2>/dev/null || false
+
+# Remove the binding; it must no longer appear.
+echo "-${UPROBE_TARGET}:${busy_offset}" > "$TLOB_MONITOR"
+! grep -q "^p .*:0x${busy_offset#0x} " "$TLOB_MONITOR" || false
+
+kill "$busy_pid" 2>/dev/null || true; wait "$busy_pid" 2>/dev/null || true
+echo 0 > monitors/tlob/enable
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc
new file mode 100644
index 000000000000..afca157b5ea4
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
+# 10 us budget; task busy-spins 200 ms per iteration -> running_ns dominates.
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
index 000000000000..a798f3e9b3fa
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
+# Binding B: 10 us budget on the sleep probe - fires on first invocation.
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
index 000000000000..bb2eeef17019
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
+! grep -q "error_env_tlob" /sys/kernel/tracing/trace || false
+
+echo 0 > monitors/tlob/enable
+echo 0 > /sys/kernel/tracing/events/rv/error_env_tlob/enable
+echo > /sys/kernel/tracing/trace
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
new file mode 100644
index 000000000000..8a94bd679b88
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
+# 10 us budget - fires almost immediately; task is busy-spinning on-CPU.
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
2.25.1

