Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73171188A3B;
	Mon, 25 Nov 2024 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732517039; cv=none; b=BD6uxyoRzdXn8dnmmC/thW6sHG4gpnRDKmQo7xJ+IxEkohghudmKprOEL0ozrdzuItaSHEk5ISBE2akVpz/7Ror+N03LU7CmH+CudBCfIx3KYCLIusQ5d0w17stqHU1mKhK53YzqanonQBefLkT21iGbjwQoDmfm3yyws0PfPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732517039; c=relaxed/simple;
	bh=35B+fTeWQyuswnXn5BbZnTA2jho20vJ2Y1w191LIGws=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tFRvDBgGSN/hDd3V4rJ0C9/ZOY7iW8wZ/kbo7hSY7M7usEWkxe3ec4eIEP+oMMgbipgCm8YCj395fw8cHf35X6OL5ThobhJFohIDMI6ZoLQ6bpyoOT1VbVPRuHz78dQ50LtOmG+eliPlDssyqimoyuoHs1VQ9k8YAfTjXJXAk6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP8ZW7+D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP8ZW7+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2049C4CECE;
	Mon, 25 Nov 2024 06:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732517039;
	bh=35B+fTeWQyuswnXn5BbZnTA2jho20vJ2Y1w191LIGws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PP8ZW7+D9Yfi6JkupASzwz0RMxFw13X5NYOHkUnO9m+dGvMOI9FdEjPPU3nZLueO7
	 phY3qY+Tr3x4r7FzT1Djh1xCEYs5fSv8zUkwxADbj+U4tNkgjqrTgkmKQa+lOA4KXp
	 TYgdRKTD1NeRRg6lRTxKdRVG68wOFIvwuzpBPAZJx5zZmZCeYkHQEnbN/Yrj6BpXDX
	 FHAuwjqectcEI4orfMzA3ffjbirMn2i1c9IS01r08KBSs9HMAhpnpvJ4J4NvthmK0w
	 C2mrnTZptx640q1ohcCMN8kEDmU2exOUQInSBl+CX9QtvEuPkBi8lKkVvVEruDQsOQ
	 N11F1kDA5157A==
Date: Mon, 25 Nov 2024 15:43:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yuxuan Shui <yshuiv7@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: uprobe_events can't accept paths that contain spaces
Message-Id: <20241125154356.1e44f3c5775bb30269ed28a5@kernel.org>
In-Reply-To: <CAGqt0zxtKboY1PWRN4kCF3uTeiH9ZJtj280ARvGWeNtR_ik0eQ@mail.gmail.com>
References: <CAGqt0zxtKboY1PWRN4kCF3uTeiH9ZJtj280ARvGWeNtR_ik0eQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 00:42:51 +0000
Yuxuan Shui <yshuiv7@gmail.com> wrote:

> Hi,
> 
> I hit this problem accidentally when one of the shared libraries I was
> looking at is located in a directory with spaces in its name. `perf
> probe` reported "Failed to write event: Invalid argument".

Oops, yes, it is limited by implementation.

> 
> If I understand the code correctly, strings written into uprobe_events
> are strictly splitted at whitespaces (by `argv_split`).

Right!

> This seems
> like an unfortunate restriction. If I submit a patch to introduce
> support for either quotes (") or escapes (\), will that be considered?

Yeah, that enhancement is welcome! You can add such function in
trace_probe.c and use it instead of argv_split.

> 
> (For context I am running something that expects its libraries to be
> located at fixed paths, so moving them to a different path would be
> awkward at best.)

Thanks,

> 
> Thanks.
> 
> -- 
> 
> Regards
> Yuxuan Shui


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
