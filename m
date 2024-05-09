Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F009D129E7F;
	Thu,  9 May 2024 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286360; cv=none; b=bfZdb70vfCqNyVZjrRYdDjV8Owl6eqrg/GIwLz1GNP4Vrvr2KTVcdVB0Rm1r6+vv8pP897O5DIHfJDZhcnYvEXGzhlaVyfw0K2Kg/qeczRoBuBiV5qvlo42+EmXy2us4oY3tTaA2FGenGbRz9BaDGMJVOMpf3ftX1anD9Sseqjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286360; c=relaxed/simple;
	bh=hWSyULYaOsDE5daF7aXr2kaFDHZCM6PG5rvsb8AziAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahe0hLKgsdip8OYMYGYEkzPR/agMwvXJvN8ORW3dKjm7SEr8VHjJzpmBRG6anPzQRJsbPKM7ZVae7ThD4dkr6OUr9av7bpdO44Z3OH8b/hyHN3eit7Vuyqqub7nYwhWiDBhtldtnHDjKPend7oHKnD5lkFuAA60u0ITOivElWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAU+yNGu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAU+yNGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B443C116B1;
	Thu,  9 May 2024 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715286359;
	bh=hWSyULYaOsDE5daF7aXr2kaFDHZCM6PG5rvsb8AziAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAU+yNGu3oWaap3Iwie57YsH+TQekgKrvNRBDSKtf2+pPoaag2og5tdmfS/60jcSB
	 Yrt3PHyBBnPHaOXRYAhM6MtNn9VT3q7dlbATGg5UgpFkX6cXFvyTPKKBFLdSGiZ3Xa
	 Kr3/umv3oMuz78Jo9joI2e5RV0MwQw5ufqpWZvQ/kYPgcZyPg3kaTpHsE6UPujRITK
	 uqNfg3vXJVxZjJvFVpwuUcsA51tPMoIzlzvqfuYI5PwE5yRwSDO+Qx32olzViY195b
	 RuIKPHT692WlGrPxJD/lR6yQwju3e08mNeeuF6imrk6qBaO5T4xNgXu0ccHRcaTGuu
	 pxz2tq7ZvQXWw==
Date: Thu, 9 May 2024 23:24:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>,
	"wklin@google.com" <wklin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Message-ID: <Zj0w9MFfjFm6XqT5@kernel.org>
References: <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <3391c693-cf54-526b-79a8-d565e7140947@igalia.com>
 <20240411154007.5bdf8d95@gandalf.local.home>
 <fa5fa4c6-2b02-f47e-b9ba-65cfd85f57f8@igalia.com>
 <20240412132243.053ad096@gandalf.local.home>
 <ZjJVnZUX3NZiGW6q@kernel.org>
 <20240501105455.42b78a0b@gandalf.local.home>
 <ZjJgIIOvvEdnisNA@kernel.org>
 <20240509000023.096d4032@rorschach.local.home>
 <20240509133122.474130be@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509133122.474130be@rorschach.local.home>

On Thu, May 09, 2024 at 01:31:22PM -0400, Steven Rostedt wrote:
> On Thu, 9 May 2024 00:00:23 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I tried this approach and it unfortunately picks a different physical
> > location every time :-(
> > 
> > So it is either adding to e820 tables or we create a new way to
> > allocate memory at early boot up.
> > 
> 
> Hmm, now I'm testing it more and it always seems to end up in the same
> location. I'm not sure why it failed the first three times I tried it :-/

If the kernel and the command line were the same, they shouldn't have. 
e820 translates to memblock the same way every boot and the early
allocations also do not change from boot to boot.

Could it be that three runs that failed had some differences in the kernel
parameters?

> -- Steve

-- 
Sincerely yours,
Mike.
