Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F422D4EB;
	Fri, 16 May 2025 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385769; cv=none; b=HASx7N+95suyvC78l8RINfdlSNg5+a/i7SrmA37V7HnYAyjj7HqbS9KmI31VLPIeooBJBzIAQqxLNamQK4dRcy4xErdurBh8wWW2zdcjiYtWBGE0ZoWnD9V6RSwPoDbZxHanTv1W4NlJkq8TTDmRcSNt3C8t60MDu2XTA8AXzo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385769; c=relaxed/simple;
	bh=MUMWv/JgUKAZa+WAOKzHRQ9xhc06QHh3pLX4LbdYiGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTSvTH3EMq/AX+uvjpoUx0wWMX+IYdRBJn2GZg67L0NDMbX9OzHSw4tt1UgcZdC7sg0+mqKAK300JooCR4ERQfAWVIP6NkQusc0wlZZ49pwJcMfS5GN32EBQe+SUYybKALajXsgb5JILmI9IgMoGrqWWBa79CU4dTKpE3i5s9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aBYd6I8/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6ufqT1mo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aBYd6I8/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6ufqT1mo"
Date: Fri, 16 May 2025 10:55:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747385764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpBkNoozJVxD0Tq1ED6D91sfOcjjeUcczIiXGsr8Xa4=;
	b=aBYd6I8/V6Pks/ycPy+/9hpvymndG8CqJ3udu8r5+O0NqEyuqUjG8dV+Xilch/vOYTSS2O
	Za0yiBEoQYer3mi17p0x/iZUvKU4c7R1GKeXbqQcimcw1rWdDsq0dyx81CRlHqgRep+F5v
	s60YuWaabOj1Z7t472P1i7+AKQmCVDH0ZVMAFovdZeD/wxWJnfhLUdbHvqwlT3Rcm/sIEo
	/rN8R+Iulo7vx1CdPsKGLq0KL+BTBfYxAPGftCib7K8aCN7mLOyE5arjDB8P0xwYDAIXy2
	2CyW8fkln40Uq1Wz0hUYPqye6z2gb/K2ZZ2R1grOVtwAP/HnCVItGIc0ea6xnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747385764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpBkNoozJVxD0Tq1ED6D91sfOcjjeUcczIiXGsr8Xa4=;
	b=6ufqT1mobYp7JSSs1K0Omsc0AhHenLEHpntMn1SMwQZs6Bqn7id7Xzyi9d/oCd+si9xvqM
	XFCxkDCbqLKa9mDg==
From: Nam Cao <namcao@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
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
Message-ID: <20250516085522.g9Uq2WBN@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
 <aCb1kBEkiriPbMo4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCb1kBEkiriPbMo4@gmail.com>

On Fri, May 16, 2025 at 10:21:36AM +0200, Ingo Molnar wrote:
> 
> * Nam Cao <namcao@linutronix.de> wrote:
> 
> > Nam Cao (22):
> >   x86/tracing: Remove redundant trace_pagefault_key
> >   x86/tracing: Move page fault trace points to generic
> 
> Does the renaming of the tracepoint class from 'x86_exceptions' to
> 'exceptions' have any negative effects on tooling?

No, tracepoint class name doesn't affect userspace. The tracepoints' names
seen from userspace are the same after the patches:
	exceptions:page_fault_kernel
	exceptions:page_fault_user

Best regards,
Nam
