Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E91B2459E1;
	Thu,  2 Jul 2026 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783025628; cv=none; b=Wd3VIJYLcHnVkI3oD0giZXyYFCnyMBjoHR9XSNRLmugVRC1htRkv5kqZGbTcYqlyUB9p0YjqbR1KPDnJSmEJnqvjLyeO3NfP6io+V0vJoX8nMWtImYkttsk3FvapfnkkXCE+ACgsLxV718Nqx72QkJJticjFzBCgnjFePFs2R4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783025628; c=relaxed/simple;
	bh=AzLiymTuCL8cgzJkJ2VAikFwg8lHpxkwf8oZLVIYjTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adO5gnoPeQ6v7k+2pCZCm/aX9q1xYri0FNIcbXNr/azOzda3Z5+ujKKfDEd2QXjscN6PbPN4bq8MpG7FgouuVvQu+dv2+JPqoHzJH7N5FY0ZU9IXpEVxebYzmSddBwW0cg4H4+wdQdLA0QQwi6+E+mtY7K4vJegxiq8eeTe5J+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id DF8AF8CD97;
	Thu,  2 Jul 2026 20:53:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 2A7ED20028;
	Thu,  2 Jul 2026 20:53:43 +0000 (UTC)
Date: Thu, 2 Jul 2026 16:53:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Cleanup event_enable_trigger_parse() by using
 __free()
Message-ID: <20260702165346.035f8eef@gandalf.local.home>
In-Reply-To: <79106214-b341-46ab-8810-a206ce8fad29@web.de>
References: <20260701174829.67ab8a33@gandalf.local.home>
	<79106214-b341-46ab-8810-a206ce8fad29@web.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: hkm44hoes9z34w9a34ihtcm8y5shx8hq
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 2A7ED20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/v8zn8fSOJzhA9K718ZsAJw+bzhxl9Rxo=
X-HE-Tag: 1783025623-478875
X-HE-Meta: U2FsdGVkX1/Rtb8muLzSjKj9e3327T3nJYDC33bMHpv08m9lRV6zlqbg9Md5l0gzEiTl5uhQBxHg3L1tUsRlfYaqoHS1YY+fL11wRD/vZwX58O0xP+mYbhqG54YR4FUAHyGfEipNjsNdo7Yv5FrNnRn1bSwjbakPiS/7in4Fh+mnR8ulhIE45SSr30LA/jvF5aIYd6Dx/x9y3JKHGXtAt10j9HIbBY6fz1Rj4rrEbHAXazezeikLLq+jXA5/+9goh9Gz9EY89mFnF/DM/Q3Z7PxJVDSANqcsukvJ4jzQho6RpWAlTWmcxgFT7CM/YMQ3

On Thu, 2 Jul 2026 11:58:02 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> =E2=80=A6
> > +++ b/kernel/trace/trace_events_trigger.c
> > @@ -1739,7 +1739,7 @@ int event_enable_trigger_parse(struct event_comma=
nd *cmd_ops,
> >  			       char *glob, char *cmd, char *param_and_filter)
> >  {
> >  	struct trace_event_file *event_enable_file;
> > -	struct enable_trigger_data *enable_data;
> > +	struct enable_trigger_data *enable_data __free(kfree) =3D NULL; =20
> =E2=80=A6
>=20
> How do you think about to reduce the scope for this local variable?
>

No, it's fine as is.

-- Steve
