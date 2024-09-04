Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C0824A1;
	Wed,  4 Sep 2024 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470164; cv=none; b=EKtZJAix0cKJO0qhAI4AWYyfvPM0TOQ2mhR6aSDjxSFl4+D95J/kl1mgz2kJXeyqgJtshkbJ1GIlj+7SfTvQJrvCHmYe7ndWcplamP9eTAF/ERmWVF3t/BiLnkaeKZ2NZOoLLDsEOElKI9PSoPBmM0vV4EvUMX/KmzTqBT7CxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470164; c=relaxed/simple;
	bh=uUzUOwJ9R3A+k/KJZTYb9XUUoEJeqLEAn1Ki+g5hwLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hahTR3qm/c/MBSsM8rNQSTW4k5Mf27jAewP2sQFKnen3Y/vuGh5w5DQFd7SMEvKVH2ySGvgkHwD+NsRtS5nFnHY4SOPDsGeJojq4y/FgZeEUMTNyU9xiRssS7Q4Pgbf78Rgdd8BvpHxkhviqqxSXt2duzGGQusGS5ZR6KqomNuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F011CC4CEC6;
	Wed,  4 Sep 2024 17:16:03 +0000 (UTC)
Date: Wed, 4 Sep 2024 13:17:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] eventfs: Use list_del_rcu() for SRCU protected list
 variable
Message-ID: <20240904131704.432482c3@gandalf.local.home>
In-Reply-To: <20240904131605.640d42b1@gandalf.local.home>
References: <20240904131605.640d42b1@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 13:16:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> This is simply fixed by using list_del_rcu() that is specifically made for
> this purpose.
> 

I forgot to add:

Link: https://lore.kernel.org/linux-trace-kernel/20240829085025.3600021-1-chizhiling@163.com/

I'll add it when I apply it.

-- Steve

> Cc: stable@vger.kernel.org
> Fixes: 43aa6f97c2d03 ("eventfs: Get rid of dentry pointers without refcounts")
> Reported-by: Chi Zhiling <chizhiling@kylinos.cn>
> Tested-by: Chi Zhiling <chizhiling@kylinos.cn>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
