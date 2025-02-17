Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973D18A95A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775394; cv=none; b=tvjCASNgFFTwA+e0Lz5TVU6+b6s3mKAc6QKQyyyqXSK0HFPJtnCOSCjzJvUpLApeMrBQ4SbcQbjmhDSOGvH6dnrYcg1BsuDtg0E48YUWgP7qtjA+6JFTLoGuOrwHXF2c6TPuMvhMAF26ge4JwCneKKed56OOxH2OLKaJx1o2r0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775394; c=relaxed/simple;
	bh=UAjwm8ZUmY9NHxBX1wqkn0W4bWD5dQPw7sKcOk9oW2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZtmTnTUFc4PPsdLd42kz7uEgLJOFgv6jwxFcx8QoyAh6tjTjotqrVtzLhI2ywVFUm5JkJtwUiEq3YeRnzVr3rxKy4TUOcWbD2ESO9c3Ydc8BQjNYpfzqZMZtMWlj3yWLMCcXmV7zhlWaMJNTSaNBKDk9Q6FFA3WqyuaeOgm5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EoqEiHM/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoqEiHM/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739775390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UAjwm8ZUmY9NHxBX1wqkn0W4bWD5dQPw7sKcOk9oW2U=;
	b=EoqEiHM//hFJzYoAQge/c2LNG6TJSrUQP6uh3iprWccRGkWmE4rxJlxFNgjlq4VKvbSyEQ
	vFLKTsAqXGtZCNvslm2VXGAvyOa7QuML8nJluYzThc7AmbOHaUlqb8TDrcJoyKQZAgF1zJ
	mjN2nRHRx0rMKPToncIhz53k1id+NPA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-4RBQo7g1N7SN6b6dOjKQWA-1; Mon, 17 Feb 2025 01:56:28 -0500
X-MC-Unique: 4RBQo7g1N7SN6b6dOjKQWA-1
X-Mimecast-MFC-AGG-ID: 4RBQo7g1N7SN6b6dOjKQWA_1739775387
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-439385b08d1so33446505e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Feb 2025 22:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739775387; x=1740380187;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAjwm8ZUmY9NHxBX1wqkn0W4bWD5dQPw7sKcOk9oW2U=;
        b=KW9lOzln5bVkC7W0wIvpfGLcwqeSv7ULcpq24CbponYLzHQscWYxnX8SsDDXVPeOJj
         5JN/XYV8kygsowC87zvKntXfK0XU9sWOAYnj1coHRTRu1AWPT9vocW8jaZHPmf6qo5/h
         Gwq9zmczErvQ+OQaFGTIxLB+3xT5OouRyScli2x116yVGBBsZkan9+TM96ikjSvd2Kf/
         DX4apbyHnUt8gwfIJKQkJy9HXDJ65/EJi5TdrRBM+29uEncnkovvKOEm8Hq8rU2XQz48
         0IWUZYw5Za4w0lNu49lVDIOovt5253ft41MHzEM0PV7ju4vb6HF69AJiQUgP66PH1GmU
         5ofg==
X-Forwarded-Encrypted: i=1; AJvYcCVNKoU4eq0fvtN6p0PqrYHTeEG7+7yCmMEPAWGKgZ9MxsI49HX88vCDiRIar1BSMhuPKTkomRrkWDgZBK1oV9OswQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcRWAU4oCJWMdDXQyr5Cxo1zbiyIniv+2CkgRFYMMj/vBPA0ys
	HiNsa5lGoIR3xtQx1R+OQqdoFkar//xRbO1mOCuWGO+yfIw4R4sFN18IL3Imc56xJGOu4W7cSMK
	jQbdzmnAP070vzcpGK83rXxe7/HVGe6tHedsXMjRJ+4iqCpEEkuVr6+fRNGn/XyhtX2WmVQ==
X-Gm-Gg: ASbGncvIsRpArbaV4wOGnksxH8YvNCjRSl/dqRY2J6e2Z7V8rhmCFCiagxMMN6M195O
	RoafgEy1fofbkrWZIcFDqc2s/y7+jgq/3ANOrFqKknxjlRQkSqkni8DV5Q4CX7oq1b+NvqvAawv
	BFMq/Lz1I9D5y0pKuKR0RsSMa19ZMne9ZVANNMdhrVD6nmQ1DSrZPzNdUjutNcYQZr8Ovw3bmBI
	ja8EOAjFHDQDPQ0z21ag7jv+bu8WIDyCndNqhRyx9dTCCSaBvwTC2fwtKdyVgDI9K2DDzNR0eKx
	fNWyHuou5NkZ7KPRiISfRsm2vbuCRDQ=
X-Received: by 2002:a05:600c:4ec9:b0:439:5506:7183 with SMTP id 5b1f17b1804b1-4396e6a6e31mr75901435e9.7.1739775386962;
        Sun, 16 Feb 2025 22:56:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk3NBZALdJoBEHy/OW1hnkv7UynhyXmZFDFCyRcaZfKjwzBNYuS2O/oEr1D7pZAVFTavR1tg==
X-Received: by 2002:a05:600c:4ec9:b0:439:5506:7183 with SMTP id 5b1f17b1804b1-4396e6a6e31mr75901285e9.7.1739775386528;
        Sun, 16 Feb 2025 22:56:26 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395cf084d5sm98968555e9.1.2025.02.16.22.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:56:26 -0800 (PST)
Message-ID: <c5fe1f637a84087afb94ed3f9255810ef3975724.camel@redhat.com>
Subject: Re: [PATCH v2 04/11] rv: Add option for nested monitors and include
 sched
From: Gabriele Monaco <gmonaco@redhat.com>
To: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli	 <juri.lelli@redhat.com>
Date: Mon, 17 Feb 2025 07:56:23 +0100
In-Reply-To: <202502170630.xSYE4cUk-lkp@intel.com>
References: <20250213090819.419470-5-gmonaco@redhat.com>
	 <202502170630.xSYE4cUk-lkp@intel.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mA1FIpR1KSw9pL1BuIhlyNrPi8hyhMfPKB3nFX0GCxA_1739775387
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-02-17 at 06:39 +0800, kernel test robot wrote:
> Hi Gabriele,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on 4dc1d1bec89864d8076e5ab314f86f46442bfb02]
>=20
> url:=C2=A0=C2=A0=C2=A0
> https://github.com/intel-lab-lkp/linux/commits/Gabriele-Monaco/tracing-Fi=
x-DECLARE_TRACE_CONDITION/20250213-171642
> base:=C2=A0=C2=A0 4dc1d1bec89864d8076e5ab314f86f46442bfb02
> patch link:=C2=A0=C2=A0=C2=A0
> https://lore.kernel.org/r/20250213090819.419470-5-gmonaco%40redhat.com
> patch subject: [PATCH v2 04/11] rv: Add option for nested monitors
> and include sched
> config: parisc-randconfig-r112-20250217
> (https://download.01.org/0day-ci/archive/20250217/202502170630.xSYE4c
> Uk-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 14.2.0
> reproduce:
> (https://download.01.org/0day-ci/archive/20250217/202502170630.xSYE4c
> Uk-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202502170630.xSYE4cUk-lkp@intel.c=
om/
>=20
> All warnings (new ones prefixed by >>):
>=20
> =C2=A0=C2=A0 In file included from include/trace/define_trace.h:119,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from kernel/trace/rv/rv_trace.h:=
130,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from kernel/trace/rv/rv.c:148:
> > > include/trace/trace_events.h:477:13: warning:
> > > 'print_fmt_error_da_monitor' defined but not used [-Wunused-
> > > variable]
> =C2=A0=C2=A0=C2=A0=C2=A0 477 | static char print_fmt_##call[] =3D
> print;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~
> =C2=A0=C2=A0 kernel/trace/rv/./rv_trace.h:39:1: note: in expansion of mac=
ro
> 'DECLARE_EVENT_CLASS'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 39 | DECLARE_EVENT_CLASS(error_da_monitor,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~~~~
> > > include/trace/trace_events.h:477:13: warning:
> > > 'print_fmt_event_da_monitor' defined but not used [-Wunused-
> > > variable]
> =C2=A0=C2=A0=C2=A0=C2=A0 477 | static char print_fmt_##call[] =3D
> print;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~
> =C2=A0=C2=A0 kernel/trace/rv/./rv_trace.h:12:1: note: in expansion of mac=
ro
> 'DECLARE_EVENT_CLASS'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12 | DECLARE_EVENT_CLASS(event_da_monitor,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~~~~
> > > include/trace/trace_events.h:223:37: warning:
> > > 'trace_event_type_funcs_error_da_monitor' defined but not used [-
> > > Wunused-variable]
> =C2=A0=C2=A0=C2=A0=C2=A0 223 | static struct trace_event_functions
> trace_event_type_funcs_##call =3D {=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> ^~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0=C2=A0 kernel/trace/rv/./rv_trace.h:39:1: note: in expansion of mac=
ro
> 'DECLARE_EVENT_CLASS'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 39 | DECLARE_EVENT_CLASS(error_da_monitor,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~~~~
> > > include/trace/trace_events.h:223:37: warning:
> > > 'trace_event_type_funcs_event_da_monitor' defined but not used [-
> > > Wunused-variable]
> =C2=A0=C2=A0=C2=A0=C2=A0 223 | static struct trace_event_functions
> trace_event_type_funcs_##call =3D {=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> ^~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0=C2=A0 kernel/trace/rv/./rv_trace.h:12:1: note: in expansion of mac=
ro
> 'DECLARE_EVENT_CLASS'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12 | DECLARE_EVENT_CLASS(event_da_monitor,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~~~~
>=20

This is something hard to trigger, but I didn't remove the select
DA_MON_EVENTS_IMPLICIT in RV_MON_SCHED . As a result if the user
enables the sched monitor without any nested monitor (which is already
a broken configuration but happens if you apply this commit without the
following ones) trace event classes would be created with no event
using them.

I will send a V2 with the fix.

