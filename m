Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14D179AF;
	Tue,  4 Jun 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510713; cv=none; b=ab9DCXtmvO0L+Z09GiPnYijuYhjAGZTXCC/J/MnFVv4n04bwwpk+MiZvTEEEy4z2a1ws/O356+KU6A45DIES+7b3V2ittQeabTBidRKQWtYQEEq337NSW94e+AzB7pF9+PnPnj5ppf2Oacv4YjIpjYb4c9VptrclBP78aYADouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510713; c=relaxed/simple;
	bh=pvPs7V3cXWF0iTPQLtBmOn4r0QtFbU+zXkNlnCR94Z0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O26yis7N4ZuJiKOycNeLnKUr8SUSICxGyvVPfZoAZkudHSxi8Q9ECOW2uVS7ZsnVRRqS2c3/ZSx893wYb4khK6Y/KtgE0XXQwHqahsM9IUYsAEbEBRw28ezfOmFDaIRB6igLr5rhmQgmAdjVUkgof7y0xMbXz+ukGMzQ/skpejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcLUXyHJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcLUXyHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FF3C32786;
	Tue,  4 Jun 2024 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717510712;
	bh=pvPs7V3cXWF0iTPQLtBmOn4r0QtFbU+zXkNlnCR94Z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TcLUXyHJDe0+47voJSe8NWV+gi7KKtVnk990WzJKPVnnTGUzmXMsqzgj/Ln05kBeR
	 cypi6Dx8RrUbmuy11i/vwPc9T9Jay7ZipYwhJBzhJB8To/dCAp+bHFx4wtcvDGCtpL
	 riH1koHSM7xhuEeh90WRHLjnpcUPG3lXJsgoATkJmFDlhDx5MyxD7SwfIGfn9y0KWw
	 ZCU6DzqANLDnZZoKV0nAwM217CczrH6VT/+Woe6f6fG4gg/Pii53AVl7At+nDpYy4O
	 8PJy4zCq0ikmMN/hiAH4zlowebcBBYOk/3tIBhCkOI3XAxX8Uiy1/0hMk6eMXjbke3
	 R+W3D8DNgpB8g==
Date: Tue, 4 Jun 2024 23:18:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tracing: Fix some selftest issues
Message-Id: <20240604231829.16b49c8868d310bcdcd78cab@kernel.org>
In-Reply-To: <20240604095746.1bbb003c@gandalf.local.home>
References: <171671825710.39694.6859036369216249956.stgit@devnote2>
	<20240527192907.49c9220f@rorschach.local.home>
	<20240529014640.3a04f7301f12eb44738f9f2d@kernel.org>
	<20240529083818.b7835de167191d4567405ce6@kernel.org>
	<3a7e679712fb47b6c75af84163b5d3ea252f4da9.camel@linux.intel.com>
	<20240531113721.c0314e0cdb3beb70c1a6ba7d@kernel.org>
	<20240531032425.3635dc93@rorschach.local.home>
	<20240531232047.fca5712a98e360d4a27fd92c@kernel.org>
	<20240604095746.1bbb003c@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 09:57:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 31 May 2024 23:20:47 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > The major conflict happens when the boot-time test cleans up the kprobe
> > events by
> > 
> >   dyn_events_release_all(&trace_kprobe_ops);
> > 
> > And I removed it by [3/3] patch in this series :) because it does not
> > needed and not confirmed there is no other kprobe events when the test
> > starts. Also the warning message are redundant so I removed it by [2/3].
> > 
> > So without this [1/3], if we apply [2/3] and [3/3], the problem will be
> > mitigated, but I think the root cause is that these modules are built-in.
> 
> I'm OK with making them module only, but I don't see any selftests for
> sythetic events. I think they should have a boot up test as well. If we
> remove them, let's add something to test them at boot up. Then the boot up
> code could clean it up.
> 
> Or change the test module to be a boot up test that cleans itself up if it
> is compiled in as not a module?

Yeah, I think we may need another test code for synthetic events, which
also triggering the synthetic events.

BTW, some these bootup tests can be ported on KUnit. Do you have a plan to
use KUnit?

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
