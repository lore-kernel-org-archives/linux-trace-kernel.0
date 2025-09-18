Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3823C507;
	Thu, 18 Sep 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213539; cv=none; b=sOUnHoh7xwsPvVuz0jzwPH1V89EWkhVVI3MsYQFR5RZZ16sAjG52rA5A5fUlCRmMWT8XjOysgcs1IhsNHqKQwC/sFcfQyqRBOBrJEj2LAaUDrQzkDD7MZS9V8E3sZbycW0AtM37MfJ9uE3vzJvdxTWcYDxaZrwDtWCB3eJibp+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213539; c=relaxed/simple;
	bh=FzcnQmFwWSl79PucrIiQL6L3Ze5ushUKfXe59SIUxSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=prrRhPBRWV1t3L3WMtnJx4dKzCqNmbZxMTZ8MfabGT3CRBJzSYr6RgHxms61LK+zDIjLcm+FcFyZM2dBSrOXoKd18x70iMNW4TkGlABXmCty5ryA7k0G5UMFs++SzxAOuxDw2zlJP8i6cmRX4IvbmgGlfuZ0u3nyWTwKZ7ofO5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qHzo6o5s; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qHzo6o5s"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7AF37406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758213537; bh=1JEp5haqo9wo88r9+2hZ88gOsmInrwX/d+0huy3uhMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qHzo6o5sSrPZ6QOgs6dZrowVOAj77f0rP/LCNElwjtm5qvUaI6UrPjjvnvkI2KZz2
	 yqSHs8iOvvNGjxEN16GU4FJo0t9SyEltmfG7riHhm6vkwOLbu6a24H1XA2RV8Yg4PN
	 0Dm3oWHWF6sI/2at5G2DNeHBkJ0JGMfrsWYFJJ24u7Va/b7jy8wd8/LcGeTCq73Bei
	 N7vsbF5SChatFqzzODYMLhN8IK76VJHf0Fnq6agdP6Mv8CwYQrZrw/qzt3sTCFVyJb
	 87kTytbEg+f1AYRtdBMI0W4lqFcJ1Kf5GAweyxkfz3oKQQ9MMLejSDz02xVQAWhSW4
	 OzcRpUK1cIRdg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7AF37406FA;
	Thu, 18 Sep 2025 16:38:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/5] Histogram docs formatting cleanup
In-Reply-To: <20250916054202.582074-2-bagasdotme@gmail.com>
References: <20250916054202.582074-2-bagasdotme@gmail.com>
Date: Thu, 18 Sep 2025 10:38:56 -0600
Message-ID: <871po390m7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> Here's a formatting assortment for trace histogram docs. The shortlog
> below should be self-explanatory.
>
> Enjoy!
>
> Changes since v1 [1]:
>
>   * Apply review tags (Masami, Tom)
>   * Reword patch description for ftrace cross-reference link (Masami, [5/5])
>
> [1]: https://lore.kernel.org/linux-doc/20250911042527.22573-1-bagasdotme@gmail.com/
>
> Bagas Sanjaya (5):
>   Documentation: trace: histogram: Fix histogram trigger subsection
>     number order
>   Documentation: trace: histogram-design: Trim trailing vertices in
>     diagram explanation text
>   Documentation: trace: historgram-design: Separate sched_waking
>     histogram section heading and the following diagram
>   Documentation: trace: histogram-design: Wrap introductory note in
>     note:: directive
>   Documentation: trace: histogram: Convert ftrace docs cross-reference
>
>  Documentation/trace/histogram-design.rst | 151 ++++++++++++-----------
>  Documentation/trace/histogram.rst        |  38 +++---
>  2 files changed, 96 insertions(+), 93 deletions(-)

Steve, will you pick these up, or should I grab them?

Thanks,

jon
