Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13AC163
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Dec 2024 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734739579; cv=none; b=nWI8UOg7TxSv6UKh2Q5eLtcgFrj1nZCdgJoFLFoSDF5RgBQsum0HqbulFQPVbQHZpBOJfOjlrzyJqSTPsf/fIErNPTR1vEmuBMDFfwA2+iP2WlTrWi/MPSSqHb0rh/scCwSVf3wfbTaLpFUV38PDchz2v9dLHACBGw9UVgXjNqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734739579; c=relaxed/simple;
	bh=bexmuoqjspW3k1y/kHlQ9GFtWiI0eq7fz8eR1wwU870=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0n/x+iFXEGthKNHQJtV8/WKP5cUs4JZFHGckFiAGTwPtbsCvQARCBPp+XWVJMUzpqu5cgQXy0/Xy/cl1tjVU05vDYGpet4XNdJ5NZY8YYXgn0BV85WRSvA5vWcWzNBBTkZmXt6+i5BFNETrrOr4GW2X6Faj82DIPDlDve3HGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=irE1EX78; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="irE1EX78"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4YFPhM332tz1DDr5;
	Sat, 21 Dec 2024 01:06:11 +0100 (CET)
Received: from [10.10.15.30] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4YFPhM1M8vz1DDhF;
	Sat, 21 Dec 2024 01:06:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1734739571;
	bh=985j3Kwlxgw4BrNrLXrOSKWdETLQ3ux9AluVWWb3qrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=irE1EX78Of640nfWeg7uBCnhOqEcZT/D84dHL27QySYeqT0UiqjB7DqIHlvdlPpDD
	 LJgVbk7jzecCLsRykEgcG3HIzind8OppIUmFUJgE/21N/MKGDf7zpKJD+lne2nEHfa
	 cayMZ7ZrYjgCja7KJwXkt87aFGe6TnhSVvD3Vn/s=
Message-ID: <9025e31d-eeef-462b-85c4-ead42d37f4ae@gaisler.com>
Date: Sat, 21 Dec 2024 01:06:10 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] spinlock recursion when enabling function tracer on 32-bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, Andreas Larsson <andreas@gaisler.com>
References: <86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com>
 <20241218110115.29d4cc77@gandalf.local.home>
 <bb8485bf-d720-4803-aa3c-037ea1169f8a@gaisler.com>
 <20241218163526.2569917f@gandalf.local.home>
 <2d634c54-d8d9-4f33-bfda-9236b6a2ea06@gaisler.com>
 <20241220100558.10b48f0f@gandalf.local.home>
Content-Language: en-US
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
In-Reply-To: <20241220100558.10b48f0f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-12-20 16:05, Steven Rostedt wrote:
> On Fri, 20 Dec 2024 14:55:27 +0100
> Ludwig Rydberg <ludwig.rydberg@gaisler.com> wrote:
> 
>> On 2024-12-18 22:35, Steven Rostedt wrote:
>>
>>>
>>> Can you test this patch?
>>>   
Sure!

I've tested it and it works. But I had to modify the entry code for sparc32
to include nmi_{enter|exit} handling similar to irqentry_nmi_{enter|exit},
otherwise "in_nmi()" always returned false.

// Ludwig
