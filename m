Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC128934F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756969666; cv=none; b=aFz3Mu5rUjQ8fhLXaQ8KfKiEsVWnJqnbrfRna/Y/nETkO7KIN0TciIELzhvpJaaxeJCXClncpefe/lVPD8xtUbPzu6kIT64mdTVXRcVOR70iQCSScQonAztIbbVtCWki/N/UTq0/7y2aBaJm7XzV3Brlj1wZVRjTE+XI0fAXdUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756969666; c=relaxed/simple;
	bh=DUrG6PR34cXrcYpSYxsvTL94sfC96aXBavlnY8zKEIE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXhoEvqG5B7oblTRk6gvPKob4Dyp6LGK1goMLGyPP4MdRqBf917oiCvMOT8hPzxZb3gTfiKEatS4bmtoE9rc7ZtuhP+WmkiTV3rm3ulhwf9mlTGD1kh9EKH6eehpkmCvICADNgWcjYQuONBGncXQMsNhNKa0Y/4CUi07sYiBOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z54XqH0N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z54XqH0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756969663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DUrG6PR34cXrcYpSYxsvTL94sfC96aXBavlnY8zKEIE=;
	b=Z54XqH0Njrz05TPHCns0jDbh8GSpI9gvVVXHP6lTxUoQL4Bbc3c5rgvxiHxewWIEMckJtu
	JRe/+z6ENiAS89bG0q6JCZlg6vgonEYAA8uLyW78G8Z15xwmEZ05trxqhWV5reHp8aSBJA
	rX2Kh2Or/XWCPUy8aISCfBg1Usvnt0c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-bpUIsivwNmKHoAsf93L8pQ-1; Thu, 04 Sep 2025 03:07:42 -0400
X-MC-Unique: bpUIsivwNmKHoAsf93L8pQ-1
X-Mimecast-MFC-AGG-ID: bpUIsivwNmKHoAsf93L8pQ_1756969661
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3dc0f2fd4acso397237f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756969661; x=1757574461;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RK8KRyGK3L9aFSO9gu7sW13SelZTzFglM4QC1yE7PXI=;
        b=cd9sQpjS/x3SIDTXJfqyhqERvmlIBbW4oDUedd4reht9NJIQsvnKPQ0toL+JixAkDd
         Tsh2QIMk7Kz+MrUjslsiqWxWTG0uSqkrzcwSr/84JjV0ZgiRfQA354RMhA8fU4JtbHlt
         B09mq82j6IKuocm7HDGQwFZwcC7IdaW19JYw+p5VaipfwREVpN6cgIcMt/GYSH9HUc4B
         85T0R8zcq3+SAia/Y8m4bzcad4PLGKJBysMBRfwZ9T++bGwXe79IJgKxLowATNhmMFtA
         Tsp9Qp/NAVXMqGqbJmrXh7kA+cDa9QRR5jwXydsRcL/tVyV7oUQPTA7jF7tVN4mcQQAA
         LH1Q==
X-Gm-Message-State: AOJu0Yx5UdyWABNHj2NvXu+zYACerryzCrU3Rn9HNx6pj93uJsnn7Uwt
	X+K4bIKWJyFEBLUH8SZ2XKSkTgEtyplj3ilP1d7yNSdflf4PGQYlciLIFzPWU1+thytpABc1lh7
	NXedT3Geb18jVs8lzfqwIbaR+HF0p8UVK9Q/YMjMBMGv2ABEYNYwv2S+4drpx2rUm3Y2NQ+c3Y2
	UY9G/9nhOB
X-Gm-Gg: ASbGncvjQbaOocV/jvk4ZIeWuzcSZBDm69FU9HSB/wbEkIRped4LRFRNu1K9xK68Jki
	PRoMFXYQFsHmMOVznqH2gxcvFn7BrDu6omuT0RheLWBquD3xKJQ+fDhIEHl5bKsqKpwKalY+tfV
	MXllYnqqpPDyTObLjNn4Q6TMZDeSQQq23Icee7sARUcZ8o2aRCt6Tx5B/aSHqFmB0bPhCKYWJKk
	68aQYm1b+mFxSlLbcL445396wNggOSNhMfK1pKtVEUxHgJZzFAETlI6knnILyjjB9wU7jwVN3rQ
	HsLHY3ifTuvdTIe2DW2rix5ngYQG/HAsqo8osYQS4UvYLZP35LKl4JRqYfBk08tN5g==
X-Received: by 2002:adf:a406:0:b0:3e1:7964:2c17 with SMTP id ffacd0b85a97d-3e17964361cmr348624f8f.62.1756969660798;
        Thu, 04 Sep 2025 00:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAG1gjB38L4a5W8ATy0+T7HjTHZIKgrGns44FrZQ91ODwrAyl3bQdk5UUgaAnn5EYjP5/6vQ==
X-Received: by 2002:adf:a406:0:b0:3e1:7964:2c17 with SMTP id ffacd0b85a97d-3e17964361cmr348607f8f.62.1756969660313;
        Thu, 04 Sep 2025 00:07:40 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3df4fd372c1sm4413056f8f.29.2025.09.04.00.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:07:39 -0700 (PDT)
Message-ID: <8fa89db22320220e1bc411ded115f0a40097f961.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix missing mutex unlock in rv_register_monitor()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Zhen Ni <zhen.ni@easystack.cn>, Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, 	mhiramat@kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Date: Thu, 04 Sep 2025 09:07:38 +0200
In-Reply-To: <20250903065112.1878330-1-zhen.ni@easystack.cn>
References: <20250903065112.1878330-1-zhen.ni@easystack.cn>
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
X-Mimecast-MFC-PROC-ID: GhW5h5O_fkxsXMGqZQxh3z6nD9JzNnmQ_oD8wcUD8p8_1756969661
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-09-03 at 14:51 +0800, Zhen Ni wrote:
> If create_monitor_dir() fails, the function returns directly without
> releasing rv_interface_lock. This leaves the mutex locked and causes
> subsequent monitor registration attempts to deadlock.
>=20
> Fix it by making the error path jump to out_unlock, ensuring that the
> mutex is always released before returning.
>=20
> Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct
> rv_monitor")
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>

Good catch, thank you!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

I would also add a:

Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monito=
r")

(Adding Nam to the loop, as author of that patch)

Thanks,
Gabriele

> ---
> =C2=A0kernel/trace/rv/rv.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 1482e91c39f4..e35565dd2dc5 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -805,7 +805,7 @@ int rv_register_monitor(struct rv_monitor
> *monitor, struct rv_monitor *parent)
> =C2=A0
> =C2=A0=09retval =3D create_monitor_dir(monitor, parent);
> =C2=A0=09if (retval)
> -=09=09return retval;
> +=09=09goto out_unlock;
> =C2=A0
> =C2=A0=09/* keep children close to the parent for easier
> visualisation */
> =C2=A0=09if (parent)

