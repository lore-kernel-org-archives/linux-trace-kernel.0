Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26F1534E9;
	Mon, 28 Oct 2024 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730092495; cv=none; b=t2hpyNU9Oj8W8xS4DoA7c+2hGQQbAOXkTe8BhX7oXuRsft0PQ6+rxKWTM7HQDpqPA/N4ZAPDxgR9tg3OlzHirLOur1m5jBXQs9/D+ZhqXtZLHMz7AS6JjbE3ciZrx6SG7A+MGxjewqi6/4ZRrntGVHlIHq+nIM/U9NsqLuUe7uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730092495; c=relaxed/simple;
	bh=ph9qCNxC2H1s5AcGeZm0TwwdMutnnnRZ5XviYZxuODA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQ9+/sKUWJgXu9BH3N0G1Nhw9UB12AYROkdku+xoELzps1fDw15GBPEvjgY4yupqRP6bnEJS6oEWhS+gWGxmfQVCmcNVJLfbU8Ipu3qgXkr60xSXmL1B7EN1/JQ8etCoHVUDGiensmr8el+zN6JrT4nXwbx+pmUlHNqTLV/sZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747A6C4CEC3;
	Mon, 28 Oct 2024 05:14:53 +0000 (UTC)
Date: Mon, 28 Oct 2024 01:14:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: MottiKumar Babu <mottikumarbabu@gmail.com>, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, anupnewsmail@gmail.com
Subject: Re: [PATCH] Removed unnecessary initialization of "ret"
Message-ID: <20241028011449.68818eef@rorschach.local.home>
In-Reply-To: <5d87c8ba-8464-4d9c-9152-611097b5ae3e@linuxfoundation.org>
References: <20241027211913.26718-2-mottikumarbabu@gmail.com>
	<5d87c8ba-8464-4d9c-9152-611097b5ae3e@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Oct 2024 21:24:55 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 69e226a48daa..b13ab2ad0e88 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -1249,7 +1249,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
> >   {
> >   	static bool fgraph_initialized;
> >   	int command = 0;
> > -	int ret = 0;
> > +	int ret;
> >   	int i = -1;
> >   
> >   	guard(mutex)(&ftrace_lock);  
> 
> It makes sense to initialize ret - i think you might see a warning about
> ret being not initialized before use. I don't see much value in saving
> unnecessary computation.

FYI, I'm rewriting this code for the next merge window, so this patch
doesn't need to be applied (as it's not something Linus would take in
an -rc release cycle).

-- Steve
