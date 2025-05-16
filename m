Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8811A704B;
	Fri, 16 May 2025 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386764; cv=none; b=RXymRvdf7t4fcq1VgHofwB7AYX2zjiHpc5P7JShb55KsMMcyAfEEovHd2xGOThXHq33WQ2nrqyKbl1lKSPkhf959UFakTHVtGImaTCeWzYrXO+ViZShv+F2zaiEg150tt0nPzxj7zcrnf51zEoy4guH4xL7nuN0lxSVT3MwU9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386764; c=relaxed/simple;
	bh=To9rgQRvNKeScnKbTmPrF+XAs6vdvnfL46mXdQcYXdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezc4EjwWt5HFte+IPz5cBE5YnjXdAYbcEWevCvuQ3kaP2v3EaGyACLzhfslNwwaTw5s2zp6T5KxBmQwaefC7LWbsaMI5arcEFBkvms7ROGKCSSqihnghXdSwyiOmvcLb95+yl3szt5TNumIdjAq0a55R0ZpOag1tknCPKgze0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUNsK4qB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUNsK4qB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6047C4CEE4;
	Fri, 16 May 2025 09:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747386764;
	bh=To9rgQRvNKeScnKbTmPrF+XAs6vdvnfL46mXdQcYXdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUNsK4qBaBBxJzi+e2ykS/6qWXVQddxS9Y6QIEcvzHTxHXg/f62zmMKWHawGqlyhY
	 AWznps5s1J2sUy03zPQGgriWJAI46hZiHkcwLdUcYvrlzEaZSifRuMYd5CDLAYeOaK
	 tQWaDgR1CUnEHhVo+S4SF26NLDVXZ1oVNeqRt8D6MX2sqcH/w+ZS1Hy/wMeY9hVSRi
	 tp8ZMZZjwvfReMsf5czOmR/92uPN8/eM+K0sw+iCkp8v2EHxW2l1UhdX3ryV/gi1U9
	 oSxvAN0F46d4DT00wP2bNtstMUrrDyV16NmgxbKeSSpN/pgWsU5ELUb0KtYda+7rNU
	 yxF4Txjj8Ilgg==
Date: Fri, 16 May 2025 11:12:37 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 00/22] RV: Linear temporal logic monitors for RT
 application
Message-ID: <aCcBhY3zYpuH_oIr@gmail.com>
References: <cover.1747046848.git.namcao@linutronix.de>
 <aCb1kBEkiriPbMo4@gmail.com>
 <20250516085522.g9Uq2WBN@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516085522.g9Uq2WBN@linutronix.de>


* Nam Cao <namcao@linutronix.de> wrote:

> On Fri, May 16, 2025 at 10:21:36AM +0200, Ingo Molnar wrote:
> > 
> > * Nam Cao <namcao@linutronix.de> wrote:
> > 
> > > Nam Cao (22):
> > >   x86/tracing: Remove redundant trace_pagefault_key
> > >   x86/tracing: Move page fault trace points to generic
> > 
> > Does the renaming of the tracepoint class from 'x86_exceptions' to
> > 'exceptions' have any negative effects on tooling?
> 
> No, tracepoint class name doesn't affect userspace. The tracepoints' names
> seen from userspace are the same after the patches:
> 	exceptions:page_fault_kernel
> 	exceptions:page_fault_user

Perfect, thank you!

Since there's been no new review feedback about these two patches since 
-v5, I've applied them to tip:x86/debug, with a v6.15-rc6 base, because 
IMO they make sense independently of your series as well.

Thanks,

	Ingo
