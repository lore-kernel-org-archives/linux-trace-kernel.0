Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B02139C9;
	Tue, 21 Apr 2026 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780035; cv=none; b=F9WQtR+UQXzCyzTzcQOhHSXHA5XHfpzFNLczA2cFCwNkZ04AfqyW7RmfypUBs//uQJoXxAm2JLFAIuizLKve9joJTO1kZkAp97uQqy0gvjXQAj0BzgT+Ca/uMbcAHvUeUA3AZHvOY/m+pDYc7dBJiFnlwCVZjmFNuAcUhaoMY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780035; c=relaxed/simple;
	bh=/1jbOgE9EYOOgUgVbI42L40v0govhiu/2Pul4kU16yY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uavXv6S7D3SPQR6sktYEgbzk1w302CcTifMwLcFlR6IuKU3XDDsUwJ5tUUE9I/YmO+SG8V3kfiPsMmK1vEHKYSJepZUQzwX5QO69ReuN5W3UQb3kJlnFwQefI306vB1BPsMUYyO9Aj7iPq5c5OQGKFWOHyMMYqg9JB7DY8BLSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 26766BE1F0;
	Tue, 21 Apr 2026 14:00:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id E6ADE60016;
	Tue, 21 Apr 2026 14:00:23 +0000 (UTC)
Date: Tue, 21 Apr 2026 10:02:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 torvalds@linux-foundation.org, Marc Zyngier <maz@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: trace: do not generate undefsyms_base.c
Message-ID: <20260421100209.7535e26f@gandalf.local.home>
In-Reply-To: <20260421100455.324333-1-pbonzini@redhat.com>
References: <20260421100455.324333-1-pbonzini@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E6ADE60016
X-Rspamd-Server: rspamout06
X-Stat-Signature: 3aajqzfum8h16okea47o66gshero7qe5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX186c+WFgLXZo/OPl0C/So0xzwDxZG/pLuY=
X-HE-Tag: 1776780023-459337
X-HE-Meta: U2FsdGVkX1//ZU8H0sffD+YNYcYrxLHWnE18KS7Bc6FKQcodMkTU3VrIHZ6/tEZXnIo8Hw+TEhcwcgpd5Vzyazidn+USihCNY8tGN/Hqx1pc2GkNBRAdWFrLcZGqA2ih76Mm5Q52DBioBMQ9UW3BO4lyF6euof1hc6MH8nCcoPIHgnd5Ea1pTTwf3I0x4foYOInVw1QC1cQBAB2cb09Qo/QN2mDqu+MMSekFAWXXGisb3AyuLbETF31r0UCv5Bsud6LjLO95VpuUIwkQ7EU4c40JIYE7TIRCgnQFfJibbyDxJf1dqHVaS7QH/pKMdqcAVtXWHZi3nyHl6r0N9QmqLYNsHnL8gCfhfxEfJEqEBhXulGjztBQW+4VrUa0psHe34CpWbprMCMWawAm5486QkwVk2s9XDQaecKrSF75GVTg=

On Tue, 21 Apr 2026 11:04:55 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> The code to autogenerate undefsyms_base.c in the Makefile is larger
> than the file itself.
> 
> Remove the "echo" indirection that creates the file, which keeps
> the build system sane and makes it much easier to edit it if/when
> new situations arrive.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Marc beat you to it by a few minutes ;-)

  https://lore.kernel.org/all/20260421095446.2951646-1-maz@kernel.org/

Although he didn't Cc linux-trace-kernel@vger.kernel.org :-p

But anyway, it ended up in my internal Patchwork. I'll take his as they are
both pretty much the same patch.

Thanks,

-- Steve
