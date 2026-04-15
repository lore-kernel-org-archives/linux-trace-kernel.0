Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2762C3043BE;
	Wed, 15 Apr 2026 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776235711; cv=none; b=WnJBW/SASPV7jCgCXpAcyKU/uk55YvtxzV9Q6dcVhaxIRIH0Wq2/vcPp+mhHDdDTONZ71nspCA/esFrKg0o+PCQT9DonFZzLHf6S8SY8fXkGa4Ie//RB7sLMSIWvatuExI+CmFVFyW94uGwOHFPw9V2PhlLlsNIfR/0ot84qe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776235711; c=relaxed/simple;
	bh=rPWZ6utNdK1NA62XbK2HB3jeBpHc1tnaRLYIJU9NPRM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rpulGgOaMb/M18O70Elk0b+G3BWCJovHuMnU0Dytuwguc+TvD0B+eiSdRCLH2zruk8/eMlt6LscrSUbzsDDhuwzUJafOfpFIYq1xiDzga3Z9zjChAXLGjfoo3SJV9OeX0duiyiZeHC7GTAtrNMm5tvZGeqdXYvFObcirMu1rzEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tX5ZtfES; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tX5ZtfES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830FAC19424;
	Wed, 15 Apr 2026 06:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776235710;
	bh=rPWZ6utNdK1NA62XbK2HB3jeBpHc1tnaRLYIJU9NPRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tX5ZtfESqVc6mjbOQ8XuoIm6ETLi0apv7+wh5RemrKx9i9B5kDyH/QwTQaLs3FSg8
	 Bv4DfAOaVOD/V9vjRhF3SKLKzll3UKC5NkrfK0PzN9jBQ4srAAyTuj3FcE5rLFfZbK
	 vYUChgLuTDozgtV9sTdXaWrGBN7v7g+g2gtsCbeqs/jq6E51vK4gMNuOJGdffJ6ExF
	 PUXadX24/+80Nz4HYlRcUjp5gWCF24VBUrIBwLGwSvH82nEbYuIou86+iwZuaV7/oD
	 kJii2aNkHX7/E9X7XlBuamS31y2eROtiUFBPANrMCluX3r6TT4teipjBOeAHFeEi5Y
	 5DYkd1lTwem9A==
Date: Wed, 15 Apr 2026 15:48:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sahil Siddiq <sahilcdq0@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
 naveen@kernel.org, davem@davemloft.net, peterz@infradead.org,
 jpoimboe@kernel.org, jbaron@akamai.com, rostedt@goodmis.org,
 ardb@kernel.org, chenmiao.ku@gmail.com, johannes@sipsolutions.net,
 nsc@kernel.org, masahiroy@kernel.org, tytso@mit.edu,
 linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] openrisc: Add support for KProbes
Message-Id: <20260415154826.fc8aeb67f1cb3aa58be6ac48@kernel.org>
In-Reply-To: <20260407185650.79816-1-sahilcdq0@gmail.com>
References: <20260407185650.79816-1-sahilcdq0@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Sahil,

On Wed,  8 Apr 2026 00:26:48 +0530
Sahil Siddiq <sahilcdq0@gmail.com> wrote:

> Hi,
> 
> This series adds basic support for KProbes on OpenRISC. There are
> a few changes that I would still like to add and test before this
> can be considered for merging. I was hoping to get some feedback on
> the changes made so far. The implementation in this series is based
> on KProbes for LoongArch, MIPS and RISC-V. 

Thanks for porting!
Sashiko reviewed this series, can you check the comments?
Most comments (not all) look reasonable to me.

https://sashiko.dev/#/patchset/20260407185650.79816-1-sahilcdq0%40gmail.com

Generally, please make better use of macros rather than magic values
in your code to make it easier to understand.
Also, use GENMASK() and BIT() macro to define bitmasks and bit.

Thanks,

> 
> The current state of the series allows traps to be inserted dynamically
> in the kernel. A KProbe can be inserted via a kernel module whose
> init/exit functions are used to register/unregister a KProbe. A pre-
> handler and post-handler can also be provisioned in the module, which
> are associated with the KProbe and triggered when the probe is hit. See
> the documentation on KProbes for a detailed explanation [1].
> 
> The following are yet to be implemented for OpenRISC:
> 1. kretprobes
> 2. kprobe-based event tracing
> 3. ftrace, and kprobe features that depend on ftrace (particularly,
> dynamic tracing)
> 
> I hope to submit a patch for kretprobes soon (possibly in a revision of
> this series).
> 
> I wrote a couple of kernel modules to test these changes. They can be found
> here [2]. I also ran test_kprobes located at ./lib/tests/ against these
> changes [3]. The results are as shown below:
> 
> /home # insmod test_kprobes.ko 
> KTAP version 1
> 1..1
>     KTAP version 1
>     # Subtest: kprobes_test
>     # module: test_kprobes
>     1..3
>     ok 1 test_kprobe
>     ok 2 test_kprobes
>     ok 3 test_kprobe_missed
> # kprobes_test: pass:3 fail:0 skip:0 total:3
> # Totals: pass:3 fail:0 skip:0 total:3
> ok 1 kprobes_test
> /home # 
> 
> When compiling the kernel, the following options should be enabled:
> 1. CONFIG_HAVE_KPROBES=y
> 2. CONFIG_KPROBES=y
> 
> Also ensure that CONFIG_KPROBE_EVENTS is disabled.
> 
> To compile /lib/tests/test_kprobes.c, add the following to .config:
> 1. CONFIG_KUNIT=y
> 2. CONFIG_DEBUG_KERNEL=y
> 3. CONFIG_KPROBES_SANITY_TEST=m
> 
> The first commit cleans up and reorganizes existing functions, fixes
> a few issues with instruction simulation, and introduces new structures
> and macros that will be used by KProbes and other tracing facilities
> in the future.
> 
> The second commit adds support for KProbes. Currently, I have
> implemented this in such a way that KProbes can't be used to probe
> a few "blacklisted" instructions. Probes can't be inserted in a delay
> slot either (similar to MIPS). I have also added a few asm functions
> to the blacklist that I think should not be probed. For e.g., "memset"
> and "_trap_handler" have been blacklisted because probing them causes
> the kernel to hang. However, I am not sure if other functions in "entry.S"
> need to be added as well to the blacklist.
> 
> Thanks,
> Sahil
> 
> [1] https://www.kernel.org/doc/html/latest/trace/kprobes.html
> [2] https://github.com/valdaarhun/or-dev/tree/main/home
> [3] https://github.com/openrisc/linux/blob/for-next/lib/tests/test_kprobes.c
> 
> Sahil Siddiq (2):
>   openrisc: Add utilities and clean up simulation of instructions
>   openrisc: Add KProbes
> 
>  arch/openrisc/Kconfig                   |   1 +
>  arch/openrisc/configs/or1ksim_defconfig |   2 +
>  arch/openrisc/configs/virt_defconfig    |   2 +
>  arch/openrisc/include/asm/asm.h         |  22 ++
>  arch/openrisc/include/asm/break.h       |  19 ++
>  arch/openrisc/include/asm/insn-def.h    |  61 +++-
>  arch/openrisc/include/asm/kprobes.h     |  76 +++++
>  arch/openrisc/include/asm/spr_defs.h    |   1 +
>  arch/openrisc/kernel/Makefile           |   3 +-
>  arch/openrisc/kernel/entry.S            |  16 +
>  arch/openrisc/kernel/insn.c             |  74 +++++
>  arch/openrisc/kernel/jump_label.c       |   2 +-
>  arch/openrisc/kernel/kprobes.c          | 381 ++++++++++++++++++++++++
>  arch/openrisc/kernel/traps.c            |  67 ++---
>  arch/openrisc/lib/memcpy.c              |   2 +
>  arch/openrisc/lib/memset.S              |   4 +
>  arch/openrisc/mm/fault.c                |   5 +
>  samples/kprobes/kprobe_example.c        |   8 +
>  18 files changed, 701 insertions(+), 45 deletions(-)
>  create mode 100644 arch/openrisc/include/asm/asm.h
>  create mode 100644 arch/openrisc/include/asm/break.h
>  create mode 100644 arch/openrisc/include/asm/kprobes.h
>  create mode 100644 arch/openrisc/kernel/insn.c
>  create mode 100644 arch/openrisc/kernel/kprobes.c
> 
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
