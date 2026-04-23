Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6753236AB5B;
	Thu, 23 Apr 2026 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932764; cv=none; b=kyWvMNmRDSGMEZyAPCWFdA7Gu9l5oh5qU0F4Z19wLFZQfrxHJ2eTS4A1BJyzCIDYYJP6UctnEddOMG3Gs10kAG6+tBKVZaIosIrpL8lQrQCMSr7Pk7SGRId270ML8ree5dtD+8KQmypv7HSqsHwqvMgVLhV/wmAoFyjNmFV+H4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932764; c=relaxed/simple;
	bh=IjL8twB+4d9z4gO+zDoSjmB2/hJ0XW6r2E+wUwSomso=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jQzhqPMWPJIRiwJ7dppyQje+cH62I0yCX1QxNhU+g9BAgZGZPwbCDFCe97F4k7ZBMmlf03H9N+qrJwzoJ0U+W/Oy2rTpTGqAs0zcJNxKy3ib0VByutmefViqFWWIoOJDnwtWxxJro1SX4a2NlRBmDhLiRXyRcJP5YWUIMetfULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTYKDCTz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTYKDCTz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD419C2BCAF;
	Thu, 23 Apr 2026 08:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776932763;
	bh=IjL8twB+4d9z4gO+zDoSjmB2/hJ0XW6r2E+wUwSomso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OTYKDCTzOUzTH4mt3kNkQ8qy0pysslUAGpHK6g0dZ6Qscu1saFiktKCF6yFfNUEwh
	 TxPdidgm8eInOeaNdayfmqU0RevjYbNYROwkoxVFNsYs8Blp54fU0Z58ydpUzKM9YF
	 T/Dx0GXkRLJr4Tj+FdSQljoKYAwrVWIjMx3A+RATNsLweYNfKW68+DXn98PCs4usow
	 eOBlcLgb8ttn7i60oG+d/HSzt2lbVDqi75OrlEjC22DkvWZA1IIb8uVfbdDO8Yi30f
	 VwNbZctEQuC0XOZlhHiGNq8p09FQ1S9OmWzjsHvizsTj6C59yRdplG7X26eu0bvrJQ
	 29SUM8xi6h+9A==
Date: Thu, 23 Apr 2026 17:26:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v17 0/5] ring-buffer: Making persistent ring buffers
 robust
Message-Id: <20260423172601.735884be696225c050566060@kernel.org>
In-Reply-To: <177687458572.932171.10907864814735342737.stgit@mhiramat.tok.corp.google.com>
References: <177687458572.932171.10907864814735342737.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Sashiko[1] pointed out other problems. Let me review it.
I also found one mistake (not by this series), so I will fix it too.

[1] https://sashiko.dev/#/patchset/177687458572.932171.10907864814735342737.stgit%40mhiramat.tok.corp.google.com

Thanks,

On Thu, 23 Apr 2026 01:16:26 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 17th version of improvement patches for making persistent
> ring buffers robust to failures.
> The previous version is here:
> 
> https://lore.kernel.org/all/177547105523.259641.14385891517704197263.stgit@mhiramat.tok.corp.google.com/
> 
> This version fixes some review comments from Sashiko[1], which
> includes:
> [2/5] Fix to use rb_page_size() of rewound pages for entry_bytes.
> [3/5] - Fix to verify head_page at first before using its timestamp.
>       - Reset timestamp if the page is invalid.
> [4/5] - In rb_test_inject_invalid_pages(), changed entry_bytes and
>        idx to unsigned long
>       - Added NULL checks for cpu_buffer and meta.
>       - In allocate_trace_buffer(), added a NULL check for tr->name
>        before comparing it with strcmp.
> [5/5] Added NULL check for dpage in rbm_show in ring_buffer.c.
> 
> [1] https://sashiko.dev/#/patchset/177552432201.853249.5125045538812833325.stgit%40mhiramat.tok.corp.google.com
> 
> Thank you,
> 
> Masami Hiramatsu (Google) (5):
>       ring-buffer: Flush and stop persistent ring buffer on panic
>       ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
>       ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
>       ring-buffer: Add persistent ring buffer invalid-page inject test
>       ring-buffer: Show commit numbers in buffer_meta file
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
>  include/asm-generic/ring_buffer.h    |   13 ++
>  include/linux/ring_buffer.h          |    1 
>  kernel/trace/Kconfig                 |   34 ++++
>  kernel/trace/ring_buffer.c           |  275 ++++++++++++++++++++++++++--------
>  kernel/trace/trace.c                 |    4 
>  26 files changed, 290 insertions(+), 67 deletions(-)
>  create mode 100644 arch/arm64/include/asm/ring_buffer.h
>  create mode 100644 include/asm-generic/ring_buffer.h
> 
> 
> base-commit: 6170922f137231b98fc568571befef63e1edff3f
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
