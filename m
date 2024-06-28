Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA33F12B72;
	Fri, 28 Jun 2024 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536805; cv=none; b=kKfBSxH2bXiQUF+uJ16yCLqwYB5vMr7W+ZwQysW/dHB1B/UMVvq0pyL0Gsx/sE7+L3S8ij33ZvmlEZxhTxo1cf/0YQULtLHcNUc52LAF1Zici2w/PxevDmdgInJCUJZe797HPOSk0ViUznpJ6MNqYkqdpBOwn51ZywUM8ag0XpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536805; c=relaxed/simple;
	bh=yefVHsO4JUxqb/nsWn/gvTjbRftGeWGVUg0tvn1oRxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1fSI6ktExuGm8brapFZYwmJwcuIjExlhy9skplZNqTklvXgSQTxm/Yhe4UM/f7OWgKCdtyPaRosxXg8RQHVbTtbv7Fr5kUGXUapvtIaX6PwiWoLBqR3eqbM2s+i/hjI5aKyRd6LjLP0oJX5WyZ5xdU74vhSwYSRzzoleTpvRzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=esuA+8gU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ObXzR877; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="esuA+8gU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ObXzR877"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C5B961140211;
	Thu, 27 Jun 2024 21:06:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 27 Jun 2024 21:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719536800; x=
	1719623200; bh=yI8GYT0tC7+Zux+1Ug0067pja9GoxuFh1z+fEwMhgEc=; b=e
	suA+8gUrtmAQDn6IbWY8U9edenoYbcGM2aS9w9obOtMXg9mUwNmKj+lh/f7lpgjo
	dY2B4FuUz4J5FiXx9rZjc4NyRl4/W5aAD1cSJDAQoAnxms9KtFR0v15bLbYGajSv
	7g/GtqYJce/JlbqHmV8635BgVbx3fAlNn5/iEe+rMA8uQyc94eqm43mgNOc/Kls6
	C2LzONO6Jp7kN0zkkWovF+Fc7bQKd/g6ygqt7ebUMvy4GPyXL4xGNqzP17f66gEN
	c35hVB/LnPBuJGWSX2Dbv49KqqrrcjxFcTh2+8FJOQ0vhlogtji+w/AlA7VhNiHF
	g+BUG9H7S0nNifhmnaW/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719536800; x=1719623200; bh=yI8GYT0tC7+Zux+1Ug0067pja9Go
	xuFh1z+fEwMhgEc=; b=ObXzR877lhFsQ7HaW7o0H/rrLmUNlgdckXnOZ2wogGRj
	uK3iKs19OOhVLaAikisMQ+6qABqildl7F7E8xPPCG5uN2jGWNMNJqfm5orFRCBqz
	kCUZIK+jdNvyVWq/HTG0IInMf10ZUQEMCtrr/XmWe9dj4gAW2y6dBzqG8H2gC2Ss
	/9TdK1ArE63SWL69EhTo2RjF4Hq61yWXIAWcW2behrxjmiBvEVM4kptRnpz/4zoI
	vshHtVfz3ACISeVNZD/whfDPadt1EnUsXh8EH7VsZRXYuaQz6DIorcOhJRCnPl+U
	skA0z6GIQFWlDk5A8s3dnVsR0GcGgu77TqfTrQpEQQ==
X-ME-Sender: <xms:oAx-ZgFq8jI5nO1NIy76el02fqScLWM4SCJ-H3sLpaGM9D-ZNHavmg>
    <xme:oAx-ZpUkVlu3C5SLJ1VSiOJ6nsxiqWEEdUtUaXYTlatw1BDwPUPSlrVOwrCUFSMwD
    r44HchR5doKgv6bxvI>
X-ME-Received: <xmr:oAx-ZqLJRy9GWTWg89LgnvLC1BH7COp8HVgi_9y0-cj7GJZMTQ7VJLs6TZxGrsoU_SezpjkgKw_3B1wjQxVh7tHo__59m5ZK0S0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdehgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieei
    tedvleeftdfgfeeuudekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:oAx-ZiHS80IbLPHSfGChMHfy0jaPxaYblv4qbcFvLTGQJ9Ae7U5hiA>
    <xmx:oAx-ZmXiSSGeaG2urRqFJz4UYdBJAi0dFsgnfu4SdR6y8WuZpzPm8A>
    <xmx:oAx-ZlO_3lm9GjhZwOjrLYPVLnxykzF408QAmGwW1WWpvSPBjp9GOg>
    <xmx:oAx-Zt2Z3TAgfMh-MIHDth8PowV0QVjJrWOiQ23sniEoBROeKQLrIw>
    <xmx:oAx-ZhH-FUPUj75UTKQIPARRPc0nlw4LtRJ0alNT_Erl-VKirGeiWLHq>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jun 2024 21:06:38 -0400 (EDT)
Date: Fri, 28 Jun 2024 10:06:37 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH][next] firewire: core: Fix spelling mistakes in
 tracepoint messages
Message-ID: <20240628010637.GA978284@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Colin Ian King <colin.i.king@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
References: <20240627170847.125531-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627170847.125531-1-colin.i.king@gmail.com>

On Thu, Jun 27, 2024 at 06:08:47PM +0100, Colin Ian King wrote:
> There are two spelling mistakes in the tracepoint message text. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  include/trace/events/firewire.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next branch. I'll use spellcheck program when posting this
kind of changes.


Thanks

Takashi Sakamoto
