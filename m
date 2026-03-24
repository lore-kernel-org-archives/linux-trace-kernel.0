Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61BD1FC8;
	Tue, 24 Mar 2026 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310423; cv=none; b=aUx4TgXAzqsu+XtBthHQDEpp90oeTjHjBsTj0nM9uZxwl3xjQ4DHWU/wJvdU04P1Yeg2skE2TLAGkchfLxVf+SmYv7ZEMsQvmHoAl+dwJ/RBKAbW5CuUxIfcm/GjMDsKBw+Ft6dkEO+HUOG6EdDIvt6SY1HDJ6tPt3Wvsx5C1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310423; c=relaxed/simple;
	bh=BQDOy9r+fV2+uNR5ku1dL3si6189g6mI5hbOGf0eN8I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=t7QK+XT15GX1ShfWbvPdYPsSSZZzDdJjfuiUAxZAWTCmEXklcMD5kwOQLMQhtjfa+yzADLBuaQA6nRaDovLE+PC/VazvSEvG0BK1b+QSXVqgxibcEsdptgwJCn9xmZ7+4du6ub1ZDOnJXnUpaGWsSsRmMVCCC7ZtG1xHaXO7Bqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEO94EX9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEO94EX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D667C4CEF7;
	Tue, 24 Mar 2026 00:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774310423;
	bh=BQDOy9r+fV2+uNR5ku1dL3si6189g6mI5hbOGf0eN8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cEO94EX9N8HX/zlhknYhYohCeDg+qhVvrZezxlBS0/it+v7ayC0wfyRTdc0m8dT8m
	 589MgEiU2R3K2lUhOfsM5kr9tjvhH54fxaFGG2dPz/qgOBUjMCEXyrHepPGItb0/R3
	 RDTvsa4v32Qn3m9Az3QFgvGlaqZl5psGocknYh2e7sHol+cwxQMZoRydegCyNTdgub
	 CUSJelFyc0rT94Sqb0jNtYlm17Ie0QgYlR6jyYd1a9w5qO+7nbmnffPr93GPl9bgpf
	 tZdKgyjJgCHdWYFptb9U5NTztRdFd7frbFUb6a9Uwe6FdLBmeUqIll6OLtiHmXLU8+
	 EDlBc9eVsgL7A==
Date: Tue, 24 Mar 2026 09:00:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v11 0/4] ring-buffer: Making persistent ring buffers
 robust
Message-Id: <20260324090020.90a472500c0c4fa73ef6868c@kernel.org>
In-Reply-To: <177426904455.3236905.2079719303397330696.stgit@mhiramat.tok.corp.google.com>
References: <177426904455.3236905.2079719303397330696.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Oops. This is v12. Ignore this.


On Mon, 23 Mar 2026 21:30:45 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 12th version of improvement patches for making persistent
> ring buffers robust to failures.
> The previous version is here:
> 
> https://lore.kernel.org/all/177391152793.193994.8986943289250629418.stgit@mhiramat.tok.corp.google.com/
> 
> 
> In this version, I rebased it on tracing/fixes branch (thus
> the first fix patch has been removed) and fixed
> a build error which came from a copy-paste mistake.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (4):
>       ring-buffer: Flush and stop persistent ring buffer on panic
>       ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
>       ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
>       ring-buffer: Add persistent ring buffer selftest
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
>  kernel/trace/Kconfig                 |   15 ++
>  kernel/trace/ring_buffer.c           |  237 ++++++++++++++++++++++++++--------
>  kernel/trace/trace.c                 |    4 +
>  26 files changed, 241 insertions(+), 59 deletions(-)
>  create mode 100644 arch/arm64/include/asm/ring_buffer.h
>  create mode 100644 include/asm-generic/ring_buffer.h
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
