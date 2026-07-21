Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F833659E8;
	Tue, 21 Jul 2026 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594316; cv=none; b=L1u7j2d0wWO6NoWeLehkHOOuvn1ReeDZFR942+3Vb0W/IQScWw6WZTHPZKedy+zpL3CP6LO5jllyq33Il+YmL8GrPI+4XUxJOKZRygh56VH+ENO2lyJk6Y/bQW0TMlJclUimJlteybeGwNXygqha2R4hbt2tuCugwrkCSYZxXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594316; c=relaxed/simple;
	bh=jBddrH4ZJlWSqb48y2KqI+9vkGOcIvkKn1uFlDMLDN0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MYa4BLhWTgO79EBdvWI7VHepwDVL8/0GkRZKi94IJ9xcEaaqlFzNWdxWSuEbX9DSAXWGGu7LmYviIaSrBzAfFX69WrKyG+PawMdXGQreoYvmmaQzxoZukNc1iiRICglw25pswmI4Gc2m1okxz6YySlaG9LyMzZqb5x3RpTkYcDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heTHd6jQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heTHd6jQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664151F000E9;
	Tue, 21 Jul 2026 00:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594314;
	bh=HWYzSSvEdfLM5OpyP97q8ZolkKLSQ8fjHRgAnnAJoWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=heTHd6jQTTuFpcKXP+VjDTuE4fp3Om4KiJr37BEVSYbptxVxJn2rQAdpOdgGFOovX
	 h5XTY7gbuOMsw68Y7tf/b5/5ORDbncvRydX2XMJ7lU2x32N7h/Nubd4Vuim3GwnvGs
	 u6CocT9OQsLyoEd9xp0/Cfvojx7Amfu/MyuxPUxDzRq/u40ph34v1m8Y7vmJl2wQdl
	 L0qjA+oXRwnOjpQpNfaEnWpVxNb3S3JCUzrnnx6PxC1Pnn5YhbSiNTMIetdLnSJAJk
	 M2h3ImEbFpA6oV40TggXhZ0FwPbutrOr+TtKmPMXDjeBJgI9xwM24+oXAbyVny2GAd
	 jaIo125zrRnvQ==
Date: Tue, 21 Jul 2026 09:38:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, Steven Rostedt
 <rostedt@goodmis.org>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
 <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [linus:master] [selftests/tracing]  c5c413534d:
 kselftests-bpf.ftrace.ftracetest-ktap._instance_event_trigger_-_test_poll_wait_on_histogram.fail
Message-Id: <20260721093830.bb1d57a6a6d30c3f8651a292@kernel.org>
In-Reply-To: <20260720232952.94b33d59eddb69cf6457ded4@kernel.org>
References: <202607161651.ab0a5bf6-lkp@intel.com>
	<20260720232952.94b33d59eddb69cf6457ded4@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 23:29:52 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 16 Jul 2026 22:30:11 +0800
> kernel test robot <oliver.sang@intel.com> wrote:
> 
> > 
> > 
> > 
> > Hello,
> > 
> > in fact, we found below two test cases randomly failed upon c5c413534d, while
> > keep succeed on parent:
> > 
> > =========================================================================================
> > tbox_group/testcase/rootfs/kconfig/compiler/group:
> >   igk-rpl-d04/kselftests-bpf/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-bpf/gcc-14/ftrace
> > 
> > 22a78be4123dce81 c5c413534d40eb4c982f1794e62
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :31          52%          16:32    kselftests-bpf.ftrace.ftracetest-ktap._instance_event_trigger_-_test_poll_wait_on_histogram.fail
> >            :31          29%           9:32    kselftests-bpf.ftrace.ftracetest-ktap.event_trigger_-_test_poll_wait_on_histogram.fail
> > 
> > 
> > 
> > kernel test robot noticed "kselftests-bpf.ftrace.ftracetest-ktap._instance_event_trigger_-_test_poll_wait_on_histogram.fail" on:
> > 
> > commit: c5c413534d40eb4c982f1794e62813f926aba747 ("selftests/tracing: Have trigger-hist-poll.tc use sched_process_exit")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linux-next/master 49362394dad7df66c274c867a271394c10ca2bb8]
> 
> Hmm, this seems like a scheduler (event) behavior is different from what
> the test expected.
> 
> Steve, I think we should use another deterministic events.

I've sent a fix.

https://lore.kernel.org/all/178459323652.354837.10711230683477156733.stgit@devnote2/

But this drops 2 checkpoints. I think we need to use another deterministic
event, like trace_marker (but trace_marker does not support histogram trigger)

Thanks,


> 
> Thank you,
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
