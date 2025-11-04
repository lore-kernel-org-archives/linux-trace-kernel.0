Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC901D5AC6;
	Tue,  4 Nov 2025 00:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215730; cv=none; b=f7n0CnXAZGkuqluHcZHAkpE6caSn6oRUOAkvXvZGsyC1TIvpbRkNq9XLlXMCwu836wpuWYv+NvtK+agIZcZySPeurc2vlaWcYH3s4zMDEtrqHnrITHdeoXD80QPtzNBtBNdXYXqIHzBMIh9VyAXanVY9ZI9mINP4/mrSFe+Qlj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215730; c=relaxed/simple;
	bh=l3NqUR/1c3+ouM5VDzArbpFS3AJQLK2NWWrA3dxB9KU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdlUQVljB+yO78UyHta8jkXvH1B+ZiHLYUVk58aC8WNqEUpGbOU4GE5xk/3f++E7+DN7FzvVuTwIsXlRtYD7eDw3DqTW9T9WuUgHY8NBkebpNEfyn8dLHx2A7FdhzhgHWxUmQaMBg3d5F/lTYTRkWivVeinNWfCHaBAY5/TSeBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 58C9F12A1F2;
	Tue,  4 Nov 2025 00:21:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id CB3762F;
	Tue,  4 Nov 2025 00:21:56 +0000 (UTC)
Date: Mon, 3 Nov 2025 19:22:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Tomas Glozar <tglozar@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>, Attila Fazekas <afazekas@redhat.com>
Subject: Re: [PATCH 0/9] Documentation/rtla: Cover default options
Message-ID: <20251103192201.4a93be06@gandalf.local.home>
In-Reply-To: <87fraubsfv.fsf@trenco.lwn.net>
References: <20251010083338.478961-1-tglozar@redhat.com>
	<87fraubsfv.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CB3762F
X-Stat-Signature: qzcby539r7akh6sihfzxtaz7cxdbenm5
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/0Jrix/cBmvjpqfIf8KPSDkJQcvfshX38=
X-HE-Tag: 1762215716-399272
X-HE-Meta: U2FsdGVkX19ZoGAV6S3yb+r4I7PP9nX2ewM9tGkHqg/gXcm3aQuAAuODFemG6oN3ZxTrX3cs8m7gEjo3pJqzTGFNEazfe/yPl51E2bGM6Y2dFb7KJM0vcxXdsGpDVQjwfqMrPpc/4lqguNs+kPXo8c8ZP9Gsi8YnJUl/AGQEoBgDfhXefFHyrFqANB0eMV38arO8cGzN+MKRrGDdVrM82oL536IbRFXnlQVuY+yIOBhDlUI+7np2181iBIlzj5fsbR3K7kcUIndW+G3PaByWLsLpwWKEC2uiJp5KZ0KtgFkJ4ImxNvAqMRuWFWSYXAEEoqjnePQ2UEthi0N6xdN+1LPTM6KCPzgrYP2G0gFBP2mGCgwmCSW+wX3oi2tYAMz10k7kGQrZH2uuugoeqzHMiX1uuzyoIFyA7pcbo4W4b8S6w65B3lnleA709sW/N6sXoyikk6d34S4Kr7vJrVyRVA==

On Mon, 03 Nov 2025 16:35:32 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Tomas Glozar <tglozar@redhat.com> writes:
> 
> > RTLA has many options that have a default value that is used when
> > the option is not set associated with them. Those are not covered in
> > the documentation for the options, which creates confusion among users.
> >
> > Document the default behavior for all relevant options: -H, -P, -C,
> > --trace-buffer-size. Some of these are covered in general
> > descriptions, only missing from the option documentation.
> >
> > Also, fix a few typos and incorrect naming of tracers.  
> 
> So I see that this series is still unapplied...should I take it through
> docs?

Yes please!

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks,

-- Steve

