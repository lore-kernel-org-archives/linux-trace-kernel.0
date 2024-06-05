Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835301667C8;
	Wed,  5 Jun 2024 23:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631105; cv=none; b=sfaT1NwOCrWZAk/sV6bFfn8WkBMcbvKlld4JGUqnikr+gzFBktnvlu195P5YR91HfmHrPA4QhQIyAfdUQSwcj6d0fKO3Ho5wL3GN8r1r/mkdZXNwnOk8t0glHjadwF8VruPLbdoWqdbpLweAStpXxhbwhXnpRF/Uz97HzeBc/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631105; c=relaxed/simple;
	bh=SxNOZQC6b6ULTjoVdRyoVNcIUDCX2H7/xrBVJ2m0CiU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AOtUGVa95nU0bXhs17ciP72zy5BfSPfZPlRcGRUqlQRe2VfZogCff8fnjAcU2NZh73cFJZjT5lTxHv49ETg/czbxKmH5Cve46Qzba7xDVbt4wzzZpUAr5sDK/FUY8YbAlPy1MTIYsaCDv8wMTA7pRkFAa3R85Uoo0EjT5WngW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUoqOXff; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUoqOXff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDE1C2BD11;
	Wed,  5 Jun 2024 23:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717631104;
	bh=SxNOZQC6b6ULTjoVdRyoVNcIUDCX2H7/xrBVJ2m0CiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QUoqOXfftlxdVJpBAQZ56H/YUZBhK9yA8rKZQFby3Pavo8j19QoUI9E0XxM+srCEv
	 X0DpKrvtD4SIvVsJ+ILCCLV2CpOybfrtpnSn3hGJi1gbdBsmMG9eEIb7Nvj077PhcE
	 vijfRTYA9saiGtlE7Fv8XJ/ghZUN5YLmKiCguFuLktK/n1Q0rKPPQTZZoxuBgpZTog
	 cQYVLeo5GLpP3KWTW9wsa44Nk8kPxtXSpqVOjpOwP6I+o4J16OYtG0AFqwKMiPhqKb
	 dNDrYXxynBMQFer23r+q/nWY4uSA/ShmWzXUZaeyYhZFRT3pkFYfuGJ1HWqbllwAcG
	 k8FlZpYVS8SLg==
Date: Thu, 6 Jun 2024 08:45:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/5] ftrace: Clean up and comment code
Message-Id: <20240606084500.134f52ee78cad21325cf982b@kernel.org>
In-Reply-To: <20240605180334.090848865@goodmis.org>
References: <20240605180334.090848865@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Jun 2024 14:03:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> While working on the function_graph multiple users code, I realized
> that I was struggling with how the ftrace code worked. Being the
> author of such code meant that it wasn't very intuitive. Namely, the
> function names were not descriptive enough, or at least, they needed
> comments.
> 
> This series moves to solve some of that via changing a couple function
> names and parameters and adding comments to many of them.
> 

This series looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

for this series.

Thanks!

> There's more to do, but this at least moves it in the right direction.
> 
> Changes since v1: https://lore.kernel.org/all/20240604212817.384103202@goodmis.org/
> 
> - While working on v1 and responding to a comment from Mark Rutland about
>   the usage of "ftrace_hash" in the __ftrace_hash_rec_update() code,
>   I realized that the function does pretty much the same thing if
>   it is set or not set (but slightly differently). It turns out that
>   it isn't needed and that parameter can be removed, making the code
>   simpler.
> 
> - Fixed some wording and typos suggested by Mark Rutland.
> 
> Steven Rostedt (Google) (5):
>       ftrace: Rename dup_hash() and comment it
>       ftrace: Remove "ftrace_hash" parameter from __ftrace_hash_rec_update()
>       ftrace: Add comments to ftrace_hash_rec_disable/enable()
>       ftrace: Convert "inc" parameter to bool in ftrace_hash_rec_update_modify()
>       ftrace: Add comments to ftrace_hash_move() and friends
> 
> ----
>  kernel/trace/ftrace.c | 161 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 94 insertions(+), 67 deletions(-)


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
