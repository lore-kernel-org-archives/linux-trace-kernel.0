Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F4155C87;
	Fri,  7 Feb 2025 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894504; cv=none; b=D5dLj8x876onAaLpHYZxTMN6+5g4V/JAW5TcvkGY1TX6TpqJ9bJ9gTgbNlyyukmoH1Wu6w7YI8NWE2tMU/xGAeYVflyIOK3gKDuuwX04zjsP1KrPQ/z2DUkJdVfoa/rnEOllbGn71yG2QMFWRC/3htrA3aP2eooIYtWF/1RaDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894504; c=relaxed/simple;
	bh=JzTNkq7+WvBJJXykzTj+oWnUhBXmrzdUTj7se1fJUkU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f2JfqQj9JoBRRBUV+dJHjGVFuvFHcGvlxdAYU51a1BZSfzPpMh8lj98IG22EAto8T9cWt96vLBlMF1iCI4h/oCabfndEIRC93XWCu89Y/oaWUIdvav2N4QBL6pD0IwBtMWubMPgfLTLUQJkhS6JuGXHIaWVIybr8A/cp4xiGCdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIoq/62F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIoq/62F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62DBC4CEE6;
	Fri,  7 Feb 2025 02:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738894504;
	bh=JzTNkq7+WvBJJXykzTj+oWnUhBXmrzdUTj7se1fJUkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FIoq/62Ft6f5aRRMmCnhqM7s6sN7EtCEHQlc1h67XNROZYsjd0/coKfI4PM8NjKvR
	 V497s3D0wPu7nwnpRbLeOAEjX+xM+dCwyxed3wSEhkNYnB1A2JuEWPYLZNZj0k/FGk
	 kpzKQPZ7ujUGW8HKu5SVvw4SfDVQVyzua9CZQDAFwAhjqOqYh1BtV8s62QM5d+TWm+
	 vAL2RNiqLuOOY70I6fagRkZPV5tV752phVDDkjm+ACk/ItXZJyPYgJ1Q6wcG6zwEGI
	 2a7H57bYb0KwZMNO7rXMwwbQybWNhazNFGSK5YL5UJ2PgogvLujqMuHSPcgYsmLojl
	 bMKK02/Lm25hA==
Date: Fri, 7 Feb 2025 11:15:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/8] tracing: Have persistent trace instances save KASLR
 offset
Message-Id: <20250207111500.294309a7d3ed7253dac2f210@kernel.org>
In-Reply-To: <20250206200316.1483aa59@gandalf.local.home>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.596907199@goodmis.org>
	<20250206142232.5a10545649210f3b3ba172c2@kernel.org>
	<20250206102425.2d1f71ad@gandalf.local.home>
	<20250207095844.c2d761f3a3588f705e5c5832@kernel.org>
	<20250206200316.1483aa59@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 20:03:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 7 Feb 2025 09:58:44 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > Which would make sure that the scratch size contains enough memory to hold
> > > 128 modules.  
> > 
> > Yeah, this idea looks godd to me. BTW, the scratch size will be aligned to
> > the subbuffer size (or page size?)
> 
> I don't think it needs to be. I think it just needs to be aligned to word
> size.

Ah, OK. The first cpu_meta data is not need to be aligned.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
