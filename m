Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898CA33DEF1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035758; cv=none; b=jP5Yggd7swp717QXnc9y2NqpeqrH/47sjI7OAGpbU731HzoB9qZRuS3ylsbe0Khdnvq4SD3GnIENHqrV30abvdGG3Z4adSnqkQ2o3ouwbGp3BbLEseqpHLiNbB6V1GE5Z/ooqr4kSJWnDd+BWjGt/2QhvIozY7h3+EYXd2vahw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035758; c=relaxed/simple;
	bh=sY0woISfq0V0vLn/UEhUhuUgg0pLJ+quj72pABKu2kk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PORViCEPwFAiqJzi7MNRwLMFjl9sUehpdAFUwkovEOxhg3VaSUkOMBFEw2U4N1GHBgNqjhFgaXH0dgqCX7arXzerhGYqupKidW8nnL35R1ZiipW9RJVYlciBLBtTzwdYdi0jjG+O5ywlOrPY3yRhVYXgEKThv7BOFa1k8OHHtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRCiud2H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRCiud2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763035755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sY0woISfq0V0vLn/UEhUhuUgg0pLJ+quj72pABKu2kk=;
	b=fRCiud2HFYBEVA0ZEXr1DJDVzHJGc2r5zVM1K5+qucYUzG9Rp/279F9H1Wegl4DFfMg1IF
	ALLNwWTibWai1ahwsjG5UVAPzTCxVqZpc5XuNK+FTY1T9fEwZISAU0ZmZ6+KGeBtk3wEDu
	jJcN12pb0weM9wOmI2ABGMIndEQFqN8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-076WsWyIMrOrwmk9C6p9FA-1; Thu, 13 Nov 2025 07:09:14 -0500
X-MC-Unique: 076WsWyIMrOrwmk9C6p9FA-1
X-Mimecast-MFC-AGG-ID: 076WsWyIMrOrwmk9C6p9FA_1763035753
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso870698f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763035753; x=1763640553;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikaLXIGQ5TqU8Nok4kXMEcM1jtaKJmmuJC6cwYTsLBQ=;
        b=M1JUSexMkB039rT3m4j2bw3XGbph6E0HKIIc59gnQTDOYMoHv3YdSJT7WDK1i/YVZF
         W6j58kqjDeSVTfEXa+mi5Yk8VoTXMD+CfpX+RQgYNRhRbe09NXMWT4/E4Cyh2SSgZufB
         YhZnbSiiofA6EVyJ6I1CuM0tJhRw5vjUZjVdKfNj3TgNC0bBE30gxpI2ExY/d145EB7c
         lO1nqhkvr3Z3p2/ZX0up/lNGfLs89S3LIeHJQC/jTThbtqdnUJ9kntuWEvSG1/6BW9W0
         SpY7yMlkp0X4BswbbtHZJW3wcAFrMeBWzAxANou66m84TdnmmKeeuANPHuqtan2alo6e
         VMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6oD+GiHC5NcCLzPVTUaLfaaboMQSTbsFQF6xHsJhnpnInd5vgtJALLXpjg4gt0X56Zyj35AtVsztQlvltbNQVO54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7u80gfTROXKwHfG7O8mu3p3OVcsqIV1rinixzazJ/tOT6nRmC
	/QMQxefRe9D0RN2GicZTL366gmDzKfHO94oTFx7HtYHxxAQPP2ndCfSWAjpFgEw4TQM/3R7WjcN
	C8ZVK/s3Ng5E0GBjv/bgLbmlioZgFnauMM1FTwj5pViI72dhF9U6+aqKExRgamqPcWNr+nwOT4m
	d4kDfpKDon
X-Gm-Gg: ASbGncvVKF/4tUUe0JeXtEvUqtYPLE54vk0dew34MUhBjWvf8UfZ9zJSMCHUXMWHI+y
	8U9il5A1zE809Kvex1BK9vNferLJNHFclfavdYVTdLB5xnXYUuqu+lgwmxcSaBVLQfK3mwVKcqY
	ETWXNDr0e3sX/y9h7S42di0y3o/wYsbU/rISEXb4Kbsx1uhRVVqfADYxLHSUGGtO4YbfTwCMaV/
	8AIy6p4EPl+0rBz1UQyL2uo4mVEAe6nOM4x/dfAHtnbPQvXiDjo1oRIVe5v/uTpeeHS/twDTPjH
	Zr+HNPsk9ZBfp+j3PRJZZGNBvBiGRBoMO8RLA1JcIL7p0jtEEnTHXhSuy4Fmx0Q22/KDipX7OH0
	TfFIjyaPN9sQaIbS5OIACDOOs
X-Received: by 2002:a05:6000:1785:b0:428:3d14:7378 with SMTP id ffacd0b85a97d-42b5282196fmr2721175f8f.24.1763035752848;
        Thu, 13 Nov 2025 04:09:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8kSf8/HWLajZCzeWCLm4U+G4OZ9zpyrvRjbuNV0w8OAhYY/jairpBHIN9CYlyZAFMRB8qJQ==
X-Received: by 2002:a05:6000:1785:b0:428:3d14:7378 with SMTP id ffacd0b85a97d-42b5282196fmr2721145f8f.24.1763035752359;
        Thu, 13 Nov 2025 04:09:12 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7aea7sm3535591f8f.1.2025.11.13.04.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:09:12 -0800 (PST)
Message-ID: <18f2704de283202ce1d634103bc480ad144f4e11.camel@redhat.com>
Subject: Re: [trace:latency/for-next 3/5]
 kernel/trace/rv/monitors/sleep/sleep.c:219:26: error: static declaration of
 'rv_sleep' follows non-static declaration
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Nam Cao <nam.cao@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel
	 <linux-trace-kernel@vger.kernel.org>
Date: Thu, 13 Nov 2025 13:09:10 +0100
In-Reply-To: <202511131948.vxi5mdjU-lkp@intel.com>
References: <202511131948.vxi5mdjU-lkp@intel.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ozXAMff7VNVTTwk9sbI2E4VJHqIDWNk6soXKo9tzK6Y_1763035753
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-11-13 at 19:41 +0800, kernel test robot wrote:
> tree:=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace=C2=A0la=
tency/for-
> next
> head:=C2=A0=C2=A0 69d8895cb9a9f6450374577af8584c2e21cb5a9f
> commit: 4f739ed19d222de33b19ca639a34523fbbec20d0 [3/5] rv: Pass va_list t=
o
> reactors
> config: arc-randconfig-r071-20251113
> (https://download.01.org/0day-ci/archive/20251113/202511131948.vxi5mdjU-l=
kp@in
> tel.com/config)
> compiler: arc-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20251113/202511131948.vxi5mdjU-l=
kp@in
> tel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion
> of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202511131948.vxi5mdjU-lkp@intel.c=
om/
>=20
> All errors (new ones prefixed by >>):
>=20
> > > kernel/trace/rv/monitors/sleep/sleep.c:219:26: error: static declarat=
ion
> > > of 'rv_sleep' follows non-static declaration
> =C2=A0=C2=A0=C2=A0 static struct rv_monitor rv_sleep =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~

My bad I didn't test with !CONFIG_RV_REACTORS, is there a reason why we'd w=
ant
this non-static?

#ifdef CONFIG_RV_REACTORS
static struct rv_monitor RV_MONITOR_NAME;
#else
extern struct rv_monitor RV_MONITOR_NAME;
#endif

ltl_monitor is included only by the files defining the rv_MONITOR_NAME, tha=
t's
definitely static as far as I see it.

I'd go with a Fix like this:

diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 00c42b36f961..eff60cd61106 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -17,12 +17,7 @@
 #endif
=20
 #define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
-
-#ifdef CONFIG_RV_REACTORS
 static struct rv_monitor RV_MONITOR_NAME;
-#else
-extern struct rv_monitor RV_MONITOR_NAME;
-#endif
=20
 static int ltl_monitor_slot =3D RV_PER_TASK_MONITOR_INIT;
=20
Any thought?

Thanks,
Gabriele

> =C2=A0=C2=A0 In file included from include/linux/cleanup.h:7,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from include/linux/interrupt.h:8=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from include/linux/trace_recursi=
on.h:5,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from include/linux/ftrace.h:10,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from kernel/trace/rv/monitors/sl=
eep/sleep.c:2:
> =C2=A0=C2=A0 include/rv/ltl_monitor.h:19:37: note: previous declaration o=
f 'rv_sleep'
> was here
> =C2=A0=C2=A0=C2=A0 #define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^~~
> =C2=A0=C2=A0 include/linux/args.h:25:24: note: in definition of macro '__=
CONCAT'
> =C2=A0=C2=A0=C2=A0 #define __CONCAT(a, b) a ## b
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^
> =C2=A0=C2=A0 include/rv/ltl_monitor.h:19:25: note: in expansion of macro =
'CONCATENATE'
> =C2=A0=C2=A0=C2=A0 #define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^~~~~~~~~~~
> =C2=A0=C2=A0 include/rv/ltl_monitor.h:24:26: note: in expansion of macro
> 'RV_MONITOR_NAME'
> =C2=A0=C2=A0=C2=A0 extern struct rv_monitor RV_MONITOR_NAME;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~
>=20
>=20
> vim +/rv_sleep +219 kernel/trace/rv/monitors/sleep/sleep.c
>=20
> f74f8bb246cf22 Nam Cao 2025-07-09=C2=A0 218=C2=A0=20
> f74f8bb246cf22 Nam Cao 2025-07-09 @219=C2=A0 static struct rv_monitor rv_=
sleep =3D {
> f74f8bb246cf22 Nam Cao 2025-07-09=C2=A0 220=C2=A0=C2=A0=09.name =3D "slee=
p",
> f74f8bb246cf22 Nam Cao 2025-07-09=C2=A0 221=C2=A0=C2=A0=09.description =
=3D "Monitor that
> RT tasks do not undesirably sleep",
> f74f8bb246cf22 Nam Cao 2025-07-09=C2=A0 222=C2=A0=C2=A0=09.enable =3D ena=
ble_sleep,
> f74f8bb246cf22 Nam Cao 2025-07-09=C2=A0 223=C2=A0=C2=A0=09.disable =3D di=
sable_sleep,
> f74f8bb246cf22 Nam Cao 2025-07-09=C2=A0 224=C2=A0 };
> f74f8bb246cf22 Nam Cao 2025-07-09=C2=A0 225=C2=A0=20
>=20
> :::::: The code at line 219 was first introduced by commit
> :::::: f74f8bb246cf22f27752977da62079cb615f55b2 rv: Add rtapp_sleep monit=
or
>=20
> :::::: TO: Nam Cao <namcao@linutronix.de>
> :::::: CC: Steven Rostedt (Google) <rostedt@goodmis.org>

