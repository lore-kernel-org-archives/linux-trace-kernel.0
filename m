Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500917BB23;
	Wed, 12 Jun 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206137; cv=none; b=WwIrWPyusmjauvcPBq7YHXzHCaoi1JMoZeq0sYUIIE7sF1kilpE3YHV8pPYIsWYrKnhDssv6FIpM0i4gO3Ev4zOoDjtvKLq28ZEDIDTUZiMtpN9ko/PLS3T0sP7vn3V0OEL13dqtSq8d1T/hqZYt1wBM5lcPbT/dNx4RMvq1dpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206137; c=relaxed/simple;
	bh=kQiMBK0k+rNB4ZdfcI9TBy6/0Qf552LfdY4dS6LInZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqaGygsiOm+Tk0nFeOaYQRBZFM6IfnZmlQyPgucuw1xX+cgOav2tV66SiMG7UI+41Ukn+QgRAwXYt6qyFrJePp7Tm3EpcJb1Th+4DYhRe494YMbpuLo1zwEN8Te5/1kRjROMvEpmTicTz2Ku40tQKr6BBZEr9Oedd+HxwtzmfZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A4BC116B1;
	Wed, 12 Jun 2024 15:28:53 +0000 (UTC)
Date: Wed, 12 Jun 2024 11:28:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Kees Cook
 <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, Guenter
 Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>,
 wklin@google.com, Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Joel
 Fernandes <joel@joelfernandes.org>, Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel
 <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240612112851.17664dab@rorschach.local.home>
In-Reply-To: <20240612073049.xof3ciae2x5qjp6a@master>
References: <20240606150143.876469296@goodmis.org>
	<20240606150316.751642266@goodmis.org>
	<20240612073049.xof3ciae2x5qjp6a@master>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 07:30:49 +0000
Wei Yang <richard.weiyang@gmail.com> wrote:

> >+/* Add wildcard region with a lookup name */
> >+static int __init reserved_mem_add(unsigned long start, unsigned long size,
> >+				   const char *name)
> >+{
> >+	struct reserve_mem_table *map;
> >+
> >+	if (!name || !name[0] || strlen(name) >= RESERVE_MEM_NAME_SIZE)
> >+		return -EINVAL;
> >+
> >+	if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
> >+		return -1;  
> 
> Another thing come to my mind: could we specify several reserve_mem on the
> command line?

Yes, in fact I have this on my command line that I test with:

  reserve_mem=2M:0:oops ramoops.mem_name=oops ramoops.console_size=0x100000 reserve_mem=12M:4096:trace trace_instance=boot_mapped@trace


> 
> If so, we may need to check whether names conflict.

Yeah, I can add that.

Thanks,

-- Steve
