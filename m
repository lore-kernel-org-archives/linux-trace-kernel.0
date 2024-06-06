Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16955197A6A;
	Thu,  6 Jun 2024 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685407; cv=none; b=OGM0cjaJ/Ztm3qegf2HlQIf9C4KTZZXF87RqsGX+pbOgZi4ezI5m1/IhdeJNnTUFu7Le1Opv/btB/UkF1kCqCQG9LpSly2qfJZv5UV+2B1jk9mPHHd5XHbDg5YGC5l0jX9WrwXMENBzZkYRpBBbu3wJcGLWTlU2CQNziftoW+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685407; c=relaxed/simple;
	bh=jmrvv5mciAYj7KHnk+dVNZFlkNGJV5J8UVdaURNL02I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKCB8Qzc2qgkakC4Me+8TNyV02LKVsBz+0b1S56yxlJc1SkfpOKqnwGPt5hT9b5hM9t0TQ6WfCt/j3nB0PLGlKC4l4vv0BjkZD71X+BpKrOyF0oXzXD8vN8hWAXUE8GNdg7V1gWiSCm4m35OiPzDNd3UYJJUbpX2hbYyO+A9gJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4942DC2BD10;
	Thu,  6 Jun 2024 14:50:02 +0000 (UTC)
Date: Thu, 6 Jun 2024 10:50:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, "linux-kernel@vger.kernel.org"
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
 <peterz@infradead.org>, Kees Cook <keescook@chromium.org>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, "linux-hardening@vger.kernel.org"
 <linux-hardening@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 "Ross Zwisler" <zwisler@google.com>, "wklin@google.com" <wklin@google.com>,
 "Vineeth Remanan Pillai" <vineeth@bitbyteword.org>, Joel Fernandes
 <joel@joelfernandes.org>, Suleiman Souhlal <suleiman@google.com>, "Linus
 Torvalds" <torvalds@linuxfoundation.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mike Rapoport
 <rppt@kernel.org>
Subject: Re: [PATCH 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240606105013.6435d553@rorschach.local.home>
In-Reply-To: <SJ1PR11MB60836B1DBD5C41BF22A66430FCF82@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240603233330.801075898@goodmis.org>
	<20240603233631.452433539@goodmis.org>
	<CAMj1kXFoNT25+ZTFaqF8zj4VkN6FFbtX5Fntf+J-c33tW3TPUA@mail.gmail.com>
	<20240604070826.030c5202@gandalf.local.home>
	<SJ1PR11MB60836B1DBD5C41BF22A66430FCF82@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 16:05:04 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> > I have been using this on two different test machines, as well as a
> > chromebook, and it appears to work on all ofthem. As well as for VMs. I
> > plan on adding this to my workstation and server too (they use EFI).  
> 
> I think that BIOS on Intel servers with ECC memory will stomp on all
> memory (to ensure that ECC bits are all set to good values). There
> might be a "fast boot" BIOS option to skip this (but using it leaves you
> vulnerable after a crash due to ECC fail to hit the same error again).
> 

Talking with some people that are interested in this, they told me that
those servers (the ones that take several minutes to boot up) usually
use kexec to reboot. Even after a crash (with or without kdump). In
those cases, they said this would likely work for them.

Again, this isn't fool proof nor guaranteed. It's a best effort
approach that, at least for my use case, works most of the time.

-- Steve
