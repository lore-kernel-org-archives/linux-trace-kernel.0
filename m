Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E131299943;
	Thu,  2 Apr 2026 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775101965; cv=none; b=hdKaIoS6lAdpQ5cexPyMFHm8qCm5uQWM7TfN99858MA95obDxgJhghM3J8m8LRnM37tXuQkXUuIARo6eSeG2zPzFJtbQqWneSLQ2jI4Pi76TXhzBiwR/N9D3I9q7bpAyrT3PWASQYpJOkBvv2/5KFmKnzddR6CCwxebkmLeSmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775101965; c=relaxed/simple;
	bh=hNmrcDnWgM6OmcyQmaWG+UQvSQwLirqjG/9/hDBhmdA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ID2JMQOUJ3jx7atLk4T/ypp0EUDA1qdJuLyEBetdeHAfyV5qwSDAlKnGLQ4RxSH+iGdAVWsyPn2vwNRuOh12QO9l4Yyc/Ps4NIOxO5fxkk2L+JEPxjaCMNvZIW+WBkNBOcahw1QbtNlrDQ74qkGdZCCsL5VzIbIL0+Z2agTMjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oovXpSM5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oovXpSM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C66DC19423;
	Thu,  2 Apr 2026 03:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775101964;
	bh=hNmrcDnWgM6OmcyQmaWG+UQvSQwLirqjG/9/hDBhmdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oovXpSM5lGOZMjCl5Z2R67fKz8X2d6Sa5qge7hSgqSjzWtAED++RGIs06RLZJYXWj
	 2W0Q9KoMvpNlMs+QDM5WP77v/80nfJC208krXx1yLrHMy2pbbJL326NxeMKu9m8Ohl
	 bbQ+cKr7TYKkpLj1Nzm117iYE98u8U9XxLPV3isA3gvq2AX0Cg/5v9gLLYYC6ZEmWT
	 JSN2LRe3MtWk9CpSqv8le27Q97Ermyk3UXxWpHBwSzwYLSYHjd+O+cKlQqNvgYSeup
	 ojyip5MIdc2BRh3Gf8KO2of88TDIp7XdNs/do9Sizps+HrPngmpgoLXKlzuUHxDHBJ
	 6bDpLBlFVbCUA==
Date: Thu, 2 Apr 2026 12:52:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: Skip printing early params to cmdline from
 bootconfig
Message-Id: <20260402125238.a470f6fa5497c55f3484f72d@kernel.org>
In-Reply-To: <ac0-rrQk8BoS9B5k@gmail.com>
References: <177505217508.1807250.22866077077504564.stgit@mhiramat.tok.corp.google.com>
	<ac0-rrQk8BoS9B5k@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 08:51:48 -0700
Breno Leitao <leitao@debian.org> wrote:

> On Wed, Apr 01, 2026 at 11:02:55PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > If user configures `kernel.key` in bootconfig, the 'key' is shown
> > in kernel cmdline (/proc/cmdline) and kernel boot parameter
> > handler associated with 'key' is invoked. However, since the
> > bootconfig does not support the parameter defined with early_param,
> > those keys are shown in '/proc/cmdline' but not handled by kernel.
> > 
> > This could easily mislead users who expected to be able to specify
> > early parameters via the boot configuration, leading them to wonder
> > why it doesn't work.
> > 
> > Let's skip printing out early params to cmdline buffer, and warn
> > if there is such parameters in bootconfig.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks, but sashiko found a problem.

https://sashiko.dev/#/patchset/177505217508.1807250.22866077077504564.stgit%40mhiramat.tok.corp.google.com

| Will this inadvertently filter out parameters that have both early and
| normal handlers?
| For example, "console" is defined as both an early parameter and a normal
| parameter. If a user configures kernel.console in bootconfig, this loop
| will find the early_param entry and return true.

Let me update it. I need to check (is_early_param() && !is_normal_param()).

Thanks!

> 
> > +static bool __init is_early_param(const char *param)
> > +{
> > +	const struct obs_kernel_param *p;
> > +
> > +	for (p = __setup_start; p < __setup_end; p++) {
> > +		if (p->early && parameq(param, p->str))
> > +			return true;
> > +	}
> 
> nit: I don't think you need the parenthesis ({) for the ifs in here.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
