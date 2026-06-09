Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B543E9C4;
	Tue,  9 Jun 2026 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023464; cv=none; b=gFOK2yTCBPupny6pPssXqxDKY03Qk+bLOvJ5AwfY60nuoac3QoL2INw97Urv3zRSZ9dpR0Qsz06thio0NoeMZR5nbmAbGnKebXqebWwG86GkRXfN0iN6q0XpeHgUDLad4ctoD0uyvAKq6HBI7Gp534YL4KBROXmevNt0kUqaLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023464; c=relaxed/simple;
	bh=F9Abvi2UiIuvQQLP0j9iYzNXV2XAt35vbQ0CGAy66uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0E0TGh6VCIkoKFPQCqyJmdXz9tW7yRGfE6V/PG7btAedJRA45UEtSz999j//iTAnnEwaMbHk7Z1JuVG37k3rmpYjnO6y6MxmCkIq+TFt5v1gtncBmP1HTUyYpjyWVWEEamXAosi627ULfG5qZ9ZGqj8UFsoWkDAcBMriwOU3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VonzYwZD; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VonzYwZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781023455; x=1781628255; i=markus.elfring@web.de;
	bh=SzUZ5c+qrMML8bQ2W2E8bPRR1arJFxeCcuizMnm5HnA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VonzYwZDEi6GH+luvL7Wof8laXZM8a13PN0NP1HmQ0nwC/nUT0iedUnCEMbE1UAI
	 TnHQNZ68gLu92Mf6UDrPf970OB/V6SDXIBpannzcek3UYAfdP8KmYZ8vx16rcMTB5
	 fmZZV7q9RJUtJSQJ3FH61LwIAxVCqzaaXNggf6EqWdVRgKpULnIAjIyqAUkad3S+Z
	 ga27nZ4M1eYgQzX+bxjwnzyEXdRI2hXYn7ircrbne1XhaK086hMO3uDUbGjGjvGa8
	 UUFYzjRQtuyREZEoK2a1z1iwP068h+Z2IexwfSUeN95I+/VYpwA3lYXb7/7gzLgcg
	 F1igo9eyTAV+AAYwXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCHy-1x48Ry4AMi-00kuHk; Tue, 09
 Jun 2026 18:44:15 +0200
Message-ID: <6762145e-3e51-43b8-8bca-a9dd200b54e2@web.de>
Date: Tue, 9 Jun 2026 18:44:04 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tracing/user_events: Simplify data output in
 user_seq_show()
To: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <596c2f16-a12c-4e24-8a8c-1243dce354ec@web.de>
 <b95f18bb-6603-4c22-b224-0226a49d26b3@web.de>
 <20260609121348.303ca675@fedora>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260609121348.303ca675@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VHW+58kBCQFRO3AIuReU+ykQirlXBHOVt8It8ClNVr4wC3G4YOR
 o5t659nglRhysL6lJFQFgl8pwR4thlim9bwchmrlbvu0yziblh1KQLYenOXqogG8nmIPri5
 37RpDv6+BIHZ1fS71rmnAMmC5X3Lqjb5utIymDGWeTfc9cFnPk3QE3b9IAavFS4U7azAGRO
 HT0do4reHop5KdjCnCNrw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:saglB5L51qo=;AMpyalRZorOVXVq/zH1cspDXUKI
 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
 h8DF5GBAdAjTZpbuo0=

>> @@ -2800,8 +2800,7 @@ static int user_seq_show(struct seq_file *m, void=
 *p)
>> =20
>>  	mutex_unlock(&group->reg_mutex);
>> =20
>> -	seq_puts(m, "\n");
>> -	seq_printf(m, "Active: %d\n", active);
>> +	seq_printf(m, "\nActive: %d\n", active);
>>  	seq_printf(m, "Busy: %d\n", busy);
>=20
> This isn't a critical section and I find the original way easier to read=
.

Would you prefer to use a seq_putc() call instead at such a source code pl=
ace?
https://elixir.bootlin.com/linux/v7.1-rc7/source/kernel/trace/trace_events=
_user.c#L2803


> But the other two patches are fine.
Thanks for another bit of positive feedback.

Regards,
Markus
