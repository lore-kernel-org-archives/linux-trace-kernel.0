Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921A13DDDB;
	Tue, 23 Jul 2024 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721769803; cv=none; b=ZgSkPHGCjWZy3V3KDqN3F0lIJ++SOca9mc1EZu3wE6Q5vBW15Rd77d23oK3KHnJT5qzKtqnFhmWlr/5oX/Q9TC7D8FejIxazZ5fqTLylWl2fIGFJYEnQ3LEaVbcX9NleY5oXwTkTT92TmSCJNYSRylaviHX4J8OXn2La67xCLbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721769803; c=relaxed/simple;
	bh=2SAWRssX8A/4xbiIP7zHne2YDpWVCC2yjhgyZeNTbBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtyL2fQx9pELVrkNfa6g3ODBW/UXeJcrU2JV6WemahUgdQtXYLp63H3qoEM627cEoPQbr53N1IulyTzBQSK9BKCufT/upCOoRg4ve/QfvY2przICrsrC4YGkA47/B+zdXTqoNK4MAlOHZYvnQWNZ1hCwQsLOvGzAGcZpUbzBV9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192F6C4AF09;
	Tue, 23 Jul 2024 21:23:21 +0000 (UTC)
Date: Tue, 23 Jul 2024 17:23:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] eventfs: Use SRCU for freeing eventfs_inodes
Message-ID: <20240723172320.4e36d9d5@rorschach.local.home>
In-Reply-To: <20240723210755.8970-1-minipli@grsecurity.net>
References: <20240723104348.645bf027@gandalf.local.home>
	<20240723210755.8970-1-minipli@grsecurity.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jul 2024 23:07:53 +0200
Mathias Krause <minipli@grsecurity.net> wrote:

> To mirror the SRCU lock held in eventfs_iterate() when iterating over
> eventfs inodes, use call_srcu() to free them too.
> 
> This was accidentally(?) degraded to RCU in commit 43aa6f97c2d0
> ("eventfs: Get rid of dentry pointers without refcounts").

Yeah, I missed that. Linus cleaned up the code code quite a bit, but
missed the subtleties of the RCU clean ups. I should have caught that
in my review.

Thanks for sending this.

-- Steve

