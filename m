Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8222C325B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110757; cv=none; b=PF1WdD8a2k2lnsok/c9ZKi0P9cUTVdob+LvHgj3NQGbAwi7iQeUMW93AgxMBi9kx42OTgbJ9+bX4s0oQUGhssiQrXdNOm6xn5EIxJqwbk0x0H/4UXS9k2BYe6ZyO6OotG2ACSuG2RYK2qCliHVuVzYKKK78Q8Gqd9H/+1E77EVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110757; c=relaxed/simple;
	bh=XcKEv1NSHYFxRoTyhy1muARE6V5xd6hDoWC+npQHoQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixMxLfmZXkkGDeR6GojIyWVisbX8o3ICKi0NcBbS75xSKhbR5FxIuaSE+IN11gYT7YZ/nPzbkITycCV+jsXvr0LY0ekkc2M1GkoauLl8nHbx27w3mzlI7KL7NmLixdm7V5/VqnMF2yveUI0nUE9VyI9JulTxQ4RYD3aTbBdGIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYU7Ws1B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYU7Ws1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756110753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HIjc3udJqoXzi7WeWTZTckDvsT2q820v4Zc6UZKPcfc=;
	b=LYU7Ws1BIAXUKktvtUD1U6M3gZYCrBvIaZaN62+WFIQJFB34jYfZdHDI0+A/VuJbe/lubo
	YpoDNiGqDEQ9kkQTQ+35nTg1MPsJVEf47XndWktdiDiMeRPZL5o5dFvd91qDldwggLGc4P
	wu8bphI41rdQFNpTXqWm5sVyquGxieY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-SrE9AsPLOOeBZxoQJdif6A-1; Mon, 25 Aug 2025 04:32:32 -0400
X-MC-Unique: SrE9AsPLOOeBZxoQJdif6A-1
X-Mimecast-MFC-AGG-ID: SrE9AsPLOOeBZxoQJdif6A_1756110752
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70ba7aa13c3so159633836d6.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756110752; x=1756715552;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kd1Ty6UgWWPnKhsbBAczdSxHzDVOW+iGIrAJcYqpEg=;
        b=sH+Q4W9zjvRwRmacuHnSU2kSmUh4oUk3ETRj6pQ7rJv98bVmqyNsUuAAaUNZRD4n48
         PvW4AjBYsKAAJEHZUsiD8zmfILnn6oLM9+gIhXtagQvVstAX3lfSXSi8w/QBMDutStCB
         4fLkmTdkUkAhZvkI2SGwosReKGssgDQGo0nd8XIoVbZRLIomOWmnYZAYl3qELHdbNATI
         7D+TDxMVDtZ4Bdm1KWpi/FO4qM41saUnVaE5eURO2SwIFPyiFWMM3IOL2QAKept0ZuhS
         tfB3oKthy8CBSEIdhT8md5gVzHg8xIPts7/AHdFjtd96BaB9CrwmabWzYhT8dKxKyxx0
         8I8g==
X-Forwarded-Encrypted: i=1; AJvYcCX7NMcwvaAuD8wBaqXPeyM/HJLnDzgkaZ1yQTiI02Gfk3kmgN+2SbvWjOoV8Th6Sp2CMFnQW++hjnHsK6/VtBTXWYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqvS1SjNWB++l1R5zVUxyrrqih0unEkxws71n40DVqP3pjIfYr
	zhZw+lfWIbjgZzOeWM7OmIvFl4mzW1Gont8I+UcZgzCVSRSzAVkQefQwMU+A0U7Kp8vJaIuKWee
	cK3autMk3dC7frDs8mAkymgfWPKfEdsTEhEUgUyzV3MiSRdJukgZEIJbnbLUqKLy4cWdm2b7zgg
	==
X-Gm-Gg: ASbGnctU30jkqO8KaVW+mqZmMwDGKl826mgATe9kfS3lYS5vkBMc+kmPldkzSXjSbPi
	+DfDTHfb45o24YYTkTThYdObPr2buYzzjj7fA/hEgOh5GtH9o5Uxybu8dLH6kzNaGEPaRXQXlFi
	LEQb7Gz+FJc10uJwwWO9haM2GOxdK3mzY1eUG8JfZCw78uu/i18rpgueApH9HotNMGuhZGrzVNv
	UK/9GuwnYDpd6FIE9zm4Ipxg27jhusVzn0ITJt60Ts9oacb71fcato1K0HoVb90n+XQ1Qvrfcyf
	7vHR1iO8UgvM4cFkyyEFJfNlJ48Ayh0lZqfIEwxA65frNtnV5B7tn4oYbvpisoz56Q==
X-Received: by 2002:ad4:4eae:0:b0:70d:8ad0:93d5 with SMTP id 6a1803df08f44-70d9710e96cmr109097926d6.20.1756110751610;
        Mon, 25 Aug 2025 01:32:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb+juQwMAs0Z188vrqiQCNcrXZ6PhDrXohg/HAYXKHBZaqXTkAZv+abGTymzbx1a2+rydpQw==
X-Received: by 2002:ad4:4eae:0:b0:70d:8ad0:93d5 with SMTP id 6a1803df08f44-70d9710e96cmr109097836d6.20.1756110751290;
        Mon, 25 Aug 2025 01:32:31 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72aff63sm41947316d6.51.2025.08.25.01.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 01:32:31 -0700 (PDT)
Message-ID: <62b076b8837139eb109c3958d28318b0ec508344.camel@redhat.com>
Subject: Re: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Tomas Glozar <tglozar@redhat.com>,  Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 25 Aug 2025 10:32:27 +0200
In-Reply-To: <20250825081320.syZmsSiH@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-9-gmonaco@redhat.com>
	 <20250821121846.N0S9tb6x@linutronix.de>
	 <fd9dc21acd4fac68a3948ded59cf9235f0e4bb7f.camel@redhat.com>
	 <20250825081320.syZmsSiH@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: LqsaA-LLLCRjKr0z8hACoMRc3m6dU9gIHXYB5i2Nc7U_1756110752
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Mon, 2025-08-25 at 10:13 +0200, Nam Cao wrote:
> On Mon, Aug 25, 2025 at 09:48:23AM +0200, Gabriele Monaco wrote:
> > On Thu, 2025-08-21 at 14:18 +0200, Nam Cao wrote:
> > > On Thu, Aug 14, 2025 at 05:08:00PM +0200, Gabriele Monaco wrote:
> > > > Deterministic automata define which events are allowed in every
> > > > state,
> > > > but cannot define more sophisticated constraint taking into
> > > > account
> > > > the
> > > > system's environment (e.g. time or other states not producing
> > > > events).
> > > >=20
> > > > Add the Hybrid Automata monitor type as an extension of
> > > > Deterministic
> > > > automata where each state transition is validating a constraint
> > > > on
> > > > a finite number of environment variables.
> > > > Hybrid automata can be used to implement timed automata, where
> > > > the
> > > > environment variables are clocks.
> > > >=20
> > > > Also implement the necessary functionality to handle clock
> > > > constraints (ns or jiffy granularity) on state and events.
> > > >=20
> > > > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > >=20
> > > So you have figured out how to deal with the time problem. Cool!
> > >=20
> > > I'm curious, instead of a new monitor type, would the entire
> > > thing be
> > > simpler if these new features are added as extension to DA
> > > monitor
> > > instead?
> > >=20
> > > The existing "pure DA" monitors would just not use the constraint
> > > and
> > > timer stuffs and would behave same as before.
> > >=20
> > > Just an idea, I'm not sure how it would look like. But I think we
> > > might reduce some line count.
> >=20
> > Mmh, that might save some lines, especially the *_hooks() macros.
> > The few functions that are now duplicated would end up together
> > with a
> > condition, though.
> >=20
> > I'm however not too fond of forcing any DA user to allocate space
> > for a
> > timer. Imagine a custom kernel for an embedded device trying to
> > squeeze
> > some RV monitors in tasks and ending up requiring 64 bytes per
> > monitor
> > instead of 8.
>=20
> I'm not sure if I follow. We put "union rv_task_monitor" in
> task_struct, so
> we always require 64 bytes, regardless of the monitor type?

That's right, but if no HA monitor is compiled in, struct ha_monitor is
empty, so  union rv_task_monitor is as large as DA/LTL.

> #ifdef CONFIG_RV_HA_MONITOR
>=20
> struct ha_monitor {
> =09struct da_monitor da_mon;
> =09u64 env_store[MAX_HA_ENV_LEN];
> =09struct hrtimer timer;
> };
>=20
> #else
>=20
> struct ha_monitor { };
>=20
> #endif /* CONFIG_RV_HA_MONITOR */

That's why I wanted also LTL to be optionally empty, technically we
could do the same for DA but since it's the smallest it's rather
pointless.

Thanks,
Gabriele

