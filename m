Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA4279905;
	Mon, 28 Apr 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860256; cv=none; b=fHtxCHGiTBFgXMh02QhJWj3Akmbu+o+t1V6fYnPEKlYbVJg7JbO2hqQraAfSO7oUkq7AK5o16uWYjcjrOZLQzgDesDe076WTKdGiLF2zVcc3hXPe3iFEDLRvTh2P4KzO+SMgI2mROgvbWDYz7GQwrAiJx9K3vXI8s2C/9MDJA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860256; c=relaxed/simple;
	bh=sZHRZhyj5pMp4MRhzvMj2XffQ6Wzn+Qml49c4H6YtrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdxRAfcjFuikVEQ5gXoyDsE+OHx7LUGNROe4A0Z/n2ZUSbsBqj3FP6zT4RW0vO8Gadybm5FLdbT4NfHKAnn0bFOo/5r+owOYEgcyPflffh/nIVe5SiaNX+hWRxv9oz9o4SGdR0PXjK4uNqJE8+wilVFmnGI7uT/no+Mb+KbI6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHL9DDcv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHL9DDcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92C6C4CEE4;
	Mon, 28 Apr 2025 17:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745860255;
	bh=sZHRZhyj5pMp4MRhzvMj2XffQ6Wzn+Qml49c4H6YtrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gHL9DDcv3Z5JecpwuZopOxwhjqrMd9+3UrYFq/trcF5sG7ix8vo4153oibvw0nZds
	 pvC4ddXhDoMzVUUHML/sB4nDb+zBOBLmdMFffDzHybcDSvVGkeKb8dsnw15BKZfLOb
	 0Y7uQCp37jDbPATKC3MOsGLhhFcTyyt25n9/k+NaokDa/AASUoRFGsCydn70IIBGJ+
	 E7EnECyIPKK+6w0V2baIKK6+OT9gOhWmQdyccEeWDi9tZ+0yEkNOJ+bBvj8BNmuBn0
	 IQkJSEyKrvSX8NwtFY/cMYL3thUJkiuzexCYR2LfOuHsIGIVoMMK2MX3qeXoj7/S0b
	 4Mbn9+NG4/m6A==
Date: Mon, 28 Apr 2025 10:10:52 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Remus <jremus@linux.ibm.com>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 5/6] x86/vdso: Use CFI macros in
 __vdso_sgx_enter_enclave()
Message-ID: <btzpfx5l43y5sp2j6zco4yh74g6zafo3jtmqumbjggjrwcoscn@vaorx7xtcmye>
References: <20250425023750.669174660@goodmis.org>
 <20250425024023.000117829@goodmis.org>
 <2d81ea94-e46e-497c-bbfb-8db38203e57c@oracle.com>
 <nl5qjjmdqgd6hrxefkhihjmzzdzt6lsjsil74pemlrywvsezkr@syb6jbpc2fav>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nl5qjjmdqgd6hrxefkhihjmzzdzt6lsjsil74pemlrywvsezkr@syb6jbpc2fav>

On Mon, Apr 28, 2025 at 09:17:01AM -0700, Josh Poimboeuf wrote:
> On Fri, Apr 25, 2025 at 04:22:22PM -0700, Indu Bhagat wrote:
> > On 4/24/25 7:37 PM, Steven Rostedt wrote:
> > > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > > 
> > > Use the CFI macros instead of the raw .cfi_* directives to be consistent
> > > with the rest of the VDSO asm.  It's also easier on the eyes.
> > > 
> > > No functional changes.
> > > 
> > 
> > Although unrelated to the current intent of the patch, a question:
> > 
> >   Why does the stub after .Linvoke_userspace_handler in vsgs.S not have CFI
> > directives ?
> 
> Yeah, looks like that stack alignment code needs some CFI.

Actually, this function uses a frame pointer so I think the stack
pointer alignment shouldn't affect the CFI?

-- 
Josh
