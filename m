Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26542253B0;
	Fri, 17 Apr 2026 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440314; cv=none; b=eNniFmd+F11dIiCerU/yDK67BIo61V9j5aMwiAgRIpy2Hqvv6DzxElCeodU5SSs1SiXvKOWFo7CbEwCvlDZMTQnZ3ALJX4BM3cSR+BQ+WfDBz5zdFEzAW/NbPWqqnDm/2X9TVdAfW8n7NFmK4jneI6YnR5SHOk/fFLZCP/5nlYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440314; c=relaxed/simple;
	bh=lwC2rrqFl6TTmRiEEGnax7UtFi3kDj58W0hjwRNgfuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5wCpnFCdmx7I7C+TuH9YUiO9v6QhqIRdZopGM/tsADgZXBUiP5PRQOfeONK8insxJGaD88CfDQ0kACcnIDnEEnBDOQVFlNsOeV0agWKKtFUHicVhQdUyWI2ZEKmmQC4EB4C6PosystlMsNTFblCzbZTAEocNiXm1QEVZmugp4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=A6SPcqLY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="A6SPcqLY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=dxO3LQzmWGzTsdaElUlZt48XTgrB2kH7gd1/pd0odW0=; b=A6SPcqLYFwM9xH/rwAur/H/Gxy
	QTzaBjPkHk925E2MfNrj6colYna9CBq8q5k6otWzVBsTcHeRyg2ofBJ8PL6QVlm4kvu6nlPESlrSg
	FyS8IbkIbpU/xWj84fzVA/CWDLeXI6TFq2tiiNKPDqEPhBKJIEgJO/4GWCI8CiSNZKyWn7IFltD3L
	zD7ItLTAdhlpIoWN1j0KPN0kLyX2x+GzZ/+5FImW4qHU/Jfq/DnRmGCeDSY7ySSiGniMg9dMgQtPc
	plvn+uY8uEuw6yQ5h5U4Yks0emBOuTT50Ki1lsuLVUOO7OJRxXfRbcWCpgP4h9LpploduMrKlVDG7
	FStiPG7A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wDlGv-00FTmG-2J;
	Fri, 17 Apr 2026 15:38:22 +0000
Date: Fri, 17 Apr 2026 08:38:16 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, oss@malat.biz, 
	paulmck@kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH 2/3] init: use static buffers for bootconfig extra
 command line
Message-ID: <aeJH8mhxqrwdsjxc@gmail.com>
References: <20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org>
 <20260415-bootconfig_earlier-v1-2-cf160175de5e@debian.org>
 <20260417104436.ece29fd5e2cb7a59c8cf8ac1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417104436.ece29fd5e2cb7a59c8cf8ac1@kernel.org>
X-Debian-User: leitao


On Fri, Apr 17, 2026 at 10:44:36AM +0900, Masami Hiramatsu wrote:
> On Wed, 15 Apr 2026 03:51:11 -0700
> Breno Leitao <leitao@debian.org> wrote:
>
> But if we can do it, should we continue using bootconfig? I mean
> it is easy to make a tool (or add a feature in tools/bootconfig)
> which converts bootconfig file to command line string and embeds
> it in the kernel. Hmm.

Sure, you are talking about a a tool that embeddeds it in the kernel binary,
something like:


0) Get a kernel and define CONFIG_BOOT_CONFIG_EMBED_FILE=".bootconfig"

1) Add an option in tools/bootconfig to convert bootconfig (.bootconfig)
   to a cmdline string ($ bootconfig -C kernel .bootconfig).
   Something like:
   # tools/bootconfig/bootconfig -C kernel .bootconfig
     mem=2G loglevel=7 debug nokaslr %

2) At kernel build time, run that tool on .bootconfig and embed the
   resulting string into the kernel image as a .init.rodata symbol
   (embedded_kernel_cmdline[]).

   # gdb -batch -ex 'x/s &embedded_kernel_cmdline' vmlinux
   0xffffffff87e108f8:    "mem=2G loglevel=7 debug nokaslr "

3) At boot, the arch's setup_arch() prepends that symbol to
   boot_command_line right before parse_early_param() — so early_param()
   handlers (mem=, earlycon=, loglevel=, ...) actually see kernel.*
   keys from the embedded bootconfig.

   This needs to be architecture by architecture. Something like:

	@@ -924,6 +925,13 @@ void __init setup_arch(char **cmdline_p)
		builtin_cmdline_added = true;
	#endif

	+       /*
	+        * Prepend kernel.* keys from the embedded bootconfig (rendered at
	+        * build time by tools/bootconfig) so parse_early_param() below sees
	+        * them. No-op when CONFIG_BOOT_CONFIG_EMBED=n.
	+        */
	+       xbc_prepend_embedded_cmdline(boot_command_line, COMMAND_LINE_SIZE);
	+
		strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
		*cmdline_p = command_line;

Am I describing your suggestion accordingly?

Thanks!
--breno
