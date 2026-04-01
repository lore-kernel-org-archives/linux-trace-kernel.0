Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447436AB4D;
	Wed,  1 Apr 2026 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051336; cv=none; b=npxqr8jzKkHRicCO1zF9RQaj+SPFg7tZDsvK3sgsCTR+KmCIMPN2/JZtXaVZYMAggr2lJ05Sbh4cM5ch+UlsAERppg+DPr0uRz84i7fgNWYdEgpLy8DuT5QRB5RMEoP/0tayprpVkwzluFM21MkQK2fbi2M68Z7OjJcYhE/525A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051336; c=relaxed/simple;
	bh=xFgnOyg8X+lea0/KUQv/0V6QZGmiCPT35r+GsxSV48Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=krEnmGSbPLdjIjiE+vuFu3TlCaZzR4bLldPK8XNapp7myiiXAZ3OFf7nMRCns2MgBZ6Tc4K/qMG+gE/JpwMsIrOL0GyJuHEfAb1eCcrrhgpY7VNitrhZig9anmi+R+iztmETy5F/Dm9+a6Kz1Tk3Ac085806BT3h1cKvBk3SLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaSufrcF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaSufrcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0BDC4CEF7;
	Wed,  1 Apr 2026 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775051336;
	bh=xFgnOyg8X+lea0/KUQv/0V6QZGmiCPT35r+GsxSV48Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gaSufrcFiBWIl+QBNrCXCpRVFhDMLErK+CL3DW5vviunWx4NGxz+Fltf3OHM37bmJ
	 vJfV8D/z01VkLJhvddv5rytXfXdiJNPALucm2QnqmPY0nLBMZw7sNPiD87Lj5x3/OQ
	 9sIl3if4zmRej4T3LQVP3cXM4CVgFZLccNPN9lpo/ViG+G5HbtawJ39k5xfdzwMq+Q
	 EWFykxLN7mdga6IcUx4EcNjZqoQJmEtYqSyzYmsFggqEEmseXxv3VI+Vi2I5pSQ0/e
	 DMRgn15a3y8R0rtan2MawR/TzQu8LHC2VGBOPO/viQIBN1YqtzVUMMizr/0MbGqwFE
	 sHrecVMsaU9rw==
Date: Wed, 1 Apr 2026 22:48:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org,
 kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-Id: <20260401224853.d8ed517a344c4be51d371a9c@kernel.org>
In-Reply-To: <acvjcCqIAeHyIiQN@gmail.com>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
	<20260325232204.05edbb21c7602b6408ca007b@kernel.org>
	<acZPZ4XKy4QynznK@gmail.com>
	<20260327223744.f246150adc1671f7605a4f0a@kernel.org>
	<acpzhCBEPh-tKVqg@gmail.com>
	<acqJk-zbyjIiy6hJ@gmail.com>
	<20260331125827.157a833882830007ea9b0b31@kernel.org>
	<acvjcCqIAeHyIiQN@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Breno,

On Tue, 31 Mar 2026 08:27:59 -0700
Breno Leitao <leitao@debian.org> wrote:

> hello Masami,
> 
> On Tue, Mar 31, 2026 at 12:58:27PM +0900, Masami Hiramatsu wrote:
> 
> > > 3) Ensure that early bootconfig parameters don't overwrite the boot command
> > >    line. For example, if the boot command line has foo=bar and bootconfig
> > >    later has foo=baz, the command line value should take precedence.
> > >    This prevents early boot code (in setup_arch()) from seeing a parameter
> > >    value that will be changed later.
> >
> > OK, this also needs to be considered. Currently we just pass the bootconfig
> > parameters right before bootloader given parameters as "extra_command_line"
> > if "bootconfig" in cmdline or CONFIG_BOOT_CONFIG_FORCE=y.
> >
> > [boot_config(.kernel)]<command_line>[ -- [boot_config(.init)][init_command_line]]
> >
> > This is currently expected behavior. The bootconfig parameters are
> > expected to be overridden by command_line or command_line are appended.
> 
> That's correct, and I have no intention of changing this behavior. Here's
> the current approach:
> 
> 1) Early parameters from the bootloader are parsed first in setup_arch()
> 
> 2) Subsequently, bootconfig_apply_early_params() is invoked. Any early
>    parameter that was already parsed from the bootloader (in setup_arch())
>    will be skipped at this stage.

Ah, I meant if we skip these parameters, we should not show it in the
command line via extra_command_line. This is still a minor issue at this
point. It should find early parameters in kernel.* parameters and do not
show it in extra_command_line, because those parameters are ignored.
So it is better to make a separated patch to fix that.

For example, if we pass

kernel.mem=1G

via bootconfig, it will be shown in the /proc/cmdline, but it is
not applied. This can confuse user.


> 
> > If we change this for early params, we also should change the expected
> > output of /proc/cmdline too. I think we have 2 options;
> >
> >  - As before, we expect the parameters provided by the boot configuration
> >    to be processed first and then overridden later by the command line.
> >
> > Or,
> >
> >  - ignore all parameters which is given from the command line, this also
> >    updates existing setup_boot_config() (means xbc_snprint_cmdline() ).
> >
> > Anyway, this behavior change will also be a bit critical... We have
> > to announce it.
> 
> As mentioned above, I don't anticipate any changes to existing behavior.
> Bootconfig parsing remains unchanged. The only modification is that
> bootconfig_apply_early_params() will skip any early config parameter
> that's already present in the bootloader command line.

Yes, but it is just different from existing one.
Suppose that if we have "early" and "normal" keys in the kernel, those
are handled by early_param() and __setup() respectively.

If we use bootconfig, like

 kernel {
   early = bconf_val
   normal = bconf_val
 }
 
And passes "early=foo normal=bar" via cmdline.

In this case, the /proc/cmdline eventually has

"early=bconf_val normal=bconf_val early=foo normal=bar"

And the "normal" callback called with "bconf_val" and "bar" twice.
However, "early" callback will be called with "foo" only once.

That can confuse users too.
I believe it's important for the system to behave in a way that is
as close as possible to the user's mind model.
Because the behavior is inconsistent when multiple parameters with
the same name are specified on the kernel command line, it is
necessary to ensure that users can later look at it and infer what
happened.

I mean, if a parameter is skipped, it should not be printed at
/proc/cmdline, because it can mislead user (and maybe bug reporter)
when a problem happens.

> 
> > > +Note that embedded bootconfig is parsed after ``setup_arch()``, so
> > > +early options that are consumed during architecture initialization
> > > +(e.g., ``mem=``, ``memmap=``, ``earlycon``, ``noapic``, ``nolapic``,
> > > +``acpi=``, ``numa=``, ``iommu=``) may not take effect from bootconfig.
> > > +
> >
> > This is easy to explain, but it's quite troublesome for users to
> > determine which parameters are unavailable.
> 
> Agreed. This turned out to be significantly more complex than I
> initially anticipated.

Yeah, that's complicated.

> 
> I'm uncertain whether we can accomplish this without examining every
> early_parameter() implementation in depth.

Agreed. My proposal is something like a divide and conquer approach.
Since these are implemented architecture by architecture, you need to
check the implementation for each architecture, and I think it's best
to implement them one by one using Kconfig.

> 
> > Currently we can identify
> > it by `git grep early_param -- arch/${ARCH}`. But it is setup in
> > setup_arch() we need to track the source code. (Or ask AI :))
> 
> The challenge extends beyond that. There are numerous early_parameter()
> definitions scattered throughout the kernel that may or may not be
> utilized by setup_arch().
> 
> For example, consider `early_param("mitigations", ..)` in
> ./kernel/cpu.c. This modifies the cpu_mitigations global variable, which
> is referenced in various locations across different architectures.
> 
> It's worth noting that we have over 300 early_parameter() instances in
> the kernel.
> 
> Given this, analyzing all these early parameters and examining each one
> individually represents a substantial amount of work.

Yes, that may require a substantial amount of work. But to improve
the kernel framework around the parameter handling, eventually we
need to examine each early parameter.

> 
> Are there alternative approaches? At this point, I'm leaning toward
> breaking bootconfig's dependency on memblock, allowing us to invoke it
> before setup_arch(). Is this the only practical solution available?!

Basically, the memblock dependency comes from allocating copy of data.
Only for the embedded bootconfig, we can just pass copy memory block
to the xbc_init(). Something like;

xbc_init() {
 xbc_data = memblock_alloc();
 memcpy(xbc_data, data);
 __xbc_init(xbc_data);
}

embedded_xbc_init() {
  __xbc_init(embedded_bootconfig_data);
}

Afterwards, we can pass mixture of embedded bootcofnigt and initrd
bootconfig data to parser again.

(But in this case, we must be careful not to override the early
 parameters that we have already applied.)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
