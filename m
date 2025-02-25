Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541414F9C4;
	Tue, 25 Feb 2025 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508277; cv=none; b=qe2kXO9jY1SOK1mk96U4ugPToPtyLyEm+Vy/cyFGQm3AlkYmAXz21mcdaDK1OjWUE0CzuwxVP69tzHSEGkCZP3jydwEDTbcl9WDGrO1vwSp8Yx4+b+H55AEElEA66j26F7v9NXFYTnwHfd8eI96PIY4NsLTsgNvtozs4vKoP24Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508277; c=relaxed/simple;
	bh=nfH+b/nxMXmB9y0LHezDiDv5L2rhc4o09RQZpD7yGh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+lM6iNAEZv/OEPaioKOFwOemT7srVZXYQRy7Qm+p2NhI+9CNGZC/g9WVRgkq6q8FCDw8HfFGPU0DLDPEuIEfdoZhlU3sQXQKSOgcHg0jpA/6x5MRYlskQg/4G2A9AMijElpthQ4rBLz0ZJf9bGbiyk254KJB6gMKG0+dMe/OsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C87C4CEE7;
	Tue, 25 Feb 2025 18:31:15 +0000 (UTC)
Date: Tue, 25 Feb 2025 13:31:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Joel Granados <joel.granados@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: don't call kaslr_offset()
Message-ID: <20250225133153.64ea6687@gandalf.local.home>
In-Reply-To: <20250225090104.554966-1-arnd@kernel.org>
References: <20250225090104.554966-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 10:00:58 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The kaslr_offset() function is only defined on architectures
> that implement CONFIG_RANDOMIZE_BASE, which leads to a
> build failure on 32-bit arm and likely others.
> 
> Hide the function call behind an #ifdef.
> 
> Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> There is probably a nicer way to do this, this version was the
> minimum fix I found to unbreak the build.

Yep, I ended up removing the reference to kasrl_offset() altogether.

You are Cc'd on the new patch set.

Thanks,

-- Steve

> ---
>  kernel/trace/ftrace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
