Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894319;
	b=zj2Bv/KaEqRp0qFHQuRvJ0PMb1fMLlJKb7iBijjiD+pg5hR6ug14e5nd4m1ffeJOldaR
	 8d/qKc97DDRsHf+tdjfDTV752z8yql7pvD70ZyEJhJoCMjRrSANvlpSteOTu1Oe+7tAI+
	 LCFACCxroGOahoM+u7GiagFEHkzLT58XQlZr1B5rlrrQjU9wImE2jtR3F8Ncs67qrT2Hw
	 vzzmdY5LYvYwuGZs9eyaYT6nZh/+cE/BNASBnY3cd0rur7brETk1gflZAqIhcI/8q73dS
	 DSM5CMAiRJ5+NZE50GiWyAD3j70i5KG8q3cx6dcxNZcO0O0Pcr+1VAmbHc5CRo6fTEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894319;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vjzD5gsdcDRuLdlSFyi3RgJzZ2o3Osb6sjcR1w7pitU=;
	b=PUnvWUAVMHYoqXdMUc/KDB6lOXZDWhdWKgmo79kv17goWCxCrgS1WMDRT1ZZSLcT1yop
	 Yc1jNIWNOx4Eh6gkG3o0p5ivr1eDwee0aGjhwEB38lDm8Hr0rJ+iLeVa9M/tYA7nEe5DV
	 n6AUQ6W1v/0u34ClKD/e+I6OPnAg2/If2+J3TtJG+g4i+uURnzrRaYRtNDJjHZ18b0Jlh
	 1rlMF4lyYTrLHjpnEK5gIS0oD4BRUAtarHTmZOMQlp1DVqVEuRQ2DfWM6kTyooSuL3yt6
	 9AP824k/h9U4Q9GoQyqrLFHKnDeJ3KJAs+LGdhV/Yq9eVo0tERrhqDxXIGUHgi1rE0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ede+pcOJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2722A606A31B
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ede+pcOJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0BB1F01828;
	Sun, 25 Oct 2026 02:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792894317;
	bh=vjzD5gsdcDRuLdlSFyi3RgJzZ2o3Osb6sjcR1w7pitU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ede+pcOJRdVP+Cd73MauDEdHilhJ0yj5UtFOKByD8TYis6QeoiVlvkwmOEGOuPK80
	 lgs30UAzmANDwvfqYGWP6QrexVssXjky1WBqKNjW4oJkDPYX6elKfcOVFYmCSKvNNX
	 U7uHtin2sldxPlCTEACRGCMlx94f34/nnlt6jWtA9FrNEyF5sf1URLJAKeTi7RMfzj
	 EN/+nzL0blbS17EzGq+eDCdAzJQiJjZalFjKvmTQgfiPvi0GH31jFo8jfqTvQswAAl
	 u0rxFKKtEEziMw5xHD6TbedHecfT6JhtcYU5rHwHzd3TNyIWBWC2iiyLrPNUXcwNE8
	 LETGMwXDkPHEA==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
Date: Sun, 25 Oct 2026 11:11:55 +0900
Message-ID: <undine-1792894315707145292-2ac5653c2d9ee218@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-183814@kernel.org>
References: <179285912318.466249.7425922682086130057.stgit@devnote2> <179285913336.466249.16045710288666912574.stgit@devnote2> <sashiko-outbox-183814@kernel.org>
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

On Sat, 24 Oct 2026 17:02:09 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] tracing/filters: out-of-bounds read in regex_match_end() when len is 0
> --
> 
> commit 1023475f1fd5bcb5e8b46a2be2fb9fe7ea16d624
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
> 
> This commit updates regex_match_end() to compute string length via strnlen()
> when len is non-zero and strlen() when len is zero, fixing suffix filter
> matching on fixed-size and dynamic string fields.
> 
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> > index 5e74d2dae40a3..18ce3ec00d34f 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> > @@ -1075,10 +1075,10 @@ static int regex_match_middle(char *str, struct regex *r, int len)
> >  
> >  static int regex_match_end(char *str, struct regex *r, int len)
> >  {
> > -	int strlen = len - 1;
> > +	int slen = len ? strnlen(str, len) : strlen(str);
> 
> [Severity: High]
> Can calling strlen(str) when len == 0 cause an out-of-bounds read past the
> end of the trace event record?

Ah, good catch! Indeed. len == 0 means it is 0. Ok, let's fix it.
(maybe we should also reject len < 0 for safety?)

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

