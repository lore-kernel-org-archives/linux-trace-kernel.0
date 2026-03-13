Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773B3176EB;
	Fri, 13 Mar 2026 01:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773365945; cv=none; b=n0WVxGx+gSzxN4EUc153ZlL/Dw6dP+t1UlpwFpicUj9gVAU7mJMx281OTRC32LvqUDFmwlfGlq/c0I6WgSoLvTQ+bouBl2FWe6ehVE7eIRS8VCUik3ge2GTf0rqjsNw3PNQfKAvA06lE5PG3QY9/toVDpIqFWBPRTBJ+2X2DOr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773365945; c=relaxed/simple;
	bh=j2IHnjKG2Gpf4b7kqEX+nqHWjiZTPBBmlXrS6VWFRFo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ehnx/MR5jMtEY/N+bahvYMzAaO4eCcGeP9iIUbIDV+kgPFWFluofsf2BpLJTHiB88gWWnu+mOTBLyX/AUb7rsVyp7vGvPmnTp8GSWk6Va2OU4eDrqNkv3yWfiCcSubNOrPPxLeePbVXoxQZoCbIuK5rXfkpfOphSf8HS2s4dhD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miT64jJ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miT64jJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2009C116C6;
	Fri, 13 Mar 2026 01:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773365944;
	bh=j2IHnjKG2Gpf4b7kqEX+nqHWjiZTPBBmlXrS6VWFRFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=miT64jJ2DCPAGnvJllKaqbzf9R4kGdx3TiiARtTDRSGlk2yKutxWRECMfB5txbBa1
	 jOLsMiZjpOto6hJtts3qUoF5SZ4vujEBopH1+ITkLqo3qy9LIT5a77JypuIw3fDZFn
	 oL6kCThgWWly7MrK/offmo4TaodDaFde4HLsBYdnjx8FeikCaHLIN2x2/nPIEeTV9G
	 fKKaGIPBDOFr0MCcSXS+/QtW5G0meA1R/LQAFRD07wiszwii9W3+4YrCgouHf3Mug1
	 LlyDKURuOzHFd6DcIr48mmweymmqBAm+CIqxy/buzImn2IIWa0elgeun+Mgr7Yxqmi
	 BcgFcBMtW4GMQ==
Date: Fri, 13 Mar 2026 10:39:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Josh Law
 <objecting@objecting.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] lib/bootconfig: fix off-by-one in
 xbc_verify_tree() unclosed brace error
Message-Id: <20260313103900.d2d0ff8ccd6179b8decbe0b9@kernel.org>
In-Reply-To: <48aee348-5859-4d13-aa88-d0c21a4c0289@gmail.com>
References: <20260312191143.28719-1-objecting@objecting.org>
	<20260312191143.28719-2-objecting@objecting.org>
	<20260312170303.61c1233c@gandalf.local.home>
	<48aee348-5859-4d13-aa88-d0c21a4c0289@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 12 Mar 2026 21:03:52 +0000
Josh Law <hlcj1234567@gmail.com> wrote:

> 12 Mar 2026 21:02:51 Steven Rostedt <rostedt@goodmis.org>:
> 
> > On Thu, 12 Mar 2026 19:11:41 +0000
> > Josh Law <hlcj1234567@gmail.com> wrote:
> >
> >> From: Josh Law <objecting@objecting.org>
> >>
> >> __xbc_open_brace() pushes entries with post-increment
> >> (open_brace[brace_index++]), so brace_index always points one past
> >> the last valid entry.  xbc_verify_tree() reads open_brace[brace_index]
> >> to report which brace is unclosed, but this is one past the last
> >> pushed entry and contains stale/zero data, causing the error message
> >> to reference the wrong node.
> >>
> >> Use open_brace[brace_index - 1] to correctly identify the unclosed
> >> brace.  brace_index is known to be > 0 here since we are inside the
> >> if (brace_index) guard.
> >>
> >> Signed-off-by: Josh Law <objecting@objecting.org>
> >
> > Nice catch. May I ask how you found this.
> >
> > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks for patch and review!

> >
> > -- Steve
> >
> >> ---
> >> lib/bootconfig.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> >> index 2bcd5c2aa87e..a1e6a2e14b01 100644
> >> --- a/lib/bootconfig.c
> >> +++ b/lib/bootconfig.c
> >> @@ -802,7 +802,7 @@ static int __init xbc_verify_tree(void)
> >>
> >>     /* Brace closing */
> >>     if (brace_index) {
> >> -       n = &xbc_nodes[open_brace[brace_index]];
> >> +       n = &xbc_nodes[open_brace[brace_index - 1]];
> >>         return xbc_parse_error("Brace is not closed",
> >>                     xbc_node_get_data(n));
> >>     }
> 
> Hi Steve,
> Thanks for the review!
> I found this while doing a manual audit of the bootconfig parser's error handling. I noticed that the post-increment in __xbc_open_brace() didn't seem to align with how xbc_verify_tree() was accessing the index. I verified it by intentionally passing a 
malformed config with an unclosed brace and saw it reporting a 'stale' or incorrect node location

Thanks, I confirmed it with below config.

$ cat samples/bad-non-closed-brace.bconf 
foo {
	bar {
		buz
}

This closed the 2nd `{`, but not close the first one.

Without patch;
$ ./bootconfig samples/bad-non-closed-brace.bconf 
Parse Error: Brace is not closed at 2:2

With this fix;
$ ./bootconfig samples/bad-non-closed-brace.bconf 
Parse Error: Brace is not closed at 1:1

Than you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
