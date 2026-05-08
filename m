Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA6311946;
	Fri,  8 May 2026 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248784; cv=none; b=CUOK1RTkUnqaNMaoxV+nEM5DvcrDpS8i5RBetloiZ4UZAz35boWXagaY8/CIGw4jsubGvNhYkkecFnRBk8PQx+BZ8gmeK4c5ZTgOCDxH0Qp5sGsRz119UrEhgh1z7qJVtFm3dmwgZF/PVHUnFjFCPJeOMg+caA2gZBmdAWW8IE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248784; c=relaxed/simple;
	bh=KdW9yULYzrFb4FGIPjUdyi9HuMrHaJZ34J4/f5NElC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exhnZ7PaWP1DKQl9FRRVCvozNf504CYTy9A1vnSfnnkVJR+IUYTQWfp31lrdoXFw+xy9v7Nj+2Qa24UzqAeSE6lwCryCQ6xab9O5WS2s2n1PJnHcRcT4nYa73VgvHt3bRpfXmqkRCOzQHQXKmMjOjn/sWEiBMJ9AwxnazHtt5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GiArDfxY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GiArDfxY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Iez1Su5tuk5ceRFo8KI+ALmnBqBbH9V15uTQFnREABY=; b=GiArDfxYMolIX0D1pr1MuWxdyt
	c8wZFN2YH27nfvQl1T2XSmXtiYAMefsc8pqq//zIqEqCZfVn6LeWKjHlGHjU7mcjT7cOoO2TlPLsc
	H2RHal+gw2dx3yJfwXefiJZSMqlZtrsS/DKdvHmRwy6hTprZkYSzSPfj33SWOh/T0AO9avp9ooylP
	sAXDpRNtxShcBC2Zc9Pi4x+m/n705ju1iuFuztPCnZv5KiETQxbQKbMSeRLseCjH19G38GXfSr+6w
	mFwOHmosb6hQICPreUKdj7dUsm2sO32P8GB4FAwCd/w0aCJJTuhASU+tRgbpMrxVjCuGCFHzGQek6
	7V5rAXxA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLLjs-005C6Y-2M;
	Fri, 08 May 2026 13:59:37 +0000
Date: Fri, 8 May 2026 06:59:32 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, oss@malat.biz, 
	paulmck@kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH 2/3] init: use static buffers for bootconfig extra
 command line
Message-ID: <af3roPwbLHDDcak8@gmail.com>
References: <20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org>
 <20260415-bootconfig_earlier-v1-2-cf160175de5e@debian.org>
 <20260417104436.ece29fd5e2cb7a59c8cf8ac1@kernel.org>
 <aeJH8mhxqrwdsjxc@gmail.com>
 <20260429172721.c89072381aa98d1090ad383f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429172721.c89072381aa98d1090ad383f@kernel.org>
X-Debian-User: leitao

Hello Masami,

On Wed, Apr 29, 2026 at 05:27:21PM +0900, Masami Hiramatsu wrote:
> On Fri, 17 Apr 2026 08:38:16 -0700
> Breno Leitao <leitao@debian.org> wrote:
> > On Fri, Apr 17, 2026 at 10:44:36AM +0900, Masami Hiramatsu wrote:
> > > On Wed, 15 Apr 2026 03:51:11 -0700
> > > Breno Leitao <leitao@debian.org> wrote:
> > >
> > > But if we can do it, should we continue using bootconfig? I mean
> > > it is easy to make a tool (or add a feature in tools/bootconfig)
> > > which converts bootconfig file to command line string and embeds
> > > it in the kernel. Hmm.
> >
> > Sure, you are talking about a a tool that embeddeds it in the kernel binary,
> > something like:
> >
> >
> > 0) Get a kernel and define CONFIG_BOOT_CONFIG_EMBED_FILE=".bootconfig"
> >
> > 1) Add an option in tools/bootconfig to convert bootconfig (.bootconfig)
> >    to a cmdline string ($ bootconfig -C kernel .bootconfig).
> >    Something like:
> >    # tools/bootconfig/bootconfig -C kernel .bootconfig
> >      mem=2G loglevel=7 debug nokaslr %
> >
> > 2) At kernel build time, run that tool on .bootconfig and embed the
> >    resulting string into the kernel image as a .init.rodata symbol
> >    (embedded_kernel_cmdline[]).
> >
> >    # gdb -batch -ex 'x/s &embedded_kernel_cmdline' vmlinux
> >    0xffffffff87e108f8:    "mem=2G loglevel=7 debug nokaslr "

> Yeah, I think this looks good to me.

Thank you for the feedback. I've begun working on the bootconfig patches
following the approach outlined in Step 1 above. Note that I've
simplified the -C option by removing the "kernel" argument mentioned in
the earlier example.

The patch series is available here:

https://lore.kernel.org/all/20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org/

I appreciate your continued support.
--breno
