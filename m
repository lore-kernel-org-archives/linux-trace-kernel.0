Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41783204583;
	Thu, 17 Apr 2025 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932569; cv=none; b=LNcw/r0lq7By8gZU1GYMo14vIswet9Z0Ji3y6WFP3n98m040fCzQlnOMc56GnnUAAbqCP1+/WJWy4c5cEUa1yWqmV687Gznd+d4q7JelzodjUtYnd/tdjGVjPLSvoEQMfJcSGP5itAaV022SQwuxbG0k1zDGSSTwHdDdB5On1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932569; c=relaxed/simple;
	bh=wjYgKY975jAFrgsX+2PJ2j8ySX7rgcB8HC8tFI9lXTI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kPNj2lCAr5/17Ww71QF2mjD8KCeDM+GsimmFPlGrICxgpbnZU46Yc/i7HQm2R2S5bKHBYsiNn4vhdASECqTE1nP0ASBNh4KMkhkbNd0f8gZ7MysA3P2zG4DrXWaJA51Iw4WpdJpW/olpIApGk8LZ4GeOGa/dY6Hqf7yqtSHaWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jEv6yVEb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jEv6yVEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DB6C4CEE4;
	Thu, 17 Apr 2025 23:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744932568;
	bh=wjYgKY975jAFrgsX+2PJ2j8ySX7rgcB8HC8tFI9lXTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jEv6yVEba3ZswWp5mklpexfv2IRZvURZ4QIWTMv3cmgl009NEq7N4/lK7oDJkdnvj
	 cftSMi3Se1rZgYH+IORieYtFEyXrqUocKStYDWE/iZL6IlLBkpmAvgc8Tu28esR5ou
	 vIsQXBfxjNjMaVRWnnbYHVxpCgE59YAvrJCczFEY=
Date: Thu, 17 Apr 2025 16:29:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>
Subject: Re: [PATCH] tracing: Fix filter string testing
Message-Id: <20250417162927.e1117ce02e612e29a34985ef@linux-foundation.org>
In-Reply-To: <20250417183003.505835fb@gandalf.local.home>
References: <20250417183003.505835fb@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 18:30:03 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The filter string testing uses strncpy_from_kernel/user_nofault() to
> retrieve the string to test the filter against. The if() statement was
> incorrect as it considered 0 as a fault, when it is only negative that it
> faulted.

changelog forgot to describe the userspace-visible effects of the bug?

> Cc: stable@vger.kernel.org

Which is more important when proposing this!


