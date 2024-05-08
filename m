Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD10B672;
	Wed,  8 May 2024 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715210641; cv=none; b=gwtRVvPzB8DnxjyMj2c0Hhrp+vAKnrtKFqSdyA2vIz7k1zwT+SfFMSkPW8jU8IB0RQP/lelX1QPU7LJcrHmToQCbPIE1qCFB0HRxpH0z7dz3LaCgKW+r1450P/CqbYW4icdHBn8H2IkizpbnTgVFM6S4z0SEfqF2rqo8CW2xB3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715210641; c=relaxed/simple;
	bh=vUTkfLdc7CqIpwGVwaRF5qhEnigzM/XCF5VTlfRUQJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lk8dP6TDSLfePVtj+YfQzueAI/ROZ1YjrskqI5J/W8WbH/lofbuydTzftrNLgqAi6msZP5QeSmUEtwHJXSniMfCQtSaBiXIFcHB6lbe8GhQHtZKzU6UIGX8GetzN4c4rVEyDhvDMPJT+yELmH2sj0cBneFTlTob0voJtqv/PW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96026C113CC;
	Wed,  8 May 2024 23:23:59 +0000 (UTC)
Date: Wed, 8 May 2024 19:23:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Ross
 Zwisler <zwisler@google.com>, wklin@google.com, Vineeth Remanan Pillai
 <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] mm/x86: Add wildcard * option as
 memmap=nn*align:name
Message-ID: <20240508192357.72bfcb81@rorschach.local.home>
In-Reply-To: <CAMj1kXG3jiLahONhPkKD0VSngDnMQoUCkDmoCsWEzOHDZmhTiA@mail.gmail.com>
References: <20240409210254.660888920@goodmis.org>
	<20240409211351.075320273@goodmis.org>
	<202404091521.B63E85D@keescook>
	<20240409191156.5f92a15c@gandalf.local.home>
	<202404091638.2F98764A41@keescook>
	<Zhmgm86tzpanoweB@kernel.org>
	<20240412181940.3e1d99f7@gandalf.local.home>
	<202404151017.FC002AA5@keescook>
	<ZjJYV7ak5ApgNTBx@kernel.org>
	<CAMj1kXG3jiLahONhPkKD0VSngDnMQoUCkDmoCsWEzOHDZmhTiA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 12:38:32 +0200
Ard Biesheuvel <ardb@kernel.org> wrote:


> The logic in arch/x86/boot/compressed/kaslr.c is now only used by non-EFI boot.
> 
> In general, I am highly skeptical that hopes and prayers are enough to
> prevent the firmware from stepping on such a region, unless this is
> only a best effort thing, and failures are acceptable. For instance,

I would be very happy with just a "best effort" approach. I think
kexec/kdump has the same issue and it hasn't been a problem in practice.

> booting an EFI system with/without an external display attached, or
> with a USB device inserted (without even using it during boot) will
> impact the memory map, to the extent that the E820 table derived from
> it may look different. (EFI tries to keep the runtime regions in the
> same place but the boot-time regions are allocated/freed on demand)

Part of my requirement was that the system is exactly the same (no
changes to hardware or even the kernel).

> 
> So I would strongly urge to address this properly, and work with
> firmware folks to define some kind of protocol for this.

We could possibly add that later, but honesty, that is something that I
doubt would ever happen. You would have to get buy-in from all firmware
stakeholders. I'm not sure if this is a big enough use case for them to
even take a look at it.

The main use case for this work is for pstore to have crash information
of what happened up to the crash. In 99.99% of the time, the firmware
or kaslr will not use the memory that was needed, and you can get very
useful information from the crash info. If the pstore is moved, it
should be able to see that the memory is garbage and just reset it.

Note that we can not use kexec/kdump in the field for various reasons,
and I need a way to reserve memory for several different devices (both
x86 and arm).

-- Steve
