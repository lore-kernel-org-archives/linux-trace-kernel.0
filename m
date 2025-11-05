Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F41C84BB;
	Wed,  5 Nov 2025 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366785; cv=none; b=KmDLB/b6IqW3ePiKR4euB86NFtLYSujr3LuwLrRh6EQ1gUt5RB1vgv5uyUl2/qHVJg84wch/d4FKFQCG9813f968in4pRB7gswicLv+tFaY10Ckto/NGlH6Z3wmglXuO/9yKNZ+SMMx7D81SpTFAe2b3XrJQaKQlBahLgvrqjXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366785; c=relaxed/simple;
	bh=IkLKwU/YV+5gjEM7bAH2y8c6Z77GNd23z+Ydrh6r/pA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CLdahEDf5megMDD6r6cqm6eHALNP47GHDjin7XplecAYyIkDwY766DxpCZZC1iSCoyymFh7pGal1H9iJ3cib/V+nurcHwvySV/BSrIueWgKiGQkeql4rBBVc58S2ZIyAsMWiWuIEs5nLuNTjSiEawi8BgZNpGn1/PhPXw0OIpeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DbchI3qT; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DbchI3qT"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 812AF40AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762366783; bh=zXAqjAPKip0SeqM54VLiYEodzs2TXgAJHcY2JAcv7uU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DbchI3qTVsT3dMrcWs09agmeZ5FAOD8sOhKkG4O0GGHsc1IrlXOZ6F7BrzNn2Ha/G
	 CSYDa7NqDVKv3VQ/lpPYnSDlADpcrkXLtecDEBRebLQGzrr5A6iOjkzFal3x27SeaL
	 1tRgUoeRvcogG5CSpgZRGYljqjkTzVs/+1FBnRWm36wb/cFJKrXLpoU6uiBWV2yPHx
	 zcNPzDs0DzG/jQFT09TPDIJ1WTJk7Idf2RJ1oJ9VwUVSb4UqPa2iicXN+DiVBYBayZ
	 6WSRPE4/+/ZtuxwzMKeTEoLFYhExLyzDlV+QCQsDb06un4dtD3KisZ7FkCCT4t6fYT
	 TtB5uJJ5lF9tg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 812AF40AFB;
	Wed,  5 Nov 2025 18:19:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>, Attila Fazekas <afazekas@redhat.com>
Subject: Re: [PATCH 0/9] Documentation/rtla: Cover default options
In-Reply-To: <20251103192201.4a93be06@gandalf.local.home>
References: <20251010083338.478961-1-tglozar@redhat.com>
 <87fraubsfv.fsf@trenco.lwn.net>
 <20251103192201.4a93be06@gandalf.local.home>
Date: Wed, 05 Nov 2025 11:19:42 -0700
Message-ID: <87jz04735t.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> On Mon, 03 Nov 2025 16:35:32 -0700
> Jonathan Corbet <corbet@lwn.net> wrote:
>
>> Tomas Glozar <tglozar@redhat.com> writes:
>> 
>> > RTLA has many options that have a default value that is used when
>> > the option is not set associated with them. Those are not covered in
>> > the documentation for the options, which creates confusion among users.
>> >
>> > Document the default behavior for all relevant options: -H, -P, -C,
>> > --trace-buffer-size. Some of these are covered in general
>> > descriptions, only missing from the option documentation.
>> >
>> > Also, fix a few typos and incorrect naming of tracers.  
>> 
>> So I see that this series is still unapplied...should I take it through
>> docs?
>
> Yes please!
>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

OK, I have done that.

Thanks,

jon
