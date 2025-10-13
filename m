Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828742AA3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356324; cv=none; b=kxwFwbG8X5XHKy02fAR9gnurFlsCUZIKl0du4hY0fsJh3nbOJAebeWxbXkJnd2HpBb7ZoQaFL8RObw1avSsDZ4lE2wN9d4wvGgIXjOM+nk2dEvZznmS+lu50pdNSlC0VY0F1bhYoMOUCxYCy/tnS75YbuXpXU7J3M4Xebm0ksPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356324; c=relaxed/simple;
	bh=5ktdav36oYdJcqDA6My9s883MNaXSOg6GE7sL6+yOxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JX4c9k7PrPUgAqWggQtoJ3G52o/mpPMjjPRuc+oiJPFJUoQdMbbDmBIDX5h3ZdfgdXrVVkddp/cYcrrFCTL7SH/unMxqQmzLA0cu67EvkJKJD4au7nQH1ngzkxg46wAYWLORmm86HuId1wv7sku6vCzO4wgZlsznmtctx9E6JHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKk2ueVw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKk2ueVw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760356321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5ktdav36oYdJcqDA6My9s883MNaXSOg6GE7sL6+yOxY=;
	b=ZKk2ueVwit1tvApZIico9dVeKJ4YGqAai8f3A3XZGPXVzaCEv4PIBFDLmNRxuLK6seL1Nx
	bJS6geBJF/YCIXNh/puMJgsu7D2N6oCqwpl8pPPiKdZAiSCH5qq6W0iR+Nr7tainJs74DI
	28J1R563OOYP2SwFed6Bf1sJcvqW0bs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-xRXHZSL1NHWn7UWMl1w4AQ-1; Mon, 13 Oct 2025 07:52:00 -0400
X-MC-Unique: xRXHZSL1NHWn7UWMl1w4AQ-1
X-Mimecast-MFC-AGG-ID: xRXHZSL1NHWn7UWMl1w4AQ_1760356319
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e3e177893so27140365e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760356319; x=1760961119;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ktdav36oYdJcqDA6My9s883MNaXSOg6GE7sL6+yOxY=;
        b=aQzepQMRQmAH/ARXuyTYOMrFW8oqVxFyPiM1VmIL+ah2maadms6bF6fwhA1Fw+LR93
         vn1QAjdjc+RSbWl5c7pFjuGKkISOejog1hYMY9kpHf7dtGl/c5oZ67SmMFRdrGOmOuzR
         7r7Cf2+A4u/IrP2cmAzYw2EwDVFn0MnvlL4tceXKkBnnc4ofgfZ0jrdlohVA683k1fhB
         EokKhhXDom+eC6GqQ/HO+wjmMapPfmYrNeWjyi9rJYDAuDLfGD40RraG760YfFNmPrKn
         VtwGywmjoK/JmxLWjMdXdmjlvDRF3+mPPiFzh2ecwKqTFyD5yQpgAWaefaNe1ifm4F1D
         wZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLB9Wwa4tBRf87vAa838RSf+4zH+6gFVd2KVsAqeIX4QvNgxViKOm33hVU0LjbqOm0uugt9NvmoPQbwMv83LiSI4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxag2WdmWjAI73kSBLt+RB48AF8Syz+gZM+y8ykHGSzLd7oODd0
	B+bSy/31LgSGE94Ypfq3lTsXFTAb26XdWsSxTCPIZPtRsyuhS7v4Ed1zVFXpDBfZ1GfRcBZQRQn
	Gjv678utQKiRyok3O2sd/Rxsqv+yBr9F32G6P87BPMTsFg+vvBQ8htQkJlBPMUO5XRAVQsWDEJp
	d9/V4FSKnk
X-Gm-Gg: ASbGnctqO0mOivVG2LzoGSIZl9Mo9Xo1uEV9F2wyOe4/M+DytxXvNsxSmpvQcp4nGQm
	O/4q8dtCGkq1xWzxYMM4SxP5HWRJd+Iqb4jYv2gGn+5uBWO+avHGJNBRGYpDc2TtAICp54vi3zl
	V1rkNYl7bce01jt3A4fQPeuJlU/g99iZMcWSZeHArkBkzrE5ghaY6i+6EZW6lrbE+As9vIjsPup
	pJw+pXs+tV5ktB+7cp4FB5GOSD5SNZvE5Hf/1rii/WS6kNQlGb2CkiuX6hjHlfxzAPCcnbbfNlo
	8K6RGoaDvb0WH22rdaPIpLvd2DrASPRVpNDa1aIiZFfBdYp1JH5sYzLZkRnQPbJE1b2Q
X-Received: by 2002:a05:600c:1383:b0:46e:330a:1762 with SMTP id 5b1f17b1804b1-46fa9af1697mr144923995e9.22.1760356318928;
        Mon, 13 Oct 2025 04:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBQpARqDOhgdRULDkvfVrdX/nnJcPItjHHJgTf6QftjMtGStmELASnMi5DCd1IOYQRiBjoDA==
X-Received: by 2002:a05:600c:1383:b0:46e:330a:1762 with SMTP id 5b1f17b1804b1-46fa9af1697mr144923795e9.22.1760356318519;
        Mon, 13 Oct 2025 04:51:58 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426d0d9050bsm16400021f8f.13.2025.10.13.04.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:51:58 -0700 (PDT)
Message-ID: <03365f64c7f94daa39bcc7df45cac2928af2a570.camel@redhat.com>
Subject: Re: [PATCH 0/2] selftests/verification: Add initial RV tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, John Kacur <jkacur@redhat.com>, 
 Waylon Cude <wcude@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Mon, 13 Oct 2025 13:51:56 +0200
In-Reply-To: <20250926094613.34030-1-gmonaco@redhat.com>
References: <20250926094613.34030-1-gmonaco@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NSkiGFdAu_twNF9kj2Znol0XNZxA0oxyqdo6NI1Pwes_1760356319
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-09-26 at 11:46 +0200, Gabriele Monaco wrote:
> Add a series of tests to validate the RV tracefs API and basic
> functionality.
>=20
> * available monitors:
> =C2=A0=C2=A0=C2=A0 Check that all monitors (from the monitors folder) app=
ear as
> =C2=A0=C2=A0=C2=A0 available and have a description. Works with nested mo=
nitors.
>=20
> * enable/disable:
> =C2=A0=C2=A0=C2=A0 Enable and disable all monitors and validate both the =
enabled file
> =C2=A0=C2=A0=C2=A0 and the enabled_monitors. Check that enabling containe=
r monitors
> =C2=A0=C2=A0=C2=A0 enables all nested monitors.
>=20
> * reactors:
> =C2=A0=C2=A0=C2=A0 Set all reactors and validate the setting, also for ne=
sted monitors.
>=20
> * wwnr with printk:
> =C2=A0=C2=A0=C2=A0 wwnr is broken on purpose, run it with a load and chec=
k that the
> =C2=A0=C2=A0=C2=A0 printk reactor works. Also validate disabling reacting=
_on or
> =C2=A0=C2=A0=C2=A0 monitoring_on prevents reactions.
>=20
> These tests use the ftracetest suite. The first patch of the series
> adapts ftracetest to make this possible.
>=20
> The enable/disable test cannot pass on upstream without the application
> of the fix in [1].

Steve, Nam, would you have time to have a look at this series.
If possible, I'd like to get this minimal selftest to next together with Na=
m's
(urgent) patches.

Thanks,
Gabriele

>=20
> [1] - https://lore.kernel.org/lkml/87tt0t4u19.fsf@yellow.woof
>=20
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Nam Cao <namcao@linutronix.de>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Waylon Cude <wcude@redhat.com>
> Cc: linux-trace-kernel@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
>=20
> Gabriele Monaco (2):
> =C2=A0 selftest/ftrace: Generalise ftracetest to use with RV
> =C2=A0 selftests/verification: Add initial RV tests
>=20
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
> =C2=A0tools/testing/selftests/ftrace/ftracetest=C2=A0=C2=A0=C2=A0=C2=A0 |=
 34 ++++++---
> =C2=A0.../ftrace/test.d/00basic/mount_options.tc=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> =C2=A0.../testing/selftests/ftrace/test.d/functions |=C2=A0 6 +-
> =C2=A0.../testing/selftests/verification/.gitignore |=C2=A0 2 +
> =C2=A0tools/testing/selftests/verification/Makefile |=C2=A0 8 ++
> =C2=A0tools/testing/selftests/verification/config=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0tools/testing/selftests/verification/settings |=C2=A0 1 +
> =C2=A0.../selftests/verification/test.d/functions=C2=A0=C2=A0 | 39 ++++++=
++++
> =C2=A0.../test.d/rv_monitor_enable_disable.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 75 +++++++++++++++++++
> =C2=A0.../verification/test.d/rv_monitor_reactor.tc | 68 ++++++++++++++++=
+
> =C2=A0.../test.d/rv_monitors_available.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 +++++
> =C2=A0.../verification/test.d/rv_wwnr_printk.tc=C2=A0=C2=A0=C2=A0=C2=A0 |=
 29 +++++++
> =C2=A0.../verification/verificationtest-ktap=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 8 ++
> =C2=A014 files changed, 278 insertions(+), 14 deletions(-)
> =C2=A0create mode 100644 tools/testing/selftests/verification/.gitignore
> =C2=A0create mode 100644 tools/testing/selftests/verification/Makefile
> =C2=A0create mode 100644 tools/testing/selftests/verification/config
> =C2=A0create mode 100644 tools/testing/selftests/verification/settings
> =C2=A0create mode 100644 tools/testing/selftests/verification/test.d/func=
tions
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/rv_monitors_available.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
> =C2=A0create mode 100644 tools/testing/selftests/verification/verificatio=
ntest-ktap
>=20
>=20
> base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe

