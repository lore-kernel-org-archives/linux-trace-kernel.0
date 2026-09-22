Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4B550DC6;
	Tue, 22 Sep 2026 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089190; cv=none; b=tEUS6ej9A8MCsYMvtzkashvwCjQpzWf7rIdFySwk5S/CZjLIHLUZ/+4BoH01gwnV4x2c2j8GO2NEMvZb03kqFE8yaH3rgkA5T7MlARwRlFrs/Br0tUosGOvflyadzrBZn25aNFmsXSRR2wF0jZaHzTvDJukP4JTsWJlmmyCPHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089190; c=relaxed/simple;
	bh=VdDKKmt2OfwPfrFz17S36ZDrC00F7JzQSwuNN97Gak4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QO4/h7brTUPnCsTOOXiNJ8CdAXA7ON6rwJDaLfsvR0z5lqs4j9TzxyeMigIvEFILEdRoQvOwC6HeTKCNBBQ+wQ3Jx/hDsA0WSnWFfSHjgFbVfOvUY0CHkHB3yV+aex0GIcsDVqyfKir6YxbcZmbXyWp03wRW0DVuQDc7uedJvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BHJOfqU1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BHJOfqU1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DX9ceSOm8m7HUk7JvUwb0USsA+Dq6TuYpLe4RKmuCac=;
	t=1790089188; x=1791298788; b=BHJOfqU1V8Rjitja8vN8KGlJDIVXTP6p3cKV6Oi++uiEkMx
	1N5ZMhJQW3hwysT2nAqKSMcIt0hU9AuUlMTbj3VjwoFX3w1UpAPbe4ItHeSVT3UwYE0/RQl/ABagA
	oJaR91hF3I7V6Ww/u6i3yXFIoIgfULICtu2zSh+ziAR6DN3VyFzL2u75MLfC5KIh1lNDmlxgt8Mc2
	TZjCRPJS7O/wwhhKWefppnMCxsfNhBxgNrYTVLhUBCZqBsSCpc9C4YoE0rgbUlYJBcEZ3AlPpSf7/
	xU7t0Vk5QwTNjRr7ljBuVQOChjtDEGPHv/BlFfTm7AHgJFsBbQx1vunJIrbCDcHA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x91y9-00000006zRs-1K9c;
	Tue, 22 Sep 2026 16:59:41 +0200
Message-ID: <7ec27c80d766884c5f0d5d0c190d2c06ebeda6e5.camel@sipsolutions.net>
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Adri=E1n?= Moreno <amorenoz@redhat.com>, Ilya Maximets
	 <i.maximets@ovn.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>,  Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Aaron Conole	
 <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 dev@openvswitch.org, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	netdev@vger.kernel.org, Antoine Tenart
 <atenart@kernel.org>
Date: Tue, 22 Sep 2026 16:59:40 +0200
In-Reply-To: <CAG=2xmNURzYdR+eL8x_kW64Bo9gEe3ne88YXaKQKT+_Ya7XZFQ@mail.gmail.com>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
	 <20260921101538.97286-9-johannes@sipsolutions.net>
	 <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
	 <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>
	 <CAG=2xmNURzYdR+eL8x_kW64Bo9gEe3ne88YXaKQKT+_Ya7XZFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-09-22 at 07:35 -0700, Adri=C3=A1n Moreno wrote:
> >=20
> > IIUC, this change only affects the printing and doesn't affect debuggin=
g
> > tools like retis that attempt to surface the drop reasons.  But, maybe
> > Adrian and Antoine (CCed) may want to have a glance as well.
> >=20
>=20
> I don't think this will affect retis in a bad way. We collect the list
> of drop reasons by inspecting the BTF enums. It generally works but we
> need to keep track of new subsystems enums being added

Right, that wouldn't really change.

> so a dynamically-generated full-list of drop reasons is interesting.

> IIUC, the only way for userspace to read this list is by looking at the
> event format and parse the printf line, right? Any ideas to make this
> more machine-friendly?

It's intended to be machine friendly "enough", trace-cmd/perf (via
libtraceevent or so I think?) parse and use this? But it's also only
available when tracing is enabled.

I think if you really wanted to have a full list dynamically exposed at
runtime across all kernels, then perhaps dropmonitor or some other
netlink interface could expose it? Or maybe another debugfs/sysfs file?
I don't know what you need it for, but I think it's out of scope for
this patchset, and could even be done without it?

johannes
