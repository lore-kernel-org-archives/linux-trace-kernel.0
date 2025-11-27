Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D248C30F815;
	Thu, 27 Nov 2025 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764230283; cv=none; b=ghBGtlKksyM7+0HVqVbXs0P4KeF6vKlswsv3sas3fQR613sj6no4DluucXa5MIgnnuh14JD184/N3lijz9qoFr6beEI/I+CluoyI5nkdhVHMXtd5sbfMKTR9UYU+ZX6c4fdNKPDMgMSH3qY6D9xiQdWdItj9FZTL+ArLTcPZuGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764230283; c=relaxed/simple;
	bh=mC2wFX6pB0jB2YWzYvpTlw3fGCrGBW5weP0O2M2WypA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3Tcbfpq+qt7TfYtNWg9BDcNIP2eUT13Th4A694Lx0j0yA9UjXuIDebHf5b0fZpdf2gxhEHEl53lmLpmy+Rnn0dkz8ND6p+VPyXSkxF1F9PMlIv9ek7I/8Tt0zfBbpbiDlhk01+uS6Zsq7emIgh1gAHBK/oKoEJgFDfJJPvEyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epp9GFfk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epp9GFfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D77DC4CEF8;
	Thu, 27 Nov 2025 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764230282;
	bh=mC2wFX6pB0jB2YWzYvpTlw3fGCrGBW5weP0O2M2WypA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epp9GFfkNMS7o71m8LQZzPi1+DkxEcSUHuvtXAD2X63KDtfhvcFJ6yMolv+NweeOK
	 OWQnRBJ55ILilTf7eP08/xrPoKMKUGORuZl5mJNBdFnCscP2cCVFK18NOdDteY3uNM
	 HwTHdQdgEGH/+1Y93k9SS93IMsK2pXCNJC2c6vHBjgObUnJ0XtNxbKM3p38l/5iQ/X
	 uUW1j93jqnmIzIeo+xgktVy1TrlU3vE2zpEq7ozOour8K3ijyhGSLzzR/MJwv9p3yX
	 za+gmxChHHMKRjJCb0vAkWKgzj5dZDRmb4IierozrwosvNzklYZ8Zm/WRfayI0MWR3
	 4dHGxAjOCkzWA==
Date: Wed, 26 Nov 2025 23:58:01 -0800
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] overflow: Introduce struct_offset() to get offset of
 member
Message-ID: <202511262356.6FE5084CB0@keescook>
References: <20251126145249.05b1770a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126145249.05b1770a@gandalf.local.home>

On Wed, Nov 26, 2025 at 02:52:49PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The trace_marker_raw file in tracefs takes a buffer from user space that
> contains an id as well as a raw data string which is usually a binary
> structure. The structure used has the following:
> 
> 	struct raw_data_entry {
> 		struct trace_entry	ent;
> 		unsigned int		id;
> 		char			buf[];
> 	};
> 
> Since the passed in "cnt" variable is both the size of buf as well as the
> size of id, the code to allocate the location on the ring buffer had:
> 
>    size = struct_size(entry, buf, cnt - sizeof(entry->id));
> 
> Which is quite ugly and hard to understand. Instead, add a helper macro
> called struct_offset() which then changes the above to a simple and easy
> to understand:
> 
>    size = struct_offset(entry, id) + cnt;
> 
> This will likely come in handy for other use cases too.
> 
> Link: https://lore.kernel.org/all/CAHk-=whYZVoEdfO1PmtbirPdBMTV9Nxt9f09CK0k6S+HJD3Zmg@mail.gmail.com/
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Works for me!

Reviewed-by: Kees Cook <kees@kernel.org>

> ---
>  include/linux/overflow.h | 12 ++++++++++++
>  kernel/trace/trace.c     |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 725f95f7e416..736f633b2d5f 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -458,6 +458,18 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>  #define struct_size_t(type, member, count)					\
>  	struct_size((type *)NULL, member, count)
>  
> +/**
> + * struct_offset() - Calculate the offset of a member within a struct
> + * @p: Pointer to the struct
> + * @member: Name of the member to get the offset of
> + *
> + * Calculates the offset of a particular @member of the structure pointed
> + * to by @p.
> + *
> + * Return: number of bytes to the location of @member.
> + */
> +#define struct_offset(p, member) (offsetof(typeof(*(p)), member))

I wonder if the kerndoc for this and offsetof() should reference each
other? "For a type instead of a pointer, use offsetof()" etc...

-- 
Kees Cook
