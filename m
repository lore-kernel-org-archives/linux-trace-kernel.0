Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB8A3BD22F;
	Tue, 28 Apr 2026 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360616; cv=none; b=TaKzxA1qSMGfPtIPgmzqGTkRloG2T/YiNDxH0uhJ+EXXxqyVp9jVGmJoyXoGdkmDisVzcnjGkiLjRdszDh68eC1huiw4wwNJ3eDtph7RsYIoStmHBzr45bT873iq0Q57QkpROIERbhHqB6DmFv/QDLEPITfi2qYmrmO6ozpmM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360616; c=relaxed/simple;
	bh=dbrUFbqJ78b2jcWIF0af1PiDl7uQgyKVtVnPGQD4pwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwP/Zv0ECLaLgEwsys6fqW2y8JeNcR01fvM3NuvKfXcnqZyJzNz8YeBC10fFgVgaiNd/CvIoXHqNyS/ZCNNhKHSjLfx7MFovh54ewcviZtnTeccczYbxLk2KrRfM+cch7EPGM1p889oQwhcEKTDzvIuRikD3Ini4V+jub9i92Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J9BNO9sD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J9BNO9sD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=lQWQrrV7LpwR+/cOPe5HTNIVTtQ7JeeBsdba0Hiaywo=; b=J9BNO9sDHBu1jD7ZMf060MuCGF
	cXdFW0rK83ItmOdyNf+AvK6bF3jK1dHIJIw1Ag3Kj8TLKKUfsBAxW49YOrzhrQoEILtLNZ+tvAY7W
	IrEx5a+g9i7oDTVdUtwStiJyjblsMJ4JUFaELcrdrTn5INHGDWpSMLLPfPQQag95TXLTxZ6hlQDeq
	RvKjTjLQCzth5bV+i9TEL/7rm2oXgDLWOQidsgAG2FGtAy9/I/gWM0W3QE6SaLlfz+EWdFg1ArQ3l
	L4H0Vq0EEM7ISxdcN9rp48091QZNcZIL4NHcilHr5yGSNXxnjUXNWViY+IzCDQmv+pLZoi8iH6zZ4
	ScF0pTAw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHcgd-00000000g4p-3lB4;
	Tue, 28 Apr 2026 07:16:51 +0000
Message-ID: <fd8f548a-b4c1-4ff0-a8e2-7d5deb0878b3@infradead.org>
Date: Tue, 28 Apr 2026 00:16:50 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation/rv: Replace stale website link
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: matteo.martelli@codethink.co.uk, skhan@linuxfoundation.org
References: <20260427131709.170505-2-gmonaco@redhat.com>
 <f841e9f6-9d0b-4e10-a930-fdd74a74b9b9@infradead.org>
 <75eeb7196b3e65b4b5d5144f87aabd8b57793ebc.camel@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <75eeb7196b3e65b4b5d5144f87aabd8b57793ebc.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/26 12:06 AM, Gabriele Monaco wrote:
> On Mon, 2026-04-27 at 09:50 -0700, Randy Dunlap wrote:
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks for the ack!
> 
>> although I don't care for the "J. Syst. Archit." abbreviation.
>> Does JSA use that? Not that I can see.
> 
> That's the citation format I got from semanticscholar.org , it's indeed
> a bit ugly but it's apparently the ISO 4 abbreviation [1].

OK then. Leave it.
Thanks.

> Not sure if it would be neater to just use JSA which looks more
> official.
> 
> Thanks,
> Gabriele
> 
> [1] - https://dblp.org/db/journals/jsa/index.html
> 

-- 
~Randy

