Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE61D2704;
	Thu, 10 Oct 2024 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591946; cv=none; b=prmxJ+1fWKH1z6upNA+hTf+oF0fcPyywbbBI17fc5w8JCn5lhbaCdon2Pk2/XSQJMnkfy8h/Y2OlGxIN47T6XVC9tR9oRhHV2yKyyrjxG7pGup6UpaIVS2JPjOO/jqv/+Za6qK7Gwrzjhq+d6RAy3swxBp7bplGE8JQ8HMA7+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591946; c=relaxed/simple;
	bh=jhWZoHyqO1ynbd0iu+NwGD8cjo9qPN77PJuyz8FEatw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJW+YGayolxrdeuqCG3h/kHdRe5Q805r3SXHvxc1MDDT8UbtBQbcVo1WPa2RfHK0Puj1Ae9oMIu2Yxhbc4OK0W1bemQz09zjV0YQmRre6/rNYF/HdnVREvh3KEDJkVc7OOb/F4ap6LCQPHkUiV3akzSJOQVjmEhQ0hGerhggM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=jV7UFb6h; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="jV7UFb6h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728591915; x=1729196715; i=deller@gmx.de;
	bh=SaZxQTfGg/O+d8km0ZGRXVXP/sl/4eIYz2XGhnSncI4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jV7UFb6h82pz0gUPhuDJJYSLhi0kU/Kyxqzf8BPsepISHzPTf8pLNYvgdiPtXptQ
	 4j9Q2ApuA3+5wpO4sOK8Imc9SMkBJr2R0De9HHkfOl9q1XPT3j9n75TwBnTvr9OKm
	 n3Nz/MOMO+sWCGzQ/yhyZx005l8ghzNLdjtUxSRECbQD+N6F7U8poOgNr6R9lej7y
	 DEa77KZkBh1NIxJM0N/0vI20xHMJBntoR9i5zx17EdS4eAh46dYcf4+0NZu1UazMc
	 4lfLA4/VniOaMdtyPsV4vcvyZwW53ICmOrgswxZrtqsAGhlPdB8dlJnZNLDSnAJix
	 FkEWDsU0f9UVHLwy9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf0U-1theC92Btq-00mgK6; Thu, 10
 Oct 2024 22:25:15 +0200
Message-ID: <f2dd3a74-cd3d-4277-904d-223a8b393d56@gmx.de>
Date: Thu, 10 Oct 2024 22:25:13 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc/ftrace: Fix function graph tracing disablement
To: Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-kernel@vger.kernel.org, Sven Schnelle <svens@stackframe.org>,
 linux-trace-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <5962b9e161b2b9296509c3d65c7f16c11b07bd16.1727904678.git.jpoimboe@kernel.org>
 <20241010154840.6e158c78@gandalf.local.home>
 <20241010195610.25mraxgovi4vowo2@treble>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241010195610.25mraxgovi4vowo2@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QkDRj+CNt1tTMbT5jVET1B7RuwVQvedD5ATsPf2paJ0gyCHsabs
 0HRXlx0IxhYwkSsaybKCqZEPZ+J1cYXbTG8AMvV1KQ9QmBDe+yzWXR0DmeS4xqXP4+IiUFz
 ipsQXSRJCjRPzdgLPjPErWe8zHOam8ySpAkRwFOcEbPxBNOxrLXHwlxw4Sh9MzxJ34rR9rj
 c/NXj1pUPgx9JAXG1wVfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bL0hCiNPB0w=;UUZxfqZtw2hZdqQCm2ayaRyAFHM
 j9nUI1g0F0jD2NikMvQwShOYvo8Mk9pTxdEfIuoltA/c3Vhp83bR2YbMK1C0ybn9+3PfZtayI
 rWKbye3hB6FxWjawSWZhh7IzXkttXkYyoyuSwJFlspbEXT/FktkhxDiDIVJm7CI6ka+exW0EZ
 Gdb4e3eplAptFZ/nTNLrGQzLppXwAcYyvAPXGSJwhpLUgKWVm8aeCsIxzdpIzZUIj5aud1rDz
 j894A/oTCsiAlyRRT43Rsc3UI4quk2uzALrNWPqXNCcObTxnK6SAafVWi2wzeyoFJFbn85n56
 1WxMkB3ReM2s81I9cSwudMOAWdVGE7em/MqOi7GvPmTA7eA1tI5y0mddHvHJnKArL65P9g4p/
 5yt3zCcU2xNlCcFnOcxTcxrgPcRwJI60MnJg4+76jm8R75hq4Myhrmr6oiSRv/I3s/oCcFoiV
 UlQ9AhGHV9bFQZ2pUJLfWQ3r8u30IgD6k8u8JqHgGTB6GU03JZKK/rT25fso36NtEXJUMia5Q
 8B7Rs+90seUqVjmogePTocVeFw1527NNFdPLOpmlUozJ+aF5LI+AlgdZwD6txg45PlS+9CzlU
 8wrqeHaysb/jL5FTSEY2ZJIqttaIma/pX/acMg+BIMrN8XHxkeMi7Bm/Rx5wulkBtwRpUFo0c
 9gsZdcunBNi3QCkjdBlQcWMcneOcsVZFMaL1ujSqYMjUEhVrkYFXgC3kTou75+OObJEZGp0wi
 yGBlZwicw0ULISuPMtSdQ32z4PW4LzGIy9fOY8VJhlLhdW1j4F2is6r4j6H/E5AI9sVmuEp8H
 dFkK9jubKI/iE/G8WQA8NYyw==

On 10/10/24 21:56, Josh Poimboeuf wrote:
> On Thu, Oct 10, 2024 at 03:48:40PM -0400, Steven Rostedt wrote:
>>> +++ b/arch/parisc/kernel/ftrace.c
>>> @@ -87,7 +87,7 @@ int ftrace_enable_ftrace_graph_caller(void)
>>>
>>>   int ftrace_disable_ftrace_graph_caller(void)
>>>   {
>>> -	static_key_enable(&ftrace_graph_enable.key);
>>> +	static_key_disable(&ftrace_graph_enable.key);
>>>   	return 0;
>>>   }
>>>   #endif
>>
>> Awfully quite :-/
>>
>> I wonder if anyone cares about parisc today?

Actually I do, and yes we have users.
Of course in reality that's "fun" users and not "productive" usage.

 From programming perspective parisc is quite interesting since it
has an upwards-growing stack, limited ways of atomic ops,
and some awkward cache dependencies, so I regularly find
issues in generic Linux code which would not be found otherwise.

> I still see some git activity in arch/parisc, so apparently so...
>
> I only stumbled on this by accident (code inspection) while making
> another unrelated change.

Thanks for your patch!
I'll apply it in my for-next git tree and push upstream at some point
(unless someone else takes it before me).

Helge
