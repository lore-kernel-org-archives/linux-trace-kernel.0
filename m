Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03099847B;
	Tue, 17 Sep 2024 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726550265; cv=none; b=DNaIARyl9WVYxy8NjsVtlV5Idqi1D9shB69QC1WJwH893XqAqhyVD8q2rosHSQwc8B2XHfgVXcHkB6W8Vc0lHhyFTczKsHGnvUn/kNT3MOQO33C8ZKNbarqmi7uGpO3kpHNO9bedLISrYRwywoIRizFTrO+pOf5vY8xvBIi/7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726550265; c=relaxed/simple;
	bh=XmLK79IKgo9Gfd5FfkuNV6VY0ioNZxix7rJzS2arwro=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GHFjXAWuNSypPn9tPlf0ZzgfmxL9iLBekaP+wGve+HH04bjMbFiTL10wnflOp4no+aib3I0DnsZWKdUTUeC5VZh/8bAJ4uwP2zFqULIdAtqN4V36QiM9+0LFDDhWxmYxErStI9X3Ho69Vk/0+hs0iSkcqAOAdzVFgNAG2n/RqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWznCF0g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWznCF0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1A2C4CEC6;
	Tue, 17 Sep 2024 05:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726550264;
	bh=XmLK79IKgo9Gfd5FfkuNV6VY0ioNZxix7rJzS2arwro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IWznCF0guh0gFiZe98GjRWm+06DKn/OTHi2IRvqe2HEA0VgAYHBQpBOUwGYMFm9YZ
	 JCbAnU0EhpBJwLkyS/AbJ2H5tGCEWQrYGcvbdZIlhSfVvTWCEFDrLyb+TqxlqNQii3
	 gBFyvlxiRpxgSvGlabRbiADdMdBGI+AOtW3xyVUSwFodgwzghMBKavaj+COuDA+roS
	 oV4KU+ldALC/f0WwlLFjKFuFkMgI8qepqslWemTH+xMDVLYih9Yqs00qIQBnbdMHlz
	 91UPzorBVI8bd0ieQCao07QzGwmmctnnqDRskO6irvu9e0M52LvZvuXV7jPdrMbDVx
	 OiNXmKH7oCbHA==
Date: Tue, 17 Sep 2024 14:17:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/ftrace: Include <asm/ptrace.h>
Message-Id: <20240917141736.e24ca6004730435676031997@kernel.org>
In-Reply-To: <20240916221557.846853-2-samitolvanen@google.com>
References: <20240916221557.846853-2-samitolvanen@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 22:15:57 +0000
Sami Tolvanen <samitolvanen@google.com> wrote:

> <asm/ftrace.h> uses struct pt_regs in several places. Include
> <asm/ptrace.h> to ensure it's visible. This is needed to make sure
> object files that only include <asm/asm-prototypes.h> compile.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/x86/include/asm/ftrace.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 0152a81d9b4a..b4d719de2c84 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_X86_FTRACE_H
>  #define _ASM_X86_FTRACE_H
>  
> +#include <asm/ptrace.h>
> +
>  #ifdef CONFIG_FUNCTION_TRACER
>  #ifndef CC_USING_FENTRY
>  # error Compiler does not support fentry?
> 
> base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8
> -- 
> 2.46.0.662.g92d0881bb0-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
