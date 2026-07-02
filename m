Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9220F4189A8;
	Thu,  2 Jul 2026 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986298; cv=none; b=aQcebSkiDP9D7FoXm82bmhht2jS6mDit0otOzlHYcsnoSQb2ceJaQo1cAOLmkxe/1UChgrTudoUf7fPdr2jEZ1NBF19bFcg/GIQWKRhxfjgsiXijG3oh/yXrzgWNPiPQ9Nd5U7HyZhy85X6+x2yLkQThRI1IkeEJxJQSTD3jDyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986298; c=relaxed/simple;
	bh=n8kaI+Yek2ozXCJb6E06IbanuWvH2maFb5FGyjealQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhnRphfp2GXpftctiobEXQ5iS7C3mD8W8+OEJBgqjdFtQbA7YNQwpDjn9xSTVA9mBWlDefvEosDiIw3hcNTQu1xxYF593LsLQDicau3uFXJ1C3YOjG3j1eObNWvjAkDv2kjm4BFObg5ROE0iEMATIdTFatgKTkqXxbGucuv+ieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=w9ej2OvV; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="w9ej2OvV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782986291; x=1783591091; i=markus.elfring@web.de;
	bh=p45CPXrvsqYWHLCnltEifr5+On3u4Mfklx8v0/GEYSY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=w9ej2OvVH2Iku7ukJEIQr2FgYUGCUSYu9u5i1ppNSIhrBLsRReJYffD1cU93Szgh
	 +jzexr3+ZQ2Y6cUpzPUGIsiCV3uQyavSAK6X9qB2M93SSleH0zJTgY9mmuWOLYfQd
	 ctkxwdEQnUuvult4S2BdQzhQ0b7DT9nwiFqwtcsr/4JgiCKPFXx+2JtTmBGE3UXVC
	 1wGLpHTQSAVjYip/6atdbvchjGPcHsCB/Gk9Wb0SvxlTqknobOCP25GzuIRgpHsaw
	 orai+n9DglEsTc5HlrBsSCbrqqz3m+ITr0BVDBVmagWAi0UjU8HWqGqeohKedP3jJ
	 FQpzJojdOb1KKXO9yA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRk0k-1wY7S51ja6-00LOsx; Thu, 02
 Jul 2026 11:58:11 +0200
Message-ID: <79106214-b341-46ab-8810-a206ce8fad29@web.de>
Date: Thu, 2 Jul 2026 11:58:02 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Cleanup event_enable_trigger_parse() by using
 __free()
To: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260701174829.67ab8a33@gandalf.local.home>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260701174829.67ab8a33@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RoLeR0viGC3n14FRVP3exTsYmemLdtHNPQlQKPI5Srb0ap76sH3
 eEZjJT0WaPuTd4RjrYsWfbNLm1l2BUwvpSjduGOxckzZgJ4+bTtOFm9uexxXFR28UiMn6Xt
 FjjnQ+Np2AzeCUpv0Ci0PNgTSDXX+ftadsAUsStNSeqdN2gYSwaqYEAXumAT06sZmFFnT/H
 PUfwY2F//2YDdcwbq6+aQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m3dDtkKvTRY=;Vxt007q1Em2xlAspbTjxt0TM+72
 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

=E2=80=A6
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1739,7 +1739,7 @@ int event_enable_trigger_parse(struct event_comman=
d *cmd_ops,
>  			       char *glob, char *cmd, char *param_and_filter)
>  {
>  	struct trace_event_file *event_enable_file;
> -	struct enable_trigger_data *enable_data;
> +	struct enable_trigger_data *enable_data __free(kfree) =3D NULL;
=E2=80=A6

How do you think about to reduce the scope for this local variable?

Regards,
Markus
