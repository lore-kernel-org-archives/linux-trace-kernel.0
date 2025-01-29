Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F111552F5;
	Wed, 29 Jan 2025 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738112985; cv=none; b=SzA3P6kI6g/vWdkU0Zy6v3N87JNkPtw57Ai/duz8tA7FI19r0Gi99XSrDbbTLSOMP4/9DkqVXgPNM1ksdt3rZjMkESODUA8P0TL1BJW+dfryoyLnmueN+gnulb3qniD2Aoxexk7A0PTt4etDWHC1ZUvzRfLpiJQTwAyrJHsIVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738112985; c=relaxed/simple;
	bh=JhUe2p98/A8IXiVWQfisV5bUTHVMXolKp+VIbbzcuWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkc9WblwJRy0WT6+fYFxFUl2E1FVAAB4Ev1WaMtoGFyzFwnes5XKaZ65Xyao8GoeJaUm67P2ME4y5aten4udLsaGzu9ypurrVFGV5KaPKq0/xJS3lETffwZMHhft8VmHI3eqjhPUdZ+1lGsKUebBUDilMYaAXjlg4Y1QedWy+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A57DC4CED3;
	Wed, 29 Jan 2025 01:09:40 +0000 (UTC)
Date: Tue, 28 Jan 2025 20:09:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] tracing: Introduce relative stacktrace
Message-ID: <20250128200939.0cbce825@batman.local.home>
In-Reply-To: <20250129095819.fe6846ddab613460647db919@kernel.org>
References: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
	<a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
	<20250128112733.37d7c771@gandalf.local.home>
	<c3842632-cb15-469f-a6e8-8e9ccb3fff56@efficios.com>
	<20250129095819.fe6846ddab613460647db919@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 09:58:19 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hmm, that also works if we only consider the kallsyms access. But that
> means to export KASLR information in the trace buffer. We need to check
> it is OK.

If they say we can't have KASLR information in the ring buffer then
that is pretty much a brick wall, and we are done with this. The best
we can do is to prevent reading the current trace buffer. But honestly,
we want that too. Heck, already get kernel stack traces from perfetto
right? That has KASLR information doesn't it?

> 
> My another concern is how to handle this stacktrace on live system. The
> stacktrace has to be handled in both crash and live trace, but in both case
> we need to consider not leaking KASLR offset.

I don't think we do.

> 
> Hmm, for avoiding the security concern, as Steve said, we may need to save
> the module relative address, which may introduce a bit more overhead, but
> it should be safer.

Actually, if we save the addresses of where the modules are in the
persistent ring buffer, and expose the addresses only if they are from
the previous boot (if it's the current boot, it just says "current"),
then we can decipher the modules from the previous boot.

> 
> Anyway, this v1 may be able to leak the KASLR offset (or estimate it easier).
> I think we have 2 options; (A) as Mathieu pointed, expose the offset
> information via trace buffer. (B) as Steve pointed, fully relative offset
> in stacktrace.

It should be fine to read the full offsets. Again, perf already does this.

-- Steve
