Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D119E7D1;
	Mon, 14 Apr 2025 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649025; cv=none; b=DB6C9B2iNGdjKgW6zkxvLirFPHvHeiSgcWQ27ToNprA2UyVyl4JWY3upSE/4a3hiKQS476bbYIBrpdbofbfACeG1miGqwScvKDwg25ZyrYvlI9BKrlpkeNxPIVlWydPg27fNbHSVNfbNVnVSyUK2dL29K++a/YRQOl+7IDegVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649025; c=relaxed/simple;
	bh=KxxTRQvhi/RrYmBBNQvUvpDVhSTo0r519iwnZOAnOBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EmqHgHYmX6AHwGOTOIXj7Otp+ySwOstg9/RrvSXTkonoqlwJhqxFCdb2yq85+2G9PKy/w6MqRjXlu6lng3KTW5fJHXgkr7dfdb2cI7ZWqMZG4h3PD4NqrzppXDLTVaJyS/1xXXhAUr5ia3Huojr5FoyntjZyqZV18OlMEOhqm3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Fo5jByiX; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Fo5jByiX"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B48EE41062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1744649023; bh=JIpqUtp2wgA/iOr50DF4TcybqAo5OmZE8zsMRi/mujs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Fo5jByiXglCDNdr9P0NrRuqMRM4pwQNLHBZL36wXAmdCF/I1ce4Bk91U9J2lm2zHN
	 iteO4nB0tE1jy7m4k1o1TkfUgnaedllfKWmheMMJTvy9UqEAm34yOiPNh6TExEXsqh
	 /NIkHCw8L1pFynT+AEVKG9aMXHn0ckkAGFXsZ8XxSsSRfVFnfgi0yaAoli+ng4Nni+
	 06iUmanClzktVfAmfAAiEtFfosUhUBgbNun8MAygtoQPa9ao5g37LlMwmDF2Eui2X5
	 RsbHcekDSbL4GqVUAMYSPUkQAX9uRgbnC1fKW1FsGtjjjac7PTpJ2vAkEFThyZ6Fao
	 ojqxQZjQ+3eLw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B48EE41062;
	Mon, 14 Apr 2025 16:43:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, "Luis Claudio R. Goncalves"
 <lgoncalv@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, John Kacur
 <jkacur@redhat.com>
Subject: Re: [PATCH 4/4] Documentation/rtla: Include BPF sample collection
In-Reply-To: <20250324195359.7e593f2f@gandalf.local.home>
References: <20250311114936.148012-1-tglozar@redhat.com>
 <20250311114936.148012-5-tglozar@redhat.com> <Z9A1oN_XdMguNgHy@uudg.org>
 <CAP4=nvRCtRwXReMt8+vxjLVqtL_pR9OyKo0HS417+93QR84mUA@mail.gmail.com>
 <87cyefe0ky.fsf@trenco.lwn.net>
 <20250324195359.7e593f2f@gandalf.local.home>
Date: Mon, 14 Apr 2025 10:43:42 -0600
Message-ID: <875xj6ae2p.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> On Mon, 17 Mar 2025 16:47:41 -0600
> Jonathan Corbet <corbet@lwn.net> wrote:
>
>> What is the intended path to get this one upstream; should I take it?
>
> Hi Jon,
>
> Yes, can you take this through your tree?
>
> You can add:
>
>  Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

...and I have finally done that ...

Thanks,

jon
