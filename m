Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B83F0A95;
	Fri, 26 Jun 2026 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469638; cv=none; b=j4hpYOYWVpvHvi36GQvl0SJNu2THTYXiIMbTGWRuZgkjgtufwZYyz1Ef7yRhexvEc37Pl1Bt4F9mkY5/ZkGkeTpPVjJ6qf6ZzATStUpvhdxl8QAMRkEBZeqwVHlX+WVw7zR867qkK2mwCGyVHfvsb8vGF1lWRf/t/EeP8BqUucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469638; c=relaxed/simple;
	bh=gIk0JBnO1KbqU0wbDh9FxwJA+SGKakNdkm1qDWkeojY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxYx185G1X+xXyKpaUqn9ren3saEIVMA6bGAC4Ap4VbKxC30c81I+5ue11RAFgab8/xAQcdwk1Zb59sz8UqPj9/r1ujFJTAzwFzJU5WjiuTWihULZ9t+UdpL1W0wRMlhR4Zcxp3mnYkptdUzw266/8i/F2aDXPsVy5KLJY1RdAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 319321C5F21;
	Fri, 26 Jun 2026 10:27:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 5417F20025;
	Fri, 26 Jun 2026 10:27:01 +0000 (UTC)
Date: Fri, 26 Jun 2026 06:26:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tomas Glozar <tglozar@redhat.com>, Costa
 Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, John
 Kacur <jkacur@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v2 0/4] tracing/osnoise: Track IPIs
Message-ID: <20260626062658.7f95bcad@fedora>
In-Reply-To: <20260617131803.2988989-1-vschneid@redhat.com>
References: <20260617131803.2988989-1-vschneid@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5417F20025
X-Stat-Signature: kkf8dp3i6gqctkje4wxpghb5n9mmb6cf
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19G6m87l64apJQvK49UW7rP/8WnSn6Erpo=
X-HE-Tag: 1782469621-445287
X-HE-Meta: U2FsdGVkX19EXOYuDnf6v/9daXPzxItIb3MQSLn14e1imUt8I74EJzh4OdzyEFaS8PL9CvbUvBfPMT/c59T326mQl5p/JBb8j6ROrZCoElLMi2nxiXt+JkHufRQpoAZMCk+/IGYBrnB9459yEp3IaT5JLL+l8HGrUJZDsTYcbPjPayPdoIBxwFdpX/anSGo5WxW+AhwxPe19uqjrYhqxnpZq6ChMw7PQogk29B+BXleU2Xyhp+bhWnWMen5YWSVpQ9JErNgQyF0US00rTZO6p72gkEy3tsWtbAm6d3iUgbQGc9snkCy6XIOxGWxR0Lc220ZCHvH6bovBkcPynxlttWnHw2Ge1zSB

On Wed, 17 Jun 2026 15:17:55 +0200
Valentin Schneider <vschneid@redhat.com> wrote:

> Hi folks,
>=20
> So I've seen a few times now reports of latency spikes caused by IPIs, us=
ually
> because of isolation misconfiguration, but only detected at the tail of e=
nd
> e.g. a 24h timerlat run.
>=20
> It's not because those IPIs are rare, but rather that they don't by thems=
elves
> cause a monitered CPU to reach the latency threshold, it's usually a comb=
ined
> interference that gets us there.
>=20
> I'd like to make it easier to detect such misconfigurations and thus IPIs
> hitting supposedly-isolated CPUs. I initially kludged a timerlat option t=
o stop
> tracing as soon as an IPI was sent to a monitored CPU, regardless of the =
latency
> threshold. It sort of did the trick, but Tom=C3=A1=C5=A1 convinced me tim=
erlat wasn't
> really the place for that.
>=20
> So here's IPI tracking added to osnoise. This time around fully in usersp=
ace, as
> Tom=C3=A1=C5=A1 pointed out to me that this will make it a lot easier to =
deploy to older
> kernels.
>=20
> Based on top of linux/next at 'next-20260616' to have the latest libsubcmd
> changes.
>  =20

Hi Valentin,

My new job actually makes me very interested in IPI interference, and
this patch set looks *very* interesting. I'm currently finishing up my
orientation and hopefully next week I can start catching up on all my
email.

I'll try to take a deeper look at this in the coming weeks.

-- Steve
