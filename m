Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3912132E6BD;
	Tue,  4 Aug 2026 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884927; cv=none; b=Op0kifhdoUgEDcduQPuD4nB1vMiAe4ZH66+UkiHk9flLTep83MsMTTYof9/FHb8vx3R8T51NGHxUmhmySLcev7nVWHKkHaUHgg4m5t6jOtEfuri+x0yIQyws5vmj1r/PjLl62J6Y/a4Q0Fjf/TH7I0uO+3p4nzKCMn5Vu0mRX9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884927; c=relaxed/simple;
	bh=zlKfplWKnzG3TCnZr0nIPioK5QOvlrpr5mRpUBhtkmM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UiNdgl+XsL47/ZznSo0zywAN6F+PV0+4iL7Al5PcQmcMuvF+OWr7d8MFtRTOI+w7bqFQP0pMMLt9LQqZXx0rKbMG0gjWZZYaLNgVgzc2cUIqokQWOSB9CHsNYTXvfAP3SQsRHXi4Y68pPSGIWVa/k9IpfK8BeG7uiNjudM9hWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ons6/XKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ons6/XKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668021F000E9;
	Tue,  4 Aug 2026 23:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785884925;
	bh=VQAw+XOIKzOxXPs/H7B3NWTfCeGVD+vu/S9yL2kr3cY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ons6/XKcQH7yabpE79oBC5/+OXhuhrQ4SqG7O63j8V2LLoATC1yCm6GmvY7rZk7wr
	 EbhijWH6SexhyWT0BgHnjJDA5zNdKQIuF3hyvdWz+krBgIUgCNIzbwvNJusUc1D2gc
	 2572VDuWNz41tm1pHtXhfFP53HF8BVc4ahoJvum0Z+oI0NJ5Ihob9lAyAptEfBJO4A
	 +kBngAA8nlHvazBFq+EOK2B7MlsS0NOZPLxEhvXUV+ME8DiUhGqY8bB9Bn7KBcPN6W
	 gBTADwym5IHd8i66YYBRe7Az2SMCXT7pPZsrXOJniA1ewRhzTDJu0okeF8C/Con1I3
	 70bt+ng1JWWgw==
Date: Wed, 5 Aug 2026 08:08:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
 kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] selftests/ftrace: allow relative paths in eprobe test
Message-Id: <20260805080841.b02390b4271e34272a5cd399@kernel.org>
In-Reply-To: <anJCpUP4sGnggyOY@akranes.kaiser.cx>
References: <20260721200612.1749777-1-martin@kaiser.cx>
	<20260723092654.12f7be2910e3e16259c61125@kernel.org>
	<anJCpUP4sGnggyOY@akranes.kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 21:51:01 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> Thus wrote Masami Hiramatsu (mhiramat@kernel.org):
> 
> > On Tue, 21 Jul 2026 22:05:59 +0200
> > Martin Kaiser <martin@kaiser.cx> wrote:
> 
> > > The add/remove eprobe test installs an eprobe for the openat syscall,
> > > runs ls and checks the filenames that were opened.
> 
> > > Commit 206b25c09080 ("tracing: eprobe: read the complete FILTER_PTR_STRING
> > > pointer") fixed access to some string fields in eprobes. This allows for
> > > dereferencing more filenames. In some cases, the log now shows a file
> > > with a relative path instead of "(fault)". A relative path makes the
> > > test fail.
> 
> > > Relax the filename checks to fix the test. Allow shared libraries and
> > > locale configs that use a relative path.
> 
> > Hmm, should we check this "nocontent" ? This change seems a bit fragile.
> > I think we should use another syscall to make sure getting filename
> > correctly. At least this point, removing nocontent check will be better.
> 
> I've just sent another patch that uses chdir instead of openat. For chdir, we
> know which filename we'll see in the logs and we can use a simpler filter.
> 

Sounds nice, Thanks!

> Best regards,
> Martin


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
