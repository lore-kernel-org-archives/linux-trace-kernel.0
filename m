Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879011448D5;
	Tue, 12 May 2026 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546621; cv=none; b=ZCp5wlDJ0RHz/JKqAjO7dEFEZKGCj8hOwptu3ykQjgzFKQjcnY+FIsYrnFylweM7ks/jLwoDx7QPqzDvNw1uHEuzWHQnnsyrowmYOT3LyGKFF3kGF9E5j6fECglO8gX5Q9u+0pAYr78U4QKWwavtILvNlqtILfCwWPhTjR7tH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546621; c=relaxed/simple;
	bh=NkUW6edDKAepH73rXX0Zr6HQcAMINqiVFnDeCFxC1lk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DdFJvzIw+L/cgZwfnQcz5F/IO45JZvfFQInsOlgTIMLVW7EAH/AgaQajrV51nqcYje727x53dgYnP1TtuPbtm1fjhZIUTV8+8uYHop7KSLlNYk+L4Xf4CgQtQ1O+fNVIG4GpaKsJnCQItjws4eyG9RGVVlmMuTorS0OWHKhp+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuxsCwGR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuxsCwGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31244C2BCB0;
	Tue, 12 May 2026 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778546621;
	bh=NkUW6edDKAepH73rXX0Zr6HQcAMINqiVFnDeCFxC1lk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tuxsCwGR8baMcOyJ/sWuD/t/odZFcskuk4ZRkIqXbeGS3B1JWfUdLwHfGWRMJx9G7
	 2NIuQolZBEILEcgfHvlD9lT7nM7S6+rnP0dpDTDoBAMABcGNnrAeBgWD/3PtLUICol
	 Sy6+9KkfuY8aQ5B4+J/dmI7JVT1+GpBCjW97wUGJ4h4m/DS+NTeg6wtJshCwVxzcUh
	 bh9P/lHqipL+lRCd/JX+BUIJ8wZbCyDUaRdV0i8Wk9rAuXgJfHmO6e7TDN+/tSCNuQ
	 7zYRoPKjq8x4fR1UzB2XSdETzQIqpYVtLb6+s0hWcrxFswjl6aBs1773h7XF/TTn68
	 l9a9QagIV6F1g==
Date: Tue, 12 May 2026 09:43:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, paulmck@kernel.org, oss@malat.biz,
 kernel-team@meta.com
Subject: Re: [PATCH 0/2] tools/bootconfig: render kernel.* subtree as a
 cmdline string
Message-Id: <20260512094336.fc548d199a08771471c0f37c@kernel.org>
In-Reply-To: <agIFZ0vSfedX7foN@gmail.com>
References: <20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org>
	<20260508145641.754e4c7f73eabad0b5f89a1e@linux-foundation.org>
	<agIFZ0vSfedX7foN@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 09:38:25 -0700
Breno Leitao <leitao@debian.org> wrote:

> On Fri, May 08, 2026 at 02:56:41PM -0700, Andrew Morton wrote:
> > On Fri, 08 May 2026 06:55:02 -0700 Breno Leitao <leitao@debian.org> wrote:
> > 
> > > Add a bootconfig -> kernel cmdline rendering capability shared between
> > > the kernel parser library and the userspace tools/bootconfig binary.
> > > 
> > > The new userspace mode "tools/bootconfig -C <file>" walks a bootconfig
> > > file's "kernel" subtree and prints it as a flat, space-separated
> > > cmdline string suitable for direct use as (or appending to) a kernel
> > > command line.
> > > 
> > > This series prepares tools/bootconfig and lib/bootconfig.c for an
> > > upcoming feature that lets the kernel build render an embedded
> > > bootconfig file's "kernel" subtree to a flat cmdline string and embed
> > > it in the kernel image.
> > > 
> > > The follow-up series (sent separately) wires this into setup_arch() so
> > > early_param() handlers see values supplied via CONFIG_BOOT_CONFIG_EMBED_FILE,
> > > following Masami suggestion in [1]
> > > 
> > > These two patches are pure groundwork. They add no kernel feature,
> > > change no runtime behavior, and are useful on their own (the new
> > > "tools/bootconfig -C" mode lets anyone render a .bootconfig file to
> > > a cmdline string from the shell).
> > > 
> > > Landing them independently lets the follow-up series focus on the
> > > kernel-side plumbing without dragging the refactor and tool addition
> > > through the same review cycle.
> > 
> > I'll assume that Masami will process this, although
> > `scripts/get_maintainer.pl lib/bootconfig.c' doesn't mention a git
> > tree.
> > 
> > https://sashiko.dev/#/patchset/20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org
> > says a bunch of picky things which seem pretty ignorable to me.  Your
> > call ;)
> 
> Well, these are some warnings about not checking that the output was
> properly set. From my view, these are not new to this patch, it is just the
> pattern we see, which is fire-and-forget writes to stdout, which seems
> quite reasonable.

I confirmed there was no problem with UBSAN.
"NULL + 1" is undefined, yes, but "(char *)NULL + 1" is sane.

> 
> If we decide to fix this, it would make more sense to do it file-wide
> instead of just in this patch code.

So no need to fix it. Let me pick this series.

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
