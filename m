Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B637B;
	Tue, 17 Sep 2024 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566945; cv=none; b=jRDOobpeGBTmjRWe2WrAafO94VDFrfsFZFPaHBU6y6H98RV+YgLK27lfEBcS8sWDwnMJpIt/NUvvHpvtV0HJQk/eKoi5mI23kypVT7ZX0v84F9Rna0cJIorfCwp29+UYob4sF5I+lS98rwGsK6/imSC5PWZdJPlcqh1D4+AYByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566945; c=relaxed/simple;
	bh=WHbeFH5Td69vGBqxgGhIT2rQhQdb5LE6FSqeOmbeESY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxsHXU6ais6Va8Ae3l+nsaGwFmFlkCkr8YzrFkpGdHxe4kCnHKKTM3UvmbiShGKrjHESZ17Q9K6fVAQ8KQQo0D/kZBLzJNQ4GVXwVfd+463QaKIDKcWNAJmyzARy5lWka1p9IsHb3pPXfYXwgKza6jRWrICbAVnuVNIWnzF+j9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX1BFEAh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX1BFEAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58103C4CEC5;
	Tue, 17 Sep 2024 09:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726566944;
	bh=WHbeFH5Td69vGBqxgGhIT2rQhQdb5LE6FSqeOmbeESY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TX1BFEAhm+ZWwoXKsSRcTE128mIgVCrFrDzOfnhgjbI74MPD7etlTl2Nu8f5kmEAH
	 odnIr3Nb6UCpPq31zJbqWeyICExBSR8Mvbv/WY13KbzhuymGLsjjQKQuHgCTunB5A5
	 X3vBKyOMNSshGpb55BjfdNjWltv6Rfutm8Fu4pSsKl88eq1M/EeKkl56tcthmVWQ1K
	 9EnNGZnVmlxv9HZGdBc/18YD0i86NfCp8NlF/dFqM9H1gt0RK94joobYPXi404jC93
	 75fz7rFhMX0vCl8FTlcc/ow9QLYH6wssRCMkBSDAw90yZc5pYTOarC111swTX63pBi
	 2LoQ6evp0eDrw==
Date: Tue, 17 Sep 2024 10:55:39 +0100
From: Will Deacon <will@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 04/19] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-ID: <20240917095538.GA27384@willie-the-truck>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
 <172615373091.133222.1812791604518973124.stgit@devnote2>
 <20240915051144.445681c2@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915051144.445681c2@rorschach.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Sep 15, 2024 at 05:11:44AM -0400, Steven Rostedt wrote:
> On Fri, 13 Sep 2024 00:08:51 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Use ftrace_regs instead of fgraph_ret_regs for tracing return value
> > on function_graph tracer because of simplifying the callback interface.
> > 
> > The CONFIG_HAVE_FUNCTION_GRAPH_RETVAL is also replaced by
> > CONFIG_HAVE_FUNCTION_GRAPH_FREGS.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v8:
> >   - Newly added.
> > ---
> >  arch/arm64/Kconfig                  |    1 +
> >  arch/arm64/include/asm/ftrace.h     |   23 ++++++-----------------
> >  arch/arm64/kernel/asm-offsets.c     |   12 ------------
> >  arch/arm64/kernel/entry-ftrace.S    |   32 ++++++++++++++++++--------------

The arm64 part looks good to me, although passing a partially-populated
struct out of asm feels like it's going to cause us hard-to-debug
problems down the line if any of those extra fields get used. How hard
would it be to poison the unpopulated members of 'ftrace_regs'?

Will
