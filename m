Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2B231836;
	Sat, 18 Oct 2025 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797243; cv=none; b=UW1MQ4mHOeym8MscW+g+9yAUTDUHW9YqSMp4JJKrj8AUx4eFDJsl/ad2UODHCiIOUVnQlTEsFDbXz/oBn8Qa7jk+odEj4tRIRIjrFBtAHNgb/urpsZcefmw2PRKS6nY0T+yt8qp60aUBfyn9GKt9LOEcgGW8JEmo3FnQ6/sJ97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797243; c=relaxed/simple;
	bh=TcTxC7aWOL3F2dwoqNA3hz7SM18cl7z32zpxJPcZOc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TFEIAIr9LiAhj7Zdckkvxq79H4TK9tNvZLb7JzdXmQLH9H9YxLUg1xEzshqHp3Wi62p+BBxOzyd86/0iSxrwudOqYiDrMDYcdCZulHYjP1P91e9tur5BQRQGjiYYB9Zo1qfOuhlftR8xKAbfPzL+eI1qVp7+gsDmdtZOTdf+7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dGSENe8K; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dGSENe8K"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 508FE40B21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760797235; bh=2lCCpJN4b+KjkcNYS++aN2uD7Z/WcJhUXmhd22yZzsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dGSENe8KyZ21nEMZj8VQrp/w9rq5SE/lYly8d8rvKOjN8xGURzJjh2ZrMecYAV2zM
	 K6I1WZ2u9D9m1UUW/NBlA2/TdIeKHwpUSFDuMD3evFrepdLKNfKW7TH5zBJWjxaA8o
	 Zo9f3OmSUVPJtDpZxb+GErFUs7uBUlB3T9Yx+JWngNB8+rny+VmDkOo2Jnnh8YLw+g
	 bRb6tj6mBkIppSTKtVJS9uzxUhmzaVaWzjzW+Z+F++ia2GU+O6Hst8PxXcneMSvtgb
	 uNyKc7hEifqFBNjq+0agyFgmgzOjhT4TcBet5AtIB5T5N0GOIBMpT/WlKIGoXvLvcu
	 ghUXtD3qwLrTw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 508FE40B21;
	Sat, 18 Oct 2025 14:20:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
 Crystal Wood <crwood@redhat.com>, Gopi Krishna Menon
 <krishnagopi487@gmail.com>
Subject: Re: [PATCH] Documentation/rtla: rename common_xxx.rst files to
 common_xxx.txt
In-Reply-To: <aPMqTSbPucoqNhA1@archie.me>
References: <20251013092719.30780-2-bagasdotme@gmail.com>
 <87zf9pz33e.fsf@trenco.lwn.net> <aPMqTSbPucoqNhA1@archie.me>
Date: Sat, 18 Oct 2025 08:20:34 -0600
Message-ID: <87v7kcz3yl.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Fri, Oct 17, 2025 at 02:27:01PM -0600, Jonathan Corbet wrote:
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>> 
>> > From: Gopi Krishna Menon <krishnagopi487@gmail.com>
>> >
>> > Sphinx reports htmldocs errors:
>> >
>> > Documentation/tools/rtla/common_options.rst:58: ERROR: Undefined substitution referenced: "threshold".
>> > Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "tool".
>> > Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "thresharg".
>> > Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "tracer".
>> > Documentation/tools/rtla/common_options.rst:92: ERROR: Undefined substitution referenced: "tracer".
>> > Documentation/tools/rtla/common_options.rst:98: ERROR: Undefined substitution referenced: "actionsperf".
>> > Documentation/tools/rtla/common_options.rst:113: ERROR: Undefined substitution referenced: "tool".
>> >
>> > common_*.rst files are snippets that are intended to be included by rtla
>> > docs (rtla*.rst). common_options.rst in particular contains
>> > substitutions which depend on other common_* includes, so building it
>> > independently as reST source results in above errors.
>> >
>> > Rename all common_*.rst files to common_*.txt to prevent Sphinx from
>> > building these snippets as standalone reST source and update all include
>> > references accordingly.
>> 
>> Applied, thanks.
>
> Shouldn't this more appropriate as a fix for current cycle (6.18)? I see
> the warnings on Linus's tree, though.

As a general rule, I don't see warning fixes as being important enough
to send outside of the merge window; the next cycle isn't that far away.

jon
