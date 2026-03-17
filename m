Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0228D343D8F;
	Tue, 17 Mar 2026 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760212; cv=none; b=M94m3+hmczbR9VqXAVlEEKvmcSHobr+I+eVi4ZoGic/Ni9dvWvm1A8MviM0h087FOQqhG0IpthVvt/NBuXNyBxTq4hG8lfE84cz+TItvxkLVNL+4lrZumxCVbshLvbeye1tmvMQVDuvvJyDTa+V6Ljqqh85/d7uKOywu2lMClmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760212; c=relaxed/simple;
	bh=m/MgPlruUerNQe0WI6OnSQw+Dlau/fEAWPBTxJRDDwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCF7Y1lAAawXg7eSil2WFtcsmQKwBibyfOdj2J0mDHGz/NGrqfsde7uRfTJHRqQEWbMl4B7ej8xn4z27oufgiVS5t0CxpAiyy9ibbDx76guZnGzWUgFN1rgnRaoF6TF3CeSItckVVCWklaZ+xD59xG/SwhQIhHowXNQnG+IbFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 6B98E1C223;
	Tue, 17 Mar 2026 15:10:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 67E5B80009;
	Tue, 17 Mar 2026 15:10:01 +0000 (UTC)
Date: Tue, 17 Mar 2026 11:10:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Josh Law <objecting@objecting.org>, linux-trace-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 09/17] lib/bootconfig: validate child node index in
 xbc_verify_tree()
Message-ID: <20260317111026.62345f9e@gandalf.local.home>
In-Reply-To: <fbe3dbdd-61a4-47e7-90a1-1042caa71129@web.de>
References: <20260315122015.55965-10-objecting@objecting.org>
	<fbe3dbdd-61a4-47e7-90a1-1042caa71129@web.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 67E5B80009
X-Stat-Signature: g1j1xiabrq45wgao8pfqgie9w58e44fd
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19cZatAR8wnG1Gox5uUagVsFyBO31Gy90s=
X-HE-Tag: 1773760201-90810
X-HE-Meta: U2FsdGVkX18siG0/eerHp4cU5YizooporrsiBWFCv7fyndJC/slnCf9tQuTrtMjLWlQ+X6zatxbgKBkjV5/olt5CiUTPgiAI0Yr8pBZQB6QF2ZPGfiu0OANLTVWpQ2OPIAb+StlFDDxI9dPQGDGhcY0m/AsrVqlmJ9P9MazdBs4wHDU8gTfuNSzr7cD1TYYyYT0TxNAXzjc1ZuQQdwUaT2MiH/PxIffho7JnXqejcmMmRyko09/tpiLk8oWZ1jPbquEQ38B6MyiMJ7S/TXKmBVmVY8dphKXufiRzgyZPhe2aMN0nz0G6X/chqIE8PXv7wxeNJKYCHOpRB65u89t8BFoyxDB3/zLp

On Tue, 17 Mar 2026 12:03:40 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> =E2=80=A6
> > +++ b/lib/bootconfig.c
> > @@ -823,6 +823,10 @@ static int __init xbc_verify_tree(void)
> >  			return xbc_parse_error("No closing brace",
> >  				xbc_node_get_data(xbc_nodes + i));
> >  		}
> > +		if (xbc_nodes[i].child >=3D xbc_node_num) {
> > +			return xbc_parse_error("Broken child node",
> > +				xbc_node_get_data(xbc_nodes + i));
> > +		}
> >  	} =20
> =E2=80=A6
>=20
> How do you think about to omit curly brackets for this if branch?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-style.rst?h=3Dv7.0-rc4#n197
>=20

Markus, please stop. If you don't understand the rules, do not suggest them.

The brackets *are* appropriate. The rule of omitting the brackets is for
*single line* statements. The above return statement is long and there's a
line break, which means, curly brackets *are* required for visibility reaso=
ns.

-- Steve
