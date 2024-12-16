Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D7E5FB8D;
	Mon, 16 Dec 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734387721; cv=none; b=GZNRmGf1OXh3amGax8Yviyh9+WJrji98L0LhlOU/cRqCJsr9PTFzh+K7yqqh2Zqt0QOukUrsIGGo9u3Vll3pCBJkFtehivUlqs91d0BFOKgArbnAz04Z26+hia0+x+MHjkjrKEfrT0QEucim3C/d0eA3dg7L85veURmOJ9G5zC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734387721; c=relaxed/simple;
	bh=yGUkbVVAVkUyZfVyqzOEkPEG1vYspvRHMPxyul1vSno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWQufQNxUNXC9uDxyD9HMrc60VO7uPx/StcO8yeDF51nhdYg3AQZQ+YF4jZjZJqbCwi5eqjQX2h+ZQAxlF3G6bq4x8cUhEwpIaoGgsNsyh5WKtdGgkiS2rr42XzJRFIIpgNkcGAz7rZDx8zcr/vo64L+gs+IW9uWZCsqnOr82Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11411C4CED0;
	Mon, 16 Dec 2024 22:21:59 +0000 (UTC)
Date: Mon, 16 Dec 2024 17:22:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Al
 Viro <viro@ZenIV.linux.org.uk>, Michal Simek <monstr@monstr.eu>, Jeff Xie
 <jeff.xie@linux.dev>
Subject: Re: [PATCH v1] ftrace: Do not find "true_parent" if
 HAVE_DYNAMIC_FTRACE_WITH_ARGS is not set
Message-ID: <20241216172233.6d18d61c@gandalf.local.home>
In-Reply-To: <20241216164633.6df18e87@gandalf.local.home>
References: <20241216164633.6df18e87@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

No idea why I put v1 in the subject. That should have been v2 :-p

-- Steve
