Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC62EE977
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655101; cv=none; b=GR9KtgOM7w+mXp7yyw1IgFEX+Om/lJFE4uIYADVsGtORIhtGV3KdzixC5VEK030HOv6l4w7pJUG/fsyvlSi7OF5Cwd8z4Q96N7BMljzbXqMBJ8OLoHnRFGjq90tkjzZmFWfJl5u/rtNqk7wnQu5TeF3Z7qvn73f2oDFf6CFKP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655101; c=relaxed/simple;
	bh=QQq8vBZfSk2P43wHNlFThQAoMuJo81QL4o6cGnRFKfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzpJctpAHLdflz4UhxfhJfDVvorzJJipeX4f7zMhT45sPkDGDEr2tqxVcoS+eIdFhTTbs8171/bmde9s2ivai31aybzpMhI2pQ8QY7cCFskFU8wBjBlJLZA326vAuB+MZeJCU+U7chaNOg6iLpSYY1pRVJZByUJCxN69PTh2MGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVCZ3ALq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVCZ3ALq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752655098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QQq8vBZfSk2P43wHNlFThQAoMuJo81QL4o6cGnRFKfw=;
	b=CVCZ3ALqNmgB4vX4NVcqPS9+ay+MehuoAxZHDjovnnMBeA5erZU7XcajZChutbz/ZMOUig
	+ZiIelcIMG1EFySAC5IUGhI3c8/v3NB77yrIvGXIiNqzo7hfOaS/iIZJSx013yjLW0CTyx
	d2cyJL0fOxByrQU997caDY6QxzfRYrs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-UfVm3PSJMM29Vq_KHtFiYg-1; Wed, 16 Jul 2025 04:38:15 -0400
X-MC-Unique: UfVm3PSJMM29Vq_KHtFiYg-1
X-Mimecast-MFC-AGG-ID: UfVm3PSJMM29Vq_KHtFiYg_1752655094
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-455eda09c57so33614665e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752655094; x=1753259894;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQq8vBZfSk2P43wHNlFThQAoMuJo81QL4o6cGnRFKfw=;
        b=EdsMdNB362AEIeefSqOAWywG/L66d2M0T48Zmg0gEOHAOU4CIZk/WCOFV8tZRMiOA7
         owhB7YOjYgG6Z+5MXcriPSBcV3rxiejmbPgAxTrgk+KfBF+MBmr3/O+SGB3v+KdCTES3
         ajVPwUpJAyxjCb552rGPhjnXB4KTjK2UTmyTqdGcyfAI/GNtXwfXowC/UKYMauAkIvu+
         uM6as82L0vAgOW/a/FIP0K3sMQGE34P8UFFgzMOb3lNDVchN+V8HQDBiJnJbvvXHE8Xo
         wfaY1eKZTVutiQ2L3udo/rSWJGKbYNJ9f/YOlCqj/Z//Qx1lWFC4P9Db7MkV2Kk022d0
         7Gfw==
X-Forwarded-Encrypted: i=1; AJvYcCVe+bZb0+Xf4yhypwzIc9WaY1OM5F9a/WmBMIodpCQ2YvFh3WE9GNTeZirnoyZv4TFEL1U93fGvAUwhXkYti8ifP+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKLQPtKF+2WxIz6PfxOd3ULsORf8jJfxRYHt+kimj6wpX+0UO
	zo6xkCuq3b7fGlrx6AiYtxCIwXe/PTqfQuzr0ZEg/awQ8lsV5lWVoWq1SdR5z0M8XX1jwL7rbmc
	8K/AAHlqgRFpJYdP6pa7xBDysDa952JuscYFtQZOHKk+qiN1pqkJoAGFh3wae/u9oBoIZWE5tvw
	==
X-Gm-Gg: ASbGncsXnz5jUxw/bZogTCbxJ7FK668JuMOTW5MyFjjjsJWWxq/t+lsFXMThhLOHxmj
	M/zlKjKgkGwfW0I3PRcCn2jRheURVmAa0WkutzZryiXtFRl3G14H/cKBr5YVtI/WwyBhU+4NAo0
	lybM/w87UFL9eMcQNn4g5RTvWb3q+7DC6RzaMc1KdtkBOFnud7qWuTP0Loo3fAHotuzOGwDxpDp
	kyJAeo2aMk8ivVmB3TYTA4wPV+WsIAoFzwLWvaexMvyKqHAJERUqYO61g+JbIBcis/ebxpODEc8
	4cXxQpZj5OYVQwD3QDy/0GEkq/haXuEBp4yBQWaJWVS/y0ttx0Kd5pcxQfSZ+b2KGg==
X-Received: by 2002:a05:600c:64cc:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4562e3548acmr19340905e9.11.1752655094320;
        Wed, 16 Jul 2025 01:38:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+/nnuhW+F2Hws04Pmk8/5vN80FGzipbhCV9r67JREdN9AMG3evNFkRpoGcxhrIiM9lirDhA==
X-Received: by 2002:a05:600c:64cc:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4562e3548acmr19340525e9.11.1752655093847;
        Wed, 16 Jul 2025 01:38:13 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886113sm13876205e9.23.2025.07.16.01.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:38:13 -0700 (PDT)
Message-ID: <f7028488e9d820848955de87ead3ec619fe5dbec.camel@redhat.com>
Subject: Re: [PATCH v3 11/17] rv: Retry when da monitor detects race
 conditions
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>,  Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 10:38:11 +0200
In-Reply-To: <20250716082712.L9z_ptHK@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-12-gmonaco@redhat.com>
	 <20250715152322.Os4lDq_B@linutronix.de>
	 <e2f4f8d372612cd61689b91562e73677599d08de.camel@redhat.com>
	 <20250716082712.L9z_ptHK@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 90j5QQ3hHTef7XydRdwe3Ap9KNvRNPE_yO4xdvTi07o_1752655094
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2025-07-16 at 10:27 +0200, Nam Cao wrote:
> On Wed, Jul 16, 2025 at 10:20:39AM +0200, Gabriele Monaco wrote:
> > On Tue, 2025-07-15 at 17:23 +0200, Nam Cao wrote:
> > > If I understand correctly, if after 3 tries and we still fail to
> > > change the
> > > state, we will invoke the reactor and trace_error? Doesn't that
> > > cause
> > > a
> > > false positive? Because it is not a violation of the model, it is
> > > just a
> > > race making us fail to change the state.
> > >=20
> >=20
> > Yes, that's correct.
> > My rationale was that, at that point, the monitor is likely no
> > longer
> > in sync, so silently ignoring the situation is not really an
> > option.
> > In this case, the reaction includes an invalid current state
> > (because
> > in fact we don't know what the current state is) and tools may be
> > able
> > to understand that.
>=20
> Can't you bring the monitor back to the init state, and start over
> again?
>=20
> I think "da_mon->monitoring =3D 0;" does the trick?
>=20

Yes you can, but I wouldn't do so silently.
I'd say the cleanest approach without reaction is to still return false
for the system to do all the cleanup but trace the event or, at the
very least, print a warning.

But you're right, this is more relevant for who develops the monitor
rather than for the user, so should probably be tracked separately.

Thanks,
Gabriele

> > I know you wouldn't be able to do that in LTL..=C2=A0 By the way, LTL
> > uses
> > multiple statuses, so this lockless approach may not really work.
>=20
> Let's worry about one thing at a time ;)
>=20
> > I don't see this situation happening often: I only ever observed 2
> > events able to race, 4 happening at the same time is wild, but of
> > course cannot be excluded in principle for any possible monitor.
> > Yet, I have the feeling a monitor where this can happen is not well
> > designed and RV should point that out.
> > Do you have ideas of potential monitors where more than 3 events
> > can
> > race?
> >=20
> > Perhaps a full blown reaction is a bit aggressive in this
> > situation, as
> > the /fault/ may not be necessarily in the monitor.
> > We could think of a special tracepoint or just printing.
> >=20
> > > Same below.
> > >=20
> > > Also, I wouldn't use goto unless necessary. Perhaps it is better
> > > to
> > > put the
> > > code at "out_react:" and "out_success:" into the loop. But that's
> > > just my
> > > personal preference, up to you.
> >=20
> > That could be done if we do a whole different thing when retries
> > run
> > out, instead of defaulting to out_react.
> > I liked to avoid excessive indentation with those goto as well but
> > yeah, it may not be quite necessary.
>=20
> Sure, as I said before, "just my personal preference, up to you."
>=20
> Nam

