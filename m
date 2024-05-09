Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9129CF3;
	Thu,  9 May 2024 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275885; cv=none; b=iXMdOtOzQkibsAPqF+5hLnoTi93MWPgvbos9Sw65TKb7+XgKSD74tTAEWP0v4fxLxSCA8zb905HYoh2B8WsZbt8edRh3ZBms8ZDOR9JRWDu4+xtiBBAH0xa+n1Zaajcc6uszu1v4gypjeXtB/Q2Po3CLsfw6DwTrj5ybfhh3Fyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275885; c=relaxed/simple;
	bh=KBr1nzhrVXmAr+eMtxim9nCzLnGrMYiBgpUtlgbJh+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lp8B/rjeep2DKHK02qB05e3Q/ZAMMoB2+hyP6YIPHlBSTRDBEsoUsCjY40kvJ+JF5o33l42jfl4R79qZUMu3bLWHmxPuPO45rRPcYwkEp+P/1dvzAA5gA0m9R+JmP/p+LRCx1c8maXgtDLlC/rW21ME9DsBTfnRdTpN4eovOcFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC7DC32783;
	Thu,  9 May 2024 17:31:24 +0000 (UTC)
Date: Thu, 9 May 2024 13:31:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "Luck, Tony"
 <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, Joel Fernandes
 <joel@joelfernandes.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, "linux-hardening@vger.kernel.org"
 <linux-hardening@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Ross
 Zwisler <zwisler@google.com>, "wklin@google.com" <wklin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Suleiman Souhlal
 <suleiman@google.com>, Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Message-ID: <20240509133122.474130be@rorschach.local.home>
In-Reply-To: <20240509000023.096d4032@rorschach.local.home>
References: <20240409210254.660888920@goodmis.org>
	<20240409172358.34ea19f0@gandalf.local.home>
	<202404091519.B7B2221@keescook>
	<SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
	<3391c693-cf54-526b-79a8-d565e7140947@igalia.com>
	<20240411154007.5bdf8d95@gandalf.local.home>
	<fa5fa4c6-2b02-f47e-b9ba-65cfd85f57f8@igalia.com>
	<20240412132243.053ad096@gandalf.local.home>
	<ZjJVnZUX3NZiGW6q@kernel.org>
	<20240501105455.42b78a0b@gandalf.local.home>
	<ZjJgIIOvvEdnisNA@kernel.org>
	<20240509000023.096d4032@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 May 2024 00:00:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I tried this approach and it unfortunately picks a different physical
> location every time :-(
> 
> So it is either adding to e820 tables or we create a new way to
> allocate memory at early boot up.
> 

Hmm, now I'm testing it more and it always seems to end up in the same
location. I'm not sure why it failed the first three times I tried it :-/

-- Steve
