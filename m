Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53940862C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615058; cv=none; b=IYo5CnwZ1nNM+sgvhbB8xPT/xAurbDejbeLhKDZVzV+iNTG7bSGESCt0AfaQ1m2mXrX8zq0QufGZdph7r//1eKGvgUZ/IDsYqNMqj84JSflfgzlsTPe0UlaDOLTYAd00YaAV2KTmkITsqUjtPyelV63YKGn5OxnDo7f61TTP4CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615058; c=relaxed/simple;
	bh=bfax+2KJbFjV5ZptSBfNYeoHIi7P8ef4MwYnvZ+m+DA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bdy0aPIx+Udp4og8+cSmTiux1DmYcnrTmqPQJzR0yaxj+tXkFLE56dPiMowzzjt6Ak7iT5WQNjd54/Mm3iLx3nITI2DasS/bMMWIfno6YLYZ34dSJt+/VjW/lDJdmXrkXaYnq169StpX7m0LFvnw9e7NzMWqdYhuYUW0K002JbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnHmsSQC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnHmsSQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784615055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bfax+2KJbFjV5ZptSBfNYeoHIi7P8ef4MwYnvZ+m+DA=;
	b=hnHmsSQC6J34WOJw1F5ufev+KKnloI/AMtCU/pvycelZcCphfgVut3Ix75y+EHVgJOT7+k
	gmQNwz6ORymGHedwRN1ZBe2lndJENuvzR1jV7S3/gyKEkCCDza4pMWBNCh/YVDihi7/6Zo
	1Jlr+y5R/Xji58MK98QYDfEz9kE6XIs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-DELTE9mrO4ifaA1iWGqVcg-1; Tue, 21 Jul 2026 02:24:14 -0400
X-MC-Unique: DELTE9mrO4ifaA1iWGqVcg-1
X-Mimecast-MFC-AGG-ID: DELTE9mrO4ifaA1iWGqVcg_1784615053
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1662ffbf57so805564166b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 23:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784615053; x=1785219853;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jYnrNqtg0uUUimLa3WE47ERp3Pp2BbcEKlJ0al7yA2s=;
        b=V2JQsA+U6fs/JVR4NTN0a3LGqDJLRszpncGVQBIAWBlWgWb94BMgpjyV1SKe7uwZTF
         XYj2L1Vq4SOYDpfBeRK24ozj4fAR+omkxssqN9UfjODbTCPR5Q5BT5l3y+/dsXUHR7vj
         TRD4NbB5ZkfzqkWMM2FAXHNbsMQCqJbWQOPa/kKEoBAitmznBLa+7szdt9sWZZ1PYCbM
         QgPZfhuvlxLj/JAxBeNB7LwzhbrsEBZPk0bjh3brEU+JjfLVaHFfDi5cGHE8f6yFV9nV
         E+T3PpiFhHCJjXL7j3ZecU3EzeG/4cblCNsS02+hstD6pkV8tjZSUEmfEeJx9ZA7Go3E
         llVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqgCcp16fHGSHhSO9seIVQtLa10moqb69lxBsNYYkiX9jfPT/ZLybRsoN5fmEH4DATjSfWjH9UcAKh6V9q4fiJEN44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+QA8Y3CifeqBuiMc3o5WG39BHsPHHw6NzX6z0/jaNHp0Ko1x1
	onGNli+MtLhJ4Wr/oyDKXw8GtAj/Ew4Ke/9rizqY3KK0s/JwmmpbpyDxmGBEW2qWrlodCk+w7Or
	ruBybmei4LCG3DYoiBH0DU1t4t8u/LHyDThbzamFKuG+XjJKpq3M907nc57rWIDVwNxCfhYnJLw
	==
X-Gm-Gg: AfdE7cleA+IapIc5F8egW4g2cB3thC6gFwId8eBmk+FhCH0hm8ADhTc+YZHnf2FUsrg
	qn/zeCOE0g/iXd1fOY6vm4gqJh6M0AZy0BaiCos0V7WNoMjIpAX/B028rqzHUGjk/WDKtSYuqFR
	QAVBucBD5XE0YTzikPdhml0gDowbnM+WprjC4OW3uWWEbUWwMkJQxhqzhzz3Yss4zwwR8BEpdv1
	W+qGi+KwwVPTGpUyi9BbFmB2CGte9WrZvGUhbqnx4ilhzgx2HMrhwxpkJzDfB02RnCbDGeZZG5q
	+W0wU57tzdb7U+MCXL7s6S1uqkO/N4d379ZUMlvg/YFGDGD9sc3+u/1QOgwpSGL8C9C82WkXWVd
	njfWxjjT2dCHrGpucCicsY5ocd0vANEaGnZ//tzB2h/FoWmP1jOJyRHuauPqfIDUq9nzB5g==
X-Received: by 2002:a17:907:8b8b:b0:c19:6ac7:89a3 with SMTP id a640c23a62f3a-c196ac790fcmr315190166b.37.1784615052970;
        Mon, 20 Jul 2026 23:24:12 -0700 (PDT)
X-Received: by 2002:a17:907:8b8b:b0:c19:6ac7:89a3 with SMTP id a640c23a62f3a-c196ac790fcmr315189566b.37.1784615052647;
        Mon, 20 Jul 2026 23:24:12 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c17009ae10fsm549472666b.10.2026.07.20.23.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:24:12 -0700 (PDT)
Message-ID: <3c4b83ceb8df81aaefd93404c4d69063db965004.camel@redhat.com>
Subject: Re: [PATCH v4 16/17] selftests/verification: Rearrange the
 wwnr_printk test
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>, Nam Cao <namcao@linutronix.de>, Thomas
 Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur	 <jkacur@redhat.com>
Date: Tue, 21 Jul 2026 08:24:10 +0200
In-Reply-To: <20260717154638.220789-17-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
	 <20260717154638.220789-17-gmonaco@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dkzfFLITbqz8C6iuedIucvTP61bvupNC85MjIp6A6n8_1784615053
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-17 at 17:46 +0200, Gabriele Monaco wrote:
> +# loads may flood the ringbuffer, wait for all pending printks
> +wait_dmesg_flush() {
> +=09local last_before last_after=3D$(dmesg | grep "rv:" | tail -n 1 ||
> true)
> +=09while [ "$last_before" !=3D "$last_after" ]; do
> +=09=09last_before=3D$last_after
> +=09=09sleep .3
> +=09=09last_after=3D$(dmesg | grep "rv:" | tail -n 1 || true)
> +=09done
> =C2=A0}
> =C2=A0
> =C2=A0echo 1 > monitors/wwnr/enable
> =C2=A0echo printk > monitors/wwnr/reactors
> =C2=A0
> =C2=A0load
> +wait_dmesg_flush

On some systems this may trigger wwnr's reactions and run indefinitely, I'm
going to send a V5 moving this after turning monitoring/reacting of and add=
ing a
timeout, just in case those switches don't work.

> =C2=A0
> =C2=A0echo 0 > monitoring_on
> =C2=A0! load || false
> =C2=A0echo 1 > monitoring_on
> =C2=A0
> =C2=A0load
> +wait_dmesg_flush
> =C2=A0
> =C2=A0echo 0 > reacting_on
> =C2=A0! load || false

