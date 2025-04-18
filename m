Received: from quail.birch.relay.mailchannels.net (quail.birch.relay.mailchannels.net [23.83.209.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF94CB5B;
	Fri, 18 Apr 2025 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744996705; cv=pass; b=bsl6LwxZpm4dhr5Xxr+FKmPTKOfvCzHAnSdzFjoOShqkeQSthwzDkaqTNWrkoExdp2LjBvWZS9OuCW1GOsz/Y4mYE7UvvrOkPlGpBrrr2v6+tagFMpsLwdCbwLLLwRgoBZAWAVgvTDVUifHVhxsuov4XofCeBz/emCJL1+kEwMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744996705; c=relaxed/simple;
	bh=nivJx+aWC/Paw9D42txKHWZuy3RESONw1UI4RDLpNAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4oasKlbbJlZsZzQXi9ULzkLzJgAYhIJ37LTTyqBPJKtqkLaOtmQ6QyX4RnEdFO3zBDOxFKu3XHpXyEiqAbRaef/MLR7NxCvEFoaEpU/hS4F2AiSjG8nLIVUSSURvmAtzrCYxwzt0ydNSjFTbDaWMTgR7xvQIA1CE0rMhZS69dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=WpjFVcl0; arc=pass smtp.client-ip=23.83.209.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="WpjFVcl0"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6A654211ED;
	Fri, 18 Apr 2025 17:08:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (100-103-157-141.trex-nlb.outbound.svc.cluster.local [100.103.157.141])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id CC8FF211A5;
	Fri, 18 Apr 2025 17:08:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744996114; a=rsa-sha256;
	cv=none;
	b=kgBcrXx0hv8mf7vIrzYjUNpQBN43GIjYFoBFgk0xFodyGAzmCWVnT0oWS2etWrKnqNXUjc
	okpHnYRuXshLwTXcRZSJFAc6pf0Et1RlaZZTHnc5bykNFfJHQKrNRleYLz8PHME8d66LxP
	36eTHyagX7wXUyNVPNm+sDAxX45mSitKrSgTgzBUphZrsHZMQjwmFlnPjL8DMO6HG7wBHU
	X7IH4oRLReevtNhhQFpJQiCbeg1mJuSUgKryR+83KS6zfMOtyyfdJAU19A/zO/5sEQqZen
	ELbhFOIzCx0zYd/36A9sUPxm9gWeIfJcg9KQVFjEY09jjSotUky0jHPX4aoKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744996114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nivJx+aWC/Paw9D42txKHWZuy3RESONw1UI4RDLpNAE=;
	b=VRM0tfHxg0QIuHjAFWy/a/8USNMx/g5z52kxu97w7PoJ3rJAcMkFDEXQoPzxVVQDRJZMp2
	uMqzrYRAagZxyJmcY8sI2Utvw5twyoZfKP2I7OF7bOIDu1EQPH9t2HUz/Mw6BQbr4KYCt+
	K/ewJfMxD+zyAXPTydKiksqHw334jrCp9C2h9gxJJcd5MN4RCZCBoOOVTOVfi3X9g0P43a
	UXIGwqyOhKgYurBGnOMpTrnc1YqHCMUA32pJpLtdYrSNQPt5xP1NzzT5h3o+4NH+OGVD2i
	NBLAwQDQB8vcu2zpYGaTXZnRxGlNh6oPTA3+Tg4fk4XiiVxBlOrEs9ZjnK0BUQ==
ARC-Authentication-Results: i=1;
	rspamd-77f95b8c6b-727mx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Invention-Whispering: 04b2fc347a10453f_1744996114220_1610682428
X-MC-Loop-Signature: 1744996114220:4071012686
X-MC-Ingress-Time: 1744996114219
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.157.141 (trex/7.0.3);
	Fri, 18 Apr 2025 17:08:34 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4ZfLnX6zHzzZh;
	Fri, 18 Apr 2025 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744996113;
	bh=nivJx+aWC/Paw9D42txKHWZuy3RESONw1UI4RDLpNAE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=WpjFVcl0xSzTJgGelxpfP8g84RwjiUFsPAF2LmooMkr9BgN9Q6PbCxpafsVorEtdY
	 uq4xRm77ubp/3z5UplKcwMb+32XenpFoz2S/5Nc1LPJqqg55bop+U0/YzbS/Wghp0U
	 /4rLWdTQL+KUcakg6GyOlJ03D4LJMSVIWdKhjH6cGAe6mxaZaadp3SJp0zIIPkS3t2
	 4vd3WR+4/rdMS9hPquv3kx2izPRR8KXaIW9yBdvTf7Lk4Gz9/axENv4RlzC6vzu4DH
	 NRk9XFJ2KnNIVE9YQ8KNFGM5dAqyQZCSxLr6bZy8iItWneqjL8YO29zyet25xWbGyJ
	 VCIayLZC5C4nw==
Date: Fri, 18 Apr 2025 10:08:30 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: nifan.cxl@gmail.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org, willy@infradead.org,
	akpm@linux-foundation.org, david@redhat.com, fan.ni@samsung.com,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	npache@redhat.com, mcgrof@kernel.org, a.manzanares@samsung.com
Subject: Re: [PATCH] khugepaged: Refactor
 trace_mm_collapse_huge_page_isolate() to take folio instead of page
Message-ID: <20250418170830.csed2ihb6ypbrncm@offworld>
Mail-Followup-To: nifan.cxl@gmail.com, rostedt@goodmis.org,
	mhiramat@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
	david@redhat.com, fan.ni@samsung.com, yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, npache@redhat.com, mcgrof@kernel.org,
	a.manzanares@samsung.com
References: <20250417171758.142745-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250417171758.142745-1-nifan.cxl@gmail.com>
User-Agent: NeoMutt/20220429

On Thu, 17 Apr 2025, nifan.cxl@gmail.com wrote:

>From: Fan Ni <fan.ni@samsung.com>
>
>trace_mm_collapse_huge_page_isolate() is only used in
>__collapse_huge_page_isolate(), which passes in the head page of a
>folio, so refactor it to take folio directly.
>
>Signed-off-by: Fan Ni <fan.ni@samsung.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
