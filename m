Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E346088F;
	Tue, 11 Mar 2025 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653618; cv=none; b=Pcg6aIu9J7bh0/9UkQPjxwe1d2gEl9V72O63dAuJFhe+1uB2g6afMstkMu0ZSKZprdFod+WQJyZkFJqojvloQBPSG4+kyFeqfhKtN6ox0Bg6B3aix+v3jdVekmx48z3txzZLSsR3jbR3Y6je9cgdUrNBnxYnEEpodUI1UeprVHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653618; c=relaxed/simple;
	bh=dwNVoDSO9LuhxUhoL9pz/AvCnYig/Hu3oCVWghUy+fo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hORGVnfqLxh763o9LhwFYKSFxIoWu1nlXGxrKpFod9yjsLVtjR58Lcss7DgsvdZEbfoKmn/xHHDdckYhzcJEaqs3Sl2WySLHnJ4WWKSSxOurFds7rJC70pqjieNGqWOs7LFm1AU+AI+2WzW0TQeXx5tzx+SdFBb4fay4e67MduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiD+OIiE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiD+OIiE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C9EC4CEE5;
	Tue, 11 Mar 2025 00:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741653617;
	bh=dwNVoDSO9LuhxUhoL9pz/AvCnYig/Hu3oCVWghUy+fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iiD+OIiETMOaeju9Asvfi74ipxsWTNoyekRFPJTwTazZAwlFfX7y9ioBrXRJDnSq3
	 lO7a5Eu51cAGJsfrtKYqhCqJSVf3dwKCISceLmuaM6YJetVqBjhBpeK3kZV7oFa9t0
	 o4ep9mIF0u4l87onP1mgfxWGHtW+Ft6nSUo0FIZMqTFxTJTpv5nkNA8ScfENIHdMxC
	 +WuxJWDXhzZZrTmClfie0zWvKczW3uogIG4B3k9XQVvscaavWefc2OP6BnJSgcnqFA
	 Lw2M+3CNx2fSq2U26vHjGss3ErYKEF2JMOMBKAdLpUTt1mBggjgscUBcgrLFAGB9ci
	 FTflX7XGhMyvQ==
Date: Tue, 11 Mar 2025 09:40:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] tracing: Remove checking the activity when module
 map is updating
Message-Id: <20250311094014.0cd4f495b31f25405f3c380e@kernel.org>
In-Reply-To: <20250307102137.2b3dde8f@gandalf.local.home>
References: <20250207015330.5c71ad55ed2f516da1410711@kernel.org>
	<173886113592.496116.11615563462036645436.stgit@devnote2>
	<20250307102137.2b3dde8f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 10:21:37 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri,  7 Feb 2025 01:58:56 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Remove unnecessary active check because tr->flags already checks it.
> 
> I've thought this over, and sure, if we start tracing on a persistent ring
> buffer, then it can add all modules loaded from then on even if it it's not
> tracing.
> 
> Can you merge patches 1 and 2, rebase it on ring-buffer/for-next and
> resubmit this as one patch?

Oops, I've missed this message. OK, let me rebase it.

Thanks,

> 
> Thanks,
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
