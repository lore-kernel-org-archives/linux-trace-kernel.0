Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F01E7A4D;
	Wed,  7 Aug 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037328; cv=none; b=ZPYIPtCDYsQw5Ay4ilqGr5LZpeGqa7uzFX1ZyFZXVjsPwedfFUgbKYpivd/4davKFLFGb35PVWhQMfkMa+jaIctWgsYxypYdeAH3DXwpy3jJnBo/BgX/oByeDEwKZ+zMX6d3d7uVvc4DMagoJxKorTEY3aWGOf9TcwI1SWOwdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037328; c=relaxed/simple;
	bh=quUyFQ2V7pqEMz1oIqvvgqIOrE37FB49Q5wPzg898gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGQtIJaAl1LdqIf36GmRLWsuRQJRgJvSSHFNOUrygJhHlHXhVj4lI4z7dszR0pVUApsI71ak4/aVBFvFf0g7L/796UQ1f2KbET7x37rthl3YIgjienv0tcIIy/RaG3shexssZfazmZqb5qfPUNpB2S9CGhJr8oDbryrl9Rlj2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66897C32782;
	Wed,  7 Aug 2024 13:28:46 +0000 (UTC)
Date: Wed, 7 Aug 2024 09:29:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Tze-nan Wu (=?UTF-8?B?5ZCz5r6k5Y2X?=)" <Tze-nan.Wu@mediatek.com>
Cc: "zanussi@kernel.org" <zanussi@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "Cheng-Jui Wang (=?UTF-8?B?546L5q2j552/?=)" <Cheng-Jui.Wang@mediatek.com>,
 wsd_upstream <wsd_upstream@mediatek.com>, "Bobule Chang (=?UTF-8?B?5by1?=
 =?UTF-8?B?5byY576p?=)" <bobule.chang@mediatek.com>, "mhiramat@kernel.org"
 <mhiramat@kernel.org>, "eric-yc.wu@mediatek.com" <eric-yc.wu@mediatek.com>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH RESEND] tracing: Fix overflow in get_free_elt()
Message-ID: <20240807092936.1661ce6a@gandalf.local.home>
In-Reply-To: <52e8ccc5dd82668c17877c97fb96f255dc2e7052.camel@mediatek.com>
References: <20240805055922.6277-1-Tze-nan.Wu@mediatek.com>
	<20240806154008.502b6c7d@gandalf.local.home>
	<52e8ccc5dd82668c17877c97fb96f255dc2e7052.camel@mediatek.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Aug 2024 11:34:43 +0000
Tze-nan Wu (=E5=90=B3=E6=BE=A4=E5=8D=97) <Tze-nan.Wu@mediatek.com> wrote:

> > > -idx =3D atomic_inc_return(&map->next_elt);
> > > +idx =3D atomic_fetch_add_unless(&map->next_elt, 1, map->max_elts); =
=20
> >=20
> > I guess we need to add (with a comment):
> >=20
> > idx--;
> >  =20
> Thanks for reviewing this!
>=20
> By reference to "/include/linux/atomic/atomic-instrumented.h",
> `atomic_fetch_add_unless` will return the original value before the
> adding happens on operands.

Ah, right. I haven't used that before and was thinking this was the same as
the inc_return().

-- Steve
