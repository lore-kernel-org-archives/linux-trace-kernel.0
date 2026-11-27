Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791047;
	b=xzoZKCmFXMrx2oifdLMYdzeeLSSrVe0M2wXY1BLUgYjonVu7JNDTM7KVmGw1r23jTjgi
	 NlNYAnmDxvApuBnPuD2xIE1EdrZBH5AXPMVRsrb1oCZV2wrtDY3u6QDRNcsaE2MhRFiAm
	 fnZY8WoKefYNGMUlyrJDYwrf5wL2whYneP9VuWIH8wqBlsOziIbchrQTeXb5jaWxmVNNX
	 4O8kJ//iHBplk6usK3CL07tS5neHOy7x0yB+4v0K4tT5kdBvA9j9EQ0bdwpFSMo8QkVDh
	 2nYXvLfkomDbM+jJdJEsVBQokurWHjLlmvjnIhnbCokejSJ21+TuBKwBnV9txX4AwtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791047;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EZGGQwvOJaxyLnrDEyGyhy23fszUciQJ6lW1UO7RFuk=;
	b=deJ0hpNI7h9b5m0z9tpEcVPVorZuFn4g23mFwdFZL63q6q+3WYgAHKZY0vnRkQf4ok9d
	 DqRfUMLH2gH3+UjVbTy2KqebjKy0+EQyLtUtw2b64yeeFWaJwQDVR5pmAvAfA3IrdJaOC
	 4SsBoU3Gz5ahlLlp5RJvZ/Lvz9yK/zPqF7gIdikAgbiSW8Pdw68BX7BW6KGLvWuHiS3N/
	 JCuJMNsVGAEl17/yrwM8gtEyoaXfA9rxUqpUb2n33N9S3JKg0Bxt58+9W7/AOPXMb84pL
	 kiSyWp1CVsKNrTycLsn70X2wD2uKAdhpFVnFee+bWij2T61KU3xMP2FBMQcVoMxLMAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqOz2b0N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A77606A31F;
	Fri, 27 Nov 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqOz2b0N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96401F000C1;
	Fri, 27 Nov 2026 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791047;
	bh=EZGGQwvOJaxyLnrDEyGyhy23fszUciQJ6lW1UO7RFuk=;
	h=From:To:Cc:Subject:Date;
	b=LqOz2b0Nqprt3aH1rSKGRpzTkrS+Pr4VATEpUFgGpVdkRpOdhNUiOrY/v72mge2qu
	 4WOJstVmH+Xpgq9NsxulWK74VZFa8AC+rtnZWl35kg24GfcUJvZsacFiS0JyvBDtF4
	 Hp9JJ3g1IAiIXWftP0Ea7J3rMSdwjEb8V6cU2UMzwgvWkNoGNrOFucN5o+bXejE8Vf
	 pdji0VxADJM/L/nUVYxj6x05QvhV9pAYqU4o8mojp2x4AEAw+PSteG/KOQuetG6z1S
	 3OMnD+MkNCExAFcUrglqcyZaVnuALrarnT6yOP6MqohLy4LVr+pyizshOC4qyNuqSj
	 bN8juvAcZo5hQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: snambakam@microsoft.com, Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 0/5] bootconfig: Support multiple named bootconfigs in initrd
Date: Fri, 27 Nov 2026 14:46:14 +0000
Message-ID: <20261127144614.61194-1-mhiramat@kernel.org>
X-Mailer: UndineD 0.1
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

This RFC series proposes support for bundling multiple named bootconfig
files in a single initrd image and selecting which subset to load at
boot time via the kernel command line.

This work is based on our discussion at LPC 2026 on supporting multiple
bootconfigs in single-image / signed Unified Kernel Image (UKI) setups.
I would appreciate your feedback on the overall design, on-disk format,
command-line semantics, and user-space CLI before finalizing this
series.

Motivation
----------
Bootconfig currently allows only a single bootconfig block appended to
an initrd. In single-image or signed UKI environments, it is often
useful to ship a default production bootconfig alongside optional
debug, tracing, or scenario-specific overlays in the same initrd image,
and enable or combine them at boot without rebuilding or re-signing the
image.

Proposed Specification (Feedback Welcome)
-----------------------------------------
1. In-band naming ("#BOOTCONFIG-ID: <id>"):
   Each named bootconfig carries an optional first-line comment
   "#BOOTCONFIG-ID: <id>" (1..31 bytes matching [A-Za-z_][A-Za-z0-9_.-]*),
   keeping the existing 20-byte "#BOOTCONFIG" trailer format, size, and
   checksum framing unchanged for backward compatibility.
2. Stacked trailers & index 0 as default:
   Up to XBC_CONFIG_MAX (32) stacked bootconfig trailers can be attached
   to an initrd. Block 0 (the first block immediately after initramfs)
   is defined as the default bootconfig rather than the outermost
   trailer, so appending optional overlays never alters what bare
   "bootconfig" loads and places the default first in stack-order
   merging so overlays can override keys via ":=" or "+=". All valid
   trailers are always stripped from initrd_end so initramfs unpacking
   is unaffected.
3. Command-line selection ("bootconfig=[+][<sel>,...]"):
   Each <sel> may be a bootconfig ID, a 0-based index, or empty (index
   0, e.g. "bootconfig=,debug"). A leading "+" appends to a prior
   selection (or to index 0 if none preceded it). Empty "bootconfig="
   clears any prior selection (for example, to override a UKI .cmdline),
   unless CONFIG_BOOT_CONFIG_FORCE=y is set, which continues to force
   index 0. Note that previously empty "bootconfig=" was equivalent to
   bare "bootconfig". CONFIG_CMDLINE_FROM_BOOTCONFIG on x86 is updated
   to follow the same selection rule.
4. User-space CLI ("tools/bootconfig -i <id[,...]>"):
   Extends tools/bootconfig with "-i" across apply, delete, show, list,
   and cmdline rendering, with rollback safety on write failure and
   merge-conflict warnings against block 0. Five new QEMU boottime
   selftests are included to exercise the selection modes.

Does this specification and command-line/tool interface look reasonable
for your use cases? Any comments or suggestions are very welcome.

Patch Overview
--------------
1. bootconfig: Add multi-config ID helpers and xbc_init_configs() support
2. bootconfig: Support stacked initrd bootconfigs and bootconfig= selection
3. tools/bootconfig: Support multiple named bootconfigs with -i option
4. selftests/ftrace: Add boottime tests for multiple bootconfig selection
5. Documentation: bootconfig: Document multiple bootconfigs and selection

Thank you,

Masami Hiramatsu (Google) (5):
  bootconfig: Add multi-config ID helpers and xbc_init_configs() support
  bootconfig: Support stacked initrd bootconfigs and bootconfig=
    selection
  tools/bootconfig: Support multiple named bootconfigs with -i option
  selftests/ftrace: Add boottime tests for multiple bootconfig selection
  Documentation: bootconfig: Document multiple bootconfigs and selection

 Documentation/admin-guide/bootconfig.rst      |  82 +-
 .../admin-guide/kernel-parameters.txt         |  10 +
 arch/x86/kernel/setup.c                       |   7 +-
 include/linux/bootconfig.h                    |  32 +
 init/main.c                                   | 261 ++++--
 lib/bootconfig.c                              | 476 +++++++++--
 tools/bootconfig/include/linux/bootconfig.h   |   4 +
 tools/bootconfig/main.c                       | 779 ++++++++++++++----
 tools/bootconfig/test-bootconfig.sh           | 116 +++
 .../testing/selftests/ftrace/boottime/README  |   4 +-
 .../bootconfigs/bconf-multi-01-default.bconf  |   5 +
 .../bconf-multi-01-default.debug.bconf        |   5 +
 .../bconf-multi-02-select.alt.bconf           |   5 +
 .../bconf-multi-02-select.base.bconf          |   7 +
 .../bconf-multi-02-select.dbg.bconf           |   7 +
 .../bootconfigs/bconf-multi-03-append.bconf   |   6 +
 .../bconf-multi-03-append.dbg.bconf           |   6 +
 .../bootconfigs/bconf-multi-04-clear.bconf    |   5 +
 .../bootconfigs/bconf-multi-05-conflict.bconf |   6 +
 .../ftrace/boottime/run_boottime_test.sh      |  99 ++-
 .../boottime/tests/bconf-multi-01-default.sh  |  23 +
 .../boottime/tests/bconf-multi-02-select.sh   |  53 ++
 .../boottime/tests/bconf-multi-03-append.sh   |  26 +
 .../boottime/tests/bconf-multi-04-clear.sh    |  26 +
 .../boottime/tests/bconf-multi-05-conflict.sh |  22 +
 25 files changed, 1762 insertions(+), 310 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-01-default.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-01-default.debug.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.alt.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.base.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-02-select.dbg.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-03-append.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-03-append.dbg.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-04-clear.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/bconf-multi-05-conflict.bconf
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/bconf-multi-01-default.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/bconf-multi-02-select.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/bconf-multi-03-append.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/bconf-multi-04-clear.sh
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/bconf-multi-05-conflict.sh


base-commit: 56bb11fe6aacc7666938e8e6765b44aa0cf1fcdd
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

