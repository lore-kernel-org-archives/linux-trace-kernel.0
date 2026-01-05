Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D527A3370EE;
	Mon,  5 Jan 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631816; cv=none; b=RV5iXoft7o06opZ5aqXurodEljhf9e9is60UsDPrC+Yms5JCdDACfNhVJqcc+04NxrR1DZvY/iqL2zh9TfK6NUNHs3qLIII6p7WZKEB6ecuUi9pW/XvQNRBFiZisR/B5BkpZfJnKTpMPqF2NbZgQZaKl3cUvAR0Ups9GL8IJxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631816; c=relaxed/simple;
	bh=QjQm+bycDFFeDXde1Pcoj2+ekMzkM7nvek428bxmyzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8OjMuugqtJVY6vaZWuYI+pNyokLQDOmmLT+EEdbIFJsb2wxLqnybd1xIwU4BWyCtzqaMGQoMejuEpNKd81WXhLsNGDgHQFnZr6ZV/Do0mggBrD0Z6H9DKRdPdx39KgpHinfidQdOYsjqKWyXQXQwV47GRzt30Gs6yL7sKwXzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id CC54D1A01B0;
	Mon,  5 Jan 2026 16:50:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id C74542002D;
	Mon,  5 Jan 2026 16:50:05 +0000 (UTC)
Date: Mon, 5 Jan 2026 11:50:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, David Laight
 <david.laight@runbox.com>, Petr Pavlu <petr.pavlu@suse.com>, Andi Shyti
 <andi.shyti@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko
 Ursulin <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Message-ID: <20260105115027.1aea85c1@gandalf.local.home>
In-Reply-To: <aVvoe5fQN3EUtEAJ@yury>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
	<20251225170930.1151781-8-yury.norov@gmail.com>
	<20251226115848.298465d4@gandalf.local.home>
	<20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
	<20251229111748.3ba66311@gandalf.local.home>
	<20260103005059.GA11015@joelbox2>
	<aVkSVk2L6VH9MYGz@smile.fi.intel.com>
	<aVkmQ4EGIQgAddZQ@yury>
	<254c1096c3b892923dd12b07a8b80291b88c0e9b@intel.com>
	<aVvoe5fQN3EUtEAJ@yury>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C74542002D
X-Stat-Signature: idz13ryxxjr91atgwngrfok7zygtutt3
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19supINbnwdWCMLx4+n0XP8la5ZW/l1co0=
X-HE-Tag: 1767631805-694570
X-HE-Meta: U2FsdGVkX1+D8ZxAlfx8ZTVUS8+VHfa4a5PuEEthOEndhQMr9j2WAdgNMKfNU0JLX+BZY7qz3ZwBP4OjtLh7tZKe9tsd59Wq9quN9m878arog0rbH0c/PP/WNy/05wieg/ovromGkJWys/94+HqDbQkfNO4m2bQENCWW7M7HN4dZzBlz+MiWzmDhPACeRXOIMG9sqBtd7u43+eRpVfAOllFgDTSccJOm1WVk4ruNei0wABLD0aIjqTqeU434OOWRQYq6RRx8qQI75kGh5P/79Qi+Lofqn39i8/aOeATec6cZFugLPICmiznlhqq9HfxGF97w/bIjotFGopaZ+dbLsxdK6TFPXcDvfIJjK12tRcgjtonU6SeUsROudhlB2cIhhkGqW8Zz5zks4Ki6Y2IbXg==

On Mon, 5 Jan 2026 11:36:11 -0500
Yury Norov <yury.norov@gmail.com> wrote:

> > You do realize this means recompiling everything when adding D=1 for
> > debugging?  
> 
> Yes sir I do.
> 
> It would be as simple (or hard) as building another arch:
> 
>         make O=../build/linux-arm64
>         make O=../build/linux-x86_64
>         make D=1 W=1 O=../build/linux-x86_64-dev
> 
> If you're both developer and CI engineer in your company, you're likely
> already doing something like that. If you're CI-only, there're no
> changes for you. If you're a developer - yeah, you'd have to learn a
> new flag.

I'm saying this right now.

Hard-nacked-by: Steven Rostedt <rostedt@goodmis.org>

Why do you want to burden developers?

> 
> The real problem of course is the status inflation. The fact that
> defconfig enables CONFIG_EXPERT and CONFIG_DEBUG_KERNEL implies that
> every random person who is able to do:
> 
>         git clone && make && sudo make install
> 
> now assumed an expert kernel user and active developer. It is not
> correct, and it leads to bloating kernel with dev-only features.
> 
> What we discuss here is a new marker for those real experts and
> developers, I think. (In an hope that it will inflate not very fast.)

This is a generic feature that helps all developers. The ones spending the
most time in maintaining the kernel.

Add the config I mentioned:

config HIDE_TRACE_PRINTK
  depends on TRACING
  help
    trace_printk() is an extremely powerful utility to debug and develop
    kernel code. It is defined in kernel.h so that it can be easily accessed
    during development or having to debug existing code.

    But trace_printk() is not to be included in the final result, and having
    it in kernel.h during normal builds where the builder has no plans of
    debugging the kernel causes wasted cycles and time in compiling the kernel.

    By saying yes here, the include of trace_printk() macros will be hidden
    from kernel.h and help speed up the compile.

    If you do not plan on debugging this kernel, say Y


It is default 'n' as the normal person building their own kernel likely
wants to debug it. Once you set this to 'y' then you get your "fast" builds.

Then in kernel.h have:

#ifndef CONFIG_HIDE_TRACE_PRINTK
# include <linux/trace_printk.h>
#endif

-- Steve
