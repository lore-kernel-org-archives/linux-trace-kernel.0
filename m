Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D421F941B;
	Wed, 19 Feb 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980953; cv=none; b=PKXEOLnw1IFsKMfx7aKsb59slJ3z/Dg51wYU2hVWupDJqLLjPUz1u3oFExTqYxmTwBKz5MHdZRp7Ekd753flFmh+MhSy4fV9+nr2H6ygZx5NQxBDFydQf8loTvPTJZvwq1n56hCc5VcrsgE8acXa3weUzK5F3j2Y5SO4KGqfvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980953; c=relaxed/simple;
	bh=HVjGOXt3Mi8RXmjmXeP/flcyAmP7JUYj++to14xmw/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RawIt1ODsUPjrmL1bAAQ6cotj1uyaA4qxbwpN+tLSzkQx/5Gtmsw5j8onIHOxggQV7DfzOZDfdgDW+krJwjpO6cctrWpovlchtUXebBJuXv1dMmOJDmbHTvE8YiJFKeHb/wUCPk3lDAqPXhDak+XDOF3FmIs2D5MWCGRT/eOrds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA3+Rlfk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA3+Rlfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8BBC4CED1;
	Wed, 19 Feb 2025 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739980953;
	bh=HVjGOXt3Mi8RXmjmXeP/flcyAmP7JUYj++to14xmw/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WA3+RlfkL4Lq50gSB3HwVB9yvk53XS9jewnoAyCAAHSDtTh5lFpgvKidTuRkmo2Tk
	 95GXo8aWyDn7fmCM0Ad8b/tw7MnwHXJzhlbXpNOitMDe9jMgM5LFcHGRmOnvkJvSzU
	 y7pjT/7mv7Zo1HGO6BMZxQ19hmulH/5ou/mWL30tyz1MpJ6l4/NZ6Rr81mvniuGZKx
	 6IDNCX2JkWsA71RT2duK/dJqO7v5DRIW4ui7z5g1/ZugOwe234LUK/IMdKZ8wlfXVe
	 9REr/ieOOuLrO20wXT8Beaqr1CJuApmtN3kYsC08/oyLmov1dwktkCrCCCrCGymLBB
	 8N6GIOQYzjiig==
Date: Wed, 19 Feb 2025 08:02:31 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 5/8] module: Add module_for_each_mod() function
Message-ID: <Z7YAlxfC9RfMfNew@bombadil.infradead.org>
References: <20250205225031.799739376@goodmis.org>
 <20250205225103.760856859@goodmis.org>
 <20250206142817.91853f475c681bc2ef7ca962@kernel.org>
 <20250206102720.0fd57129@gandalf.local.home>
 <20250214173017.07b0b250@gandalf.local.home>
 <Z7T50DxEL7NYkr8H@bombadil.infradead.org>
 <20250218192446.1269e461@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218192446.1269e461@gandalf.local.home>

On Tue, Feb 18, 2025 at 07:24:46PM -0500, Steven Rostedt wrote:
> On Tue, 18 Feb 2025 13:21:20 -0800
> Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > The patch is not OK, you're looking at old code, look at
> > modules-next and as Petr suggested look at Sebastian's recently
> > merged work.
> > 
> > git remote add korg-modules git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git
> 
> Would this be OK?
> 
> I have this on v6.14-rc3, and it doesn't cause any conflicts when I merge
> it with modules-next, and it builds fine.

Seems more in line with what is used now.

  Luis
