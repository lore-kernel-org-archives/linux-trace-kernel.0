Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BA53A3807;
	Sat, 30 May 2026 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780138008; cv=none; b=mAWLZ/uXgxiDkz1ycQWQXxPCqkc39AJ+pJNS6z/UeKQgM/PDLyFAl5GoxSb4FJJjo8ofgglbbye8xO9HoctTYJAulF7qwvgrfurc732FFvos9vQlx0IsXvOgIPoqq5qpaIukJver4Fiz3xLepQ8cLcMK6RYUJtX38HgNF69VIZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780138008; c=relaxed/simple;
	bh=ToyTRiNs/K8aXzFq2SeM+FksqWokwudyCREIlfvJtzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=NgrWZ/GdPPunzDyqVQClhxhUgowOM/c3XwToXrj3rt5ZBsq20D2UZtGidZJRAJ18I3teJUsyn6OrjATu1hnqKezA9SFzMm8LVcdzFg+xZGacSSnQnxcGZgWjX0u0dkXO2/RRcj/iuMdFRtyxbKCiM3bEV0js54GwjsOft9zdZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UH3AI7yd; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UH3AI7yd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CjY52TRu8FG2fSgNnSGmQZjImbm00Cohjr6YBPdTj7g=;
	b=UH3AI7ydItaFgIv7K70bJiQObiozuwmj7bOA/ryhiBTIGjP5C8B9q9+uyGgHQ4eoEHlhauRBa
	nFYTaS7eyXU0TudnWAj371NzXFHeTV5qUprPQzKyLWZWFonwb17+3ICuuxFjfyfEGWeA4sgj0AZ
	ieVrSItmLctzJko5xRklzjk=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gSGsv4kxtzcb0c;
	Sat, 30 May 2026 18:38:43 +0800 (CST)
Received: from dggpemf200008.china.huawei.com (unknown [7.185.36.39])
	by mail.maildlp.com (Postfix) with ESMTPS id D5BD440561;
	Sat, 30 May 2026 18:46:35 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (7.185.36.138) by
 dggpemf200008.china.huawei.com (7.185.36.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 30 May 2026 18:46:35 +0800
Received: from dggpemf100008.china.huawei.com ([7.185.36.138]) by
 dggpemf100008.china.huawei.com ([7.185.36.138]) with mapi id 15.02.1544.011;
 Sat, 30 May 2026 18:46:35 +0800
From: "chenjun (AM)" <chenjun102@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] trace: Introduce a new filter_pred "caller"
Thread-Topic: [RFC PATCH] trace: Introduce a new filter_pred "caller"
Thread-Index: AQHc3uav6LjaLik4q02qQ72BQ6h7Tg==
Date: Sat, 30 May 2026 10:46:35 +0000
Message-ID: <b72c8c6ce638449ea9e99e892a25dc86@huawei.com>
References: <20260508122623.74290-1-chenjun102@huawei.com>
 <20260512084750.c17a93d0ccdacddfd52d3d40@kernel.org>
 <20260513124017.770e3098@gandalf.local.home>
 <20260514131901.8c94136f6fede18c608c8a55@kernel.org>
 <20260529103811.37b0e357@fedora>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=1B$B:_=1B(B 2026/5/29 22:38, Steven Rostedt =1B$B<LF;=1B(B:=0A=
> =0A=
> Hi Chen,=0A=
> =0A=
> Do you plan on sending updates to address the comments that Masami and=0A=
> I have made?=0A=
> =0A=
> -- Steve=0A=
=0A=
Hi=1B$B!$=1B(B=0A=
=0A=
Sorry, I've been busy with other things lately. I'll release the patch =0A=
v2 next week.=0A=
=0A=
One thing I'd like to confirm is whether to use `called_within` as the =0A=
filter name.=0A=
=0A=
Thanks=0A=
-- Chen Jun=0A=
=0A=
> =0A=
> =0A=
> On Thu, 14 May 2026 13:19:01 +0900=0A=
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:=0A=
> =0A=
>> On Wed, 13 May 2026 12:40:17 -0400=0A=
>> Steven Rostedt <rostedt@goodmis.org> wrote:=0A=
>>=0A=
>>> On Tue, 12 May 2026 08:47:50 +0900=0A=
>>> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:=0A=
>>>    =0A=
>>>> On Fri, 8 May 2026 20:26:23 +0800=0A=
>>>> Chen Jun <chenjun102@huawei.com> wrote:=0A=
>>>>    =0A=
>>>>> Low-level functions have many call paths, and sometimes=0A=
>>>>> we only care about the calls on a specific call path.=0A=
>>>>> Add a new filter to filter based on the call stack.=0A=
>>>>>=0A=
>>>>> Usage:=0A=
>>>>> 1. echo 'caller=3D=3D"$function_name"' > events/../filter=0A=
>>>>=0A=
>>>> Thanks for interesting idea :)=0A=
>>>>=0A=
>>>> BTW, we already have "stacktrace". Since this actually checks=0A=
>>>> stacktrace, not caller, so I think we should reuse it.=0A=
>>>> Also, I think OP_GLOB is more suitable for this case.=0A=
>>>> (and more useful)=0A=
>>>=0A=
>>> Actually, it's not a stack trace, it's a function that is called from o=
ther=0A=
>>> functions. But since "caller" sounds like a direct called function (sta=
ck=0A=
>>> trace of the first instance), I think perhaps it should be "called_with=
in" or=0A=
>>> something similar. :-/=0A=
>>=0A=
>> Yeah, what about "callers"?=0A=
>>=0A=
>>>=0A=
>>> Also, OP_GLOB can't work because it only works for a single function. A=
t=0A=
>>> the time of parsing, it finds the function (and should probably error o=
ut=0A=
>>> if there's more than one function with a given name). It then records t=
he=0A=
>>> start and end address of the function so it only needs to find if one o=
f=0A=
>>> the entries in the stack trace is between the start and end of the func=
tion.=0A=
>>=0A=
>> Ah, OK. It is just comparing address, not name.=0A=
>>=0A=
>>>=0A=
>>> I don't think this is possible with GLOB. We don't want to do a search =
of=0A=
>>> the functions when the event is triggered.=0A=
>>=0A=
>> Agreed.=0A=
>>=0A=
>> Thanks,=0A=
>>=0A=
>>>=0A=
>>> -- Steve=0A=
>>=0A=
>>=0A=
> =0A=
> =0A=
> =0A=
=0A=
