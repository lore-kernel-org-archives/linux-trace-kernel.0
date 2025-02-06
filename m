Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BDE42AB4;
	Thu,  6 Feb 2025 04:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738815438; cv=none; b=f44Pffde+UBLjwq5/YrnMo4kgXhndPkMChrczRTcBDUSS6QX2W2oIN/psGWhoNIDe9xL/DsPWcCls9GUz2Qaxz+7PtVc1sKkuhex+D3x8Efxw13i3bom55Z574sIr1xaeICnDMmTkYN4Ww16nucmGf6qn6WghguiH3W24Zn/zxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738815438; c=relaxed/simple;
	bh=HCq5b0fDR0TmfBCtLQJgUTCL8Se2exjE7cI0z7FCH5Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fC+WEOeW+OyW3f5l2kRBkcj2+r2hJTXlXlb8vKFXQK1ykq88FW2tXwx+AOwXeART77AoKDgC56wmxG9Du6zKRZUpC5Z4qWSyHOwUdVOmAKN4I9b9r0L7F8Bmo1OwHdBFtx+7d4EdVAXinFiewB2aB5BS6OuMw2mqensRmyx16vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2Q/Gl6h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2Q/Gl6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBAFC4CEDD;
	Thu,  6 Feb 2025 04:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738815436;
	bh=HCq5b0fDR0TmfBCtLQJgUTCL8Se2exjE7cI0z7FCH5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O2Q/Gl6hBJbueVxCp+5BLPjn4hq/5oezqB0gdyWfqNFZFlKahL8sBCNM/DRKN0ITL
	 LKi17iHZerhO9d0FbdcGSjWdW/5rKBPBriWbIA9IId47+B8P/I21oVfeoASVuNSAsG
	 qhRFZqsSTqhpna2GxT6mWrP6StQma8VmaEfPLN/aZ3JQKhknvVANYGvtfq9ux/ufO1
	 6P58hXcVosIsRgSMX2IMkOg2cFm3EL4JARUwuy67H1T8cNBXt71YRn6K7qqBQFCMOs
	 LzhVRx2dzwBdDVpgzw7Y5But3K6l9JIkbrwMkQLLuEZlpFbAvDyJggpOKDftpGnjig
	 mWTlBT6mRt9qQ==
Date: Thu, 6 Feb 2025 13:17:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Haiyue Wang <haiyuewa@163.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
 linux-trace-kernel@vger.kernel.org, samitolvanen@google.com, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "open list:FUNCTION HOOKS (FTRACE)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ftrace: Fix compile error when CONFIG_GENDWARFKSYMS
 is enabled
Message-Id: <20250206131711.ea536f165d5b5980b3909acd@kernel.org>
In-Reply-To: <767d054d-1d00-40bb-b8c7-0e990b1578b9@163.com>
References: <20250205180116.88644-1-haiyuewa@163.com>
	<20250206093853.4e55405ccfcba7111705f395@kernel.org>
	<20250205195300.42d3e3b0@gandalf.local.home>
	<20250206114529.d2483df2c9d09726f1f3a43d@kernel.org>
	<767d054d-1d00-40bb-b8c7-0e990b1578b9@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 11:23:02 +0800
Haiyue Wang <haiyuewa@163.com> wrote:

> 
> 
> On 2025/2/6 10:45, Masami Hiramatsu (Google) wrote:
> > On Wed, 5 Feb 2025 19:53:00 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> >> On Thu, 6 Feb 2025 09:38:53 +0900
> >> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >>
> >>> Thanks for the fix. And this fixes one of problems.
> >>> Another one is that `is_endbr()` is defined in <asm/ibt.h> but that also depend
> >>> on CONFIG_HAVE_FENTRY.
> >>>
> >>> Let's pick this and fix above issue.
> >>
> >> OK, I'll pull this into my urgent tree and start testing it.
> > 
> > Sorry, Gabriel found another issue.
> > Let me fix this instead of this patch.
> > 
> > https://lore.kernel.org/all/CAFEugPfFykYsHqS-J36CNWDn+d34bSQg-e5hJ=AaJPC8=6Ej-g@mail.gmail.com/
> > 
> 
> If I put the fix above '#ifndef __ASSEMBLY__', then I can reproduce 
> Gabriel's founding:
> 

Yeah, thanks. Anyway, I would not like introduce header file dependency
too much, especially header files under asm.
Please check below my fix;

https://lore.kernel.org/all/173881156244.211648.1242168038709680511.stgit@devnote2/

Thank you,

> +#ifdef CONFIG_X86_KERNEL_IBT
> +#include <linux/uaccess.h>
> +#endif
> +
>   #ifndef __ASSEMBLY__
> 
> 
> In file included from ./include/linux/kcsan-checks.h:13,
>                   from ./include/linux/instrumented.h:12,
>                   from ./include/linux/uaccess.h:6,
>                   from ./arch/x86/include/asm/ftrace.h:26,
>                   from arch/x86/kernel/ftrace_64.S:11:
> ./include/linux/compiler_attributes.h:91:20: error: missing binary 
> operator before token "("
>     91 | #if __has_attribute(__copy__)
>        |                    ^
> ./include/linux/compiler_attributes.h:103:20: error: missing binary 
> operator before token "("
>    103 | #if __has_attribute(__diagnose_as_builtin__)
>        |                    ^
> ./include/linux/compiler_attributes.h:126:20: error: missing binary 
> operator before token "("
>    126 | #if __has_attribute(__designated_init__)
>        |                    ^
> ./include/linux/compiler_attributes.h:137:20: error: missing binary 
> operator before token "("
>    137 | #if __has_attribute(__error__)
>        |                    ^
> 
> 
> >>
> >> -- Steve
> > 
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
