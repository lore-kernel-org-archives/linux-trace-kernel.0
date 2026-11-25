Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616074;
	b=FJv09gUfzvnoXy1d2Nzy7nEh0XRIabOAx1Wcf4QJLsp4hzkzEmgrZ04kW4oFONxGjJHK
	 Owa9aFN57PsFviP+UGbH41F5GYJy9hkAReullfrWHbFdA+fgzVC2/VnibcWnY+n2L5TZw
	 /47DnpiJP9CYqxAWWZRHvpBLbllji2If9BCuU62v0/b38i41DWC11OhmsLq3AfF4H0uu7
	 cSr90c3h2vQqrI72y5wMtwXdqYcHEXmF5U17BcyuvDuEIShULPsUnIBFrpgkmiVx58Ncq
	 YWVyAFLiS4E4C++sHkNmrg01bU4OZjhDKTMCIUHl/2Pl/J49zB68gPmYzUr2XM96Y5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616074;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=gBP8MLvqgrdXYCSJZaJNLoss77tHBezOYxNnjA42fbg=;
	b=LLBXIGEMcRLEBXIk8Kg/DwmKJdVcv6CoQkV8G+JHK8KnxQedTSzhFBYg9Bq3ObFkRCUd
	 klz6qIW99dC7nP/m0b2hdkDkv1zBSRNRhM+1dS2C4UYgux423RJkBeZT2ZMa+JjIGoDaN
	 NpD/kBj8pwJMRQA9Cy+YLaZcIVUk6ZS1qgNU+PtzeOJQcmvb4rjb9yf4d4pDpDABDFev7
	 OwZJg2D2vwamzke4f/74LsWksUEjqAMsIxbWXJJhcxctXod8obxbLvCvkgly6gZcT9+Yz
	 AIs5PFQQU173VI9TprlJj1OMbyAnpZnJwrbAYmjkabfHIFje2jhj+kXd2VHFk86E8OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=5XdaFI1C;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53013606A326
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 14:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53013606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=5XdaFI1C
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id D77BE1A0E60;
	Wed, 25 Nov 2026 14:14:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 30A1B32;
	Wed, 25 Nov 2026 14:14:30 +0000 (UTC)
Date: Wed, 25 Nov 2026 09:14:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Crystal Wood <crwood@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] tracing/osnoise: Take trace_types_lock in
 timerlat_fd_open
Message-ID: <20261125091428.5783cc9c@gandalf.local.home>
In-Reply-To: <20261113064103.3041704-9-crwood@redhat.com>
References: <20261113064103.3041704-1-crwood@redhat.com>
	<20261113064103.3041704-9-crwood@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hr6wug84fe6143cnz8iamntpj4fwd58t
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 30A1B32
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/0Jf4XfSgH4QTnSnRh+3HsW/XEKz8G85Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=gBP8MLvqgrdXYCSJZaJNLoss77tHBezOYxNnjA42fbg=; b=5XdaFI1C9PCsS5SpivGtYmY1FLHTu9q7Zw1NauXBI3C1VN3kAvV1a7WeOdL3Q9KPuwzjbxN/5KnMykhhKX+hmFXKiUQFlr44uOvPKtmQZeGa0s8R6IvNu5Qx5nFTc/qmeoiIJaGafmdYMKMKolGTjo0ywZkueUR7LNIlxuby4KA=
X-HE-Tag: 1795616070-82410
X-HE-Meta: U2FsdGVkX1+9+0iX7EP0K9uhfoX4vhcnLRwidHkHYIalCdTxvmGob6Ft91yBHFltboovJAVjoQbkzNKQcJwNn+2lLtIU14WO5HojWIPSv4KOC6y5I7Q8mIEYx/Sfo84h/UBrkc4j9rrvB7Spotb21PajFA443oZOjEZQHNK+tIfkTYbo/IW/IBfRcEFb+B0VEbbF89MemzKJ8o3la0JYPgxHlCOrf5rsyDMKN+o+kDUcRK0KP98KeFeR8t754fkUgAn1SaDoUpBl392/5jott6bnLa1mXVIkd9Vs3O8DK+e8m0cZkUlrU8j1ViyBlfQOw0EaVSR9hgf6nKln7luSl+KTQ8ozEnn7

On Fri, 13 Nov 2026 00:41:01 -0600
Crystal Wood <crwood@redhat.com> wrote:

Hi Crystal,

> This prevents a user fd from being opened when osnoise_options_write()
> has already stopped threads but not yet set OSN_WORKLOAD, and matches what
> all callers of start_kthread() do.
> 
> The original intent was probably for interface_lock to cover things like
> this, but it never covered the full race window, and currently can't
> due to lock order issues stemming from using interface_lock in
> osnoise_sleep().  There does not appear to be any remaining reason
> to take interface_lock in timerlat_fd_open(), so remove it.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
> v2: convert rest of function to guards

Ha! I see this does what I asked for in my reply of patch 5.

Please, fold this into that patch instead of adding a bunch of gotos and
then removing them.

Thanks,

-- Steve
