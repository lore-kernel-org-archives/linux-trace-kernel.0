Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5294D1EB39;
	Mon,  9 Jun 2025 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455224; cv=none; b=iSSIcdpx/NHkogStzKH6IM3ytnSLggvts3sCM0LqiR5OHdMng4LlRF8zOJhsQq1JHVAWqdabMsFqEyR6zbIEXrcYyJybW0c9M1WQJnaNtI35beug+946Bu6bcstqe+jmpBjmMvp6Q8kh8JRqHOSb1dUPMOMA3d3vs9mLT1uVw9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455224; c=relaxed/simple;
	bh=EjYiWxwuGJBa4mMQSG85+fR2fIar5kDV1gsocLjcxRE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lkWS3VvWFNJcv64I5Moidnri196EM8p3SkRgTlUJ/VfxziFQBjHpqgdWlgFh8dDWCDJCfS7Eh47PS3QYYeunqnJSZZDQfa0x9pKZD7VP58iDrHW4Q33o/fFMU7QJsDJFXbEoiMb+DXC1ZdMH248Mb2RYW9uLf1+KkVx8WlfHnOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atp8aQje; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atp8aQje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D502C4CEED;
	Mon,  9 Jun 2025 07:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749455223;
	bh=EjYiWxwuGJBa4mMQSG85+fR2fIar5kDV1gsocLjcxRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=atp8aQjetDwe3Lw/IgYCcN1a/6GwIT5uyo5GZhfrw3Nx9uqn2GQqk+7dDPhnB4uSL
	 rrs2bokC6uG5E6Lw+RVuJJJXH5/km7ugimcazdAAnQfBEEafxC4PDFByuQ1GW33UCm
	 Yto1S6ZrVqVBIjV3T1DwDiiChKC5CyA2WYfRbwffYdElEzpWMcPvQMMvONT43Da9gF
	 G4nxhgHNZz60+Cq73los/HYuTlA2ezGqeykWn5rOXYKCqDQGPrtTafIdEuLL9oeBw5
	 TehVg68F0n0fo6PghG6m5MEotsdfNgVK8XKbzcWeaXOVryR9OLew4/wDcTzKFKOGyo
	 Rx0Gg5+9TNwAA==
Date: Mon, 9 Jun 2025 16:47:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Aditya Bodkhe <adityab1@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, Hari
 Bathini <hbathini@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/fprobe: fix updated fprobe for
 function-graph tracer
Message-Id: <20250609164700.d8afe4ac1b4dea195bb7e379@kernel.org>
In-Reply-To: <20250528134820.74121-2-adityab1@linux.ibm.com>
References: <20250528134820.74121-1-adityab1@linux.ibm.com>
	<20250528134820.74121-2-adityab1@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 19:18:20 +0530
Aditya Bodkhe <adityab1@linux.ibm.com> wrote:

> From: Hari Bathini <hbathini@linux.ibm.com>
> 
> Since commit 4346ba160409 ("fprobe: Rewrite fprobe on function-graph
> tracer"), FPROBE depends on HAVE_FUNCTION_GRAPH_FREGS. With previous
> patch adding HAVE_FUNCTION_GRAPH_FREGS for powerpc, FPROBE can be
> enabled on powerpc. But with the commit b5fa903b7f7c ("fprobe: Add
> fprobe_header encoding feature"), asm/fprobe.h header is needed to
> define arch dependent encode/decode macros. The fprobe header MSB
> pattern on powerpc is not 0xf. So, define FPROBE_HEADER_MSB_PATTERN
> expected on powerpc.
> 
> Also, commit 762abbc0d09f ("fprobe: Use ftrace_regs in fprobe exit
> handler") introduced HAVE_FTRACE_REGS_HAVING_PT_REGS for archs that
> have pt_regs in ftrace_regs. Advertise that on powerpc to reuse
> common definitions like ftrace_partial_regs().
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>

This patch in this series looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

I think this series go through powerpc tree. But you have
some comments on 1/2, so please solve it at first.

Thank you,

> ---
>  arch/powerpc/Kconfig              |  1 +
>  arch/powerpc/include/asm/fprobe.h | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/fprobe.h
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9163521bc4b9..2203e4fb64c1 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -246,6 +246,7 @@ config PPC
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_GUP_FAST
>  	select HAVE_FTRACE_GRAPH_FUNC
> +	select HAVE_FTRACE_REGS_HAVING_PT_REGS
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_FUNCTION_ARG_ACCESS_API
>  	select HAVE_FUNCTION_DESCRIPTORS	if PPC64_ELF_ABI_V1
> diff --git a/arch/powerpc/include/asm/fprobe.h b/arch/powerpc/include/asm/fprobe.h
> new file mode 100644
> index 000000000000..d64bc28fb3d3
> --- /dev/null
> +++ b/arch/powerpc/include/asm/fprobe.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_PPC_FPROBE_H
> +#define _ASM_PPC_FPROBE_H
> +
> +#include <asm-generic/fprobe.h>
> +
> +#ifdef CONFIG_64BIT
> +#undef FPROBE_HEADER_MSB_PATTERN
> +#define FPROBE_HEADER_MSB_PATTERN	(PAGE_OFFSET & ~FPROBE_HEADER_MSB_MASK)
> +#endif
> +
> +#endif /* _ASM_PPC_FPROBE_H */
> -- 
> 2.43.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
