Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0473F12E4A;
	Mon,  6 Jan 2025 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165993; cv=none; b=Gna2ZGTtTsMtrX7bbbYWytffIZvsI73vcpLkyp3jy7HlZ++STTlmyQrYGdgZ54ElNbq/AMhQ4CdmD6obzqbh3RHMwdHQ02HxE/li7ccRFg4Z8mK9ZkdZTExXN2H+KQ2fFWp+fb+L9OHXnlca+QCQmt6qi0OYugtV/86o2nfReRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165993; c=relaxed/simple;
	bh=ryNIPPEpcmt+2C9PMrU7ng1DbOvtyouc6tlGwl43Fn0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qJeCfmGrOKdSR1qzF3FZeHvv8dSjzAiy2mQ/E3VvGCXKgNG4GxrFGwuPul2TsxS8XC0HHSo6PriczjtsJATJS5nGd/nEl7EdoYttB1CGugSiuYCP3uQWNgntkmVLeP4buHN7JJWUO6FCr0Ne7Ueq6kcQRbixf32PoQEW/TMYKjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzV6MdqX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzV6MdqX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46859C4CED2;
	Mon,  6 Jan 2025 12:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736165992;
	bh=ryNIPPEpcmt+2C9PMrU7ng1DbOvtyouc6tlGwl43Fn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZzV6MdqXjPwZJVDq6eF8Z9BATAnLpxm9U3hGYRZS42wq4sNdhDVh0Xgme8IOUVBx7
	 A+4geFUcxAGt5Es+cXqfNgfgVJF+9j/w9aroEpvM6K86+vfnaCyDn5+i6cvBy4VyUf
	 5m9vx9ElgNrRmz8TFNEYwaorUagkPFH7NA3rEw1r30GC9GK8Z0TGGvby2805Frl1Wb
	 ndm0M3+LewIJ4wPrf6S8nrbkI6uFJBhysC9hxUKReTHJ4Ww/BdEEsEQI4xfx1M68Jm
	 9AuOzQKWmWvPwp/f1i74W4WPevSs0bstvJG9KHXuS9v0pkRziO3QyogCLXMbrGeWaC
	 eKspXtNXbAFtg==
Date: Mon, 6 Jan 2025 21:19:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tzvetomir Stoyanov
 <tz.stoyanov@gmail.com>, Naveen N Rao <naveen@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard Biesheuvel
 <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: DEFINE_FREE/CLASS && code readability (Was: [PATCH v2 2/6]
 Provide __free(argv) for argv_split() users)
Message-Id: <20250106211946.2a1b1351421298150ca8c6bb@kernel.org>
In-Reply-To: <20250105141422.GB23059@redhat.com>
References: <173608125422.1253657.3732758016133408588.stgit@devnote2>
	<173608127627.1253657.12054758575695672674.stgit@devnote2>
	<20250105141422.GB23059@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Jan 2025 15:14:22 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> Masami,
> 
> Sorry for abusing this thread. Your patches look fine to me, it is not
> that I suggest to change them. I will use your patch as an example for
> off-topic discussion.
> 
> On 01/05, Masami Hiramatsu (Google) wrote:
> >
> > +DEFINE_FREE(argv, char **, if (!IS_ERR_OR_NULL(_T)) argv_free(_T))
> 
> (IS_ERR looks unneeded but this is cosmetic).
> 
> OK, so it can be used as
> 
> 	void func(void)
> 	{
> 		char **argv __free(argv) = argv_split(...);
> 		do_something(argv);
> 		return;
> 	}
> 
> And I cry every time when I read the code like this ;)
> 
> Because, to understand this code, I need to do the "nontrivial" grep to find
> "DEFINE_FREE(argv,".
> 
> Perhaps we can establish a simple rule that every DEFINE_FREE() or DEFINE_CLASS()
> should add another #define? I mean something like
> 
> 
> 	DEFINE_FREE(argv, char **, if (!IS_ERR_OR_NULL(_T)) argv_free(_T))
> 	#define __FREE_ARGV	__free(argv)
> 	
> 	void func(void)
> 	{
> 		char **argv __FREE_ARGV = argv_split(...);
> 		do_something(argv);
> 		return;
> 	}
> 
> This way I can press Ctrl-] and see what the cleanup code actually does.
> Can save a second or two. Important when you try to read the code you are
> not familiar with.

That sounds lile a problem of your tool. Do you really need to find the
DEFINE_FREE() or do you think "__free(argv)" is too generic name?
If it is latter, we can make it "__free(argv_free) so that it is more
obvious to call argv_free()?

> 
> Same for DEFINE_CLASS. For example,
> 
> 	int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
> 	{
> 		CLASS(fd, f)(fd);
> 
> 		if (fd_empty(f))
> 			return -EBADF;
> 
> 		return vfs_fchown(fd_file(f), user, group);
> 	}
> 
> If you are not familiar with this code, it looks mysterious until you find
> DEFINE_CLASS(fd, ...) in include/linux/file.h.

DEFINE_CLASS() is somewhat mysterious to me too :) But if I understand
correctly, it is for intermediate macro for implementing guard().

Whether we like it or not, cleanup.h has been introduced, and it will be
more popular. What we need is a document about cleanup.h which includes
better naming conventions for its label.

BTW, I agree that 'argv' was too simple. Basically the label name of
DEFINE_FREE() is better to be a function name for free.
Let me fix that.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
