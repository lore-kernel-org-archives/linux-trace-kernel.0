Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3837490C0E;
	Thu, 10 Sep 2026 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050811; cv=none; b=lBSWRg5UQtLOR8xPS2T9RFn3j0NEO9mPVYY30sT6OgB4ErQ7slvo85ZB2R+itb5hbqjVlwMmmfditw6F3KKDBqS+edeHQUEWaIkr5QfR0ZZqP8cnPCmWiTyuA9kHinXJKtjWzKMsGeGnxQOKt+u0vXvLMT2LKv6eI9aB1eIYAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050811; c=relaxed/simple;
	bh=+Md/nIdjOBGgpXDoBQEhx0pPkzwPf3XZnL5eaE6nldA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d/xOq20VeG4iDotFjtun46b2Ra4FNDmXgSwfRJM/H21z1ATq+IgF9Cpgg2HlYeStmu1yq5NMqE8JrgzueorhScL5vieamAG4ddyXEDnZ9TJhaTjoI9y2EJp+QTyXrd9yGjdD/UC0aQFyWgA/RDmOGfF3+G+ro+ajD2irgqiPTe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlecpdlL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlecpdlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736B91F000FF;
	Thu, 10 Sep 2026 14:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050810;
	bh=Tq0iKdS9Ls9zgqaUG52Odq6tQg7OuXykkEE8do2w5Vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JlecpdlLiDsY4nFqTS9SHgLq/vr07DplOk/HrlpxFQAX1neIeaLEJpbK0fzQdeHdF
	 wIaBxXX9XFw12CZ8hYILmQeasBj5GAP0auHYdsQC0RIZ7DVU/vyM6incrAfRE1VCp7
	 ESs7wJ/OqmUo3mXL5tcLRj6HI4syh4eQHO0wUAO18nHFsu6W2MwBiLXALsuAG1bbA8
	 qldJiSPDJvV7SI+lUfToZwvP+b5YLWydUyYl8tT1MAI3iWkJ0fY9sEDSe3jQohHajA
	 1oz/NYZMFoEbnI95KcBmMtIrKz7RvrePYZzJyfIhhZkWHWnI8tzLxHoYEzgBGsHpsP
	 nORP4MA9XTQ3Q==
Date: Thu, 10 Sep 2026 23:33:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christian Brauner
 <brauner@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ryan Roberts
 <ryan.roberts@arm.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas.weissschuh@linutronix.de>, Douglas Anderson
 <dianders@chromium.org>, Huacai Chen <chenhuacai@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: Re: [PATCH v3 2/2] bootconfig: Fix integer overflow in initrd size
 check
Message-Id: <20260910233325.e59a0b26f504885206a59335@kernel.org>
In-Reply-To: <aqKAzTzpqYmuj8Rm@gmail.com>
References: <178900555453.200943.4719889510443114485.stgit@devnote2>
	<178900557529.200943.11099215789605267709.stgit@devnote2>
	<aqKAzTzpqYmuj8Rm@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 03:05:12 -0700
Breno Leitao <leitao@debian.org> wrote:

> On Thu, Sep 10, 2026 at 10:59:35AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Sashiko reported that in get_boot_config_from_initrd(), a crafted initrd
> > with a huge bootconfig size (such as 0xFFFFFFFF) can cause the pointer
> > arithmetic:
> > 
> >     data = ((void *)hdr) - size;
> > 
> > to wrap around on 32-bit systems (or when pointer subtraction overflows).
> > Because data wraps around, the subsequent bounds check:
> > 
> >     if ((unsigned long)data < initrd_start)
> > 
> > evaluates to false, bypassing the check. The kernel then calls
> > xbc_calc_checksum(data, size), which attempts to read 4GB of memory,
> > hitting unmapped pages and triggering a fatal kernel page fault during
> > early boot. Furthermore, on 64-bit systems with an initrd > 4.29 GB, an
> > unbounded 32-bit size can similarly bypass the initrd_start check.
> > 
> > Fix this by:
> > 1. Ensuring the initrd is at least large enough to contain the bootconfig
> >    footer and verifying hdr is within the initrd bounds.
> > 2. Checking that size does not exceed XBC_DATA_MAX and does not exceed
> >    the available space between initrd_start and hdr before performing
> >    pointer subtraction.
> > 
> > Fixes: de462e5f1071 ("bootconfig: Fix to remove bootconfig data from initrd while boot")
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/20260910010137.EE0431F000FF@smtp.kernel.org/
> > Assisted-by: Antigravity:gemini-3.8-flash
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reviewed-by: Breno Leitao <leitao@debian.org>


Thanks! I'll make a small fix and send v4 with your reviewed-by.

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
