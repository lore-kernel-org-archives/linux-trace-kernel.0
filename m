Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C403185E4A;
	Tue,  4 Feb 2025 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738671906; cv=none; b=Het9nKuW/VxztZpFuXAr8fvvJYI5Mcc9smmqf8zhCwKvAfoPWbwlSlu0cJw5z0eNs1PAuzaecByXzwWkMdwj1rsHbu3Hd85PW/BSP0rNeQQFdOfmLIlzk6PMGJCoIGks37IMyCoEQhwSHg+1vnhpzrYxmqcoE5p4iHLhJcXxUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738671906; c=relaxed/simple;
	bh=nxM4s2+q4jMZZl9mmJo4b5VSqkcMlsVNTuzIDh7bq9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afA9eEd64vwzodX3Sp+PlI25yZPM8RdguItVvwj9HRaBMYacQBy6/GFX0/ULUi7RBkwkQfTYxp78okKeUugbi7dlBpnI1kEqN3EeAm0XK8tdb5DUJRVOYnNcbIdaPoBh3zj42fp/1z3603wiYmmbdi8fWGvmjIjl49DyKScXx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks/IsdNh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks/IsdNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2491C4CEE2;
	Tue,  4 Feb 2025 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738671905;
	bh=nxM4s2+q4jMZZl9mmJo4b5VSqkcMlsVNTuzIDh7bq9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ks/IsdNh5Qkr6K3WXKSZIcSbXY6wUP5hDJ2befaqkWNrPe2XwEUZCFrZc6rgK9Gyh
	 zU23yHkNgIA+ZmgQ4GIUyRtO+v4OSacd9aH+20AWDsGE2ANT2rqqeEgHz8mx83/pbU
	 vN2q69DIDF1Vu7LQHyykA1RhLOmYlrgysh6HinQVNGD3tzpyLVZJczVAb0Vi7Wmp4y
	 9FGhHKr4x1D6amsB0Tk/MFD9byksGe2z1y1YvsFMOP8mDSl9maPPwBgjbAqvxAu/ix
	 MPzuAaAkKjK3e+cHZhsF6L6Z+1I2cp4XCJf/MfScHqwDlf0jpP3yHezz2dWobBn4zY
	 LqxVsMTd8BszQ==
Date: Tue, 4 Feb 2025 12:25:00 +0000
From: Will Deacon <will@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] arm64: Kconfig: Remove selecting replaced
 HAVE_FUNCTION_GRAPH_RETVAL
Message-ID: <20250204122459.GB1063@willie-the-truck>
References: <20250117125522.99071-1-lukas.bulwahn@redhat.com>
 <20250204113614.GD893@willie-the-truck>
 <CAOc5a3O-8wrQq3oNJC+H9ncFt0yxcm4O+QSgPk4QckF6Ak5pGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOc5a3O-8wrQq3oNJC+H9ncFt0yxcm4O+QSgPk4QckF6Ak5pGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 04, 2025 at 12:44:25PM +0100, Lukas Bulwahn wrote:
> On Tue, Feb 4, 2025 at 12:36 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Fri, Jan 17, 2025 at 07:55:22AM -0500, Lukas Bulwahn wrote:
> > > From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > >
> > > Commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs")
> > > replaces the config HAVE_FUNCTION_GRAPH_RETVAL with the config
> > > HAVE_FUNCTION_GRAPH_FREGS, and it replaces all the select commands in the
> > > various architecture Kconfig files. In the arm64 architecture, the commit
> > > adds the 'select HAVE_FUNCTION_GRAPH_FREGS', but misses to remove the
> > > 'select HAVE_FUNCTION_GRAPH_RETVAL', i.e., the select on the replaced
> > > config.
> > >
> > > Remove selecting the replaced config. No functional change, just cleanup.
> > >
> > > Fixes: a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs")
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > > ---
> > >  arch/arm64/Kconfig | 1 -
> > >  1 file changed, 1 deletion(-)
> >
> > Hmm. There are still a couple of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL guards
> > kicking around:
> >
> > include/linux/ftrace.h:#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
> > kernel/trace/fgraph.c:#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
> >
> > so it's not clear we can just remove the option from arm64 without
> > breaking ftrace_return_to_handler(). What am I missing?
> >
> 
> Will,
> 
> I believe you are looking at a tree, which did not include commit
> a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs") yet.

Argh, sorry, you're completely right! I'd forgotten to fast-forward my
fixes branch to -rc1 before looking at this.

In which case, thank you for the patch :)

Will
