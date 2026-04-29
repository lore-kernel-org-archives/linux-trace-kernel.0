Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B8337BA6;
	Wed, 29 Apr 2026 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451246; cv=none; b=QVxm9s9AUtzm3N30YBfDkGF1747WOw/DDlftYENFVPBU373Jqg0+T2o7UCN4/7xhRrWoOPIX5a3sGotkiebjfvCk/d+7Ui1P8XQUe6dL5Z5AlJaZLOWVkIXqe3xt8ySqbmc13l2Ta0lTrqtp8Is1zPHZo+kEQ5vcPmeB6BLgDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451246; c=relaxed/simple;
	bh=o+95Ucj/ynt4ViFziBMatxXxyRFitCLjco50gPOP+QM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AJrTaPxmmNRyBV7vf7DJfDByp4tdcrNaxfXoI7z6fTAsarpD98xCSoX6mWHjAjk+IEnZD5Ro2ojrRURtxXmHxoWMPtBvb+gLjAYc5LzziTkDgSgzl2pbPM0mV/Bl1a1YGUsTLSjC8z5/4pNcB85v3RBru7twig7xPmp3doXc5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GghI29wV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GghI29wV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AB7C19425;
	Wed, 29 Apr 2026 08:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777451245;
	bh=o+95Ucj/ynt4ViFziBMatxXxyRFitCLjco50gPOP+QM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GghI29wV3liS6tk/yt9RyJ/dltOARO+U/Vj/ZYZ0PsDVu2vLLqbzdQ8OqDthKGB6a
	 I95+zMxZar6e5aqmVdBbjVYS+LNFnRgEroAj7ZQxrNAbs9tPIHN53jcVbXLPJGLaMp
	 gGZ+WKyYLmrfLIErximFzguSl87Bp9/HzTcDAFGl3efBfGsHGd3ruM4lF6gYtpgBRH
	 2wCPvDc3Rn+GM94i1MxZOR4Xq3u6AXqEwFDOGXPbLu3UufvU6yjxm/vG7kcKgpPp7J
	 jAoQpITMwtu74CfG+T+gyRMEk+O7MmbhYY+7lHoL5HfumzgGYYL7hN0Ix79n7N0SRB
	 X8UejAqSzw9zg==
Date: Wed, 29 Apr 2026 17:27:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, oss@malat.biz,
 paulmck@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/3] init: use static buffers for bootconfig extra
 command line
Message-Id: <20260429172721.c89072381aa98d1090ad383f@kernel.org>
In-Reply-To: <aeJH8mhxqrwdsjxc@gmail.com>
References: <20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org>
	<20260415-bootconfig_earlier-v1-2-cf160175de5e@debian.org>
	<20260417104436.ece29fd5e2cb7a59c8cf8ac1@kernel.org>
	<aeJH8mhxqrwdsjxc@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 Apr 2026 08:38:16 -0700
Breno Leitao <leitao@debian.org> wrote:

> 
> On Fri, Apr 17, 2026 at 10:44:36AM +0900, Masami Hiramatsu wrote:
> > On Wed, 15 Apr 2026 03:51:11 -0700
> > Breno Leitao <leitao@debian.org> wrote:
> >
> > But if we can do it, should we continue using bootconfig? I mean
> > it is easy to make a tool (or add a feature in tools/bootconfig)
> > which converts bootconfig file to command line string and embeds
> > it in the kernel. Hmm.
> 
> Sure, you are talking about a a tool that embeddeds it in the kernel binary,
> something like:
> 
> 
> 0) Get a kernel and define CONFIG_BOOT_CONFIG_EMBED_FILE=".bootconfig"
> 
> 1) Add an option in tools/bootconfig to convert bootconfig (.bootconfig)
>    to a cmdline string ($ bootconfig -C kernel .bootconfig).
>    Something like:
>    # tools/bootconfig/bootconfig -C kernel .bootconfig
>      mem=2G loglevel=7 debug nokaslr %
> 
> 2) At kernel build time, run that tool on .bootconfig and embed the
>    resulting string into the kernel image as a .init.rodata symbol
>    (embedded_kernel_cmdline[]).
> 
>    # gdb -batch -ex 'x/s &embedded_kernel_cmdline' vmlinux
>    0xffffffff87e108f8:    "mem=2G loglevel=7 debug nokaslr "

Yeah, I think this looks good to me.

> 
> 3) At boot, the arch's setup_arch() prepends that symbol to
>    boot_command_line right before parse_early_param() — so early_param()
>    handlers (mem=, earlycon=, loglevel=, ...) actually see kernel.*
>    keys from the embedded bootconfig.

Ah, I thought it is arch independent config, but it depends on
architecture.... Hmm.

> 
>    This needs to be architecture by architecture. Something like:
> 
> 	@@ -924,6 +925,13 @@ void __init setup_arch(char **cmdline_p)
> 		builtin_cmdline_added = true;
> 	#endif
> 
> 	+       /*
> 	+        * Prepend kernel.* keys from the embedded bootconfig (rendered at
> 	+        * build time by tools/bootconfig) so parse_early_param() below sees
> 	+        * them. No-op when CONFIG_BOOT_CONFIG_EMBED=n.
> 	+        */
> 	+       xbc_prepend_embedded_cmdline(boot_command_line, COMMAND_LINE_SIZE);
> 	+
> 		strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
> 		*cmdline_p = command_line;
> 
> Am I describing your suggestion accordingly?

I think we can start supporting this option for the architecture which 
already support CONFIG_CMDLINE. Maybe we need CONFIG_ARCH_SUPPORT_CMDLINE
option which indicates the architecture supports embedded cmdline.

Thus all of this feature can depend on that Kconfig.

Thank you,

> 
> Thanks!
> --breno


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
