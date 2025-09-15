Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610EE229B36;
	Mon, 15 Sep 2025 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979386; cv=none; b=YbeWrntQ7Ee/Y0E846aHAnq6dzGU8fX6SVZXSSVsA33bGG0tR8iMAEUx5ljGz/uqVGmy5acWZk/2fZUVsfTOuONrarurKBYB6WUSH4LmH6gECtupGxxK9V59fvxF6WbGm+9ZjXKT8W+J9W/vxU0VrT+/27eiAPuf2GSigu/7t48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979386; c=relaxed/simple;
	bh=iKc0rwv9nnPkO2ppIT8he/RWC6XXcgnPfLhnZFlFye0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6CmDIeqVg6tXUs57vzI/v96ic+euNrmxUy6zD/QlXehQA57bpmwFPgGGds4vy6xhT3i6hPXUnhTu9WcvAmayunHmCtaAcAgbHT1olhFv+A5YGLzvWrsUSPGUpWM4/J+E+WMVw/KinQtfCIC3wt7gCBEX65gmHI0FMpbequxxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 0318A1DF9D0;
	Mon, 15 Sep 2025 23:36:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id EF8FB17;
	Mon, 15 Sep 2025 23:36:13 +0000 (UTC)
Date: Mon, 15 Sep 2025 19:37:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-mm@kvack.org, Kees Cook
 <keescook@chromium.org>, Aleksa Sarai <cyphar@cyphar.com>, Al Viro
 <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] uaccess: Comment that copy to/from inatomic requires
 page fault disabled
Message-ID: <20250915193716.5357b448@gandalf.local.home>
In-Reply-To: <20250915164313.42644914@pumpkin>
References: <20250910161820.247f526a@gandalf.local.home>
	<20250915164313.42644914@pumpkin>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 33i6gkzu83bfzdnbgkz68sni8e167bsf
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: EF8FB17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18RfPw8aj/71xqwlywpNWAQzZY4z6xKu1g=
X-HE-Tag: 1757979373-771640
X-HE-Meta: U2FsdGVkX1/YJoZe9UBIgt61WeL/CIOcWy6Mxx2xXHClEjWsLi1jqg4Aq9gRdcvoWEhOJCDVGhrgnU7WIkhfw18LhHSrRIiYcEt0RrYgyMSSkb1bVZDaJYUd0VuDosC13lXdUBdR2c+wfWNfB5/SsauHh7NS8SEHG2lhAIzY3UrWpXOe/STds4w/GTcfqYnGICB8CF6fRfuLSZNimdC86U0oIoJ9vkn4QjqCRThosI5eJKEwCe0lMypVk/ZUa+oMwzUhGL2IPHZGaBfSrrXzTCSUXH7ma7SPQBnPvvs8Cyt22XkWbx93d9/1WufLv3BfbhMzqsuFPgAD63ehS+qr+0HzqXVOVxzJ

On Mon, 15 Sep 2025 16:43:13 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> > @@ -124,7 +130,8 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
> >   * Copy data from kernel space to user space.  Caller must check
> >   * the specified block with access_ok() before calling this function.
> >   * The caller should also make sure he pins the user space address
> > - * so that we don't result in page fault and sleep.
> > + * or call page_fault_disable() so that we don't result in a page fault
> > + * and sleep.  
> 
> It is worse than that - it must avoid a COW fault as well.
> I suspect the comment should really be that these are not the functions you
> are looking for, you probably want the 'nofault' variants.
> 
> Even if the code thinks it has pinned the user buffer it has to be better
> to use the 'nofault' variant.
> 
> The only exception might be in code that already has page faults disabled.
> But even then it would have to be pretty performance critical for normal code.

OK, perhaps just change the comments to state that this is an internal
version and should be avoided unless you know what you are doing. Otherwise
use the _nofault() versions.

-- Steve
