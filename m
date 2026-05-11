Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE07312832;
	Mon, 11 May 2026 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517516; cv=none; b=a+8Lw1eQKzhRRGR493bVux9ombMtxU4VcjqHqBV40BnZYkZhADakAZczgEBWG4T37sPobDwZ9EUrVEWUYsTCczLoehCJaIbErL1h9DeVoFMOU2KrVQo/39y9EDIEQDcKMQaKmRlcV1bR9f1x6AoJo4Vp47aCtIJddWabvzFWxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517516; c=relaxed/simple;
	bh=hEIX9EipGUvR1x7oDQrx8x8JOgF91opY4DsEALWqyBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWvA0v1wPUl0Rb7KzJjovAH+xRZJSh5kmIWcb++HRiX1oUSLf/IDu/QHqwsn4OtJJ5YnRHARdiDzDts6HCXZRdS+J/rYX+PKdcoZoGGQwThRYjPIcj5iKC1pYLOrAQEpCIPHUUuN8BmF3iXWlyoTTPWAlvPAZH+YTobbVSeyo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=E1xuGats; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="E1xuGats"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RPkJdNPZWjGL3yJJ8QOsn3oNWtCSC1Hk0P4HuVLPSKY=; b=E1xuGatsn1WTmRdnNNKf2g1ot/
	zj2HO6G2Qec0YYaxl5CeElPlpdd2Xh/ykXFc+X1gj+R1+j2p/e02qOdYjEt94/f4mmomwrOZNc688
	K5qT9VHezMmlFaUgkExnlD6eIwj+VJI19jg3WXWUFUVB5qdldhYhqA5/+lZ+UbRks+44VDTosadA/
	0lX8sfL5UG5P1UrxsekXFUX30ZIZHzwTvfQ1YGZnGL+h4lh7MOGrsFZZRDdCgchuvtHac6zMaZhSk
	QsYAofaYfDLmiEokNq1wLM741n2AW4LmbcZPNYQk/Qe4MydO4NN3rpcZHNOJmipfA681X8AXwvSmt
	n2tw4htA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMTeI-001jcF-0Y;
	Mon, 11 May 2026 16:38:30 +0000
Date: Mon, 11 May 2026 09:38:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, paulmck@kernel.org, oss@malat.biz, kernel-team@meta.com
Subject: Re: [PATCH 0/2] tools/bootconfig: render kernel.* subtree as a
 cmdline string
Message-ID: <agIFZ0vSfedX7foN@gmail.com>
References: <20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org>
 <20260508145641.754e4c7f73eabad0b5f89a1e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508145641.754e4c7f73eabad0b5f89a1e@linux-foundation.org>
X-Debian-User: leitao

On Fri, May 08, 2026 at 02:56:41PM -0700, Andrew Morton wrote:
> On Fri, 08 May 2026 06:55:02 -0700 Breno Leitao <leitao@debian.org> wrote:
> 
> > Add a bootconfig -> kernel cmdline rendering capability shared between
> > the kernel parser library and the userspace tools/bootconfig binary.
> > 
> > The new userspace mode "tools/bootconfig -C <file>" walks a bootconfig
> > file's "kernel" subtree and prints it as a flat, space-separated
> > cmdline string suitable for direct use as (or appending to) a kernel
> > command line.
> > 
> > This series prepares tools/bootconfig and lib/bootconfig.c for an
> > upcoming feature that lets the kernel build render an embedded
> > bootconfig file's "kernel" subtree to a flat cmdline string and embed
> > it in the kernel image.
> > 
> > The follow-up series (sent separately) wires this into setup_arch() so
> > early_param() handlers see values supplied via CONFIG_BOOT_CONFIG_EMBED_FILE,
> > following Masami suggestion in [1]
> > 
> > These two patches are pure groundwork. They add no kernel feature,
> > change no runtime behavior, and are useful on their own (the new
> > "tools/bootconfig -C" mode lets anyone render a .bootconfig file to
> > a cmdline string from the shell).
> > 
> > Landing them independently lets the follow-up series focus on the
> > kernel-side plumbing without dragging the refactor and tool addition
> > through the same review cycle.
> 
> I'll assume that Masami will process this, although
> `scripts/get_maintainer.pl lib/bootconfig.c' doesn't mention a git
> tree.
> 
> https://sashiko.dev/#/patchset/20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org
> says a bunch of picky things which seem pretty ignorable to me.  Your
> call ;)

Well, these are some warnings about not checking that the output was
properly set. From my view, these are not new to this patch, it is just the
pattern we see, which is fire-and-forget writes to stdout, which seems
quite reasonable.

If we decide to fix this, it would make more sense to do it file-wide
instead of just in this patch code.
