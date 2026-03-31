Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5104035AF;
	Tue, 31 Mar 2026 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970892; cv=none; b=G9dnCE+rQMaO5et6yUD9jwSTjrDCT2OMCuutiIgCA8YnM7kugWZ6uHdlO+0+ju3GNgEE3F9KvH1vmK+8uQ92GdqIu+KdlrDWrfjUOzU1IR7Ng5nKJUw9oGiPBVuDcZIs59ok+X5o8B4FUcmpNy90jJePYUPKSXBmsy7++ktMyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970892; c=relaxed/simple;
	bh=RMUAeb69PPwHEKmTqWmtRn1qmoUYSPBUdmsbBm5anyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh0AE29ZfOo9PiC9QTnpWJJFCqXUIoXX/Sdro1BsPUY2T7RsndTBe30g/KJfkP5P7Y2I/RvZfO4qNqukfMQNuyiUwcHUHAuoBB/qyPB3N3o2Ta9rtppvyS/S4v5+Aqt+ux0uP3Xw8EAdMBStSaU5IfWPa5l9weAQLbW24V51AQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=b4M+FWIx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="b4M+FWIx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3vBzhmYF9+iiyfEfsznZLwdZleJyljUxgdY6awsp15o=; b=b4M+FWIxozvX+MqnxEcHgtizwF
	+xV7IBfqlTYsccpQ2zDMCBTRoG6YbpeHpHmBdfg7KDgvEgnM+lEJdjXcOmWVlXIh+6qlUj0Vl5MVB
	X8urruVf5DRAiGY60DSVxk9NUHOGw1UnmdMr/DwTz2fTZx0r+VO32Bgw51w1WydwHO70rlSBoysUX
	UD4eTkXtS32cDszfYqoBKwUQ8Ljkom/EzhfI+hGEpCi8nQtRGKNhD8SV3Y1DScvTNt4drLaxh8DN7
	ZemFtH5xq78lI4inoI2Gph1PwClBGGLm1iF0TVwEwVseq0N1QBmges3ePVMqxr+O08chxrjZgxRXC
	hY/zaH+A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1w7b0f-002JIg-2j;
	Tue, 31 Mar 2026 15:28:04 +0000
Date: Tue, 31 Mar 2026 08:27:59 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-ID: <acvjcCqIAeHyIiQN@gmail.com>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
 <20260325232204.05edbb21c7602b6408ca007b@kernel.org>
 <acZPZ4XKy4QynznK@gmail.com>
 <20260327223744.f246150adc1671f7605a4f0a@kernel.org>
 <acpzhCBEPh-tKVqg@gmail.com>
 <acqJk-zbyjIiy6hJ@gmail.com>
 <20260331125827.157a833882830007ea9b0b31@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331125827.157a833882830007ea9b0b31@kernel.org>
X-Debian-User: leitao

hello Masami,

On Tue, Mar 31, 2026 at 12:58:27PM +0900, Masami Hiramatsu wrote:

> > 3) Ensure that early bootconfig parameters don't overwrite the boot command
> >    line. For example, if the boot command line has foo=bar and bootconfig
> >    later has foo=baz, the command line value should take precedence.
> >    This prevents early boot code (in setup_arch()) from seeing a parameter
> >    value that will be changed later.
>
> OK, this also needs to be considered. Currently we just pass the bootconfig
> parameters right before bootloader given parameters as "extra_command_line"
> if "bootconfig" in cmdline or CONFIG_BOOT_CONFIG_FORCE=y.
>
> [boot_config(.kernel)]<command_line>[ -- [boot_config(.init)][init_command_line]]
>
> This is currently expected behavior. The bootconfig parameters are
> expected to be overridden by command_line or command_line are appended.

That's correct, and I have no intention of changing this behavior. Here's
the current approach:

1) Early parameters from the bootloader are parsed first in setup_arch()

2) Subsequently, bootconfig_apply_early_params() is invoked. Any early
   parameter that was already parsed from the bootloader (in setup_arch())
   will be skipped at this stage.

> If we change this for early params, we also should change the expected
> output of /proc/cmdline too. I think we have 2 options;
>
>  - As before, we expect the parameters provided by the boot configuration
>    to be processed first and then overridden later by the command line.
>
> Or,
>
>  - ignore all parameters which is given from the command line, this also
>    updates existing setup_boot_config() (means xbc_snprint_cmdline() ).
>
> Anyway, this behavior change will also be a bit critical... We have
> to announce it.

As mentioned above, I don't anticipate any changes to existing behavior.
Bootconfig parsing remains unchanged. The only modification is that
bootconfig_apply_early_params() will skip any early config parameter
that's already present in the bootloader command line.

> > +Note that embedded bootconfig is parsed after ``setup_arch()``, so
> > +early options that are consumed during architecture initialization
> > +(e.g., ``mem=``, ``memmap=``, ``earlycon``, ``noapic``, ``nolapic``,
> > +``acpi=``, ``numa=``, ``iommu=``) may not take effect from bootconfig.
> > +
>
> This is easy to explain, but it's quite troublesome for users to
> determine which parameters are unavailable.

Agreed. This turned out to be significantly more complex than I
initially anticipated.

I'm uncertain whether we can accomplish this without examining every
early_parameter() implementation in depth.

> Currently we can identify
> it by `git grep early_param -- arch/${ARCH}`. But it is setup in
> setup_arch() we need to track the source code. (Or ask AI :))

The challenge extends beyond that. There are numerous early_parameter()
definitions scattered throughout the kernel that may or may not be
utilized by setup_arch().

For example, consider `early_param("mitigations", ..)` in
./kernel/cpu.c. This modifies the cpu_mitigations global variable, which
is referenced in various locations across different architectures.

It's worth noting that we have over 300 early_parameter() instances in
the kernel.

Given this, analyzing all these early parameters and examining each one
individually represents a substantial amount of work.

Are there alternative approaches? At this point, I'm leaning toward
breaking bootconfig's dependency on memblock, allowing us to invoke it
before setup_arch(). Is this the only practical solution available?!

Thanks,
--breno
