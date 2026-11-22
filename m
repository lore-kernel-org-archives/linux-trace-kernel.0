Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340399;
	b=bCiH/fEyzmvbfBneFqN9C1kvO4gA/Km30+lztEed9hKXnKMNALKk6oLtBT7WibGTNSCn
	 tl+T4JOTCd+RbyZ16km1jiaom3hdOhFd9uquCphQG8MWNYuC29CLrUW8IuQ9fM8yQN1T2
	 nhe//Or98piAy7Q9zS6viVOCN44+I2qDBwSJHSFfCwT6ib+m8pai449+NrhmwfBXo4BQ+
	 CxW+Gc8uWU078jlk1LQ5YLPN449lCpHIvb1eKQ4MOAsWuFa4ddrDtn9t2oHZhEqyEJ9LA
	 61IqCyQqoNIfTVkj4oGtBPh+xJg7ndtu2t4OhxYmGT1OX6HOWQ8dhupoXqgFNDhEfMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340399;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mSaw5zdS1mtlO86FGGVxC95UV//gWZDw3sHxp1UvTno=;
	b=uOiO2KnIzBdukpmztUQrc/7aoAHYOTQv3caIKqVQ7NQdY3Ronwo2Z4sILFLl9MIswno7
	 eiio0pn3LJMFKSSLMwRSIkZD62ph6MnAR5JhqYehG8mfGfdDofa7PSQbjxrYX8MuGyiqA
	 v5jDJ2Sl5EGRIfBiwSdtTUXFJLYzetRxbT/6YU8K2zVqmwNLzcIruUL9SQT1z88VjbN/l
	 j/9F0oS43UQ6m6SqFOUpR4OwqmOKQwg6vZgWJJbHx7JgPKPWSbwh+aMRncIWCJErpvLKb
	 Mtr8z8Vz6Tjsu59gcnrenMosXxZydPZPR6kYgTnN24PRPyjPPAI/L9o+ghElP0K1meg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqfSf4RI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74130606A32A;
	Sun, 22 Nov 2026 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqfSf4RI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513FD1F000C6;
	Sun, 22 Nov 2026 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795340399;
	bh=mSaw5zdS1mtlO86FGGVxC95UV//gWZDw3sHxp1UvTno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PqfSf4RILDatlHNMd9zBmY1nEOLIriB7QjldZUWMt5PT2UT4+zp+/9X0JD5iTI1Xk
	 jw0xOyd9ukNRqh2wLIquOXtu8AqInWiLs7VROvP0whhj+loLyEJAx37fPHFo5xWL+A
	 C3e4BxM+jtwct7XVge0M1kxsOxvAQGktY6lrmypyqO9L32oUiisdjgbgj2SSlAYikq
	 wDEwxbaouSWPJYy6NjD8RcEIG6PC7OWPEkaVGhV8QG6diGDCuXhPA5i/osydazg8Wk
	 jquc0IO28n4AIcnIiM5qjn05lNbBDSXyWvmIjNJtrHm0xvRDBhH8UJAPXW1NNefMIW
	 dQtV8fiq5R7lA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, corbet@lwn.net, linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/bootconfig: Use the registered global tracing parameter names
Date: Sun, 22 Nov 2026 18:39:55 +0900
Message-ID: <undine-1795340395802979275-8df591c357ed0841@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <undine-1795340240141573056-b3b8376c0d49c0eb@undined.local>
References: <cover.1795307698.git.edumucelli@gmail.com> <fecf6e33d4f7e2ddf031526e7a1abef27e28f754.1795307698.git.edumucelli@gmail.com> <undine-1795340240141573056-b3b8376c0d49c0eb@undined.local>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sun, 22 Nov 2026 18:37:20 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> On Sun, 22 Nov 2026 01:34:58 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> > The boot-time tracing guide lists four kernel.* keys that do not match
> > the parameters registered by the tracing code. For example,
> > ftrace2bconf.sh emits kernel.fgraph_max_depth, which bootconfig passes
> > as fgraph_max_depth on the kernel command line. The function-graph
> > tracer registers ftrace_graph_max_depth.
> >
> > Use the registered names in the guide and the exporter. Teach
> > bconf2ftrace.sh to read those names, with the previous script keys as
> > fallbacks so existing replay configurations still work.
> >
> > Fixes: 47781947947a ("Documentation: tracing: Add boot-time tracing document")
> 
> Since this patch also fixes the key names in bconf2ftrace.sh and
> ftrace2bconf.sh (which were added later than the documentation), consider
> adding the corresponding Fixes tags as well:
> 
> Fixes: 7e66ef0046cc ("tools/bootconfig: Add a script to generate ftrace
> shell-command from bootconfig")
> Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates
> bootconfig from ftrace")

BTW, I will update the Fixes tag and pick this patch in the series
to bootconfig/fixes because it is obvious a buggy description.

So you can only update 2/2.

Thank you,

> 
> Thanks,
> 
> > Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
> > ---
> >  Documentation/trace/boottime-trace.rst   |  8 ++++----
> >  tools/bootconfig/scripts/bconf2ftrace.sh | 21 ++++++++++++++++-----
> >  tools/bootconfig/scripts/ftrace2bconf.sh |  5 +++--
> >  3 files changed, 23 insertions(+), 11 deletions(-)
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
