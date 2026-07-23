Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8138402B93;
	Thu, 23 Jul 2026 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848865; cv=none; b=H274tYokWMfj8XuJ1gpNnHuo2NCSKtftxSLs9nT0mq9zJ9rmOaPqU4a6LdTtbJd0q0O7BAItUi2+6fmaQ5Zj8PI+9zipGWKW6F6Z2h8UVOlhEARSIfpvlIoSKxfeJuDGveIT7fWZWmXsZwLk5zy9zhwxMbZtZw6ZQA4DdRH7w38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848865; c=relaxed/simple;
	bh=KPdZI6sjiRJaG/DQ5UMu/dukY/0uFqS3TehBDSLVQPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=korxBDKk0YGikwiCXh9el3E7XRnzzcFES6KJJgOuEz7n9AVXZapG0s0rPFHvt+zr2dnf9c8po3H2X4hToJ6q1c5IFfucsL581lCoDp/hDo66VAlugvUcSjjPQhg898aN5c+lNK9hljjrPzSuvHIA6JSbXvMXJt+Jta/uLYL/HgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org; spf=pass smtp.mailfrom=rostedt.org; dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b=k15fSJoQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jaxgyioo; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rostedt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b="k15fSJoQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jaxgyioo"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD176140023F;
	Thu, 23 Jul 2026 19:20:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 23 Jul 2026 19:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rostedt.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1784848857;
	 x=1784935257; bh=22s3N3mTFM/9l98eIgw0YUL9qYlrG/ytSrlKsjvI+b8=; b=
	k15fSJoQHiXWZ9PntYw91yu7rX3d3xkgKvuvBHSztlaWidyCUGnh/olwqut/12YI
	yWsld3fujFzGp1iiy+iRU2st4AQvbk+nZTTHBNjsxQUjq5xO9V9oJGlsRLWPN+t1
	9d+K0erPmh5Dsf3gykoKnDg7d5m5H+0YRSDj1IFXC4lkM3nO0IewMNTjJBiKTadz
	Hu5EB4Yb7DU6gkIAXMAsNJoJGOuXoSEzd+dIWxm+z56ZwlE6ci9b2mDBYRB5vHM4
	4MUWUtUwMtWC3tubnUukS78jchtYCCOGcPl6R1Sn+Y7TxbCRUIg5qgu6pd2AP6Y4
	Vo1xhIHBKAfhM4rybIOy9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784848857; x=
	1784935257; bh=22s3N3mTFM/9l98eIgw0YUL9qYlrG/ytSrlKsjvI+b8=; b=J
	axgyiooKfGx44zkVPVNsBBG1kemdGW5CcD9tHxEIoOHVM3s5X6NC7ocGi2H8pglP
	NJmzy0JZndnnVlQKz1SXD+ANTvQC+ghW0YRi8pe1cF1v4FcaxWP1cJTrqyNZqniQ
	nOXAdThhIFJNmrtGjlYhPCQG7Ej6mZ3/g1fOr95BUsQ/nO5uOLCnc0bo5g9KfPuY
	wwIYlBXbQSJeC51Odjp+muBVxWw0hsWOOMZ83nb16ed42DmhJjBpP6h9fmTvXX+L
	rHJv5Oz4akBWLCerqLu5jWBjeaCUrWSnUkueJv5iUtCROn9HzvBbI4Z/He6u8OZ7
	/mz68lwdqdOl9XOxMn0ZQ==
X-ME-Sender: <xms:2aFiahrTYSU-g123Ja2IFI9wmMbb4OEKqEY73H0W1hgAr5FVRQXx6w>
    <xme:2aFialJo6XuEZ7kDpMlSlTOgtCaywGakQPZZYXS5x90oU6C9vrr0yhMKwe0RiLTXY
    E_I7dgCRy8-9Q0MJWLGQWk4w_L84hpCvzYnOxmHaHhqlD1C3eprqNMm>
X-ME-Received: <xmr:2aFiauTTyPKCMgYeBi4FuIqxYR9QtRgJ_pmMtwkxnSqz3lDAMjgt72GDN-jHNf7cvuNYA3C4>
X-ME-Proxy-Cause: dmFkZTFSLVaaUj04zhOKPfSZkzF0CfR84aqxeSYMxZppeB+w4r7+UelQLeVaahlPhKi+Oq
    0rHcrAwP3C4Mdhv//iJAxuL1zYisStFn+whQaBx6XxTautL0JoBCUqDqLCFKCoupHgdHJF
    643Sc62hKZoVVmnbvE3aTRYcqqymR8H9YoXtNj78lsH/a0t5c9Vk4flKzCsOAJpJnnz2qQ
    D2mQoSJaTyQric/FVWnHIrtu2fJePvHFB2NjPOAbo1zI8hIWnVtMcZLmsRqRVEiv6J80If
    tPTyT64cbJF9LL2xQh1CUxP4iJoC8qiTEHA6aut2ZvP0wbbILd4C3eWMRPaF51SV+sJffx
    YKjyDVNCMleejobabSOuOo1giFI1aULe48d/U8RuB8PUax1fPoZENVEiUgRWrtzpb7Fokd
    3lbOgUCrqf5nj4kWsNbmJGW/2d/C0fNWBGPKaHHsmnDjzrTC1KiqVIyv32RIJdGDuaWPvE
    5logpEsmguCvPvZEQpXuqVwkAds/+qk8Ag4FhN5IFpYvXGI2UfV4d9UUiCylO4Y3GFRrM1
    k8fsTJoCD4pOfI4ACrZ2tVtghqP+xD3IZB/iOQ3ywH/MzL0jpDmRd05mqUaqT+7RV//e2S
    s/KvUwnIO1YIoMymE2Mr2TljLiqNNP86L0YB2xUcRTOBWu2C+vmr5LripvnQ
X-ME-Proxy: <xmx:2aFiastpDeDOgakVWTaUAWvDx3MZ029tRYVJBTiqw40PamhtQRxjvA>
    <xmx:2aFiana1H1ru69xj3_PQl7Z07WmAO4GkZ5X-agzk1N7YG3fW_l5JRA>
    <xmx:2aFiaqGIwXCeG1fsFnB7brOeX8qc9hRVEHOJuhLYrnZxStBB6uQJLg>
    <xmx:2aFiajwtV76nHAlLYg1i-iOLxY4yO25T9t6Y7H6qpwkcR7VsibGfcw>
    <xmx:2aFialgX0vEdLwKW2Hn6dYsqutMYh5x5bT_1DFfPNyXTAwAzEVBP7Aif>
Feedback-ID: id06e481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 19:20:56 -0400 (EDT)
Date: Thu, 23 Jul 2026 19:21:20 -0400
From: Steven Rostedt <steven@rostedt.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: David Carlier <devnexen@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Restore synchronize_rcu() before freeing
 trigger private data
Message-ID: <20260723192120.6a556199@gandalf.local.home>
In-Reply-To: <20260723191846.16a9cec9@gandalf.local.home>
References: <20260723170212.55325-1-devnexen@gmail.com>
	<20260724063315.b5ab5f8519c1555fa0d49756@kernel.org>
	<20260723191846.16a9cec9@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


[ Resending with my steven@rostedt.org, as gmail is being a prick ]

On Thu, 23 Jul 2026 19:18:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 24 Jul 2026 06:33:15 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hi David,
> > 
> > Instead of adding just a synchronize_rcu(), can you reconsider to introduce
> > .private_data_free() to event_trigger_data? I hit the same issue on wprobe
> > and fixed it with ".private_free()" (I think private_data_free() is better
> > naming)  
> 
> You mean like this?
> 
>   https://lore.kernel.org/all/20260723191534.67136-1-devnexen@gmail.com/
> 
>   ;-)
> 
> But yeah, David, can you send a v4 that renames private_free() to
> private_data_free()?
> 
> Thanks,
> 
> -- Steve

