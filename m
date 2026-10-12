Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35FF1624D5
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Oct 2026 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806314; cv=none; b=N1fMdDcVTM3YZU0H11DIoGrp/5cNfZWHIMFhazumhySAx6bpTpiSzhV66sfaT7WMkLTnEpnNlF02CGl9SdrXPCGEBbWMY5qgbnCLvPErCX6mL1GdYjsq48EcaWCAbSgaI3+uwIm+NPYt/k6DzTp7p4x7U6HYyZVj961Ti3mlHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806314; c=relaxed/simple;
	bh=ZN1vayRctHh8NpBgSGCZwcKF9qbdnQM1w14tC/GzSnc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOdEQf26OYPazEGzUzGzWWngFzwW4nXKWY7ky3PQ+lYaScDPSK5I0tm1PRXPflAF9uFqNVng6Vu3d1wytNzSuwiL/tNPUf9ETi1jNnfn/HDlji/wvxI+ObpLtQB0pideime/A89GPMNylqbUY5q4KZzxM3scC4DQcWSuJvfk4Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/6H7R6t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/6H7R6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791806311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZN1vayRctHh8NpBgSGCZwcKF9qbdnQM1w14tC/GzSnc=;
	b=C/6H7R6tIE4JgyLHOq/Ceps0ljVDhSXetsF/S0fg9Gd8wpMtK79jW9sz4T4BH+cF35Cip/
	PlCgDxAB10Wwp/Lkod6k+UL3RG3pwD9uX8UgavhrLGA6RVK3McJhBi/tdig7hgGM+fU+kJ
	jrQLRAOoBDH+2btLsaJUtBPPGiNa8Eg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-beSfXaFrPI2NyJxy1vKqZQ-1; Mon, 12 Oct 2026 11:58:30 +0000
X-MC-Unique: beSfXaFrPI2NyJxy1vKqZQ-1
X-Mimecast-MFC-AGG-ID: beSfXaFrPI2NyJxy1vKqZQ_1791806309
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a028616bebso12167345e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Oct 2026 04:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806309; x=1792411109;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZN1vayRctHh8NpBgSGCZwcKF9qbdnQM1w14tC/GzSnc=;
        b=hcJOUNMcPHyE5KeUdz4aZAEs530crMF0+WKzorgXmIrqopcG+uyseeVedd4TuKoNC+
         tjXvKDb0BbtnE5v83JdleBdSinSbS2+jSD1NLftzxKYm25ncKXNm44HtJ8G9Ragilc3k
         EPWjiHeMaLk0rlglIR0HEZry8+qFqIaSHR0FqUPjWuUXJzEH1u93PcwGp8GhxJD+wivY
         IN4g9aArlUE5J1FoM5VflG3NXfLjb4WD+3LagO2128BaxiQWoG04p+Itpz8NaBpwHmCs
         wTe9dlfuIIXBkvMKZBN+K79JjOl+MZ/Ce9tr0Pd+PBD0LPLaxg5JhPI/WZobtdnIR9wG
         2jVg==
X-Forwarded-Encrypted: i=1; AKwUvBwf9dGfES8tx1ar+rydaH+nh4CM6twfyVgB2iNpHoNBLJuSI5bYm/TEgOpCdqvskqV+M68Kg9BesipBUayvRr9fwVY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZAp8f4jTmCivC3O7Yejb0bwLC5XKoHh9FjjwytGY5Rqpf38ya
	3pBowE33cbUg1wIkz3upPHRMYEPyDQOYWw1scSW+7Dw4gQ3+4OAOh0SwH9DrjAl/DKx5nxfqQyP
	6rMGUSyxXWzbZ8xZmER0rWpSOLXbtdO62pSlCkq4YA1iSgJhqAEGW2GC3wV6E+UEmXCYzvjTenw
	==
X-Gm-Gg: AYBFou14g7HoMNAfHoXz0gLLHJKwRph9o9BoGqPTDQ/tbuqMHABUaMuO4nYShX19Avx
	XkiBhpadwijTd9fcsmAyV8d3E6VTrGX7IyNK7hU0zg+kTmcGY8Atv1tHmjL5jNji78qai0hRMof
	19Oo3I4sBOeNrskR5PY8V5me4EvXwXuRsJP4LRYbspyyka36UVbpZQjRO8r91mrVV0PDKnAsMCA
	a1ImYKiWhL+BcJjcLZaNB+jNBfkRDy1NnhipZG+yAg/nPaxadWaSduriUq4duvjJZan5oVAzckd
	kPQkzQrSrSdvTGP1tST2WqKMSx8mRkhhow4gTxq/K30w45mkB1YzDEAvUApAzyOk4Kvg460G2Rx
	UPRTVFv2qelxdliat/joohOkemaRO
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1419 with SMTP id 5b1f17b1804b1-4a18e4cd667mr171082675e9.26.1791806309389;
        Mon, 12 Oct 2026 04:58:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1419 with SMTP id 5b1f17b1804b1-4a18e4cd667mr171082355e9.26.1791806308919;
        Mon, 12 Oct 2026 04:58:28 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db94e33d2sm20228336f8f.9.2026.10.12.04.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:58:28 -0700 (PDT)
Message-ID: <3eb0948c9ca67f64b3b311f823cd0f7628033c68.camel@redhat.com>
Subject: Re: [PATCH v7 00/14] rv: Add task latency over budget RV monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 13:58:27 +0200
In-Reply-To: <cover.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r7GtsTALB7OkdBsHqp7EYloCBIycH4wEZa1QqFNWDgo_1791806309
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-12 at 03:39 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> This series introduces tlob (task latency over budget), a per-task
> hybrid automaton RV monitor that measures elapsed wall-clock time across
> a user-delimited code section and emits an error when the elapsed time
> exceeds a configurable budget.

Hi Wen,

there's been a conversation at the LPC conference about completely migratin=
g RV
to BPF.
While we aren't sure of its feasibility yet, and it will take time, it's
something to keep in mind for new contributions.

First of all, would dropping RV in-kernel support negatively affect your cu=
rrent
workflow?

About this series, completely converting it to BPF isn't trivial, I can kee=
p on
reviewing it and we could upstream it in-kernel, then convert it later (tog=
ether
with the work with other HA).
But I'd prioritise not affecting the in-kernel implementation much to keep =
it on
par with the BPF one.

I'd first like to focus on what should the rv userspace tool support for a
monitor like yours to be useful. You'd have all reporting as stdout (or any=
 BPF
reactor you'd want to write), then we should probably support some way to s=
et
the uprobe location and threshold before loading.
Would you really need dynamic uprobe addition?

What do you think?

Thanks,
Gabriele

