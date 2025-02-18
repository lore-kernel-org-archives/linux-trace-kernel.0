Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F622690FE;
	Tue, 18 Feb 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883993; cv=none; b=XNhAa0lvJ4lw32+YdJHowib88iapPt740FhfaP+ykWTAT+nzIyPbiX/WJ+43xYzLCJZY57WToYr0oqbwRKMMCNp0w87VvCV5bRQucZh0Lk2VWsapyUDvkIObkqciCxJ0W9dOP0hj6HQfDX/uohqcjN6Bht9TxJ8D8azza/WCrSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883993; c=relaxed/simple;
	bh=YodAmXd4oybScYWK8pNDUTkadK7M3omvdyYffhVFwN8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hGBt5onBTOyorI74VUuzH11Ocs+mm3lSIY03PRkQ77xI7sZCEbNmWWtxZGOQXqwbMYFzcLYCHLWeef3YEgbcooYgZjlFvSlwTFcuSx16M3w9PJeUwmYpiihzwU+PZpkf2/Mt52gmsag63Ngpop0D8bKCh+myrZ3SQ4s8SDGX+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwJX5dZK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwJX5dZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5259EC4CEE2;
	Tue, 18 Feb 2025 13:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739883993;
	bh=YodAmXd4oybScYWK8pNDUTkadK7M3omvdyYffhVFwN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RwJX5dZKGEAx2BCwkf+b+WqYyNQVu6NPYzFcunnG51iBEOEidGQjcnq1W+7r0bCQ7
	 cCqNfV44z5Q0V1ixU4WZmL92185hc0KGmZl2uAqdCSOhVxPnEwtqEqAcQUkE9k4ZxV
	 3oh6pYDgmYG4c5c9PL0V37a5xODUkx0f9gUnL6oP0hy6pW6ioV8G5oWnlyS9/Z/QFY
	 jBnfXtRk0U08P+MKGd0lfafF8q9mcWxu2FlW8o+kbO3OLxJrbJJlNFj/ZE/j4pL71G
	 PCHfiTNB1vPrb/fveOAplSQY4cqLER7QwqG5MXoxgOg257pO+xc4bYhScncbEVoRDa
	 nmRBLsx1gZ0nw==
Date: Tue, 18 Feb 2025 22:06:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] mm/memblock: Add reserved memory release
 function
Message-Id: <20250218220629.6a352d70e0350b01e662d782@kernel.org>
In-Reply-To: <Z7RwWyD67BxWPnK8@kernel.org>
References: <173928521419.906035.17750338150436695675.stgit@devnote2>
	<173928522350.906035.5626965043208329135.stgit@devnote2>
	<Z7Q1xY3jhWjaSdeh@kernel.org>
	<20250218174257.61018735a30268b5e21e50e3@kernel.org>
	<Z7RXGX/TyAvETRgc@kernel.org>
	<Z7RwWyD67BxWPnK8@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 13:34:51 +0200
Mike Rapoport <rppt@kernel.org> wrote:

> On Tue, Feb 18, 2025 at 11:47:11AM +0200, Mike Rapoport wrote:
> > On Tue, Feb 18, 2025 at 05:42:57PM +0900, Masami Hiramatsu wrote:
> > > Hi Mike,
> > > 
> > > 
> > > Thanks! but I can not use free_reserved_area() here because it uses
> > > virt_to_page(). Here we only know the physical address in the map.
> > > I think we can use free_reserved_page() instead. Is that OK?
> > 
> > For reserve_mem ranges virt_to_phys() will work, they are allocated from the
> 
> I meant phys_to_virt() of course :)

Ah, I got it :). Let me update it.

Thanks!

> 
> > memory that is covered by the direct map.
> 
> -- 
> Sincerely yours,
> Mike.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
