Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F662D1911;
	Tue, 31 Mar 2026 03:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774929510; cv=none; b=MtPZRmcGiTFD/9oRCe3y1piM3WM1AgtMUTZn5YhlYYCkfrBTJ3ll6HgD61xPA7LLmnP2/N55g70OiM8Toixv+B+Tt+GSEQgIARIkiWyv/lqrM2J6U6anQmtLCSvJg4DkmFmg849bZcuHgtsswFSZfaSu6ka7tihIAqivauwAanU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774929510; c=relaxed/simple;
	bh=Yb/1ywhF0OYFAjht7EoorIYEOaRdcsawozGia+/qSu8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lyGWBMIVh45L/3fQlYSHxbEAIb2ce4Cu7rEnVe089J8cm9FXaPUb0pTdPVHIeWlI5zccLMLUHean4u118tVFX9vVVuq74hucNRXkzmECI/+y1yQkX1+VKryywi6MVYy18CuT6UFM+U1U/xVUa0g2dL1MgjW9JoFaDzySlMGrwS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUY9F0/F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUY9F0/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBE6C19424;
	Tue, 31 Mar 2026 03:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774929510;
	bh=Yb/1ywhF0OYFAjht7EoorIYEOaRdcsawozGia+/qSu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XUY9F0/F+rHjbeWJLHGO9J/BKlElVHsRg9iDM+EsShz7tooswcCNx2O2EgwbzcXlX
	 cU54g8iwvWf/ML38ZYh8TN1wJtoiVcGY9WEDWYnltWO4zgTEZxDwPwMk7G2hH4JyAX
	 +jdrlRtkaK//czAvOcu3xlzYAIhSwYl4mB0XIwiTAjV5rWxh2JHP96/dxf5A28e/ci
	 VQm1CkG3sXhOFQSyx3je1VwQ8HSYtopINkXGlJ323vipAOzhtv2cmf29eT59LCiGsG
	 0E/LbRW5wzY7h2yNaTIZcaJnKjtcAECaVElsk0XB5/0XWuYaJj4J9gF/0i9FIQOyiP
	 QSUCjWWsE5Xhg==
Date: Tue, 31 Mar 2026 12:58:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org,
 kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-Id: <20260331125827.157a833882830007ea9b0b31@kernel.org>
In-Reply-To: <acqJk-zbyjIiy6hJ@gmail.com>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
	<20260325232204.05edbb21c7602b6408ca007b@kernel.org>
	<acZPZ4XKy4QynznK@gmail.com>
	<20260327223744.f246150adc1671f7605a4f0a@kernel.org>
	<acpzhCBEPh-tKVqg@gmail.com>
	<acqJk-zbyjIiy6hJ@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 08:04:23 -0700
Breno Leitao <leitao@debian.org> wrote:

> On Mon, Mar 30, 2026 at 06:15:17AM -0700, Breno Leitao wrote:
> > On Fri, Mar 27, 2026 at 10:37:44PM +0900, Masami Hiramatsu wrote:
> > > On Fri, 27 Mar 2026 03:06:41 -0700
> > > Breno Leitao <leitao@debian.org> wrote:
> >
> > > > > To fix this, we need to change setup_arch() for each architecture so
> > > > > that it calls this bootconfig_apply_early_params().
> > > >
> > > > Could we instead integrate this into parse_early_param() itself? That
> > > > approach would avoid the need to modify each architecture individually.
> > >
> > > Ah, indeed.
> >
> > I investigated integrating bootconfig into parse_early_param() and hit a
> > blocker: xbc_init() and xbc_make_cmdline() depend on memblock_alloc(), but on
> > most architectures (x86, arm64, arm, s390, riscv) parse_early_param() is called
> > from setup_arch() _before_ memblock is initialized.
> 
> That said, I'd like to propose a simpler approach as a first step:
> 
> 1) Keep calling bootconfig_apply_early_params() from setup_boot_config().
>    This is the least intrusive approach and expands bootconfig support to
>    additional early boot parameters.
> 
> 2) Document that architecture-specific early parameters might be ignored.
>    If a parameter is consumed early enough (during setup_arch()), it will
>    not see the bootconfig value.

We have to carefully do this because what parameter is arch specific or not
depends on architecture and undocumented.

How about introducing a new Kconfig, which supports early params by
embedded bootconfig?

> 
> 3) Ensure that early bootconfig parameters don't overwrite the boot command
>    line. For example, if the boot command line has foo=bar and bootconfig
>    later has foo=baz, the command line value should take precedence.
>    This prevents early boot code (in setup_arch()) from seeing a parameter
>    value that will be changed later.

OK, this also needs to be considered. Currently we just pass the bootconfig
parameters right before bootloader given parameters as "extra_command_line"
if "bootconfig" in cmdline or CONFIG_BOOT_CONFIG_FORCE=y.

[boot_config(.kernel)]<command_line>[ -- [boot_config(.init)][init_command_line]]

This is currently expected behavior. The bootconfig parameters are
expected to be overridden by command_line or command_line are appended.

If we change this for early params, we also should change the expected
output of /proc/cmdline too. I think we have 2 options;

 - As before, we expect the parameters provided by the boot configuration
   to be processed first and then overridden later by the command line.

Or,

 - ignore all parameters which is given from the command line, this also
   updates existing setup_boot_config() (means xbc_snprint_cmdline() ).

Anyway, this behavior change will also be a bit critical... We have
to announce it.

> 
> 
> If that is OK, that is what I have right now:

Let me comment on it.

> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index f712758472d5c..6ed852a0c66d8 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -169,6 +169,15 @@ Boot Kernel With a Boot Config
>  There are two options to boot the kernel with bootconfig: attaching the
>  bootconfig to the initrd image or embedding it in the kernel itself.
>  
> +Early options (those registered with ``early_param()``) may only be
> +specified in the embedded bootconfig, because the initrd is not yet
> +available when early parameters are processed.
> +
> +Note that embedded bootconfig is parsed after ``setup_arch()``, so
> +early options that are consumed during architecture initialization
> +(e.g., ``mem=``, ``memmap=``, ``earlycon``, ``noapic``, ``nolapic``,
> +``acpi=``, ``numa=``, ``iommu=``) may not take effect from bootconfig.
> +

This is easy to explain, but it's quite troublesome for users to
determine which parameters are unavailable. Currently we can identify
it by `git grep early_param -- arch/${ARCH}`. But it is setup in
setup_arch() we need to track the source code. (Or ask AI :))


>  Attaching a Boot Config to Initrd
>  ---------------------------------
>  
> diff --git a/init/Kconfig b/init/Kconfig
> index 7484cd703bc1a..34adcc1feb9b6 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1525,6 +1525,16 @@ config BOOT_CONFIG_EMBED
>  	  image. But if the system doesn't support initrd, this option will
>  	  help you by embedding a bootconfig file while building the kernel.
>  
> +	  Unlike bootconfig attached to initrd, the embedded bootconfig also
> +	  supports early options (those registered with early_param()). Any
> +	  kernel.* key in the embedded bootconfig is applied before
> +	  parse_early_param() runs.  Early options in initrd bootconfig will
> +	  not be applied.  Early options consumed during setup_arch() (e.g.
> +	  mem=, memmap=, earlycon, noapic, acpi=, numa=, iommu=) may not
> +	  take effect.  If the same early option
> +	  appears in both bootconfig and the kernel command line, the
> +	  command line value takes precedence.
> +

As a compromise, how about making this a separate Kconfig?

config BOOT_CONFIG_EMBED_EARLY_PARAM
	bool "Support early_params in embedded bootconfig"

and afterwards, we can introduce 

	depends on ARCH_BOOT_CONFIG_EMBED_EARLY_PARAM


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
