Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584A224FD;
	Sun,  5 Jan 2025 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736067619; cv=none; b=tZWQJN9C5A3yVtuXTbYdBJRlZqj+SqQwZHxyMGlxP14cvxaBmO6c4Nkb16ORVsWnWEr+jPbv+uoWG5aDitEPHmV5Mejv6lCuf7fq5c7++T9YOudYJ0VxXHjGuuxUQph+QOFP7WRt1wsUzv3Ro1HMU7Plu2uqTkpZToWTBTZE6j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736067619; c=relaxed/simple;
	bh=Ub4orJbrn0VY+e9Avpm5hHUqIvH/e5yMARo4kEwsqb4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PDH7V4F4LJwgmjle4KOcxQlpbBOmQfSfSa/nZZoENfmPn6eebxzrtxWw/ykZJkG9HpNOGhbUMj7zZXDgUobbWlmNP5IrR0JmBZ4wv/vvksa8DQfIH8rpm8U0iEwvWyTuntii5vUtTmfhrKklrP4Ecc+XA7AVneEWbUauwRPWZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRF6mtyA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRF6mtyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5F0C4CED0;
	Sun,  5 Jan 2025 09:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736067619;
	bh=Ub4orJbrn0VY+e9Avpm5hHUqIvH/e5yMARo4kEwsqb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lRF6mtyAHUf52O2ivBhj+r6zJnDSzfNq3eO/HZiHObpM4Ma9vlVedtbd/9Zwgp4TN
	 aOtsXGDPvPRAM+1keyw7xLamJO+Zo6PkGSvng8C+zK9IFEJMLfeW+frLPiAte+RsdL
	 ttLc19aiVnEebTnzDCxTgkoyyDZXXt7nJLWi6ylN0pauJ1X/eCtmn92UuDDQg+JjOI
	 g5C/pXjbL/jsLM/A6AzPfZJgm3YIJTPF9BmaRTE2Ac1dHGdkwEocOP9chYvPXyjojZ
	 s2JTf8hu0rZtSD0kjDIWkpX+/ZiQEwtUP79ctFKG559+C8YUUyfy7pi/9nLZaUPRuB
	 obfK+xEspkDxg==
Date: Sun, 5 Jan 2025 18:00:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tzvetomir Stoyanov
 <tz.stoyanov@gmail.com>, Naveen N Rao <naveen@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard Biesheuvel
 <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] Provide __free(argv) for argv_split() users
Message-Id: <20250105180013.98eab05796c20d529df4aae8@kernel.org>
In-Reply-To: <20250104110955.GA2394@redhat.com>
References: <173594528527.1055889.2175884987203674189.stgit@devnote2>
	<173594530753.1055889.17844868397124331132.stgit@devnote2>
	<20250104110955.GA2394@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Jan 2025 12:09:56 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 01/04, Masami Hiramatsu (Google) wrote:
> >
> > +DEFINE_FREE(argv, char **, argv_free(_T))
> 
> This doesn't look right, I think we need
> 
> 	DEFINE_FREE(argv, char **, if (_T) argv_free(_T))

Ah, yes. I misunderstood argv_free() can get NULL.

Thanks!

> 
> ?
> 
> From the next patch
> 
> 	@@ -73,24 +73,20 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
> 		struct dyn_event *pos, *n;
> 		char *system = NULL, *event, *p;
> 		int argc, ret = -ENOENT;
> 	-	char **argv;
> 	+	char **argv __free(argv) = NULL;
> 	 
> 		argv = argv_split(GFP_KERNEL, raw_command, &argc);
> 		if (!argv)
> 			return -ENOMEM;
> 
> if argv_split() returns NULL, then __free_argv() will call argv_free(NULL) ?
> 
> Oleg.
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
