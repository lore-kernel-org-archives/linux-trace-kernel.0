Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0BF25DD10;
	Wed, 30 Apr 2025 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746040693; cv=none; b=a27hT/c7Y6x42Wp3v+JzkKqOdHZuPWnH9bTMLK1A3HQ1DehXShsGg2G7l2oEZmXASn0u4tWRELZoRZjpRnUkTBN1EmuNEW46M3Q2OiUQemasEzvqdRfSjpVa8M2ZF3hfJRcOMq4gfEqyz4XGu7VQ1h1zI8we8dK+CRwEsdEEGiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746040693; c=relaxed/simple;
	bh=Y2qpOIMsb8pa3rCb9o42f9nrygLlXpgYDt/QMQ9ojZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCYltLoUPm/p4rimnbCzaBJIlDApCQ9dgI7zbrOq8JslNfDeuk0civ1BCSnbFVc7PEXpIo69q8AOcRJ4k6JpAd7lE+eybBcc6EnGiu3Mhb67JjaaT59f35t47kmCPZwCak/dYAx4ZOeMGivtAOHgGg06HCzgdQGq0MK26M5TAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59515C4CEE7;
	Wed, 30 Apr 2025 19:18:10 +0000 (UTC)
Date: Wed, 30 Apr 2025 15:18:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, john.ogness@linutronix.de, Petr Mladek	
 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Ingo
 Molnar	 <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav
 Petkov	 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin"	 <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra	 <peterz@infradead.org>, Catalin Marinas
 <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/22] RV: Linear temporal logic monitors for RT
 application
Message-ID: <20250430151813.0ec8f762@gandalf.local.home>
In-Reply-To: <cbcefdb80d5e10b8fed80de17bb97bf61df81386.camel@redhat.com>
References: <cover.1745999587.git.namcao@linutronix.de>
	<cbcefdb80d5e10b8fed80de17bb97bf61df81386.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 14:17:30 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> Steve,
> 
> >From my point of view this series is ready for inclusion, what do you  
> think?

I haven't had a chance to look at it yet. I'm finishing up some deferred
unwinding work, and then hopefully I can take a deeper look.

> 
> We may still need Acks from the x86 and arm64 maintainers regarding the
> tracepoints changes, though.

Yeah, probably want to start pinging them.

-- Steve
