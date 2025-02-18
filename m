Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7DF26B2A9;
	Tue, 18 Feb 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891667; cv=none; b=CokiAfyIp6HM2D7ZoHR3019jqrWCxR2dY/HTfxXZ2AQMHDjk0sOMf1t1tPm7JztDzM7TXBnRcQCjeZj4lAUzRnRAtxHNSa13oby7jWrFMXAE1LcuL0d5eLfTdx2xBTojbZKFceytQVuK2Fa5z2BnS+VD/Ct4EyNFWwnFCbUHOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891667; c=relaxed/simple;
	bh=3obvX+KG+HGkv5JE3tSrMW+CExZhG6R6NkUu0G95+iE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WwPfO9b8925WST2J5S6ElQwMBIbMU+D0Ppx/8njxG2YzQX44Ulco/cR03WIsr/kshRavoSoBnA8F4NiCpE2z1D4WqdAAWDifnJbBjwm3bpU0PnWnzZ28HJXDw8lag6TFTx+t2/7jOv3+V6nzJGT/dqbIYMB/ItcUy5vShmv7M/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fp595QVy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp595QVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FE5C4CEE2;
	Tue, 18 Feb 2025 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739891667;
	bh=3obvX+KG+HGkv5JE3tSrMW+CExZhG6R6NkUu0G95+iE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fp595QVyOtcYuRCtw/VrBPxdVC9lwsHWOZEKr/cx/ZUOpz0B9n44RO9ETt/dXlui+
	 SE/3fnw9uQQkbFBXk1hbhmJkHkQTpTRvFBNHKZ9aZE11xzRCkH8v6zpk8a3ne6p9d0
	 QuKc1RWuwYoaniWb2Wh0NGOiV/KP1zRVKpI3s0UT080sqqvPg1ycd8yDS/dmzHKHfl
	 gAb1v0wiH+5Q6lVY8S4Fea21OqT7SHXoV+9x1Ht9oiNmt9aNoRaLQUv7qS1xLA/l30
	 7bJAQTZBrXYWphoibXPi8BGPYWCcSPyOvnsce8g1/qHzAPqfN9w0JV5zt/rVQnOmfJ
	 /woNbdnlju3Gw==
Date: Wed, 19 Feb 2025 00:14:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] tracing: Do not allow mmap() of persistent ring buffer
Message-Id: <20250219001424.c457366901b9327a79e2b83d@kernel.org>
In-Reply-To: <20250215114540.7203feaf@batman.local.home>
References: <20250213180737.061871ae@gandalf.local.home>
	<20250214110722.7eaf35b42c4858e6b74500f7@kernel.org>
	<20250213212147.6511b235@gandalf.local.home>
	<20250214161332.8797b20f09e068c33f872698@kernel.org>
	<20250214070712.01997ea1@gandalf.local.home>
	<20250214233613.bde0638f393186f56f0b30eb@kernel.org>
	<20250214095943.178501fa@gandalf.local.home>
	<20250216003702.eef00d543ebbc3b16140ed9c@kernel.org>
	<20250215112153.55e56284@batman.local.home>
	<20250215114540.7203feaf@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 11:45:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 15 Feb 2025 11:21:53 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sun, 16 Feb 2025 00:37:02 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > > My concern is related to the fixes policy. If this is a "fix", we will
> > > backport the new "disables mmap on persistent ring buffer" limitation
> > > to the stable kernel (that was not documented previously.)
> > > 
> > > However, from the user point of view, "mmap() ring buffers" is already
> > > supported (although it did not work on stable kernel for now). Thus I think
> > > the "Fix" is expected as "fixing mmap() persistent ring buffer".   
> > 
> > This only disables mmapping of the persistent ring buffer. Other ring
> > buffers can be mapped. We never supported mmapping the persistent ring
> > buffer. Even in stable kernels, if you mmap it, it will crash just like
> > it does now. Thus, this doesn't cause any regressions. It's a fix even
> > for stable kernels.
> > 
> > Or did the virt_to_page() change recently where that wasn't the case?
> > 
> 
> Although the fixes tag is wrong. As the persistent ring buffer didn't
> even exist then. It should be:
> 
> Fixes: 9b7bdf6f6ece6 ("tracing: Have trace_printk not use binary prints if boot buffer")
> 
> As that's what added the BOOT flag and is in the same kernel version
> that added the persistent ring buffer.

OK, so this fix is for the limitation of the buffer which has
TRACE_ARRAY_FL_BOOT. When this flag is introduced, it should also
prohibit the mmap.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
