Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B96F073;
	Tue,  4 Mar 2025 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072106; cv=none; b=aqTgmcz+KVn0Ei9iR11NI0boFRyFrjRML0g8DZQ7QWBs07DKh2Rl9Vyji02wQtR/S9VmZjWGpc+yb/cG3oHWNyLxY0NHuVkJwNBvelc7AdltIvWTBWg9SpZlRHOlPK3FwPz2NgVFyy1SYbybcIIy902o0hCTrylyJQiKycvsZ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072106; c=relaxed/simple;
	bh=2ojdVaJ4G76tqTc/qqQChnWRj6JmQQElqU5o4AQFH7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jca+UAStQqmEm2Q6AOO7NNsIRCNSeuLRKcCPrx8+6CwxAQeLm5xWyaIHEjulN7b5w3Ct3LzDOtbu+TlVktSDt/xCQjk0IEmNPOZlKR6muUUTP0GvkBmafAEEFTUZG1CDBj87REuv5BKk1LILIb0lzd+jWvfJ0rrLzxA82Jc7wwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+ovV/tt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+ovV/tt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F119C4CEE5;
	Tue,  4 Mar 2025 07:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741072105;
	bh=2ojdVaJ4G76tqTc/qqQChnWRj6JmQQElqU5o4AQFH7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+ovV/ttnXAPC/wyP4rwOjCuqHCbXC4A2U2SnoAqVdWj91nMEqjbTEP/TQmZVqg9h
	 /rKTfvG+wylQijMYyaa3DwiDEAeZN6V4RAfMgKlIZNY7VUkGT8ZCH0wQ+ZkStYZzOj
	 1so1lDBqXes236aR6nO5kg0Ww5n0Z/EI5VtgtuMoNxTxPkh1FEJ0QxZ0yfzKib5R9t
	 sQmydH0+0erhD3LwXiweB754p8nk4SQz8DTUnn2zRnEcMZQpQDpsA4YR6gU2hcDIef
	 NaYChZSZIHhL5Eij3GaFzoi6ZmfBxM2v0KUEhetIHG5jfAnDjYwYGmJ3hIUlmwkYVm
	 kOFK+hBC296PA==
Date: Tue, 4 Mar 2025 09:08:12 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/ftrace: fix boot time slowdown
Message-ID: <Z8am3EgVK9qADIgJ@kernel.org>
References: <20241124140705.2883-1-rppt@kernel.org>
 <Z07KnNk5AK_Jq6CU@kernel.org>
 <20241210230056.185826cd@batman.local.home>
 <20250303172427.1ae6c924@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303172427.1ae6c924@gandalf.local.home>

On Mon, Mar 03, 2025 at 05:24:27PM -0500, Steven Rostedt wrote:
> On Tue, 10 Dec 2024 23:00:56 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 3 Dec 2024 11:08:44 +0200
> > Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > > Gentle ping  
> > 
> > I'll take this if nobody else will.
> 
> I guess I'll take this for the next merge window.

It's not relevant anymore, the commit that changed text_poke_early() to
text_poke() is now reverted in tip tree.
 
> -- Steve

-- 
Sincerely yours,
Mike.
