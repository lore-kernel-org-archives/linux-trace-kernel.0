Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97713A3F0;
	Wed,  7 Aug 2024 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037608; cv=none; b=LzXNHgljauY97m/ffyU/4q3erZium2mWDpvgTurDVLdKS/xLpMjAeAGUSccWr6zvsN7J/F3ZDNVvlV0qgeN2yIFj0En0X0LTL7pn+ZtDbpsTnZQQn3H4ltp3oHyaU5eYUOzraa4+Jj5NZy8vHJzmd40CNkaWuHoDO/JY7vhNzik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037608; c=relaxed/simple;
	bh=BBBxhGFN3mpe3H/SDIuazQz/Lh524jPf1nS8AgHDdfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqPdwWGKyHo0fJdOTPztMQuRTZO0MsHBLsU2A+e1nGFtRERvKtyyxOxCZkGjEgAWA19uQQoFCLYlpaG8Im97LZa7m/v6SDd6h2Z46hrxxwf4Gx6yVWkgZdR907KtvSWeux86kxxyq0bUM6ZJA0RLVkiiiKOnQU+YRuSH9T4bMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33357C32782;
	Wed,  7 Aug 2024 13:33:27 +0000 (UTC)
Date: Wed, 7 Aug 2024 09:34:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tracefs: inode alloc/free related fixes
Message-ID: <20240807093417.4d93b11b@gandalf.local.home>
In-Reply-To: <20240807115143.45927-1-minipli@grsecurity.net>
References: <20240807115143.45927-1-minipli@grsecurity.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 13:51:37 +0200
Mathias Krause <minipli@grsecurity.net> wrote:

> Hi Steven,
> 
> We ran into yet another tracefs related bug but, fortunately, were able
> to root cause it ourselves.
> 
> The problem only occurs when CONFIG_RANDSTRUCT is enabled and one gets
> (un)lucky to hit a random seed that'll overlay the 'rcu' member of the
> union with a list_head in 'vfs_inode' -- quite unlikely but, apparently,
> we're exceptional "lucky" with our testing ;)
> 
> The first patch is more of an API correctness fix, to bring the tracefs
> inode cache in line with all the other filesystems. The second patch
> actually fixes the bug, which, I think, may also be the cause for what
> Ilkka is seeing[1].

Ah, that would explain it, and why I never triggered it.

> 
> Please apply!

I have an update though.

-- Steve

> 
> Thanks,
> Mathias
> 
> [1] https://lore.kernel.org/all/CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com/
> 
> Mathias Krause (2):
>   tracefs: Fix inode allocation
>   tracefs: Don't overlay 'struct inode'
> 
>  fs/tracefs/inode.c    | 2 +-
>  fs/tracefs/internal.h | 6 ++----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 

