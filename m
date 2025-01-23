Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C4A12C475;
	Thu, 23 Jan 2025 01:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596926; cv=none; b=AyLZalxUIKVcDERDdiJgeWpEQPSaKLk8MnAMXKRqI+RKdZia3xi1fTeUlEdJ8O+1egiQiXaF/m/P43iFgOfbC5bDq+KwZRxpQaVapfqSnv3yrSL+EJiYqYol2ZTt3GzC3SReUm5+529rqNbf9/6e8dv5jRE1mi+BGdzmskQ1rT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596926; c=relaxed/simple;
	bh=VdIfwH9DCllkF0gmoqh6DXTPUcd2mI/piWjcd6eJewc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SirnHvzZGui6R8ewLl0pvjLU/+cnSgOj7Q+JReJb4Lca607YXmHcHWp2d/pB8Q6UAhY2C21rMedH1+meHkHSwgsiIH4Q+ooGL6bLdVxZlsJZHcOF1Dg2E3xINI6Jp/1dzyu7OLC6xFOPg2Q8PMJG0/6m9TrmzALTjhZWaV1my1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb2d8+uU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb2d8+uU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F087C4CED2;
	Thu, 23 Jan 2025 01:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737596925;
	bh=VdIfwH9DCllkF0gmoqh6DXTPUcd2mI/piWjcd6eJewc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Eb2d8+uUfn+XIcvtr4UkLBIg/h/Vh0X+qgb3av9ofe49nmD+5TMCoctUI10qrPkiQ
	 TUt0+0dj9UKtvswYtYEyLFDn7Z//94bVGB5iU7Mv6o80/1NNGCiNWudxiXNkMUZIXI
	 BdDXJcX85hNpugrgbFot203eQaayyeAKYxRy/qRn3QOQjrai3A1a1tDgk04Ub3diNl
	 gxqcFoA0BgJTddgFud5c3pWX+g9gXUmS3BXGqaTOLjnv52z+RI5QWfVmujbNzcfUz8
	 Kq8hNOtJCUZu4IgZhUKPxd84B4pd+4eNcNS7XpJSsY5K1vXF3jZEUxMWTU4lJssjes
	 aeNCMs8RJ+wDQ==
Date: Thu, 23 Jan 2025 10:48:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, naveen@kernel.org,
 anil.s.keshavamurthy@intel.com, davem@davemloft.net, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: kprobe on local function
Message-Id: <20250123104842.92336327f898e546c5b67536@kernel.org>
In-Reply-To: <20250122172936.09bc8c9a@gandalf.local.home>
References: <20250122075939.qw7HsuMd@linutronix.de>
	<20250122172936.09bc8c9a@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 17:29:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 22 Jan 2025 08:59:39 +0100
> Nam Cao <namcao@linutronix.de> wrote:
> 
> > Hi,
> > 
> > I installed a kretprobe on the function "rt_mutex_slowunlock". Although the
> > function is called, the probe is never hit.
> > 
> 
> How did you install the kretprobe?
> 

If you specify one original 'symbol' name to tracefs/kprobe_events, it
only sets the kretprobe event on that symbol.


> > The reason is because there are 3 copies of rt_mutex_slowunlock() in
> > vmlinux (at least for x86 defconfig + CONFIG_PREEMPT_RT). But probe point
> > is only installed in 1 copy.

You can add those copies manually on the same event but,...

> > 
> > Is this considered a bug? Or is kprobe not intended to be used for local
> > function? Should we modify kprobe to support such cases?
> 
> It's not a bug, but just the way the compiler works.
> 
> Have you tried "perf probe" to install the probes? That uses dwarf info to
> find all the functions.

Yes, I recommend you to use `perf probe` (under tools/perf) to put kretprobes
on those copies. See tools/perf/Documentation/perf-probe.txt for details.


Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
