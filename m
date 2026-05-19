Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B83E34040F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204399; cv=none; b=PHHcMkPf5+3Y/aAv6jyS7V48kTJLLOnfkdA4vUqND1KsTiy6JhgpTz//ZJJO0VhGobN2ayZaQKgOZ3bUe8tpTr/EB8fPgCbXYLll5D9RQb0JjBnAdlAbqr+uqxPxHwqzJtHHT9/vYfUG0ueuaV7gfbReOvkCvel4on8o//47xaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204399; c=relaxed/simple;
	bh=RhHhLz0ktvn4Y5cTid2w3gxzIwhfEm+oxBirNRiAeNI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjHtRWmJZ0h1U7RZJ7+vqaada0yotEUJnFS7IafDIOv04FeVpawCtTd4Hb9HBjjq/PEtFQVn/eeZQGDgfbU1u0z45dhAiihlsQNyjlSgvWvw1bTsEVLjzA5xnbCsXVAqDfywJwvuEs04ZpcMcoVQaMQDz7ccYExljp8WD4HiZs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYg4Sawe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYg4Sawe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779204397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RhHhLz0ktvn4Y5cTid2w3gxzIwhfEm+oxBirNRiAeNI=;
	b=XYg4Sawen8H2XrNUhdqS2J+AIsTMXJUaZBnXPIw+xY6hMlC3bJ2aNt2wJd5rNgBSBZ1hDZ
	Pr+dqEfL8Rg/bcgXoj6E44ufruYQQlHB+HH3dtC3UzUwlZQVfxA2LDKKBNAik1NtDdtsow
	jZnlucaidZzg0IGntojHH+ThlnJu9Qc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-rEY3yyjhNFiFN5T7yZj7Ng-1; Tue, 19 May 2026 11:26:35 -0400
X-MC-Unique: rEY3yyjhNFiFN5T7yZj7Ng-1
X-Mimecast-MFC-AGG-ID: rEY3yyjhNFiFN5T7yZj7Ng_1779204394
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45dbbbf8d57so5338387f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 08:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204394; x=1779809194;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhHhLz0ktvn4Y5cTid2w3gxzIwhfEm+oxBirNRiAeNI=;
        b=b79PL09H7R+RRxoxdoYRzF46fS13jW2tH4arE142MrC9KMacKTp87CjGw1rwwH0tYx
         afKHJFMYJoz8vFtF0RTynr+5AhfD+YkiCg3L+sxKCxWvSw3ufWz4n4nsIjyuqM3v8Nd1
         FMzDv/GJUfGk7Y+xa+c6XWATjj//4Un0ErxiHkPtZjPsscuzyxaonTzpeFiN41IArXnw
         1/VtlBbI9uTGVRBQwB586k910DEIODeR/dIEMYoeRCrqsdvk+jVYUWDtheQadJ9N888u
         nKSSRKRFAn4LjwaduUXQU/Twjayn35U7x/wiQfUrwAY7e9B811YBWWyUwC2+PblEEFk9
         e2+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/jzqigD376bCJmtl0Hr2XFussr1LGLF8/5Qg6kfy7RU8BTBthdn4eJS+Mf7BLDcfnMoCht2eB+mT9gWqIvFbaWdrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2OT5WLK6zFMK6ukES6jfCCHexCjhMckd5tcg4ElngfD67TBB
	Ymf+fMVub/8UODZEjo8dtblC2RL+3o5CEwLg05Ps3ea77MiSlWvZFoQj4VvF78fz0K5s4jLWl4Q
	E5xUiy80gL8Lm8/j9351KxgFL8AYNq/Kcwyw9jyjJpfJ8d21TR2emIEZA7uF31nJwNu8Wrtm03T
	DZ813OgdSD
X-Gm-Gg: Acq92OHPEa/6NVablaFJZXNn0TXHXVo5IB20OQPcjwm78vYka++UAoYA9cQhJxJeUrF
	OAfPVS3T+KuD/ul71cfXr/r22TkLzWeLhx/Y/r0CDLXPRoJvKJl5lHlhlWyo4W5mX2XyykXKe0f
	YwKEqwC00ustjCGvFJOGiVenNGA7K+NdBlPcqTeJJYllf8MQ6sa1GIONVsTGuheX5+odZOiz/Cv
	mqslLsZ4GT9OG3Nr0gUy5oqYTzIajiJT/tf2jj+NOE7hRmk7/n2zRhHJfZUg2FeHDORjuHKFlZ2
	b+SF+iHmIvSQ9EL/ZDHWXfBxIJCM5mqwa2KbZfZnEc9QqKiUw1OklPiCw8hv7fX34z5xPLdq6lb
	h6w4kef4xU0ap+ygmcfaQa2Xz7oVEWcPuusmpSV2EDhu3pvnJeCExmtKAkZ8Ag1X7hmNcvRvisg
	zQyiNLA1L69WhEa4g=
X-Received: by 2002:a05:600d:10:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-48fe60e7d79mr253400295e9.8.1779204394107;
        Tue, 19 May 2026 08:26:34 -0700 (PDT)
X-Received: by 2002:a05:600d:10:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-48fe60e7d79mr253400035e9.8.1779204393723;
        Tue, 19 May 2026 08:26:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48ff2cb4ae0sm159772365e9.0.2026.05.19.08.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:26:33 -0700 (PDT)
Message-ID: <2d19140a92df11d28f9b74e4a370f55940e042f1.camel@redhat.com>
Subject: Re: [PATCH 1/3] rv/rtapp/sleep: Make the error more informative for
 user
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Tue, 19 May 2026 17:26:31 +0200
In-Reply-To: <87y0hf2zj9.fsf@yellow.woof>
References: <cover.1779176466.git.namcao@linutronix.de>
	 <14242f444f7d2396c0c5a345f0099665d09a0ec5.1779176466.git.namcao@linutronix.de>
	 <19cffa1267c6538e6310b0149b0367807af76ac0.camel@redhat.com>
	 <87y0hf2zj9.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -6ujwivkxQpwi2TscFpFsnKOqIZaKYTLLLsZ6dn2fm8_1779204394
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-19 at 17:24 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > On Tue, 2026-05-19 at 09:49 +0200, Nam Cao wrote:
> > > The rtapp/sleep monitor detects real-time tasks which go to sleep in =
an
> > > real-time-unsafe manner. If this happen, the monitor triggers a trace
> > > event
> > > in the sched_wakeup tracepoint's handler.
> >=20
> > Ok so here WAKE is no longer tied to the wakeup event but to the end of=
 the
> > task
> > switch.
> >=20
> > So what happens if a task was not sleeping but just got preempted? Woul=
dn't
> > that
> > trigger WAKE (though that isn't a real wakeup) without RT_FRIENDLY_WAKE=
 ?
>=20
> The monitor's rule says that when a task sleeps, it will not wake
> without rt-friendly wake. If it "wakes" without initial sleep, it is
> simply ignored.

Right makes sense.

> I can change the name to be SCHEDULE_IN or something like that to make
> it clearer.
>=20

Yeah that'd be clearer, or at least a comment stating this somewhere.

Thanks,
Gabriele

