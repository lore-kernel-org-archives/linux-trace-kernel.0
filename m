Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6DE1805E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739236323; cv=none; b=XduZ8cKoxchfGu0amlGbT1EjqLZRNW9DbAbt3qrfmnL0wv/K4ZIsYVlCtPFYWLTBABxBSdO7REogn0LNvxSmxxK4sWTX7ejkN/swJUvfa3/5cYr5d4AKcmOA9sznitiFUai5fPuh1VGwJgyDG8rcYsu16rEQrPCctzaz2S1bzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739236323; c=relaxed/simple;
	bh=92WSHvse9NtZPS+NBDuQNJM3LfmfR22EdTszvKHj7DE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U337NcN4a+n3RsvQA/bEk7A/y1ZDXnmxGeTd0jCmfitOLPqX9JhTGHFDyVCK1FJn9YX0YfJN92Ep0Xjw5yRKjkijCa4NBK7x8sZZmWiOn5yurBI522SAmCFsaIC9Fya8hADURCoqhDd0xZdeILnJa4c/CnZhgmiZli4GMUlzFJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=biLcJqze; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="biLcJqze"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6e45258610bso22017176d6.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 17:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739236319; x=1739841119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCB0N5o/wEhbzt+lHYfCNCbBWPXl1jq2hVotYWnfk0w=;
        b=biLcJqze75NaNcQXhnyTEp7yeQ4uYR2U8gWYsKKmhjFs4rMOupWTL0naaniOg/0J1q
         F/HtWKpcd+y3GrruHBGpnqBaCuADMBPi0v+pQcl7SiE6X9gVEM9u6R+4UNPNQzcVGYsW
         RnalZfTeBiSHOVLyO1kg6ATLeYSIGWGLciRhRYz+sF05DwIMIbP1DjuKVXzHhgLba1I0
         12z4YnKSeRESTwfdD5crMS4JEaJ/YPNdspT1wixAhZJ1TOKwS+SgnagOllpi/4/q6T86
         cgDba8rONkXe+ViEYKg67DLOlypGVD2FwauSgYsnu1iSrT5bmXq0VUe+i6KmXxYWUxvX
         IVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739236319; x=1739841119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCB0N5o/wEhbzt+lHYfCNCbBWPXl1jq2hVotYWnfk0w=;
        b=D/keH6fI+Qu0bMcZYwp2+T4Jv71VO1Twk6QEcRBZMXMozU9xl7XldgK7KunNdMhwnQ
         hR9Igy3l9GlCx1IC4TZXeTRQv/J723cFOJcZfUPn3/GDsjfnyUWvye5mMvGJ1IDcvSDV
         Zi+tnt5TGBe2SoOW8iydD//IgcK5kTnx8GvwnM+Tmdh1ILLqFxl3670NZTTZES5I05h1
         U0d82kIuqd2i8sd823D+OUfbJWz0tTZPR+vuuRRUFWktUhb9Tb+bZg7uWB8AxpZoiDxa
         bkZFdFyM+XduESS/KE0LAiLRkAiuYA9lSanxM5aTXnqr88sVGINU1QvCnroaHcCtYBii
         qqaQ==
X-Gm-Message-State: AOJu0YyBeYwdBqSt+Ol/oJmb+WbKKUMGUeiWmSjuIHg+r5KAZ0S3f8kb
	3fNvEhEkyU4BHdWdqISdNvJA2pLAxwANqL6djAHcGS/s3OouFBObgcTuY0Md5rxDoE6qgxmsEfl
	hY/zwy42w3GcgRabxnzX/zeuYROrEMPjb
X-Gm-Gg: ASbGncuMDOIxugsRDBCH1WhBusqYI/TzUFjevrI0fwE/RRHgojS2ZkgH/+vStQ1A0k7
	wXzjvPmS0gPLa+JGV+Z+NEw3fkE3XxKJBtY7/zomb6bZYJnqRmxYTk2FgdkZri7Z0SU+x2VQ3mU
	Sgtyo04lBFNC5QWv1Qz83j/rywIM5FSCNIz5PSXGyGh5+VTwsgbR86hHxzlrTSyOWJ3W+EGB94e
	LUB198Lg2Oa5Jy/lY+rlo/8wiYAi7pISe7C2zCDdgjZhXwKDL12Jva5sh9ReDFfARsyTOLjfM/N
	TtFFzsHdcDne50+2B1eLu3pH/LFXdAUAnc9Scak=
X-Google-Smtp-Source: AGHT+IGMeCd/+nLFf32o97B15A+EpITJvjQV2ikgtlVCO0kbiodUAzYk5R16Y3XR2XfX5iF/ivV3zkHMIOal
X-Received: by 2002:a05:6214:3008:b0:6e4:25ff:4bac with SMTP id 6a1803df08f44-6e46804e796mr23993126d6.10.1739236319216;
        Mon, 10 Feb 2025 17:11:59 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6e45a20724dsm2681346d6.28.2025.02.10.17.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 17:11:59 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 65ABA3405AE;
	Mon, 10 Feb 2025 18:11:58 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 6D668E559CC; Mon, 10 Feb 2025 18:11:58 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Date: Mon, 10 Feb 2025 18:11:55 -0700
Subject: [PATCH 2/2] kbuild: rpm-pkg: build debuginfo and debugsource RPMs
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-debuginfo-v1-2-368feb58292a@purestorage.com>
References: <20250210-debuginfo-v1-0-368feb58292a@purestorage.com>
In-Reply-To: <20250210-debuginfo-v1-0-368feb58292a@purestorage.com>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

The rpm-pkg make target currently suffers from a few issues related to
debuginfo:
1. debuginfo for things built into the kernel (vmlinux) is not available
   in any RPM produced by make rpm-pkg. This makes using tools like
   systemtap against a make rpm-pkg kernel impossible.
2. debug source for the kernel is not available. This means that
   commands like 'disas /s' in gdb, which display source intermixed with
   assembly, can only print file names/line numbers which then must be
   painstakingly resolved to actual source in a separate editor.
3. debuginfo for modules is available, but it remains bundled with the
   .ko files that contain module code, in the kernel-%{KERNELRELEASE}
   RPM. This is a waste of space for users who do not need to debug the
   kernel (i.e. most users).

Address all of these issues by additionally building debuginfo and
debugsource RPMs when CONFIG_DEBUG_INFO=y is set, in line with standard
patterns followed by most distribution packages. With these changes:
1. systemtap now works (when these changes are backported to 6.11, since
   systemtap lags a bit behind in compatibility), as verified by the
   following simple test script:

   # stap -e 'probe kernel.function("do_sys_open").call { printf("%s\n", $$parms); }'
   dfd=0xffffffffffffff9c filename=0x7fe18800b160 flags=0x88800 mode=0x0
   ...

2. disas /s works correctly in gdb, with source and disassembly
   interspersed:

   # gdb vmlinux --batch -ex 'disas /s blk_op_str'
   Dump of assembler code for function blk_op_str:
   block/blk-core.c:
   125     {
      0xffffffff814c8740 <+0>:     endbr64

   127
   128             if (op < ARRAY_SIZE(blk_op_name) && blk_op_name[op])
      0xffffffff814c8744 <+4>:     mov    $0xffffffff824a7378,%rax
      0xffffffff814c874b <+11>:    cmp    $0x23,%edi
      0xffffffff814c874e <+14>:    ja     0xffffffff814c8768 <blk_op_str+40>
      0xffffffff814c8750 <+16>:    mov    %edi,%edi

   126             const char *op_str = "UNKNOWN";
      0xffffffff814c8752 <+18>:    mov    $0xffffffff824a7378,%rdx

   127
   128             if (op < ARRAY_SIZE(blk_op_name) && blk_op_name[op])
      0xffffffff814c8759 <+25>:    mov    -0x7dfa0160(,%rdi,8),%rax

   126             const char *op_str = "UNKNOWN";
      0xffffffff814c8761 <+33>:    test   %rax,%rax
      0xffffffff814c8764 <+36>:    cmove  %rdx,%rax

   129                     op_str = blk_op_name[op];
   130
   131             return op_str;
   132     }
      0xffffffff814c8768 <+40>:    jmp    0xffffffff81d01360 <__x86_return_thunk>
   End of assembler dump.

3. The size of the kernel-%{KERNELRELEASE} package goes down
   substantially. Here is a comparison of installed size of the
   kernel-%{KERNELRELEASE} package (configured with allmodconfig, dwarf4
   debuginfo, and module compression turned off) before and after this
   patch:

   # rpm -qi kernel-6.13* | grep -E '^(Version|Size)'
   Version     : 6.13.0postpatch+
   Size        : 1382874089
   Version     : 6.13.0prepatch+
   Size        : 17870795887

   This is a ~92% size reduction.

Note that this feature is incompatible with CONFIG_MODULE_COMPRESS -
if it is turned on, the module .ko files are compressed before
find-debuginfo.sh sees them, and it will not be able to extract
debuginfo from them. There are two potential paths forward here:
- teach find-debuginfo.sh to extract debuginfo from compressed kernel
  modules
- teach the kernel build process to produce split debuginfo and then
  package that directly, bypassing find-debuginfo.sh

But leaving CONFIG_MODULE_COMPRESS off seems common, so taking this
patch as is still feels useful.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 scripts/package/kernel.spec | 31 +++++++++++++++++++++++++++++--
 scripts/package/mkspec      |  3 +++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index ac3e5ac01d8a4daa031bc9e70b792a68f74c388b..efd7b1f43c64c8324bb0a6e540f2ba5f77f9de1e 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -2,8 +2,6 @@
 %{!?_arch: %define _arch dummy}
 %{!?make: %define make make}
 %define makeflags %{?_smp_mflags} ARCH=%{ARCH}
-%define __spec_install_post /usr/lib/rpm/brp-compress || :
-%define debug_package %{nil}
 
 Name: kernel
 Summary: The Linux Kernel
@@ -46,6 +44,24 @@ This package provides kernel headers and makefiles sufficient to build modules
 against the %{version} kernel package.
 %endif
 
+%if %{with_debuginfo}
+# list of debuginfo-related options taken from distribution spec files
+%undefine _include_minidebuginfo
+%undefine _find_debuginfo_dwz_opts
+%undefine _unique_build_ids
+%undefine _unique_debug_names
+%undefine _unique_debug_srcs
+%undefine _debuginfo_subpackages
+%global _find_debuginfo_opts -r
+%global _missing_build_ids_terminate_build 1
+%global _no_recompute_build_ids 1
+%{debug_package}
+%endif
+# some (but not all) versions of rpmbuild emit %%debug_package with
+# %%install. since we've already emitted it manually, that would cause
+# a package redefinition error. ensure that doesn't happen
+%define debug_package %{nil}
+
 %prep
 %setup -q -n linux
 cp %{SOURCE1} .config
@@ -89,8 +105,19 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEA
 	echo "%exclude /lib/modules/%{KERNELRELEASE}/build"
 } > %{buildroot}/kernel.list
 
+# make modules executable so that find-debuginfo.sh strips them
+find %{buildroot}/lib/modules/%{KERNELRELEASE} -name "*.ko" -type f \
+	| xargs --no-run-if-empty chmod u+x
+
+%if %{with_debuginfo}
+mkdir -p %{buildroot}/usr/lib/debug/lib/modules/%{KERNELRELEASE}
+cp vmlinux %{buildroot}/usr/lib/debug/lib/modules/%{KERNELRELEASE}
+%endif
+
 %clean
 rm -rf %{buildroot}
+rm -f debugfiles.list debuglinks.list debugsourcefiles.list debugsources.list \
+	elfbins.list
 
 %post
 if [ -x /usr/bin/kernel-install ]; then
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 4dc1466dfc815c110eb7206f83dd874b17f5170f..4c96bdca381a2fb4cc57415ca914d14e37e16caa 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -23,6 +23,9 @@ else
 echo '%define with_devel 0'
 fi
 
+WITH_DEBUGINFO=$(grep -c CONFIG_DEBUG_INFO=y include/config/auto.conf)
+echo "%define with_debuginfo ${WITH_DEBUGINFO}"
+
 cat<<EOF
 %define ARCH ${ARCH}
 %define KERNELRELEASE ${KERNELRELEASE}

-- 
2.34.1

