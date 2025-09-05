Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075E2750F0;
	Fri,  5 Sep 2025 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079815; cv=none; b=F2FdWXnG3GW2KSTiA6DuZ/KRMomhPwzsTbU3I1JWyELVkO8HKhejkechQZZvzR0MX2DLeCT+vvR7k6ffO2ZCahcesX0qHwBfRpinZ/bWuoR0RcI1Ph+1t+o6lhNu+gXD1v3iKD02iKZl8USVmsINZotjG866pNjIV8/QETdewuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079815; c=relaxed/simple;
	bh=tCUjMHHCl/gwyX6Je7S4esPQkPk1Jl5ydpTIk1TU3L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6QQb/qVBChO6olOXwrYqZ9uj/5CM/EF0lLqzUqUPbmjUsMao7ym4lkm/oqeAGHk4nLykVS1zXxfrexsrH9dWtNYW7+7YeTL+DUfUdZ1NW5P0eeEEZ8y/pkF+ScAsvNds6KtAQmkSMRrVrNV1FIu1FywL2jqOMTqU2aunHTgTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0wqGjCP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0wqGjCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0508CC4CEF1;
	Fri,  5 Sep 2025 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757079815;
	bh=tCUjMHHCl/gwyX6Je7S4esPQkPk1Jl5ydpTIk1TU3L0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=A0wqGjCPeCJXRBA5Ba/Ux6U/SNko2XK4EI+DRA4rkXa0Z5O3CW5RD2RvMtNd5vjO7
	 ZV23+IP4kSpkF6fIuCNskr41/+jQmMF+ygS2JW6EIX5sitqMMy58Eauda/y7aMfmIv
	 mJ3rt5+JI/CrSPpuOYhu2BUKd+LChElafZ5uQH68vVq+kA8CRZrvo+r88cwkGlWq+0
	 cZE0RgWzibGQopQDAEBVn5mr1Wc8V37eZbdVETQlquTJPCkfoXtim0YJU/dUqt7YBu
	 HX/QhBt7e193/wdrPUs0sCIoNnJtjdyDOjYI8uKsj3CnTsAr7RTncGnND62jx7+CEr
	 SuVnbuZrmZZ3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A196FCE0E09; Fri,  5 Sep 2025 06:43:34 -0700 (PDT)
Date: Fri, 5 Sep 2025 06:43:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2025.08.13a] [tracing]  364ac25d46:
 WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault
Message-ID: <ea678a68-6a32-42d7-a9c7-f80261d02093@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202508211038.c93e8603-lkp@intel.com>
 <68044ea3-32c1-4d72-9bd3-fe2031669d79@paulmck-laptop>
 <aLebLoM2OQD+KPxQ@xsang-OptiPlex-9020>
 <d1ee722b-eb90-4b7e-9c2f-2db7d3b33ce9@paulmck-laptop>
 <20250903113112.247eb552@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903113112.247eb552@batman.local.home>

On Wed, Sep 03, 2025 at 11:31:12AM -0400, Steven Rostedt wrote:
> On Wed, 3 Sep 2025 03:31:31 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > by applying the patch, the issue gone. but since you said this is a 'diagnostic
> > > patch', not sure if it's a real fix. anyway:
> > > 
> > > Tested-by: kernel test robot <oliver.sang@intel.com>  
> > 
> > Thank you very much!  This tells me that something on the code path from
> > the tracepoint to the BPF program needs to have preemption disabled.
> > I will leave the diagnostic patch in my tree, and will be looking into
> > what the real fix should be.
> 
> Was it a BPF program that triggered this? I couldn't get that from the
> backtrace. Also, is this only a x86 32bit issue?

Excellent question, now that you mention it!  Your thought is that
one of the other preemption-disablings might need to be moved?

						Thanx, Paul
