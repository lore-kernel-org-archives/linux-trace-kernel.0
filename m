Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B712B94
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 07:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134539; cv=none; b=M8aUfJVTBICvv4odKhK21XDSc5x5hHLg7xQvSiQeqURhsu6dRX/x9VmTdIIksseBTvv3WazCfREg5ExuZtwOThDYxQGbJQk1wvdpVINUL5R0auoWk/QT7dJ94dSU6HNi5huFmR0qZo4LfckAGW2+zLJgaRqUjUAonXUgWYr/hJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134539; c=relaxed/simple;
	bh=Y/RPevcJTSmu4HkHURItkoOBz5fFPW7vk2IpLR8P0Ss=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WAk0NGboByEiSjcvHFVr8qDxBHhqIoy3CpwdAQHzNrbI7MR1KazU9+q5OMA5V/aAu19tzuUA+nL+sU5fByAZtk3ZwedC/UnWX3Kw/mr1Oq4OIKnwmP6gvryaBCO4wS0ZHvgt/bOtJMu5XRmHhEtJA+Ru+flxU2P4RrLtUVaGaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjWIAW4o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjWIAW4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07861F000C4;
	Fri, 16 Oct 2026 07:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792134537;
	bh=+213ytgF2zedN/74oMfPPq8OMubzZJQjcEtFCQZvySg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KjWIAW4o1rAncJgdXkvahi0RDrE7paXDRG4Bm2rdubc7DIOaY5DV3hk+CHj9moR9e
	 eKD1rr1VoLznv7o5C4Z4EQb3h9YEYldUD1fLLWyUxLm4A51O935G6H09VhnH5efFOt
	 t1TyCwLq42oqVhhkt5PI/4nDIIMuWyHhHslSh2sXpaSLK/XwiBNNS5E/alJdpi0vqt
	 4U9CWmbUCi7ssu5mLL/ya8cK6mKWv88sL/nG4mYdEZUNXnX0U7LArB5DoHtaP8/zJm
	 AS6MWrWRaL3pOy96mQ23G7DEkTBSm1dn+j1mPv4qaxAXp5BDx99N8oxgdApobwne4S
	 DFgJdTBZUQxOg==
Message-ID: <sashiko-outbox-173902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: reject trace events with an empty
 TP_STRUCT__entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoran Wang" <haoranwangsec@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <6ad1cad5.856c1b21.18f9b7.a2c3@mx.google.com>
References: <6ad1cad5.856c1b21.18f9b7.a2c3@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:08:57 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tracing: user_events broken by fields_array[0].type check
--

commit e8b9d44518a8f72216cba6b41f5a36c08fdcef3c
Author: Haoran Wang <haoranwangsec@gmail.com>

tracing: reject trace events with an empty TP_STRUCT__entry

This patch adds a check in event_init() to reject trace events that have
an empty TP_STRUCT__entry by returning -EINVAL if the first element of
fields_array has a NULL type.

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 30c0ddf90887f..9f79fbdf40a20 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3406,6 +3406,10 @@ static int event_init(struct trace_event_call *cal=
l)
>  	if (WARN_ON(!name))
>  		return -EINVAL;
> =20
> +	if (call->class->fields_array &&
> +	    !call->class->fields_array[0].type)
> +		return -EINVAL;

[Severity: High]
Does this inadvertently break the user_events subsystem?

In kernel/trace/trace_events_user.c, user_events are assigned a statically
initialized dummy array:

kernel/trace/trace_events_user.c:
static struct trace_event_fields user_event_fields_array[1];

Because this array is size 1 and zero-initialized, its first element's type
field is implicitly NULL. When user_events are registered from userspace via
the ABI, __register_event() calls event_init(), which will evaluate this new
check to true and unconditionally return -EINVAL.

Can we find another way to handle empty TP_STRUCT__entry events that won't
cause a feature regression for user_events?

> +
>  	if (call->class->raw_init) {
>  		ret =3D call->class->raw_init(call);
>  		if (ret < 0 && ret !=3D -ENOSYS)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6ad1cad5.856c1b21.1=
8f9b7.a2c3@mx.google.com?part=3D1
