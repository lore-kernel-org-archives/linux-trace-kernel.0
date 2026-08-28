Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FAC3C0617
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906181; cv=none; b=ClPIfeQBnMod/3gX6517DnUnBK4sU+y0vinz4Qgix/13HkoUb/nLzXtWTTlgoxNph+DRNtmSN3xuNr4i/Wl/m+ugXfU2KK2IlN3gg14MXE0PIys7PMhJTD4K8/hAINYmFhBWngZOsdncYRgJ7WbcrJsSrqjLioFL2TznieQ1x44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906181; c=relaxed/simple;
	bh=L4c2OpDSr6TUVSbdJycmnHLDzjDBnhmAaouVIH65QN0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=V4E1pelZ2RYUF7MA1W095oNyyw30krLJIHy5wetWyqPJh7xpHnP+m1gahg6JEydciYBzOS8hqrDydU2EpaEeuiCXWx3ZE2yPoG4FUSerX/NOJnLzKVKbRnuCUA3lMF8ouWkTOh98y3VBmkMbe9XYIviNOPPD1+B66pyHOh/EN5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=me3RrIhX; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="me3RrIhX"
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id E2DA01A025F;
	Fri, 28 Aug 2026 08:36:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 2568220025;
	Fri, 28 Aug 2026 08:36:17 +0000 (UTC)
Date: Fri, 28 Aug 2026 04:36:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
CC: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_1/3=5D_tracing=3A_Fix_subbuf_?=
 =?US-ASCII?Q?resize_races_with_trace=5Fpipe=5Fraw_readers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <apFFxOw_DUUChws5@google.com>
References: <20260826094528.3738023-1-vdonnefort@google.com> <20260826094528.3738023-2-vdonnefort@google.com> <20260826095947.4FF8B1F000E9@smtp.kernel.org> <20260826103736.2b55b464@gandalf.local.home> <ao8TQ-SvhjYgy43-@google.com> <20260826143123.1b3e3854@gandalf.local.home> <ao_Zu0ThaWThj9YZ@google.com> <20260827091541.5d03e33c@gandalf.local.home> <apBhLDTEa_3yYZP5@google.com> <20260827153314.77218528@gandalf.local.home> <apFFxOw_DUUChws5@google.com>
Message-ID: <F249A854-1A7B-4EA0-8694-736F65BD64CF@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 8u9q9m134frpfmu4okzmjb9ropoyj6rs
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 2568220025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+nDc4LQV1QnNMbpW/2Qpz7zgI33JHKiXc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:in-reply-to:references:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=3d+BzhqxMjwfCc5A7D0t3ECGIstg2OFEL/2i8UWqTNo=; b=me3RrIhX91odQx20yaakMzau/QNB4AIViRkgOszI/m0uVu02++32p08YP0CjGYKbWZe9LV/Pq2KkrvSGkRI8iH2FOBzAZbT9TDzYurjvqydeTD8sgzT2EwF/F6T8WQ97boGIntP5+PrBuRxbp1OKNog7BS4xd1OISWf1hJkD+fQ=
X-HE-Tag: 1787906177-979784
X-HE-Meta: U2FsdGVkX18Pw71snKpU/gMWLSSHsKxh236ZzA0+tl7J4XxZWEacEaR9qInqj2r3g4WaJy+qbrjlBBzUCswljjGDM5n9fOhxRHKVTqgx1evZt+Cnk93KUjm46OudZk3ULrnQ/dvxZMbBvsiZaptqwqboFeelF5FQ5I3YUujxlywGzSZ/0CyzDpDZqN3tRRz2+3xWpvEMdOiaXytI0GIYzBl4A7SKllDxQHdTCkVyPqqcS2RIWzYbuHG5cwOsL2TdC/THphsJU8alqrBdKuytbTd7gdhnebwTgJ2lVMR8lTVrJZya0RgeEkgKD7/MtSsvEZjWgOwe3zso0V2Gl9cuDrhZ5SDzbfHhyIYRJLzzKk/kHFlDj0MfAQ==



On August 28, 2026 4:24:36 AM EDT, Vincent Donnefort <vdonnefort@google=2E=
com> wrote:
>On Thu, Aug 27, 2026 at 03:33:14PM -0400, Steven Rostedt wrote:
>> On Thu, 27 Aug 2026 17:21:39 +0100
>> Vincent Donnefort <vdonnefort@google=2Ecom> wrote:
>>=20
>> > On Thu, Aug 27, 2026 at 09:15:41AM -0400, Steven Rostedt wrote:
>> > > On Thu, 27 Aug 2026 07:31:23 +0100
>> > > Vincent Donnefort <vdonnefort@google=2Ecom> wrote:
>> > >  =20
>> > > > Looking at the function again, shouldn't we add !rb_is_static(cpu=
_buffer) as
>> > > > well to the full page test? =20
>> > >=20
>> > > Why?=20
>> > >=20
>> > > -- Steve =20
>> >=20
>> > So that the splice can make progress when the ring-buffer is presiste=
nt or
>> > user-mapped=2E Or do we say that's expected behaviour?=20
>> >=20
>>=20
>> Ah yeah, I see=2E Hmm, looking at the code to see how this would work, =
I
>> think I found another bug=2E Let me look deeper into it=2E
>>=20
>> -- Steve
>
>A bug if we allow rb_is_static()?

No, something else=2E

>
>If not, shall I add it to my series?

Yeah, go ahead and update it=2E

Thanks,

-- Steve=20

