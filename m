Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2A22A4EB;
	Thu,  5 Jun 2025 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129680; cv=none; b=fTIsNI7LcQAphL4V1sXY1lUrf22p1frS72qCqfaxKmkExidhHClo2Hy25MKDjJPSy9UZGUekBRMvny3YZKLmvzd2eD1w+2x6VpB8K9FjToZWJK91Zbv838UM0O2far+O7FTGaL2ubEGfVkMLwJ9Nb/L3H2gRUuqOXG0vn1izmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129680; c=relaxed/simple;
	bh=vx3AyTyMbsSiqF5B30zA1JnwgZnh2tHc2KRb85USan0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5VCkocj7Yg7WZgiCvFHX/GELaC/TNgNn44c7UFo0a4sidysimYPe4alNDEcQldrKYa6nNXiIPgD+Eylx7h1eKS5yTg4ptwiCHEKzbsNNF83j8VvyPAhgK80/rLobeNJSP2oUOr+Ho/CntGsk0QBwYWYwyLlCaI6O2xZRLV/aiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E323C4CEE7;
	Thu,  5 Jun 2025 13:21:18 +0000 (UTC)
Date: Thu, 5 Jun 2025 09:21:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Linux
 Regressions <regressions@lists.linux.dev>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Masami Hiramatsu <mhiramat@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Anders
 Roxell <anders.roxell@linaro.org>
Subject: Re: next-20250604: qemu-riscv64 ltp tracing warning kernel trace
 trace.c ignore_event
Message-ID: <20250605092117.37a245dd@batman.local.home>
In-Reply-To: <CA+G9fYuXxxPG7YY4ffbJ=hrBvBU4171J_FykYC2xoPV6uUB2sg@mail.gmail.com>
References: <CA+G9fYuXxxPG7YY4ffbJ=hrBvBU4171J_FykYC2xoPV6uUB2sg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Jun 2025 18:24:08 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> Regression while running LTP tracing on the Linux next-20250604 and
> next-20250605
> the following kernel warnings found on the qemu-riscv64.
> 
> Regressions found on qemu-riscv64
>  - LTP tracing
> 
> Regression Analysis:
>  - New regression? Yes
>  - Reproducibility? Yes
> 
> First seen on the next-20250604
> Good: next-20250603
> Bad:  next-20250604
> 
> Test regression: qemu-riscv64 ltp tracing warning kernel trace trace.c

Does riscv64 place __func__ in rodata? If not, this may consider the
string unsafe to use in an event. 

> ignore_event
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Test error
> 
> ------------[ cut here ]------------
> [   28.134981] event 'ma_read' has unsafe pointer field 'fn'

In lib/maple_tree.c we have:

        trace_ma_read(__func__, &mas);

Where it records the address of "__func__" into the ring buffer 'fn' field.

At a much later time (when the ring buffer is read), that pointer is
dereferenced. As rodata doesn't change for the life of the kernel, it
is safe to dereference. But if riscv doesn't place __func__ into
rodata, this will be considered unsafe to use.

-- Steve
