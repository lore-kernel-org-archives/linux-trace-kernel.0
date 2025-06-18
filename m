Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8FB67F;
	Wed, 18 Jun 2025 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750205128; cv=none; b=ayyaM4O8WgU7P6PV6MILzbXhecYLh3qBCBBu/UM5bR6bd8FtjYAokGW4GGv4jvwwjGEfBLRFXvQumY2dLY1D0lMaNfsb6G7iozXIXkQUQPT4Yi6eQIkrukhN413Hw6YYoEkulF30hWo4drxEmedQDZWxeymj7POCxdDvliDYzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750205128; c=relaxed/simple;
	bh=kZZqKgGds/9LKl4Eq4CR1t3oOptmXoLBcMRjo5EffH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U95DWZlaqjSM43ag60GyyCMMA73wKxVtlNMmgy5C/vMKO9VQHS9OyhNClRnpEp9kNuU724PObngERvZCmV9RAJ5oVzlkU8fhMj0C9vsEnAm8B7FQba7XMdggYlXvSEA8abjSl2Hyj+tEDfyEaJqO3kVJF56Ay+6DiqOm3eIFnTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=po/KddO7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="po/KddO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66DBC4CEE3;
	Wed, 18 Jun 2025 00:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750205127;
	bh=kZZqKgGds/9LKl4Eq4CR1t3oOptmXoLBcMRjo5EffH4=;
	h=From:To:Cc:Subject:Date:From;
	b=po/KddO73azstcH/VHredA1By5o6x9TwMkK2lExf6Gg/ooCgxW9EOI4yysL5KUG9v
	 LLysquRVJsSBJjUUq01luOKe32bTmYIQxBdd9saz23B7B6IeRRq2Zpx7ke674I34jI
	 Z6tVgqxgZoB/Bf5qZgpMbPSJ8PcyJ5cYPD48gwqzILn2/aPUxtPDr0cCg27SFo3Y/R
	 4vPvTODmtpvtbh9sW0KCvJ8xFv9nnc1H2m7kBnXr1aP6MEDoQnu0FaKdbRkPE0ZbVQ
	 afeIVMTJ0clXz3PK/1actSx3+ciLCmSbN1Ah6glcAcJXEhgL1FDzbTUNLo65QWislH
	 tkeW0LcnQ6AvA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	x86@kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] x86: alternative: Fix int3 handling failure from broken text_poke array
Date: Wed, 18 Jun 2025 09:05:23 +0900
Message-ID:  <175020512308.3582717.13631440385506146631.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since smp_text_poke_single() does not expect there is another
text_poke request is queued, it can make text_poke_array not
sorted or cause a buffer overflow on the text_poke_array.vec[].
This will cause an Oops in int3 because of bsearch failing;


   CPU 0                        CPU 1                      CPU 2
   -----                        -----                      -----

 smp_text_poke_batch_add()

			    smp_text_poke_single() <<-- Adds out of order

							<int3>
                                                	[Fails o find address
                                                        in text_poke_array ]
                                                        OOPS!

Or unhandled page fault because of a buffer overflow;


   CPU 0                        CPU 1
   -----                        -----

 smp_text_poke_batch_add() <<+
 ...                         |
 smp_text_poke_batch_add() <<-- Adds TEXT_POKE_ARRAY_MAX times.

			     smp_text_poke_single() {
			     	__smp_text_poke_batch_add() <<-- Adds entry at
								TEXT_POKE_ARRAY_MAX + 1

                		smp_text_poke_batch_finish()
                        	  [Unhandled page fault because
				   text_poke_array.nr_entries is
				   overwritten]
				   BUG!
			     }


Use smp_text_poke_batch_add() instead of __smp_text_poke_batch_add()
so that it correctly flush the queue if needed.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com/
Fixes: c8976ade0c1b ("x86/alternatives: Simplify smp_text_poke_single() by using tp_vec and existing APIs")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
---
 arch/x86/kernel/alternative.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ecfe7b497cad..8038951650c6 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -3107,6 +3107,6 @@ void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, c
  */
 void __ref smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	__smp_text_poke_batch_add(addr, opcode, len, emulate);
+	smp_text_poke_batch_add(addr, opcode, len, emulate);
 	smp_text_poke_batch_finish();
 }

