Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A6022DA15;
	Fri, 16 May 2025 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386442; cv=none; b=YrS9cRfCTjd0QZZ2HMxB/pdyIoa0GWM6D53JUj1DxGUDkaxnArqw5CtJeX8YqVF+aAERvh6n2CK5ocMiS+KuwvPoKhvvidPrLZ9DsvyGGo0lR3Og4ibv0QSwIenlSwooHA4dscqF0W2umirupXkuAsYpFO0YllSvnyv9Au1TjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386442; c=relaxed/simple;
	bh=tpsrsFA5MborRsSdDPvezZT3AtK8h3l1uYooL/Kdq90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRklC93RAmA1FRmZBbLe9hf2i4r9E2Ha1mL15usyfi4dZxl9PuivQvm+1NuXZ+JWeouCksg3zjcmgqQrJlbb50g07VyygNazaCr2LYYZeSiyBAFU3dRT81G6uhTuUX7+UKU3tkP0uOAbKnRovHcIA6yoH3t21OSdvvwxWNkIQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oYZQB0GA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z9HThYfK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oYZQB0GA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z9HThYfK"
Date: Fri, 16 May 2025 11:07:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747386438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5osR2bWYYN0P9nNV8UDUFWHpF1H2aHP5wQW+njVZik8=;
	b=oYZQB0GAI6HTifE4M/kjoF+9vfwVLPLJWhY0kR+u3S1RJT+4Jq6DbnnmwmaCmE3zW01DEE
	DsbQ8uHLglMWcfpHY8wOW0J+xwuMghDN8z8IcFiN/hdfnOkiRGEb92FtL0N+Zoqu1z70hD
	y++OtbBLYPVegFrxH+FtHzpgOxGH9rL0pl2uo9+wv1CfPpQAtmjYS9Wqp4SUE42l8Q9i4b
	ZXXJ+uEM5PFpg20vP18sI7fYkTt1WYaUB/H5kZt/W8Ov7syOgpKYm3t/4vsNN9JBdLsNy2
	0ArlqWA46tafZ/4coJ8TZKa6/vbGmfqGZWjlRBOzAn4TtwRLA6dphVda773sAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747386438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5osR2bWYYN0P9nNV8UDUFWHpF1H2aHP5wQW+njVZik8=;
	b=z9HThYfKLtzhh+RMv6GDyaE2SZqwb0NSGVJc28gk2Z8peoVJWITv36CWu7uuLtYk9zyLCG
	i2XH14hiqnEN/XAw==
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
Message-ID: <20250516090713.VrZEEdqR@linutronix.de>
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

On Fri, May 16, 2025 at 10:56:04AM +0200, Nam Cao wrote:
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

Just in case of confusion, the "exceptions:" name is from the TRACE_SYSTEM
macro, not the class name.

Best regards,
Nam
