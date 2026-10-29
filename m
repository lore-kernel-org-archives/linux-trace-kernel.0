Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793232232;
	b=u2ZxKyIdOpPoERmS0jcdMJNFCI9G+lh2CXAMaHu7ZKdyHHmwYPSGfOjNxJ16phR4QPBs
	 JgruSRDdvP+9FxwoelOPj3iEzSJArhu63x+RF29J1pX2I0mUv3DgGegqC0hI+9tkNTtJR
	 lnFK04uTO525tINFGSsA90+79FfkYYSqa3Jwk2GQPczfH5GBNpwfVEM5JiGVxwGYxQFSq
	 3wOHnbojo8wsmKE7w1J/LHijBP4hqxhreshcjmcpdAWpjt6n2qOw5obxVRdT6KzNbjV4r
	 uSAsnwsLUqcUhqboSHnqLJOS9xE4gHbD9nXaN3FH83JXhBTZw20oJaf7gl6Ct+5QwnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232232;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=70No2fTQHTJsNHnSJkKU+59Q2xNNNVJJE6vcMoZGS20=;
	b=14bQnvmnRnfEj6ZWaI9vijckyVT2ocLNC8B6cLJao/TWWfp9sepBsV8XfNoTpyrjkFWB
	 4S6esKECee3nG6ZTjVZa+tFHCgzDAhPqlojuOosJSM5CGLhcpJ8FDjl+AheHTNI1+udIc
	 1sJ3yfDnhE2wiiBCQGg3R7mV4dLDNBcS39xH0si0vlN2kxdUhFwP+fuwZ3v7xPU1Bj4hu
	 kDrlKvu763JU+OOEzV4GZ4JTht960YfJsbomd4jDZM3TA8RbYWlTIOPLgJvr/dyXG3GlM
	 13GnhIp4w1wVRYTzglZZSMXu7fE+s8kDN38XSbEg2hHWHNPbT1nVPF03iqm3kl4Hn+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/U52mHw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C1606A31A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/U52mHw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911B41F01825;
	Thu, 29 Oct 2026 00:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793232232;
	bh=70No2fTQHTJsNHnSJkKU+59Q2xNNNVJJE6vcMoZGS20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U/U52mHwukkfAF7/3EqTfvB/QyaLX1ACwAlvHWkFrBRnuOwAn8fhDSUfKFMft3jV5
	 cJtqb7PryUJYIg89sfY1ncQq20blErpleE0HAeqaG0BtESKvLVOPHKS13gPfXYJK9c
	 CQXPzAOVRFFU+5RjIOr7EUvJchxu4dPc7X8xXYxy+7ZfHJqWhma3rvKrKf/PQMq9wr
	 QGqjZ9PTGT4O83T5mY1fAyZ4fskl3SmuaT2+Sqr+8E4L1b+2qg2EWsNP5nECoLzBp6
	 LHf6b1jjXIj31fQTqvJ9wsGBlZkrVmWMIbg586oUASZCv7Xl/qTQUDsI6/UZMZ0DP8
	 5dD4KBWb67KqA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/16] tracing/filters: Check for trailing characters after newline in filter string
Date: Thu, 29 Oct 2026 09:03:50 +0900
Message-ID: <undine-1793232230039360048-ae912373eb8d8692@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261028100348.584836ec@gandalf.local.home>
References: <179314820431.684037.4147763044424284198.stgit@devnote2> <179314830681.684037.17927533770192828788.stgit@devnote2> <sashiko-outbox-187296@kernel.org> <undine-1793150890261749864-1d389ec021e6edea@undined.local> <20261028100348.584836ec@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 10:03:48 -0400, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 28 Oct 2026 10:28:10 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Hmm, IMHO, there is a bad implementation in __ftrace_set_clr_event_nolock().
> > It should make a working copy of the filter string and pass it to
> > apply_event_filter(). Or pass the filter string as `const char *`
> > so that it is copied in the apply_event_filter() side. The ownership
> > of the filter string is not clear here.
> 
> I noticed this when I applied the patch.
> 
> Yes, the correct solution is to pass in const char *filter to
> __ftrace_set_clr_event_nolock() (I was planning on doing this after the
> merge window closed). But no, making a copy in
> __ftrace_set_clr_event_nolock() is *not* the right solution. There's
> nothing in that function that modifies that string to suggest it needs to
> make a copy of it.
> 
> The correct solution is to pass const char *filter to apply_event_filter()
> and have *that* function do the copy. That was my plan to make a patch for.

OK, so at this moment I will follow Sashiko's suggestion.

Thanks!

> 
> -- Steve
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
