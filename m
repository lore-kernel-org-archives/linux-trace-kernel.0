Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5E2135A;
	Wed, 12 Jun 2024 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217960; cv=none; b=NjpPkgdGxlKUexMQx1nP07jaec/j4p1cOyVJ/l3w6RYr8gJz0Tno1jINZ9apVWmkLkaoWdESTtlM6IIyyM78ZBw6KpLOA7QrzPc8zVByd5ANRDs2D1yM9kWdDrBvGKoX4stHJQfadDmQ3PfWkwtcjE9TrPlSISwG+6YGzrZBQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217960; c=relaxed/simple;
	bh=dXhvjwM/0oFIvt2EbGPoQJdmtCjDsX+7C5LbE2ZsBNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4PcrEsmaE2HTDNQYkowTdBis6NaEdb/7E2ca4aedo8JR8U4V02PJfCauRpLNj3cmZ0E7v9cFPNYkjYm24SyRuRZLAjAmJ9RNAPwwb7dMQONoZV2AbkHK8SmVba26qw8wIcd7WvJV4GdaTs6DGfPh7N6Y4TBicSE/wIAGkf7pgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbFj2lOK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbFj2lOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29118C32786;
	Wed, 12 Jun 2024 18:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718217958;
	bh=dXhvjwM/0oFIvt2EbGPoQJdmtCjDsX+7C5LbE2ZsBNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbFj2lOKKRLqmpNJyH1ELmss+TDEz4RJ1NB0NKtbvEQ2Q6/0z5WVXLtB/tOQOZ0KV
	 EAy+4jYi1xAS63Q/3Nmc3D53yrduqGvkwkWy80rWFLxGYC/t3ubqBJD90Hw6ORZiAm
	 tw+lzL1LOEn4fgoAEEB2R8Vb8Nu6CeOFEk1/4IECUnTQ1kPSF4v1GPdUyuW4gnaV8w
	 h55x04pfatlIDpIiWLt2lDQPIYDhcA3YGu19NkxWsRwfKSuLPCjIGqMPtncmjSd6LE
	 M0qxhxk+ERJ7Q6e3qi8IC4pbnahl/1I6ROoaU7q+pzDF+hzQWqOx0q76fNHfbPbuck
	 06aLuT5irhExQ==
Date: Wed, 12 Jun 2024 11:45:57 -0700
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
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
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v3 2/2] pstore/ramoops: Add ramoops.mem_name= command
 line option
Message-ID: <202406121145.8860502D7@keescook>
References: <20240611144911.327227285@goodmis.org>
 <20240611144949.703297941@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611144949.703297941@goodmis.org>

On Tue, Jun 11, 2024 at 10:49:13AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Add a method to find a region specified by reserve_mem=nn:align:name for
> ramoops. Adding a kernel command line parameter:
> 
>   reserve_mem=12M:4096:oops ramoops.mem_name=oops
> 
> Will use the size and location defined by the memmap parameter where it
> finds the memory and labels it "oops". The "oops" in the ramoops option
> is used to search for it.
> 
> This allows for arbitrary RAM to be used for ramoops if it is known that
> the memory is not cleared on kernel crashes or soft reboots.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Kees Cook <kees@kernel.org>

Let me know if this should go via the pstore tree, if you'd rather carry
it?

-- 
Kees Cook
