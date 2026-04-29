Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C53382DE;
	Wed, 29 Apr 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777477422; cv=none; b=cb5gvH7Fq19XNtq6qtvV0GMy9hFrjy90Y3JNjU61BpGofyB99RLD56Z212GlGvosFdNfbFY0a6ZKFsUh2cNyzpm650ERPfjBcM9SdJJUVBL0rLrv3JhvxfmV35t2gbRb4l0+oybd3PnObtkh5vKpm0dE9gpn7ZzMDoweuUOfweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777477422; c=relaxed/simple;
	bh=VcwVETLijd8uEmjnb8irxgE6M/7EMe9PveqH/NPRobs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CY8wDnFe30OHld9AEHYyuLzeApyXs3EJnDcbOFUtmBXslbI4ajJ/vCbk4i2nR6M0PSd677ZwwrW+8+5eepD/gkFZu20WaxsJTVxx5wJDYmUOIDxdOg5+dSp6urwzAe5C7IDr5jh/OGevjtCbYKBlRXwA9QAyinx2McVv/+kgpWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew2tyNvv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew2tyNvv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5930EC19425;
	Wed, 29 Apr 2026 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777477422;
	bh=VcwVETLijd8uEmjnb8irxgE6M/7EMe9PveqH/NPRobs=;
	h=Date:From:To:Cc:Subject:From;
	b=ew2tyNvv73pY8Ni3C4pEOmxj5VBCMmMinJgX9y2v9mPA4O0hQRyHrXNvdWNWCjIB8
	 vw/W2uQSNn1l2OhOl8t3wDmf40Typ+i67sq5Hu37N7nFfv3lU2LzA4a45sH+BHELuP
	 y/i3wT0l7OwPz4kIl9kvF8kkmoh3FmqtDk4SpmH8h7kUJtYhVajeDBLlONddOXHwym
	 tSyD7ygmN/tsVOAgcM1rQzmL7pp/iY6ItnV+Fo50d+Hu2HfF2+qUxKfO8W5gCF6tAp
	 IUNFg0xXvM3n1p8R1NPE344IiCmyuDRjmXvUXumtJrqJDAwaChSFLZ6sdtfVgHWJY9
	 ZxIEgs8bFzZHQ==
Date: Wed, 29 Apr 2026 11:43:55 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jens Remus <jremus@linux.ibm.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, "Carlos
 O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch
 <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: [RFC][PATCH] unwind: Add stacktrace_setup system call
Message-ID: <20260429114355.6c712e6a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/w4=xW6Wlw24GCJFeDbVxxxI"

--MP_/w4=xW6Wlw24GCJFeDbVxxxI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: Steven Rostedt <rostedt@goodmis.org>

[
   This is an RFC that adds a system call for dynamic linkers to use to
   tell the kernel where the sframe sections are when it loads dynamic
   libraries.

   It is built on top of Jens's sframe implementation for v3:

      https://lore.kernel.org/linux-trace-kernel/20260127150554.2760964-1-jremus@linux.ibm.com/

   I have a repo with that code that this applies on top of here:

      git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git sframe/core
       

   The name of the system call is "stacktrace_setup", but I'm not attached
   to this name. If anyone can think of a better name I'm happy to take
   suggestions.

   This patch is just to get the conversation going and the final result
   may be much different. I tested this with the attached program which is a
   major hack. I built glibc with sframe v3 support and I used readelf to
   find the sframe size and location of glibc.

   readelf -e /work/usr/lib/libc.so.6 | grep sframe
     [19] .sframe           GNU_SFRAME       00000000001d3fc0  001d3fc0

   Then I wrote a program that takes the above location and size of the
   .sframe section in libc as parameters, scans /proc/self/maps to find
   where it loaded libc and then calls this new system call with a pointer
   to the location of the sframe along with its size, as well as where the
   libc text is located.

   It then spins for 2 seconds, calls the system call again to remove the
   sframe section it loaded, and spins for another 2 seconds.

   I ran perf record --call-graph fp,defer on the program and looked for
   the do_spin() function.

   With sframe loaded:

sframe-test    1350  1396.333593:     202366 cpu/cycles/P: 
            7fdf0ec38a44 [unknown] ([vdso])
            5621a6b97243 get_time+0x19 (/work/c/sframe-test)
            5621a6b9727f do_spin+0x1f (/work/c/sframe-test)
            5621a6b975cd main+0xd4 (/work/c/sframe-test)
            7fdf0ea26bda __libc_start_call_main+0x6a (/work/usr/lib/libc.so.6)
            7fdf0ea26d05 __libc_start_main@@GLIBC_2.34+0x85 (/work/usr/lib/libc.so.6)
            5621a6b97131 _start+0x21 (/work/c/sframe-test)

   After it unloads the sframe:

sframe-test    1350  1400.332902:     657582 cpu/cycles/P: 
            7fdf0ec38a5e [unknown] ([vdso])
            5621a6b97243 get_time+0x19 (/work/c/sframe-test)
            5621a6b9727f do_spin+0x1f (/work/c/sframe-test)
            5621a6b97602 main+0x109 (/work/c/sframe-test)
            7fdf0ea26bda __libc_start_call_main+0x6a (/work/usr/lib/libc.so.6)

   As you can see, with the sframe loaded, it was able to walk further up
   the libc library.

   Again, this is just an RFC, but I would like to get agreement on the
   system call so that we can then update the dynamic linker to do this
   instead of using my hack ;-)
]

Add a system call that can be used by dynamic linkers to tell the kernel
where the sframe section is in memory for libraries it loads.

The system call stacktrace_setup takes 5 parameters:

  op - the type of operation to perform
  addr_start - The virtual address of the sframe section
  addr_length - The length of the sframe section
  text_start - the text section the sframe represents
  test_length - the length of the section

The current op values are:

  STACKTRACE_REGISTER_SFRAME - This registers the sframe
  STACKTRACE_UNREGISTER_SFRAME - This removes the sframe

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/tools/syscall_32.tbl             |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
 include/linux/syscalls.h                    |  1 +
 include/uapi/asm-generic/unistd.h           |  5 ++-
 include/uapi/linux/stacktrace.h             | 10 ++++++
 kernel/sys_ni.c                             |  2 ++
 kernel/unwind/sframe.c                      | 37 +++++++++++++++++++++
 scripts/syscall.tbl                         |  1 +
 22 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/stacktrace.h

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index f31b7afffc34..8c320029a156 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -511,3 +511,4 @@
 579	common	file_setattr			sys_file_setattr
 580	common	listns				sys_listns
 581	common	rseq_slice_yield		sys_rseq_slice_yield
+582	common	stacktrace_setup		sys_stacktrace_setup
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 94351e22bfcf..60f9a33b2dc5 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -486,3 +486,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	stacktrace_setup		sys_stacktrace_setup
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
index 62d93d88e0fe..a0bd04a23006 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -483,3 +483,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	stacktrace_setup		sys_stacktrace_setup
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 248934257101..266ec877300a 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -471,3 +471,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	stacktrace_setup		sys_stacktrace_setup
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 223d26303627..916294849393 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -477,3 +477,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	stacktrace_setup		sys_stacktrace_setup
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 7430714e2b8f..20fec148901e 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -410,3 +410,4 @@
 469	n32	file_setattr			sys_file_setattr
 470	n32	listns				sys_listns
 471	n32	rseq_slice_yield		sys_rseq_slice_yield
+472	n32	stacktrace_setup		sys_stacktrace_setup
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 630aab9e5425..2743bbcab143 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -386,3 +386,4 @@
 469	n64	file_setattr			sys_file_setattr
 470	n64	listns				sys_listns
 471	n64	rseq_slice_yield		sys_rseq_slice_yield
+472	n64	stacktrace_setup		sys_stacktrace_setup
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 128653112284..187eadc4a42e 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -459,3 +459,4 @@
 469	o32	file_setattr			sys_file_setattr
 470	o32	listns				sys_listns
 471	o32	rseq_slice_yield		sys_rseq_slice_yield
+472	o32	stacktrace_setup		sys_stacktrace_setup
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index c6331dad9461..9442a92ef0aa 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -470,3 +470,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	stacktrace_setup		sys_stacktrace_setup
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 4fcc7c58a105..005441233932 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -562,3 +562,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	nospu	rseq_slice_yield		sys_rseq_slice_yield
+472	nospu	stacktrace_setup		sys_stacktrace_setup
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 09a7ef04d979..bc9894b25584 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -398,3 +398,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	stacktrace_setup		sys_stacktrace_setup
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 70b315cbe710..5766251b4d2d 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -475,3 +475,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	stacktrace_setup		sys_stacktrace_setup
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 7e71bf7fcd14..20e7f3b856e4 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -517,3 +517,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	stacktrace_setup		sys_stacktrace_setup
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index f832ebd2d79b..652ede93b724 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -477,3 +477,4 @@
 469	i386	file_setattr		sys_file_setattr
 470	i386	listns			sys_listns
 471	i386	rseq_slice_yield	sys_rseq_slice_yield
+472	i386	stacktrace_setup	sys_stacktrace_setup
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 524155d655da..5da918e912a6 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -396,6 +396,7 @@
 469	common	file_setattr		sys_file_setattr
 470	common	listns			sys_listns
 471	common	rseq_slice_yield	sys_rseq_slice_yield
+472	common	stacktrace_setup	sys_stacktrace_setup
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index a9bca4e484de..34f0de06baee 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -442,3 +442,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	stacktrace_setup		sys_stacktrace_setup
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f5639d5ac331..fdbea39c1b38 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -999,6 +999,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx __user *
 asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx __user *ctx,
 				      u32 size, u32 flags);
 asmlinkage long sys_lsm_list_modules(u64 __user *ids, u32 __user *size, u32 flags);
+asmlinkage long sys_stacktrace_setup(void);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a627acc8fb5f..d3f57d8454d7 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -863,8 +863,11 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
+#define __NR_stacktrace_setup 472
+__SYSCALL(__NR_stacktrace_setup, sys_stacktrace_setup)
+
 #undef __NR_syscalls
-#define __NR_syscalls 472
+#define __NR_syscalls 473
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/stacktrace.h b/include/uapi/linux/stacktrace.h
new file mode 100644
index 000000000000..60b581f55995
--- /dev/null
+++ b/include/uapi/linux/stacktrace.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_STACKTRACE_H
+#define _UAPI_LINUX_STACKTRACE_H
+
+enum stacktrace_setup_types {
+	STACKTRACE_REGISTER_SFRAME	= 1,
+	STACKTRACE_UNREGISTER_SFRAME	= 2,
+};
+
+#endif /* _UAPI_LINUX_STACKTRACE_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index add3032da16f..76998b0f811a 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -394,3 +394,5 @@ COND_SYSCALL(rseq_slice_yield);
 
 COND_SYSCALL(uretprobe);
 COND_SYSCALL(uprobe);
+
+COND_SYSCALL(stacktrace_setup);
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index f24997e84e05..a842038fb03b 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -12,8 +12,10 @@
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
 #include <linux/sframe.h>
+#include <linux/syscalls.h>
 #include <asm/unwind_user_sframe.h>
 #include <linux/unwind_user_types.h>
+#include <uapi/linux/stacktrace.h>
 
 #include "sframe.h"
 #include "sframe_debug.h"
@@ -838,3 +840,38 @@ void sframe_free_mm(struct mm_struct *mm)
 
 	mtree_destroy(&mm->sframe_mt);
 }
+
+/**
+ * sys_stacktrace_setup - register an address for user space stacktrace walking.
+ * @op: Type of operation to perform
+ * @addr_start: The virtual address of the stacktrace information
+ * @addr_length: The length of the stacktrace information
+ * @text_start: The virtual address of the text that @addr_start represents
+ * @text_length: The length of teh text
+ *
+ * This system call is used by dynamic library utilities to inform the kernel
+ * of meta data that it loaded that can be used by the kernel to know how
+ * to stack walk the given text locations.
+ *
+ * Currently only sframes are supported, but in the future, this may be used
+ * to tell the kernel about JIT code which will most likely have a different
+ * format.
+ *
+ * The type command may be extended and parameters may be used for other
+ * purposes.
+ *
+ * Return: 0 if successful, otherwise a negative error.
+ */
+SYSCALL_DEFINE5(stacktrace_setup, int, op, unsigned long, addr_start,
+		unsigned long, addr_length, unsigned long, text_start,
+		unsigned long, text_length)
+{
+	switch (op) {
+	case STACKTRACE_REGISTER_SFRAME:
+		return sframe_add_section(addr_start, addr_start + addr_length,
+					  text_start, text_start+text_length);
+	case STACKTRACE_UNREGISTER_SFRAME:
+		return sframe_remove_section(addr_start);
+	}
+	return -EINVAL;
+}
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 7a42b32b6577..54a99cffeec4 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -412,3 +412,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	stacktrace_setup		sys_stacktrace_setup
-- 
2.53.0


--MP_/w4=xW6Wlw24GCJFeDbVxxxI
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=sframe-test.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <errno.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/syscall.h>

#undef SYS_stacktrace_setup
#define SYS_stacktrace_setup		472

enum {
	STACKTRACE_REGISTER_SFRAME = 1,
	STACKTRACE_UNREGISTER_SFRAME,
};

#define stacktrace_setup(op, start_addr, length, text_addr, text_length)\
	syscall(SYS_stacktrace_setup, op, start_addr, length, text_addr, text_length)

static void usage(const char *name)
{
	printf("usage: %s sframe-offset sframe-length\n"
	       "\n",name);
	exit(-1);
}

static unsigned long long get_time(void)
{
	struct timeval tv;
	unsigned long long time;

	gettimeofday(&tv, NULL);

	time = tv.tv_sec * 1000000ULL;
	time += tv.tv_usec;

	return time;
}

void do_spin(void)
{
	unsigned long long start = get_time();

	/* 2 seconds */
	start += 2 * 1000 * 1000;

	while (get_time() < start)
		;
}

static int dump_self(unsigned long idx, unsigned long *sframe,
		     unsigned long *text, unsigned long *text_len)
{
	FILE *fp;
	char *line = NULL;
	size_t size;
	unsigned long ptr = 0;

	*text = 0;

	fp = fopen("/proc/self/maps", "r");
	if (!fp) {
		perror("self");
		exit(-1);
	}

	while ((!ptr || !*text) && getline(&line, &size, fp) > 0) {
		unsigned long start, end;
		char *file;
		char *perm;
		int r;
		int l;

		r = sscanf(line, "%lx-%lx %ms %*x %*s %*d %ms\n",
			   &start, &end, &perm, &file);
		if (r != 4)
			continue;
		printf("%s", line);
//		printf("file=%s\n", file);
		l = strlen(file);
		for (l--; l > 0; l--) {
			if (file[l] == '/') {
				l++;
				break;
			}
		}
		// r-xp	
		if (!strncmp(file + l, "libc.so", 7)) {
			if (!ptr) {
				ptr = start + idx;
				printf("found sframe libc.so %lx-%lx (%lx)\n", start, end, ptr);
				printf("VAL=%lx\n", *(unsigned long*)ptr);
			}
			if (!*text && !strcmp(perm, "r-xp")) {
				*text = start;
				*text_len = end - start;
				printf("found text libc.so %lx-%lx (%lx)\n", start, end, ptr);
			}
		}
		free(file);
		free(perm);
	}
	free(line);

	*sframe = ptr;
	return ptr && *text;
}

int main (int argc, char **argv)
{
	unsigned long idx; // 0x001d3fc0;
	unsigned long len; // 0x303f9;
	unsigned long ptr;
	unsigned long text;
	unsigned long text_len;
	int ret = 0;

	if (argc < 3)
		usage(argv[0]);


	idx = strtoul(argv[1], NULL, 0);
	len = strtoul(argv[2], NULL, 0);

	if (!dump_self(idx, &ptr, &text, &text_len)) {
		fprintf(stderr, "Could not find data");
		exit(-1);
	}
	ret = stacktrace_setup(STACKTRACE_REGISTER_SFRAME, ptr, len, text, text_len);
	if (ret < 0) {
		perror("Registering stacktrace");
		exit(-1);
	}

	do_spin();

	stacktrace_setup(STACKTRACE_UNREGISTER_SFRAME, ptr, len, text, text_len);

	do_spin();
	
	return 0;
}

--MP_/w4=xW6Wlw24GCJFeDbVxxxI--
