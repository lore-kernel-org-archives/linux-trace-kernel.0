Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1E43AC5;
	Tue, 11 Jun 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123580; cv=none; b=DKuinD71/eXNacXUV+qzzRfCp38pDgswnKy7QkGSqR0+dczBSGoi7nIFXmnqkA/KxgyNJVCYAmxg0sowgyyAZSlWNcnFg8dW+ai9ktE/7rtNbjMQdN3B7M/ocws+o54zkt17vC2IWfT5T7epE9Gpz9LUcX07PQgMeJjWWa4uRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123580; c=relaxed/simple;
	bh=lMxIU0XrRl1uDi4V9mQvR4uYAOJm3ABeMJ3659SyNfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT4jXQFFVRX14SPPRyXV3JVgQDFt47/1iYHk7kFLLaF8WPWGhB3ZN3RnBtezLQr7+M6aMJ1ZkA1eiWLV/LRPvmUoJTHbvNgfvmcXnFhDjgkA4nta7YXYEqpJty1G8jbute7dQVCHiCuaaYXsnHRosBp6h3AMhNyYkTwvOI8TfC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0SeGOy3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0SeGOy3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BE2C2BD10;
	Tue, 11 Jun 2024 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718123579;
	bh=lMxIU0XrRl1uDi4V9mQvR4uYAOJm3ABeMJ3659SyNfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0SeGOy39UxoSlhAVdG/eluwXKp2QUawAC6eypf/lhxLj2IwA1gM1z8lmQek294p+
	 GLzRrfwOaIjPKGOBjrQyqnAZuX2GsKHDggIVMiZBtedF7VIN+zFpE23EE3qFnZ+m/Y
	 mChR4oemg9D9kd47zNiYzEYJhGlUemQtN6DtWwFZB14M/JHL6FGy+fEptHHt968qTu
	 cb624KQo3PzMm+RZ5w7xryiNG4sCp74j2XCTNoEMvTBWNwrwy8GtHfMIF+RONjOUdn
	 iiII/twh0quHERH/7BmNby08G2J3iqHq5xrIJy9hrrV6fTyEQ8sXh+3DKZXSSiBMzI
	 GJv3BakXu2fZw==
Date: Tue, 11 Jun 2024 19:30:47 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <Zmh7t8kupN2pbCF0@kernel.org>
References: <20240606150143.876469296@goodmis.org>
 <20240606150316.751642266@goodmis.org>
 <20240611144029.h7egl4aif5mjlrwf@master>
 <20240611111218.71e57e0f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611111218.71e57e0f@gandalf.local.home>

On Tue, Jun 11, 2024 at 11:12:18AM -0400, Steven Rostedt wrote:
> On Tue, 11 Jun 2024 14:40:29 +0000
> Wei Yang <richard.weiyang@gmail.com> wrote:
> 
> > >+
> > >+	align = memparse(p+1, &p);
> > >+	if (*p != ':')
> > >+		return -EINVAL;
> > >+  
> >
> > Make sure command line parameters are valid before doing the allocation.
> 
> You mean that size is non zero?
> 
> I don't know if we care what the align is. Zero is valid.

memblock won't like zero align, it should be SMP_CACHE_BYTES at least.
No point requiring it from user, just update the alignment if the user passed
zero.
 
> > >+	start = memblock_phys_alloc(size, align);
> > >+	if (!start)
> > >+		return -ENOMEM;
> > >+

-- 
Sincerely yours,
Mike.
