Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D235361DC0;
	Mon, 19 Jan 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836464; cv=none; b=uKIwCXru6IeiAGKQaXNgQvov1RZCh8hv6yLzXTFJA2deet3EafDePDebKaRT8dBGZcxsCjF5XzJRLdcjLoboBwdJdE6XB461v934zijYqmK4WwSIVIGZMqtQJ+VknX0Xqdvsib9GRWtJBvrmUSK48tWRFPjNDVuo8nUFY/hoFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836464; c=relaxed/simple;
	bh=NMaPDVTGxBb6uMMJoZrpglIidek9Wkie8uiZz19gmHE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c+PlhmwmXqWoFWEtUIbG9quY8LLGudkN4Yv+4bqB1lUtyySm8VeQD9BqJG90zmnsE25dQoU1l+9Xrh96Zrb8r74rnHDxcoDCXIxJkXnDZ4FTqR0gwe9DB6T2vbu0qVN2PSacGdRg17YbiLSfNKHfImDzKYrtT4dJ+N+zCXdWqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfJxqtUM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfJxqtUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42FFC116C6;
	Mon, 19 Jan 2026 15:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768836464;
	bh=NMaPDVTGxBb6uMMJoZrpglIidek9Wkie8uiZz19gmHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EfJxqtUMD2KRrAnoIFwU2KC9X5UsyEan1ykJprX0vYZvF3mMDJKqFc25xWNZHYg4u
	 JSyyIvrwvrmmPttb/NSA3oXkj2cLLFhKskaWiqwXkxtTXyA0rUBQj/N/vtd3rqMcy8
	 FRCboGKfagUPu3+P1u6XG88XKICMSG6TWDe8kxTa1CMfdFkABpFADgurXiCHbwbTcr
	 kaFBbSXAkL8itgjKvNOKlxlzQiv5xyNSucbJ9daaR8lw0d3bdYy6n/vhp3ilGTrRfM
	 vK/iKln5/9BaKIn53M5nslWpNNheR6L+a7KyGioV/eA5ru4lAKXBHa7Ablbx/3Wj67
	 SknkRKSUPdeeQ==
Date: Tue, 20 Jan 2026 00:27:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tracing: Remove backup instance after read all
Message-Id: <20260120002740.7962e180f9ea88006a32abb9@kernel.org>
In-Reply-To: <176828713313.2161268.62228177827727824.stgit@mhiramat.tok.corp.google.com>
References: <176828713313.2161268.62228177827727824.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I found another bug on this (or persistent ring buffer itself)
Let me fix it first.

On Tue, 13 Jan 2026 15:52:13 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 3rd version of the series to improve backup instances of
> the persistent ring buffer. The previous version is here:
> 
> https://lore.kernel.org/all/176788217131.1398317.11144318616426272901.stgit@mhiramat.tok.corp.google.com/
> 
> In this version, I updated [1/2] to back to checking readonly
> flag and consolidate the eventfs_entries.
> 
> Since backup instances are a kind of snapshot of the persistent
> ring buffer, it should be readonly. And if it is readonly
> there is no reason to keep it after reading all data via trace_pipe
> because the data has been consumed.
> Thus, [1/2] makes backup instances readonly (not able to write any
> events, cleanup trace, change buffer size). Also, [2/2] removes the
> backup instance after consuming all data via trace_pipe.
> With this improvements, even if we makes a backup instance (using
> the same amount of memory of the persistent ring buffer), it will
> be removed after reading the data automatically.
> 
> ---
> 
> Masami Hiramatsu (Google) (2):
>       tracing: Make the backup instance readonly
>       tracing: Add autoremove feature to the backup instance
> 
> 
>  kernel/trace/trace.c        |  164 +++++++++++++++++++++++++++++++++++--------
>  kernel/trace/trace.h        |   14 +++-
>  kernel/trace/trace_boot.c   |    5 +
>  kernel/trace/trace_events.c |   68 +++++++++++-------
>  4 files changed, 191 insertions(+), 60 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
