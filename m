Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59515509EF7;
	Tue, 29 Sep 2026 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677697; cv=none; b=a5gBkyV39SdrXTZL7woO2kkQYayIBJ0Z0t7B5pe8A2DQpjjfHEy/o/81zaX01cv9wjQe440QtknRXpTjCjaC9j3xzA+QFZgDnwylPbF+6tXG/ZSHl/R6kXjW0qKMCx6Xcpk8wXYt9n9OBkAq30PL4e7ug+SRXK4J7SpZBRq75w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677697; c=relaxed/simple;
	bh=Pt41P2HkVTv+6/n7KRKAcTRCUaZVj0J09lRCJkOVm44=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=nkgwiURarHf1cvKLTuvxBDbyG/nJaHxltk6e7A6i1CghKLdidYEoXrhke7LpDHrYzd4dhTk4Yr7tQy830HenYJ4a5fTo1U0LhZKrdZ5ycpzhe6iXWvsxgVAjOvBbkzYeuVd5MdVO1ZPqoSeogrLqEDPh27aWKb1v2n3r+QqoG5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUHoJEBA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUHoJEBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093F71F000FF;
	Tue, 29 Sep 2026 10:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790677691;
	bh=Pt41P2HkVTv+6/n7KRKAcTRCUaZVj0J09lRCJkOVm44=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=kUHoJEBATUUTerwTqkCcMB9GDs9SaFTHuyIfkL2Z/HPutRHJoBV71p3REv01T1myC
	 rOwZ328EqBt6UW0EcBQqjX4YD2Kt3DaMh/hs6NZMURQIUykxpdQmotTC1qXP1OD3rS
	 WjICtSjcQh1RjrvEGcpCpPEUuLSGYsmCnNYtltw29//b6f6gPNj2F1cvTDhkjwbdSc
	 StTCXJCXD4YmQAo2Q77WSONLTIu/Gvt1qlZXtA6KDOUADnkAFP6CtNdfGCCrcc7hKR
	 HbjbhgMcHhKHiZN/+TLeyRIxtAeVOUh9bSOih62q74gL90fLbw39ijnL1GAeIhuCg5
	 FQgGBk3AeJTOA==
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 12:28:07 +0200
Message-Id: <DLRQ9H3ROCH0.3KR62BLPWK0VW@kernel.org>
Subject: Re: [PATCH v3 0/3] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Johan Hovold"
 <johan@kernel.org>, "Aaron Tomlin" <atomlin@atomlin.com>, "Bradley Morgan"
 <brads@mainlining.org>, "Thierry Reding" <thierry.reding@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, "Armin Wolf" <W_Armin@gmx.de>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-trace-kernel@vger.kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
 <DLR4AMFM8QZ2.36R6G0LD9D53Q@kernel.org> <artRKXU0jygdcxx3@monoceros>
In-Reply-To: <artRKXU0jygdcxx3@monoceros>

On Tue Sep 29, 2026 at 7:53 AM CEST, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Sep 28, 2026 at 07:15:12PM +0200, Danilo Krummrich wrote:
>> On Mon Sep 28, 2026 at 6:46 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
>> > Note that different to Danilo's suggestion I don't differentiate betwe=
en
>> > driver_overrides setup in userspace and those setup in kernel space.
>> > IMHO all are bad and there are alternatives for the legitimate cases.
>>=20
>> I agree that the implementation - i.e. (ab)using driver override - the a=
ffected
>> subsystems have chosen is wrong.
>>=20
>> But, there is a difference between picking the wrong implementation and =
being
>> semantically wrong to a point that we need to taint the kernel.
>>=20
>> So, yes this should be cleaned up, but we should not taint the kernel fo=
r
>> otherwise correct code. Otherwise we could as well taint the kernel for =
every
>> other abuse of an API.
>
> My position on that is: Do the global change now and help the subsystems
> to clean up the mess. In my experice waiting with changes until all
> affected parties are smooth with it is a recipe for failure.

I do see an advantage in having the taint in match() rather than store(), s=
o I
prefer that too.

But again, I do not feel comfortable to taint the kernel for something that=
 does
use the wrong API but otherwise behaves correctly and shouldn't taint the k=
ernel
at all.

We have six users of device_set_driver_override() outside of a userspace
reachable scope. Did you have a look at how hard they are to fix? Do you pl=
an to
provide patches?

>> > I think applying this complete patch set and keeping fcbfaffee51a ("dr=
iver
>> > core: add TAINT_FORCED_BIND for when userspace manually messes with de=
vices and
>> > drivers") is too much, so this series serves mainly as discussion grou=
nd for
>> > choosing a sane way to prevent fuzzing results of only mild interest a=
nd stop
>> > patch sets harding drivers for driver_override handling.
>> > My preference would be to revert (or drop) fcbfaffee51a and then only
>> > apply patch #3. Maybe also keep patch #2 to taint if
>> > "allow_driver_override" is provided.
>>=20
>> Agreed, but as mentioned in [1], I think it is also reasonable to only k=
eep
>> TAINT_FORCED_BIND for buses that do not support hotplug in the first pla=
ce.
>>=20
>> [1] https://lore.kernel.org/driver-core/DLIL9H50MALI.3JROXYEEUM3KU@kerne=
l.org/
>
> Fine for me, that would mean to apply the whole series and restrict
> TAINT_FORCED_BIND to "static" busses.

That sounds fine to me.
