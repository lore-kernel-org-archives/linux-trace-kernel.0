Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78C1FC10E;
	Thu, 10 Apr 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312220; cv=none; b=hANC5k2Rj4FgP7Xjrb7M8blEpL/lD0hW+G5M19f9Usqxn6S/t9qxQMgs/3g7lFWmFlkZUzoqLqKtRTTJ3Xoi3SixSflvAzkFtDoGCzlmHX4MRhfeiGFVc/imAKalk31MLQLpObvb3Jy5lVxHE42sIeBzeCULZC/4tdpoSxF8+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312220; c=relaxed/simple;
	bh=FK60XRMM36XWGeD9sJ24oGq8nWQuIZnns09CXmyiJww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtuDZhiMiDmNsOyNHbxguEKwlVBNTNz3EmA7+Ay8h3DrstoMHryslAoMwqaV31/WmvY7CACuOtkZPDfsluhDtdWBImqM51xTRtrukEFGtIf6YeO2Y8lhU1/m5q8nciGSTkR8iz+gPVqbRCxmbBWoLLesnQWi9RbLuzWKqppBkcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJrHrgdR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJrHrgdR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0888DC4CEDD;
	Thu, 10 Apr 2025 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744312220;
	bh=FK60XRMM36XWGeD9sJ24oGq8nWQuIZnns09CXmyiJww=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DJrHrgdRbG5K3ogKJhl6X+Ga2K4/l1oOEsRn1BBbn+NOLwGaHAN53QMAIDhFe71Py
	 vEfbKX3biuFSYPAzHbpqAGMMNaXFvm0zFefiwjflPZluxG5bIydNeZZylbDkQbXjPp
	 5RXnEBgbycFN71w1qeUcqQvtf3uAXPSu2P2PG4sBPf+YZiwvMoqLZNWbQio3X3wO1u
	 rwtQ/yF+6RbZGQO5TIYC0EdgGu38DfA2I0d8JNLFnciztcKXeWekZtbuLrQxhO6snk
	 Wya5zlzF7lnQM1uKGRTlfYTZDN3Kx2Rzyn/z2q3bm3le0RyCjYh+9eoTOSyUjF9oRW
	 6nqW1F7PGMccQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94D0DCE087D; Thu, 10 Apr 2025 12:10:19 -0700 (PDT)
Date: Thu, 10 Apr 2025 12:10:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Junxuan Liao <ljx@cs.wisc.edu>
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Interface for enabling context tracking
Message-ID: <a9d1144e-0f75-4594-b85f-d66b1de623a0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu>

On Thu, Apr 10, 2025 at 01:51:39PM -0500, Junxuan Liao wrote:
> Hi all,
> 
> From what I can tell, tracepoints context_tracking:user_enter and
> user_exit might be useful for performance analysis. e.g. Figuring out how
> much time is spent handling page faults or in system calls. However
> context tracking is by default inactive and the only way to enable it is
> to turn on nohz_full for some CPUs.
> 
> Is it a good idea to support turning on and off context tracking through
> some interface accessible from the userspace?

There is some in-kernel support for turning the rcu_nocbs portion
of nohz_full on and off on a per-CPU basis, but a given CPU must be
offline in order to do this transition.  Last I heard, there are still
issues preventing this support from being generalized to cover all of
the nohz_full functionality, and I doubt that it would be exposed to
user level until all of nohz_full is supported.

The rcu_nocbs in-kernel functionality is tested regularly.

Are you interested in working on joining the noble quest of getting the
rest of the nohz_full support in place?  (Full disclosure: This stuff
is non-trivial.)

							Thanx, Paul
