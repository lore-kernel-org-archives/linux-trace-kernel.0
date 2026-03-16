Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AB1359A76;
	Mon, 16 Mar 2026 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703311; cv=none; b=t5VhOTDK7IHM7kQUXlRrvK+kCOB37EsayNAjD66GpqcRw9FPon/FVIVRtEf0o1N0intqbhal8j/ZtrSgvFtt66+2wbin32Ie77ii2i7oI9OMZk2rKE4NYZk2eEMvXcOTqYfxFRk1Ay9g38tBlt4riv0KCRSECdGE3rzVvVcI3Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703311; c=relaxed/simple;
	bh=AxYtMQ2Nom5pkj1pM4xTyRNeKqbtPrG6JSLZZ8+oCg8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dyvdpFtHvro9xlrgQe1k/L66yTHxZld0mH/WfsZg5g9HBQHEdbO68CXg+jXVqQlFtj+wy6XcHcxl+Rq0vRP/5U0e+vbeCkglOaADFsTv2/TNJTL7NCBhrsrDQyIj0znlY/NtGXlI3pBnQrG9HGZUhIr3EfTo6fhMxayUVSIdG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLdJEooH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLdJEooH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB15CC19421;
	Mon, 16 Mar 2026 23:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773703310;
	bh=AxYtMQ2Nom5pkj1pM4xTyRNeKqbtPrG6JSLZZ8+oCg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LLdJEooHT6pb3Z9svL8tq2pq5ODZ502u4EXJAqClwYkhkAYkw+k+G6vuWHk9PDhEK
	 bhsATkoSgRfy9LJoo4H1ApGlTXnz/qSGxTFQ9nh0MJ3ugAjq2rkWg7IJ+m266/nMqb
	 nv0z7nIRQRdwxCrZ+Ma35VdW2f9lCx2+QaIrINr5hghEeXunwapqmj0oc7LzvUQGf9
	 C33W6TaHs/1VQtc+HFskZyJq8o/KhCIF/ynxuFuihavCks8x4FyjCDCQfl73+nXw0i
	 O8r3SIZ8FRVegg4RkcfJXAJA5xld69UCSGJseX72yUBejIMqB4XajiCznznOdpGGzr
	 SLyH1eu80gq5A==
Date: Tue, 17 Mar 2026 08:21:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v9 0/4] ring-buffer: Making persistent ring buffers
 robust
Message-Id: <20260317082148.a54ae29a7c991cea149d8f1b@kernel.org>
In-Reply-To: <177319273059.130641.10882692460536780093.stgit@mhiramat.tok.corp.google.com>
References: <177319273059.130641.10882692460536780093.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Mar 2026 10:32:11 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 9th version of improvement patches for making persistent
> ring buffers robust to failures.
> The previous version is here:
> 
> https://lore.kernel.org/all/177303264034.767813.5345788067082238396.stgit@mhiramat.tok.corp.google.com/
> 
> In this version, I fixed bugs/typos in [2/4][3/4] and add a bugfix patch
> [1/4] and a test[4/4]. Also, add a meta->subbuf_size validation[3/4].

Hmm, the test case fails if rewinding happens, because the 
data_page validation failed in rewinding and stop rewinding.
The test may need to be designed more carefully.
Others looks good to me.

Thanks,

> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (4):
>       ring-buffer: Fix to update per-subbuf entries of persistent ring buffer
>       ring-buffer: Flush and stop persistent ring buffer on panic
>       ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
>       ring-buffer: Add persistent ring buffer selftest
> 
> 
>  arch/alpha/include/asm/Kbuild        |    1 
>  arch/arc/include/asm/Kbuild          |    1 
>  arch/arm/include/asm/Kbuild          |    1 
>  arch/arm64/include/asm/ring_buffer.h |   10 ++
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
>  include/asm-generic/ring_buffer.h    |   13 +++
>  include/linux/ring_buffer.h          |    1 
>  kernel/trace/Kconfig                 |   15 +++
>  kernel/trace/ring_buffer.c           |  169 ++++++++++++++++++++++++++--------
>  kernel/trace/trace.c                 |    4 +
>  26 files changed, 192 insertions(+), 40 deletions(-)
>  create mode 100644 arch/arm64/include/asm/ring_buffer.h
>  create mode 100644 include/asm-generic/ring_buffer.h
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
