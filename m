Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495541DED6D;
	Tue, 22 Apr 2025 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745346931; cv=none; b=Kou0Dppzi6U1UMMmXsQsMh1V9SWwQASW0r4c3YDd/+ZW/G1IABbonh2C/Okcw9qByLiyPQ3QB1aKNbZ/JiWi16QRHFi7xpXneot0tUJXheS1D2ERIgJlRzBAIIDwDDseY4Ed3UtmxA0tFmUcMJJgrL20z67//MuRaLKuZ2d3KNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745346931; c=relaxed/simple;
	bh=6dD9L4Ar5xunxIrVeGdzSytL7j9LfgOAxRrj5P3DFCw=;
	h=Message-ID:Date:From:To:Cc:Subject; b=RiBuEqWSVyFUASsOy1cqy82pctcvIcy1+gujo35xFlaXcRPcrYnC/DLMK1IV5lH6j7i2gOx3svwSX2rhtRXhojS2Fbz69biFFsu+lNzdA2lDRPjW35l5QwC5W2jmybCHE8MKyoeJGKkXNBz+oJelcCohWTAAuPqFR3jRALQa304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11A5C4CEEB;
	Tue, 22 Apr 2025 18:35:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u7IUk-0000000Fw6v-09ni;
	Tue, 22 Apr 2025 14:37:22 -0400
Message-ID: <20250422183439.895236512@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 22 Apr 2025 14:34:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Jens Remus <jremus@linux.ibm.com>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 0/6] x86/vdso: VDSO updates and fixes for sframes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


I'm currently working on getting sframe support from the kernel.
In order to do that, it requires some fixes. Josh Poimboeuf did
a lot of the hard work already, but he told me he doesn't have
time to continue it so I'm picking it up where he left off.

His last series of v4 is here:

  https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/

It covers a lot of topics as he found issues with other aspects of
the kernel that needed to be fixed for sframes to work properly.

This series focuses only on the VDSO code. They are helpful fixes
and updates that doesn't rely on sframes (although the last patch
is sframe related).

I based this off of the latest tip/master:

 commit 7ab869c799fc0fb22f9b4c2f36aaa603d9c7cc9d

Patch 3 (Fix VDSO DWARF generation with kernel IBT enabled) had
a bit of conflicts with a clean up patch that removed ENDBR and
should be reviewed the most to make sure I didn't break anything.

The last patch I included the suggestions made by Jens Remus.

Other than that, the patches are basically the same. Hopefully they
can get into v6.16.

Head SHA1: 2d48d5dcf5308a87d3bb34027867ee347bf4fb6b


Josh Poimboeuf (6):
      x86/vdso: Fix DWARF generation for getrandom()
      x86/asm: Avoid emitting DWARF CFI for non-VDSO
      x86/asm: Fix VDSO DWARF generation with kernel IBT enabled
      x86/vdso: Use SYM_FUNC_{START,END} in __kernel_vsyscall()
      x86/vdso: Use CFI macros in __vdso_sgx_enter_enclave()
      x86/vdso: Enable sframe generation in VDSO

----
 arch/Kconfig                             |  3 ++
 arch/x86/entry/vdso/Makefile             | 10 ++++--
 arch/x86/entry/vdso/vdso-layout.lds.S    |  5 ++-
 arch/x86/entry/vdso/vdso32/system_call.S | 10 ++----
 arch/x86/entry/vdso/vgetrandom-chacha.S  |  3 +-
 arch/x86/entry/vdso/vsgx.S               | 19 +++++------
 arch/x86/include/asm/dwarf2.h            | 54 ++++++++++++++++++++++----------
 arch/x86/include/asm/linkage.h           | 33 +++++++++++++++----
 arch/x86/include/asm/vdso.h              |  1 -
 9 files changed, 89 insertions(+), 49 deletions(-)
