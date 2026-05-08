Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E606329E6A;
	Fri,  8 May 2026 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277402; cv=none; b=qS2e0xXgKkJbTTL++deb0k11EBNWXbGCW9EdIjHLTdtrhzzv7gP6H46TFsn2OFF7SR0PFwPR+uO6NoMm7Raob1lm3Ual+8GTZo0YQyW296zfagdXwDtspU0iksdXB9cwqDgnRSfVRmBxM5zwc96T0pqYN922y0IZH9z226S6cs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277402; c=relaxed/simple;
	bh=03N1Ktj1E+v6c9Sk9BiAlbP06uQ4BdeKqRHxjOaz0Yw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VXRP3sqLzCuezTNqTc6LpnfM0289G5KaReT6nSta1CHecXB43wTqeld8xNuHZrfPwgQGwmlo2rvwzk+v03Z5985UPcmhrfrerP3jxQkciHnHyGo+zuq3TfC6P20+qEMlvamAKo0pwG9e+0WmMASghgpbQFNnmVtfl5egGKZEzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0ZfxIQdx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0ZfxIQdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C28FC2BCB0;
	Fri,  8 May 2026 21:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778277401;
	bh=03N1Ktj1E+v6c9Sk9BiAlbP06uQ4BdeKqRHxjOaz0Yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0ZfxIQdxoqd2bq8V5qYurSjrQXqRIelWmysQglZdVMfCI0VvHMaa4yIet8dyID4Lr
	 OhnF1x+7AfdSo2HrvLLPKxbPak+RN/FXSQVjxNDPrIik+tZHHqer/j4oCROS1s70gz
	 ckFn+tbBmJfcz2WXhLJsvAIj5YmyPbdiwsoFhFa4=
Date: Fri, 8 May 2026 14:56:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, paulmck@kernel.org, oss@malat.biz,
 kernel-team@meta.com
Subject: Re: [PATCH 0/2] tools/bootconfig: render kernel.* subtree as a
 cmdline string
Message-Id: <20260508145641.754e4c7f73eabad0b5f89a1e@linux-foundation.org>
In-Reply-To: <20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org>
References: <20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 May 2026 06:55:02 -0700 Breno Leitao <leitao@debian.org> wrote:

> Add a bootconfig -> kernel cmdline rendering capability shared between
> the kernel parser library and the userspace tools/bootconfig binary.
> 
> The new userspace mode "tools/bootconfig -C <file>" walks a bootconfig
> file's "kernel" subtree and prints it as a flat, space-separated
> cmdline string suitable for direct use as (or appending to) a kernel
> command line.
> 
> This series prepares tools/bootconfig and lib/bootconfig.c for an
> upcoming feature that lets the kernel build render an embedded
> bootconfig file's "kernel" subtree to a flat cmdline string and embed
> it in the kernel image.
> 
> The follow-up series (sent separately) wires this into setup_arch() so
> early_param() handlers see values supplied via CONFIG_BOOT_CONFIG_EMBED_FILE,
> following Masami suggestion in [1]
> 
> These two patches are pure groundwork. They add no kernel feature,
> change no runtime behavior, and are useful on their own (the new
> "tools/bootconfig -C" mode lets anyone render a .bootconfig file to
> a cmdline string from the shell).
> 
> Landing them independently lets the follow-up series focus on the
> kernel-side plumbing without dragging the refactor and tool addition
> through the same review cycle.

I'll assume that Masami will process this, although
`scripts/get_maintainer.pl lib/bootconfig.c' doesn't mention a git
tree.

https://sashiko.dev/#/patchset/20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org
says a bunch of picky things which seem pretty ignorable to me.  Your
call ;)
