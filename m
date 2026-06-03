Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A71337DE92;
	Wed,  3 Jun 2026 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780516478; cv=none; b=M7VgE/F1KsZpDHDOUoGoFZlj5tgEzppOM0fVIq4J+HT8hOiaMtcIakTNRlou+RRqohizY2vzYxe4XdCoUDE886DweD3/CfkCazVQU0Uk0yLsBpeIrRbfvStxOvSSo9tuLuJdfbKFUyC0MImkT4xfPce691FElnMZRzK7b7fPHEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780516478; c=relaxed/simple;
	bh=ve+KpbkLdMn3AcUn+ycD/Lrptv3aWzaYh82cGZFXzE8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JdzVbKj+Kap7hg7YmF7ZgG+pe7GrvKZNTslBerR0F7kx/zIine+8RdvzHLr7CC6rKdqIVVva/xKQNInfaeqz/kjTZvCy3LOUeKjH4PgKR+tlaItWVhcMKdmzUr04Ue+vyjdY81QF3/2UbIIZFoA4jY4A30Q6kKzIX7YYcz5tQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fuVKQNQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fuVKQNQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F3A1F00893;
	Wed,  3 Jun 2026 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780516477;
	bh=W6J5DA436y/HhFA9gpiCgTUa/dySnD1o7NofgEPrjxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fuVKQNQQ2buo8lmNRBk5nzewJOYysiTyksg5ZBUVfTAgHamPi5USG6d47Z7pXZxzN
	 6D3i9HYbOLXd4BeLLbYP9P99vkCtRm5Q/I8PohStr0whqg0qhOXKlG58oUjP0JQBTQ
	 2os4/2qrHYnucfdLr1VFs+g5j7MNVdjQxt9/MJFY=
Date: Wed, 3 Jun 2026 12:54:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Borislav Petkov
 <bp@alien8.de>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>, "Luck, Tony"
 <tony.luck@intel.com>, "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "xieyuanbin1@huawei.com" <xieyuanbin1@huawei.com>, "Lai, Yi1"
 <yi1.lai@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
 <linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mm/memory-failure tracepoint change breaks userspace rasdaemon
Message-Id: <20260603125436.22a4d5763052f8f4933be91b@linux-foundation.org>
In-Reply-To: <20260603130006.7d2c4a62@gandalf.local.home>
References: <CY8PR11MB7134346A3E4BB28ECA28D6E989132@CY8PR11MB7134.namprd11.prod.outlook.com>
	<b930678d-a1ae-458c-8705-7ca9680d4cb6@kernel.org>
	<20260603121707.7eccb9fb@gandalf.local.home>
	<20260603161947.GBaiBUI7C8WWPwD84S@fat_crate.local>
	<0c16bf3d-7c6d-4e28-b200-03b7d0ef714a@kernel.org>
	<20260603130006.7d2c4a62@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 13:00:06 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 3 Jun 2026 18:26:24 +0200
> "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> 
> > Yeah, I was fearing that when I read in [2]:
> > 
> > 	"It has become clear in the past that this promise extends to
> > 	 tracepoints, most notably in 2011 when a tracepoint change broke
> > 	 powertop and had to be reverted."
> 
> Technically the issue is with trace events and not tracepoints. The
> difference is that a trace event is created via the TRACE_EVENT() macro
> which defines what is to be collected from the tracepoint and exposes that
> information to tracefs which applications can easily see.
> 
> A tracepoint is simply the hook in the code that you can attach to. Trace
> events create a callback from that hook to extract the data from the
> tracepoint to fill in the fields.

The problem here appears to be that "ras:memory_failure_event" became
"memory_failure:memory_failure_event".

Perhaps we can add infrastructure to permit aliasing "ras" onto
"memory_failure".  So if we make these namespace alterations we can
easily preserve back-compatibility?

