Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423623ED6A;
	Tue, 25 Nov 2025 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101066; cv=none; b=MjVMXxWnCSpsstcphxjzOd8JotK1KPFwQVju+zt1MuBHqZuTTirxcuBgAydT9bmD16nyy6h0+E0wAUJlR4JDMWNkBOw9PTSqZA5VH0nq0dGdGdsvsYUkuisK4ESdQaA73YP3Jen9N5CSxjnyagPmdhrAV8MGK2tn30ZP8XuDWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101066; c=relaxed/simple;
	bh=BJzops8WfEhbkyZ9TkZA475LPq0hTkLiNwXZkrfv66c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cj8oxiM6Xiig9s1G2Gxq9Z6We69oaqxzHyUQ3UsIC95uIhF/fasDG1xSGIEfrfKPDfwJgSAv5wYBkuXy+XPZWmI4C0fjfPovkiHMdj2bDJQhx53l1JFe5nso+y3ke507ERbULyuZ4MlrU/LywZk+LwdK9LMND9d7rE5bjit86Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 61D304FC15;
	Tue, 25 Nov 2025 20:04:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 1B8126000A;
	Tue, 25 Nov 2025 20:04:20 +0000 (UTC)
Date: Tue, 25 Nov 2025 15:05:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <zanussi@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] tracing: Merge struct event_trigger_ops into struct
 event_command
Message-ID: <20251125150504.407ebbc2@gandalf.local.home>
In-Reply-To: <cfa03e4c70ff706b5373bf5314f453930019e1a1.camel@kernel.org>
References: <20251119031042.328864818@kernel.org>
	<20251119031603.658997916@kernel.org>
	<cfa03e4c70ff706b5373bf5314f453930019e1a1.camel@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 5ooq41n1bzyxrcmw3wykmzprzk4h3cog
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 1B8126000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX183oBoMH612NXBNWwrCqP9zWZfq5AAAO+c=
X-HE-Tag: 1764101060-311374
X-HE-Meta: U2FsdGVkX1/6i8Q5S6sGzMikyfZC8GnL/mk6yBupBlhJ5lPRUKmPFqR4oqaz3zepn0k9EPZOHwF7jOHOIPwjKIiuCBJZT9oZLpVSvnNFH7H+k9HSpHnoeg6Wpqewgv8DfUnFWvd996kgzPTAQf0PxWEVTaagYzeW3BoGoZncH+YEMGev1dLlolB69lQODU/w1VNnELT1bhflEyE2+BYJHpePObmxr6gnqP+ttmXlChlHkMYMW+uZifpOSs2n2ImUWF/TMPrCS0+yeV4DMjJQ2GAiG0J3aaOULsAMkkS5ghKaRDkfV/PRr/NkG05gyNzxpQFUipFlgZ2a9Z4CZ+pMMDi19/9hEcXR

On Tue, 25 Nov 2025 07:01:43 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> > -static const struct event_trigger_ops event_hist_trigger_ops =3D {
> > -	.trigger		=3D event_hist_trigger,
> > -	.print			=3D event_hist_trigger_print,
> > -	.init			=3D event_hist_trigger_init,
> > -	.free			=3D event_hist_trigger_free,
> > -};
> > +static struct event_command trigger_hist_cmd;
> > =C2=A0 =20
>=20
> I don't think this is needed, since the same declaration already
> appears just above the event_hist_trigger_parse() declaration.

No it doesn't. Nice catch. I'll send a v2.

Thanks for the review.

-- Steve
