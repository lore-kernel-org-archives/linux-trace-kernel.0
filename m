Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577C1CF5FF;
	Fri,  6 Sep 2024 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631596; cv=none; b=OwMOgVXT5cxMwH2Ie5mJe7/uFegWt/5Jv4VgYusQtDhvljG1BM6vRdyo3D5x4AsMUz4OaQqR1AcK/KzueDSipPaIMjwsbv8qK4b0VZjbvj4mNCz+eiQcrv0jFSJiwDmzW80EcNMQ85A20L9haW9PAcSrG/YfB/W+tTyY2MzIAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631596; c=relaxed/simple;
	bh=+zdrnvlf2fkVlri6q/BJ2ajsqbURgHArUNpFpoUDyYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5q11Z/Hg6a4ELYImiQGShvavniJksvUBVYlTyksT6rn7mYPub7DouxIUHOwhSUZITq7JlQGC5u2nvHsHgxMOdv3FYa4MvAmwSXQqww7KuJ8APh4Yqnk23M6iKwSuGHE4f8m/1b58Z9caBmYyiuWhaLb+8QCdhbpNTZA31TH0AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954F1C4CEC4;
	Fri,  6 Sep 2024 14:06:34 +0000 (UTC)
Date: Fri, 6 Sep 2024 10:07:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
 <guoren@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-csky@vger.kernel.org
Subject: Re: [PATCH 0/7] add function arguments to ftrace
Message-ID: <20240906100738.2526cffd@gandalf.local.home>
In-Reply-To: <yt9dv7z9l2zp.fsf@linux.ibm.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
	<20240905111620.5211d9f8@gandalf.local.home>
	<yt9dv7z9l2zp.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Sep 2024 08:18:02 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:


> One thing i learned after submitting the series is that struct
> ftrace_regs depends on CONFIG_FUNCTION_TRACER, so it cannot be used
> with the graph tracer. So either we make it available unconditionally,
> or use some other data structure. Would like to hear your opinion on
> that, but i'll wait for the review after your travel because there
> are likely other issues that needs to be fixed as well.

Hmm, I thought the graph tracer depends on function tracer? Anyway, the
configs should be cleaned up. I would like to make CONFIG_FTRACE just mean
the function hook mechanism (mcount,fentry,etc) and not be used for the
tracing system.

Anyway, we can just make ftrace_regs defined outside any config for now.

-- Steve
