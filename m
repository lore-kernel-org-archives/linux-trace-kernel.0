Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2AD4A29;
	Sun,  4 May 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746377013; cv=none; b=WcCn3nULb6IwM/Z3jPDFyd4Uzezs7pdG8b5wWOUTI9cE2pAxRloN73e0n1uZAIpgmrY+64CGI+sSmN0QqFdouFMvbl9oWVw8ZJeoWPskRL/aOzpScy21NyUVfO2niToXlXxb7qQFT2fOj5D9FNVHRjOK7xdAfeUQeJ2zibUnUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746377013; c=relaxed/simple;
	bh=e834IqtPjBItAoaJcN1CA1A3N8UgbDL2QhASn2BFB9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJvMYpW/nBVGkaQxwrWU0fbCL1yETSECRavRhvip8AfR4C8+JRzUB+ocGrycYFh3cyNEZfmq1ZaSoj52l6AJ6ux3HO+PrNVKsJoYlbAWKWKC9iTI7TFN2JCrxdOXlxb4Fg9qrlqtFKAegKHYykf8DU0xqma9OXft+iIy0FWPX+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB14C4CEE7;
	Sun,  4 May 2025 16:43:31 +0000 (UTC)
Date: Sun, 4 May 2025 12:43:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>
Subject: Re: [PATCH v7 01/17] unwind_user: Add user space unwinding API
Message-ID: <20250504124330.6a62e7b5@batman.local.home>
In-Reply-To: <aBczuIoPIV3kkCnu@gmail.com>
References: <20250502164746.178864972@goodmis.org>
	<20250502165007.549687075@goodmis.org>
	<aBczuIoPIV3kkCnu@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 May 2025 11:30:32 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> > +struct unwind_user_state {
> > +	unsigned long ip;
> > +	unsigned long sp;
> > +	unsigned long fp;
> > +	enum unwind_user_type type;
> > +	bool done;
> > +};  
> 
> Will any of these types be visible to tooling via ABIs?

Not that I'm aware of. Josh can confirm. Josh?

With the exception of BTF (which exposes pretty much all structures), I
believe this is completely internal for the generic code of the unwinder.

-- Steve
