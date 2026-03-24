Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E13DBD5E;
	Tue, 24 Mar 2026 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366962; cv=none; b=iAM0soZxOSZAo/t6JVKnNXJ8wPWQgbcMPRQBBu3K90bBan1uK8Ne55yWDmR/8vrOhOD0Y5SG5fE2Ta9L7gBggSsrrWR4aQP0bdqyK5AUp1F23Ek+BuB9G6bxI8F2YAvCVZelxv7T25WqZ4AngiH3vx8twXCwMDbdLW2Z18wx2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366962; c=relaxed/simple;
	bh=2Zsq8skSNnh/MXXGZNOJx5noaTfOOayvR6/+7n/9yQk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u950vr2ePy6zQuLJdeJN6Fz83Tv8q+Taiq7qegNaYES1j659qYsGQMkdU84HlOJdV42pyvHvzF9P1JBChwVOFmT2kn/TolH35OePuITmzaqhlDXObUobDf+sBVisdpHwOKg2+RbAVBrEtKizTOEPVm2qyN4u2ah1c6R40Sqw3Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt9xEVjR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt9xEVjR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74097C19424;
	Tue, 24 Mar 2026 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774366962;
	bh=2Zsq8skSNnh/MXXGZNOJx5noaTfOOayvR6/+7n/9yQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xt9xEVjRQAy03h/xT4dHGrNbiSNtzplkl0cuifiVSX409f/6fyMyTsESXCWptScD7
	 dWGIsldm2WS6Y6M5mMzZEj3TJq39ggbLB9YmlDcjM1di0nAOPfW8l7wljVsFc0kFpA
	 Ns+XDCwYvUlXgbTO1x56OqzDWZpY6dS2GZVHZ/KeN23X9fGwJUOupUfgKUvIdwdmiS
	 jCTJqPO23SMvRjyAXYRhjp6TyFNZrrj3NCPslpKDtJGhS8tMA5onHfpl1aEJIBXGDs
	 sFlVF1eXuVojai4DCy6LrUMFoqgspCVtQKU8OQv3KEcc1nQcr8QPi+QqeOVVhe+GFm
	 drptW/zYQ89wg==
Date: Wed, 25 Mar 2026 00:42:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Kaiser <martin@kaiser.cx>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: fprobe: do not zero out unused fgraph_data
Message-Id: <20260325004238.a25e7dc93f891d4cf17f76aa@kernel.org>
In-Reply-To: <20260324083903.414352aa@gandalf.local.home>
References: <20260323102020.239567-1-martin@kaiser.cx>
	<20260324084804.375764-1-martin@kaiser.cx>
	<20260324083903.414352aa@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 08:39:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 24 Mar 2026 09:47:08 +0100
> Martin Kaiser <martin@kaiser.cx> wrote:
> 
> Hi Martin,
> 
> First, please do not send a v2 as a reply to v1. A new version should
> always start a new mail thread.
> 
> > If fprobe_entry does not fill the allocated fgraph_data completely, the
> > unused part does not have to be zeroed.
> > 
> > fgraph_data is a short-lived part of the shadow stack. The preceding
> > length field allows locating the end regardless of the content.
> > 
> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> > v2:
> 
> But to maintain a link to the previous version, I recommend adding here:
> 
> Changes since v1: https://lore.kernel.org/all/20260324084804.375764-1-martin@kaiser.cx

Ah, this is a good idea for the patch which does not have cover mail.

Thanks :)

> 
> 
> >  - remove the memset instead of fixing the length
> > 
> >  kernel/trace/fprobe.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index dcadf1d23b8a..56d145017902 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -450,8 +450,6 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
> >  				used += FPROBE_HEADER_SIZE_IN_LONG + size_words;
> >  		}
> >  	}
> > -	if (used < reserved_words)
> > -		memset(fgraph_data + used, 0, reserved_words - used);
> >  
> >  	/* If any exit_handler is set, data must be used. */
> >  	return used != 0;
> 
> As for the patch,
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
