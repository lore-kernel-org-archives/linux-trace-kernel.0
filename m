Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D021F5821;
	Sun,  3 May 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777821067; cv=none; b=FzZftXIrRDV9/+oyv7at70oQ6ouGmiLDMgBjyVfeN6UwyE46tDDqUk+3GHIcx+DSZsyP7e+Uz1Nvy8AqH1u8uthI/EmD/IIEklDC+N8g+zdj021wSBTHvH9HTmJeVb6RPpqvyDbYjlCSFUelK8/dO3DCglLhhFr1/uqREgVYUyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777821067; c=relaxed/simple;
	bh=VEN8p6cZXYdhRVXcT4lY8SFhKNEB/BT4+PFsX7BB/7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZmVxsyGosk1Qud1Jz3XXW3U+5tuhamTih1cfLPKFvNztkEudJK3fuSoZko6fgjAjdfU1/b8p39wz09gcW1WM8rkiK7MSkHlhfTptfySTQF2WgAaEIPD0CbQ+Rg+PQtYOcH8Z85Ps5+Tu+O+zkEol4lpM7CNY0SaOQ5oAjfvgy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qcIa0opv; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qcIa0opv"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 15DD741084
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1777821065; bh=yhcZ62idcYRCfP53a11nbos/rNfuk1TTCaR3NGxdkK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qcIa0opvjdX/0WuN5p2C3lcMpSrOo4cJYssTOLWd9eCHKHo25RKtYQIwdeEtCsaA2
	 yShDwbbbBju4lEv3lM/16SEHDhcm6gYGpnjjf7WCkw0WRzbiLKgbKsUqZynC613rv2
	 dKxIMR95M50wO61dguow8IadjX+6ySWesKUwJpTgd9zSiMVzj2k9YVh/Lof6vyuvni
	 U0HSdr928SuyCnEMRBy0iicYTXmMrL8qwZXU2KZVqVe69Muqbls7vkP7ZnZKwzQDEm
	 o8RwG1hszPBNUNNh7aGwn1nyIfiNQeIvksntjH3Q6A8ydcM+Ei0JTzAiObgW44mSg6
	 gl54c2LaN9TQg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 15DD741084;
	Sun,  3 May 2026 15:11:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Gabriele Monaco <gmonaco@redhat.com>, rdunlap@infradead.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: matteo.martelli@codethink.co.uk, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] Documentation/rv: Replace stale website link
In-Reply-To: <20260427131709.170505-2-gmonaco@redhat.com>
References: <20260427131709.170505-2-gmonaco@redhat.com>
Date: Sun, 03 May 2026 09:11:02 -0600
Message-ID: <877bpkcyux.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> The sched monitor page was linking to Daniel's website which is now
> down. The main purpose of the link was to point to a source for the
> models from the original author and that can be found also in his
> published paper.
>
> Replace the link with a reference to Daniel's "A thread synchronization
> model for the PREEMPT_RT Linux kernel" which can be found online and
> includes the models definitions as well as the work behind them (not the
> original patches but since they're based on a 5.0 kernel and are mostly
> included upstream, there's little value in keeping them in the docs).
>
> Fixes: 03abeaa63c08 ("Documentation/rv: Add docs for the sched monitors")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
> V2: Add link to the PDF and fixed RST references
>
>  Documentation/trace/rv/monitor_sched.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.

jon
