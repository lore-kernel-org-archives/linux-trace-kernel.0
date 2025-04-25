Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4647C15B543;
	Fri, 25 Apr 2025 02:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745548706; cv=none; b=DZx0dVxhMuIIQSNVAyko4DLii0J/iqpaFvqav7liPo/C3bYjMfb5hZYZczcD9TMwVliyZZ1CHypvtAsQFAr0co51Gbm0yGDjnM5NRkwGss0EKMf4cwmUNGsZRtqFzRktqUp8oV0F1Wf+yV6uMZvOOSZNg2+BjIWzs94WEuSOoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745548706; c=relaxed/simple;
	bh=UschMkblraqHY5gdJ7MXLcjHLOAy+xsSTGpDeVkHSvc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=pCtvUNQ0YabYsPEkQ4xnED4HsmH/jMfTmn2DHr7LcjRVIj4V6MUrZ+9CtvLRxCWLj9VtsboFlB4klu6p0MgLFhjDf1TY5N86YTTQtffhggfKTBGTgQtTZa6H8vEC099OtG5Qy3smGAlWk+KLcjuWRKMzmlQWdAEIpsQ2cZlZxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80768C4CEEB;
	Fri, 25 Apr 2025 02:38:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u88zG-0000000HC6R-197C;
	Thu, 24 Apr 2025 22:40:22 -0400
Message-ID: <20250425023750.669174660@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 22:37:50 -0400
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
Subject: [PATCH 0/6] [PATCH v6 0/6] x86/vdso: VDSO updates and fixes for sframes
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

 commit 0c6ae66ef164c408daeab6a61aace4b86010369a

Changes since v5: https://lore.kernel.org/all/20250422183439.895236512@goodmis.org/

- Updated change log of patch 3 to make it more of a clean up than a fix.

- Replaced $(comma} with actual comma in Makefile of the last patch.

Josh Poimboeuf (6):
      x86/vdso: Fix DWARF generation for getrandom()
      x86/asm: Avoid emitting DWARF CFI for non-VDSO
      x86/asm: Use CFI_* macros in SYM_FUNC_* macros so they can be added to VDSO
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
