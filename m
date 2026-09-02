Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49816472F67;
	Wed,  2 Sep 2026 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354901; cv=none; b=aEDBcytdHkiwaFV1y3JGOVdyOWMCVVVAxfo/gTiu2O9ayu/7Bb0HjPev2nQD85jjzXteqt4ql6WJ8zK/pHL39iDBrlKmbjKtcfDN0ON0/RGSRj7LH9VArOhio3KGhlpiELR3WVIS5+3VZqH9Jrh8sRdSewBWf5tURIySnw8U524=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354901; c=relaxed/simple;
	bh=llL0fq6MHfb3x3/fbHPbOaKi1AltfhsdW+uncHlYs5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Si5FGZh3p+s3p1gQxPP3ptOLgUQuSqJL9eAisqwvvDn9oZym2BD5ahXWv5yF4+sxoDrw/FX4Z9/vEvVpbb8jB4JBijhvuz7Z4D6uISjMGnuciCO9EsUnLDdAyj4SpnL30nsk6+qPa1rkHkXivyhGPqPuhAPAHeq8PN85Mhiy7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=W3kMTaAZ; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="W3kMTaAZ"
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id D0163140202;
	Wed,  2 Sep 2026 13:14:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id D86E11B;
	Wed,  2 Sep 2026 13:14:54 +0000 (UTC)
Date: Wed, 2 Sep 2026 09:15:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Gao Xu <gaoxu2@honor.com>,
 =?UTF-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External Mail]Re: [RFC] tracing: aggregate ring-buffer memory
 statistics
Message-ID: <20260902091555.450b521c@gandalf.local.home>
In-Reply-To: <88d476d443e74672957a5e0d1f8bf9ba@xiaomi.com>
References: <20260825141015.3539553-1-gaoxiang17@xiaomi.com>
	<20260827113815.0a0e37fb@gandalf.local.home>
	<15c244f5bc8f4858b8ffa2974a46d009@xiaomi.com>
	<88d476d443e74672957a5e0d1f8bf9ba@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: aknydimr6a97o9us8nh3bkrou6z5k6u1
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: D86E11B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ohUGFcNZp7XbN1Z9V/SQ2mcXexHS1Dbc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=aNSS6owsISO1dJeq02hyfcUeTR42Jaw3NROhHSm+DEI=; b=W3kMTaAZgMmlRRBCrpebeZ8dKGzvcnFxy6yId0TuxcpJfbgTW/pzL8fS0/ebVMlWibXJu1XmK/PmSWrjLp7k9tjpB/kOPFD8Be6YxJ/gCp1fZGhcOeJTbsaA1k2WBRexZ7CPqaTM1iwK8uGRoYi/v+AID4MDOOrrBar8fbAEHMk=
X-HE-Tag: 1788354894-503581
X-HE-Meta: U2FsdGVkX18s9Af5vshpTC/L79oepm5794RlazNh0uSs54U8WDIXxZyUYQrQK4ZhwxiL5IVEJscA8u4WjRBZaikCHSwBgQeb0Se1jmDic8Pd4Ap8VZKWXq41dXaHX90TEDnrBa1BDeLrYcUSGUnYDg1SSvi1Cl3gsIYRWUXc6h5zEAIDg9Hr2gNYzFXUd08HqbP/R/lJ286P+QGbgkm6mtFBeXTkl4+R6HpNCk341qQZEim6oYRBNU+F9an5cieBwOpZlNv53267y0e+VRR/r+RUsqau8BI9OQbrfRLfkUxhVckk3VN8HAx4A35vm4K/kDW6vpdzs48Ge2eIY1BbUIec6FJO7Tp+x2C6VhXieNVm2lfkERFipg==

On Wed, 2 Sep 2026 02:24:23 +0000
=E9=AB=98=E7=BF=94 <gaoxiang17@xiaomi.com> wrote:

> Hi Steve,
>=20
>=20
> Just checking if the metadata split I proposed last time looks
> reasonable, so I know whether to proceed with the implementation:
>=20
>=20
>   total:
>   buffers_mem:
>   snapshot_buffers_mem:
>   metadata_mem:
>=20
>=20
> where buffers_mem and snapshot_buffers_mem report all page memory, and
> metadata_mem reports the slab-allocated ring-buffer metadata.
>=20
>=20
> Would you like me to proceed with this split?
>=20

Let's start with just the buffers for now. Thinking about this more, the
file can be called "memory_usage" and we can drop the "_mem" part of the
items.

 # cat memory_usage_kb
 buffers: XXX
 snapshot buffers: XXX


We can then add more information later.

-- Steve
