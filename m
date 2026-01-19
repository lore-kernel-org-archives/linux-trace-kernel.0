Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0132E3803C2;
	Mon, 19 Jan 2026 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838178; cv=none; b=ggoT9Se3gzqjv15ChE05nrTJxCLxw9I4oZP4bHss1evWfUG/oEsJtiL8cnq14nMtpCRhWprbiPDo1boZ+jeRbAVuJNBY4xr8mhiTpKcvEVyZezGPoqNQ36+12aNG7TzU2ukqVWWpseRRlg10eoHn7cgq4wvOlB+GMqw4M4MMcgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838178; c=relaxed/simple;
	bh=nDiAUd7t+jVJtsONtWrPHsunQ75TiBTnZVNfkIyHNXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaPvTV860VM/wsy82TYj/Ch1RO0TW9/vJA9RTkDlSxAU2yg3Mm/fbcBQAh42lGutWrEYc1pUJfUCuEFqSvjo0orAna0Ip7QvCgqk9AWz4KA99kP7jcTe5ZZuqM/sci+7QWCat36alNlh+BFgrzw7M5tPzGfr9UjazoirRUyDrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IOHqH5EQ; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IOHqH5EQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768838166; x=1769442966; i=markus.elfring@web.de;
	bh=NOE7KB+Fw73DI25/czfEIYqChpCw4xwJsi/vOSqGBGc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IOHqH5EQJFxWrjBZCSgjOea6wxFEmIN1NerYXaStxwHlLtcHJQoHhHlrFjgWO/Ax
	 AvtneA4/gnMu3xVEs7m3thdUGmpVW4JhX/VCNcTq4ivcJbKy0qF6pHJiUo39SxLK5
	 dcarxm1NaIhWloZK/NevCZV6zDdwLUF7OKa1xi28zX/xOsuBQ4cL8iZuYwEDiVb63
	 N5w9/hM2ITa7EywhpJYKu+0sW4koo8efBJ15/rN/8DXcovqmAlKsLTX9XXJJeYoN5
	 0J/wKxQypJthFM/hC115BMHdU/YtP4k+3KQQeL8cL1V1kj7exnPeIomc2b8SgLVax
	 cuSbKUO4y8CD+8AePQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.178]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPZj-1vUr3v1vEH-00UVA3; Mon, 19
 Jan 2026 16:56:06 +0100
Message-ID: <a2aa3091-4a93-48be-970a-8bc506fb0cd3@web.de>
Date: Mon, 19 Jan 2026 16:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu: Fix NULL pointer deref when io_page_fault tracepoint fires
To: Daniel Thompson <daniel@riscstar.com>,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <20260116-iommu-io_page_fault_null_fix-v1-1-6c20c2e62987@riscstar.com>
 <fca8f2cd-c3e5-40b0-a793-bded109e37bc@web.de> <aW5CIA1aCC8FVyFl@aspen.lan>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aW5CIA1aCC8FVyFl@aspen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y61srb9u+nV37cdp/UCvCkBtS20CsXLOeeztrx63OoVYO5VjDmI
 Dl6SnzHDEiBiw7qL3xdgpH+gAtyUU6ZheYoD/PyLO2qsIph4Fskkpy/hrM7EG2F3iqhV+jh
 rtclaVOpv7WOLgm90sPVeVklrnd4VgEOyuNYngHU3q0as8clgQBJ+ADNr/BzHA9BPnJ+6eW
 iz7tC5WCuoCuLLxPrNJxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ETxlV5+rwKM=;wr+POEz0Dfp8oDaeETSuL6iaqhe
 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
 amtUV4gzol2gObo23QzE59DpO3OEo

>> =E2=80=A6
>>> Fix this by adding logic to the tracepoint to safely propagate NULL.
>>
>> * How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D =
and =E2=80=9CCc=E2=80=9D) accordingly?
>=20
> I could add a
>=20
> Fixes: f8f934c180f6 ("iommu/arm-smmu: Add support for driver IOMMU fault=
 handlers")
>=20
> However, who do you think I neglected to Cc:?

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n262
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv6.19-rc5#n34


>> * Would a summary phrase like =E2=80=9CPrevent null pointer dereference=
 for a tracepoint=E2=80=9D
>>   be a bit nicer?
>=20
> I don't understand what is wrong with the original phrasing. Can you
> explain why this change matters to you?

* Questionable abbreviation =E2=80=9Cderef=E2=80=9D

* when clause


Regards,
Markus
