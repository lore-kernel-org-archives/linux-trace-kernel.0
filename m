Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351339EF2F;
	Tue, 31 Mar 2026 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954441; cv=none; b=A7hThfwN+xuZznjXXSosmAZ0hmNR98Hj69nKEdmv1RokXWaApu3MOvPukjOVQu5YkXuq0bmpKDxK2L0RRAOoh1cbMPF4/dW3xpoawNOrVEJ9cisfGa/Ess5M1RkkpgfTfTapj6ZYzS5uVcq24BES05leQGCPybcPv3FZyvISrQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954441; c=relaxed/simple;
	bh=amEmg934H9HD4owWVyAuDEOFmw6M2IeeWp79hup+Dnw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=elEgPiN5SjfHBFa+8q5FGe+9QO7LaxLWyQFe+i/L0R1xAE9h9pi339FPqTN1t+/AOTFTRZWKAV/HtsVcKAmp63oNIrahB+fUI3SZrBixhj1D9Nr1Tcf1Bn4r09Tu9+nLKJMbtefZBlZosWuKmu7MDozFjmzz1U7745DyTH4f6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HSicztta; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qmIKNVj1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HSicztta";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qmIKNVj1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id ACC53EC010D;
	Tue, 31 Mar 2026 06:53:59 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 06:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774954439;
	 x=1775040839; bh=C+IzGmq39t+VP216mNiLCQFGv/FuetYgb6ni6li9zdI=; b=
	HSiczttannIQBUir2XfxfkJfhkIRAYZo02WhyK+qIJ7/nTFJzdhusGVQ+fSUvtvd
	+cW+UzV9dYaquveuSwWsE0PYdlXB32xDnxNWoM1ZkcDwFeb9n63OHU9fqFojc29e
	xNKabMTt3jA0/5jJGlEdk6zCSqQnUtQ5Z8HotTgwJmByA8uNjS3Hbv/izya4ZlW0
	mdz9KzxPWCuxhhQYOhg8Q+7upZnY9o9TK5upajWXpwc8q1EVbSx/74dhIX/OCcpq
	cIQoRvUNZTwJahKCVRlb8DRmIyrheKz3/UMc8odPfzonvANWXHp1v82AWlX5vTIL
	iZALrAVM70h7EO3wJQiBXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774954439; x=
	1775040839; bh=C+IzGmq39t+VP216mNiLCQFGv/FuetYgb6ni6li9zdI=; b=q
	mIKNVj1fhpvejq2rWn7WkkMJg72IOv8Y4vCsMe0bv3CX2b2E7FAXMV4TpZ+Qt6hy
	wX6wTC769KhGWm4hMTjwWTCJhIUFx9epa8U7r6jMMD2Lis1REF3II6ELYo4FHc+H
	LpVLHIXfdpAA7HTt/VQovZrFR+sJjZktpu2JTGtjK5kRls/6GIw50OeXe6lF4nrU
	PsctaOlnewJ/Gm6TkePU9OSYdu6dqXxECcGazy8yc/Eh0DAjJxyswAFPF3f0m1aS
	CNb7JXDntuFE5ijDge4m5El/b1b7rfLOlAFjt6OoMDVdH63ZAeeTWA3lzTu/fhfu
	jgExkyZl7b1sx90mxJdTg==
X-ME-Sender: <xms:x6fLaXh8u4M3xN3yhCBCMVOdFDWECCS57RPlSPECIbP8bPbPyayOOA>
    <xme:x6fLae2i1jIXeoxgWN8Nl4g8p1tiHgQA7bdu4Jla8vmGRlKq2E_nJGnfXkTyUmptF
    y6gJG1CC9yzOPlQE0wDYM3e7Lhq4j9VmwPk9TvzBr7Wg7hImdwnjDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegv
    rhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpe
    fhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrg
    hrnhgusgdruggvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomh
    dprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohep
    lhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhlvhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhr
    tghpthhtohepohgvqdhksghuihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhtrhgrtggvqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x6fLaTcamxn3Y5ms-Bgyh2Vas3930ISqu3c2kcUpFgVNaqvA6Mh6FQ>
    <xmx:x6fLaeJI2CrUUdWOZQWZC7IXYn2SNliBF7ZQbPimQyS_256MrywpEw>
    <xmx:x6fLaQxEaj3SajuAtVNUC3W7zEw1GDq-fhMFW0sD2gGk49b2axiFjQ>
    <xmx:x6fLaUt3E9SkWayamyStIv5d0tSTQ6o_IOx_tNrudK3mDW32xEIvUA>
    <xmx:x6fLaRwQybzSprLjOPq2kiKiOgkXv-MyNdawxv4e9AhL_XzAQELveiIm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 54DD6700065; Tue, 31 Mar 2026 06:53:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1v9eCq-71EB
Date: Tue, 31 Mar 2026 12:53:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "kernel test robot" <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 "Linux trace kernel" <linux-trace-kernel@vger.kernel.org>,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Message-Id: <6efebcb6-194e-4c21-8808-fdf09160eac0@app.fastmail.com>
In-Reply-To: <20260330120516.73aede9b@gandalf.local.home>
References: <20260305211810.3f48aa07@robin>
 <202603070230.Zz4BBLtb-lkp@intel.com>
 <8580f943-4c37-4c66-937d-adee13b72201@app.fastmail.com>
 <20260330120516.73aede9b@gandalf.local.home>
Subject: Re: [PATCH] tracing: Move snapshot code out of trace.c and into
 trace_snapshot.c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 30, 2026, at 18:05, Steven Rostedt wrote:
> On Mon, 30 Mar 2026 16:06:44 +0200 "Arnd Bergmann" <arnd@arndb.de> wrote:
>
>> I saw the same thing and worked around it by removing the function.
>> I then noticed that a bunch of code surrounding it is also unused
>> and I removed that as well (see below). This version passes
>> my randconfig build tests, but I suspect it is still wrong,
>> since the code never had any callers and I don't understand
>> why.
>
> Note, this code is in include/linux/tracing_printk.h, and is for debugging
> purposes (just like trace_printk() is). Hence, it shouldn't be removed.
>
> The purpose is to call tracing_snapshot() when your code detects something
> isn't right (but it doesn't crash), and this will take a snapshot of the
> current trace that lead up to the anomaly.

Right, I assumed it had to be something like that, just didn't immediately
see what. I've sent a patch to just remove the duplicate inline
function now.

> If anything, I should add more to Documentation/trace/debugging.rst about it.

Or maybe a samples module that serves to show how the interface
gets used?

      Arnd
