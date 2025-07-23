Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92A2E54C5;
	Wed, 23 Jul 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283890; cv=none; b=e/TvF+IUuKwDToen6rDne0qkojvA0SvZkm3VcaXgJIkmYesnf8M+djWUhqCSz2nx526wzQZLxGXkgPz8j5DcjCyQdTW8YHUtV3r/egvERTeRollvF7KhBJN6WK53vn7dLOYONrwbFob42HeuDIPLd8Umb3tJND2Y9OXo7yEfyDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283890; c=relaxed/simple;
	bh=V5e0tUIjwuwuKnbH878uP7oQPdKDuVpmqmXrgePMdBA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nnijoZDJwi+8QEsHCe3X0vMlXuVIcFHzwSpQQalfoIPSjVcBsMEFroltf3lVyD9dbqEEjIG5LybJ/k+j674VOidnuKD+91xlehI4W248pddJNB2CfQDA2sQqwrN6Tni4Ia73cbu3Jm5dae1RLveCi5gz8nHvfKxRnM7iQJ48WzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEk1tYyo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEk1tYyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDD7C4CEE7;
	Wed, 23 Jul 2025 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753283890;
	bh=V5e0tUIjwuwuKnbH878uP7oQPdKDuVpmqmXrgePMdBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YEk1tYyo0Eyjyhqkev87EQoztc27tAFvBLqJAZYWtehVgb12YWBJZF4NfjphB0J3Q
	 7IVqN9Cp5nqzXnRUGeU+ek9H0F3WIy0mp3Y5lueagy3rncITf66NjzrkvpPwdbn447
	 fXyrEWhqvqfGYQGj8U/VZKSnqCLYHPKqH8KLn1FSQKIBCPdRyIZJFb7CMfu8zYlmci
	 wyUzhVPeBgV7i78ikzeAV5CugtOvjx0y5qgUajLlbVExScDELnxWOlp7kA6Wo8ZTgb
	 HJjPnpxYmlbpFfZ3RV9IlWcBPaQF5WO3lmsIwwIfcMy2XDefNh4vCejkAkzDHaANTE
	 4OvPaB31r7v8g==
Date: Thu, 24 Jul 2025 00:18:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] tracing: Remove "__attribute__()" from the type
 field of event format
Message-Id: <20250724001806.2dfd6baf4990f952ee77b6c6@kernel.org>
In-Reply-To: <20250723104030.6ec24dfd@batman.local.home>
References: <175257695307.1655692.4466186614215884669.stgit@mhiramat.tok.corp.google.com>
	<175257696222.1655692.4019049819386139160.stgit@mhiramat.tok.corp.google.com>
	<20250723104030.6ec24dfd@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 10:40:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 15 Jul 2025 19:56:02 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > +static void
> > +trace_event_update_with_eval_map(struct module *mod,
> > +				 struct trace_eval_map **start,
> > +				 int len)
> >  {
> >  	struct trace_eval_map **map;
> >  
> > -	if (len <= 0)
> > -		return;
> > -
> >  	map = start;
> >  
> > -	trace_event_eval_update(map, len);
> > +	/* This must run always for sanitizing. */
> > +	trace_event_update_all(map, len);
> > +
> > +	if (len <= 0)
> > +		return;
> >  
> >  	trace_insert_eval_map_file(mod, start, len);
> >  }
> 
> So this will add more work during boot up as it is processed on every
> event regardless if it has an eval map or not. But this is only needed
> if CONFIG_DEBUG_INFO_BTF=y and PAHOLE_HAS_BTF_TAG=y is enabled.

Hmm, In this case can we check it in trace_event_update_all()?
If we need to sanitize more word, it is easier to add a condition
there.

Or, maybe we can sanitize it while building the kernel as a part
of post build process.

Thanks,

> 
> What about having this be:
> 
> 	/* Always run sanitizer if PAHOLE_HAS_BTF_TAG is set */
> 	if (!IS_ENABLED(CONFIG_PAHOLE_HAS_BTF_TAG) && len <= 0)
> 		return;
> 
> 	map = start;
> 
> 	trace_event_update_all(map, len);
> 
> 	if (len <= 0)
> 		return;
> 
> 	trace_insert_eval_map_file(mod, start, len);
> }
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
