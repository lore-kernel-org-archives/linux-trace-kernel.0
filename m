Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BCE36D9EE;
	Fri, 24 Apr 2026 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014402; cv=none; b=ZbVtCu1z3OiL1/hhI3pxb/RSg38vXOdLfGDC6FyKOs94626H7aYA7aW13FFazT0iJN00/buxeXhc32VAOOLOCFB0hiHTOEwFQPgWxJaucNVEnzlY9iT003i1dzYyJxG3cjEYvuNUyYkI1eKlPNCsqmR4HhK7BN2PV5DSSgLDUZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014402; c=relaxed/simple;
	bh=TmX8gnlQzrvHw83tZno67tfF8CIFAFoS4SrixL+jdmU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NaWfAxhy1EjXeE0J8s+nh1WZGG/W1S/aYwFsBd+XjSl2ssBwKamxIvdGYxYQArJ2yo3WLDJyey2MrkFW63UR98deqWPawYmMNfAvtmhLvZBOD2vRvQuC/T51lzima/FPxgUrTsI0kp5yk3j2y70Z14H1k1RXKvJDNDMSnVfjRAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYBVy+yL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYBVy+yL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C553C4AF0B;
	Fri, 24 Apr 2026 07:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777014402;
	bh=TmX8gnlQzrvHw83tZno67tfF8CIFAFoS4SrixL+jdmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CYBVy+yLqbqsoQniZcJDsow97WhQ/imgTiJHRnvl0GKUMDCrftQjAZ89QZPbuItFz
	 lLfr61nzZg0wRCHx7fcAKrZyEBfzFNZZ/MU2SwFxVHwECeddDJIRCagNpZLxN9d0h5
	 P1JULOdLoFm+M240dG7aLGle7Z5RC5pWb6d0PGugwtTrL3FwTaNAhdFAsLfVVpMzkd
	 4Dq1SdO8HoyiBvtgc5CLTRPM+Y1zZ4sLkkZMvsgMzH2PGFiz82oSmuozIkdZVMatfe
	 dSBWWi6H6d4zpdglAq7iR1S7t/+UDhEf85PpVgSTNtQTuQphE8vJ4ouy9zkJ8PlhEp
	 2rQj0PAeql1Yw==
Date: Fri, 24 Apr 2026 16:06:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 0/8] ring-buffer: Making persistent ring buffers
 robust
Message-Id: <20260424160639.1a65e2f1ed2dbe780e6a1e95@kernel.org>
In-Reply-To: <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
References: <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

I added a fix related this series as the 1st one. It can be merged
independently.

Thanks,

On Fri, 24 Apr 2026 15:51:59 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 18th version of improvement patches for making persistent
> ring buffers robust to failures.
> The previous version is here:
> 
> https://lore.kernel.org/all/177687458572.932171.10907864814735342737.stgit@mhiramat.tok.corp.google.com/
> 
> This version fixes a newly found bug and some review comments from
> Sashiko[1], also, add 2 cleanups, which includes:
> [1/8] Do not double count the reader_page when verifying persistent
>       ring buffer.
> [2/8] Add Geert's Ack (Thanks!)
> [3/8] Fix to substract BUF_PAGE_HDR_SIZE from meta->subbuf_size
>       to make the limit of commit size.
> [4/8] Reset timestamp of reader_page when the entire cpu_buffer is
>       invalid.
> [5/8] In rb_test_inject_invalid_pages(), changed entry_bytes and
>       idx to unsigned long.
> [7/8] Cleanup persistent ring buffer validation code.
> [8/8] Cleanup buffer_data_page related code.
> 
> [1] https://sashiko.dev/#/patchset/177687458572.932171.10907864814735342737.stgit%40mhiramat.tok.corp.google.com
> 
> Thank you,
> 
> Masami Hiramatsu (Google) (8):
>       ring-buffer: Do not double count the reader_page
>       ring-buffer: Flush and stop persistent ring buffer on panic
>       ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
>       ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
>       ring-buffer: Add persistent ring buffer invalid-page inject test
>       ring-buffer: Show commit numbers in buffer_meta file
>       ring-buffer: Cleanup persistent ring buffer validation
>       ring-buffer: Cleanup buffer_data_page related code
> 
> 
>  arch/alpha/include/asm/Kbuild        |    1 
>  arch/arc/include/asm/Kbuild          |    1 
>  arch/arm/include/asm/Kbuild          |    1 
>  arch/arm64/include/asm/ring_buffer.h |   10 +
>  arch/csky/include/asm/Kbuild         |    1 
>  arch/hexagon/include/asm/Kbuild      |    1 
>  arch/loongarch/include/asm/Kbuild    |    1 
>  arch/m68k/include/asm/Kbuild         |    1 
>  arch/microblaze/include/asm/Kbuild   |    1 
>  arch/mips/include/asm/Kbuild         |    1 
>  arch/nios2/include/asm/Kbuild        |    1 
>  arch/openrisc/include/asm/Kbuild     |    1 
>  arch/parisc/include/asm/Kbuild       |    1 
>  arch/powerpc/include/asm/Kbuild      |    1 
>  arch/riscv/include/asm/Kbuild        |    1 
>  arch/s390/include/asm/Kbuild         |    1 
>  arch/sh/include/asm/Kbuild           |    1 
>  arch/sparc/include/asm/Kbuild        |    1 
>  arch/um/include/asm/Kbuild           |    1 
>  arch/x86/include/asm/Kbuild          |    1 
>  arch/xtensa/include/asm/Kbuild       |    1 
>  include/asm-generic/ring_buffer.h    |   13 +
>  include/linux/ring_buffer.h          |    1 
>  kernel/trace/Kconfig                 |   34 ++
>  kernel/trace/ring_buffer.c           |  472 +++++++++++++++++++++++-----------
>  kernel/trace/trace.c                 |    4 
>  26 files changed, 395 insertions(+), 159 deletions(-)
>  create mode 100644 arch/arm64/include/asm/ring_buffer.h
>  create mode 100644 include/asm-generic/ring_buffer.h
> 
> 
> base-commit: 6170922f137231b98fc568571befef63e1edff3f
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
