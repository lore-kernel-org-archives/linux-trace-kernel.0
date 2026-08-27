Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46443C056
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825454; cv=none; b=k+zGtZz1v1L6IgvOHru32PteSBYb8qR0nBEmyu1np4nd1r/KNq58rbip2hQRWcCQXDVEHkF4kvwB+BGwaj7wPJpoCW06kk0R/pIVyEtGgDlbiXbm2wBeUbaUgIse7GDIKNziRHbNEVrMgNkTzxR9Lyc7yHWJmqEoH6d4uFoV7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825454; c=relaxed/simple;
	bh=paECNd/d7ymJN0gou5RgDual1idh6iiwnWiEwuClM/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGcrkHdhw9AzekCvhMotJ24c2WgkST08g9Tfl2xZkkYhtkU85yW/tG57F6PsVoukKwuWWMwJMFDyQ6eX+5RU1ia8lq9WKWBOX7n89vA6SCf4/FX6k+FkeGThtutanbgz0ZUaZM8u7CL8fPVnaNqdAfkWkCL2Df3smqyL225MyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8/LHk9J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8/LHk9J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787825446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=paECNd/d7ymJN0gou5RgDual1idh6iiwnWiEwuClM/0=;
	b=F8/LHk9JKu03OQYXp7jy4EFI3m/AsOwU0J2UgqWAgpTtoItUfLq7LFk07FH1F2urD0Se1n
	QxFE0+ksr8Jct9nukjhOGkq/ApT7HVFUwi41LyiB/cxPcz2b4tjh2KCC858BlwwZol58nd
	oKXAk/N1dhzdBkuI5Z+76WqS+WyCALQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-PKFVxCxMMOKqNJQ27GRS-w-1; Thu, 27 Aug 2026 06:10:45 -0400
X-MC-Unique: PKFVxCxMMOKqNJQ27GRS-w-1
X-Mimecast-MFC-AGG-ID: PKFVxCxMMOKqNJQ27GRS-w_1787825444
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c252686999cso127665966b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 03:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787825444; x=1788430244;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4w0qq3Y1zby89lLWO/tifyuK1AJLIJqbBqfesQ6MqW8=;
        b=spOzhMOc8RwdU3WYhJ51tVmDkrMfZO7e31v/8shCY+DA/JwZUUhqyXYXq/axfPPdfN
         3VNm5W+FXeGqD69cXC6MelLos3T0i05Z+ZzhQ99SaNqiexjQTwgfLwS8MIZhxT/Yjb8Q
         hXK4fxuOry1XREyvVlMfq/8p+CtCGyZdRbUChuVdMkKhBLtiNtw8sNaFpQ0F0VJ4nDvt
         6MeTyRzrV7KPeOugsavKMcpLQiwYipNw1lm5U2+fKXf+1vJ/mcgucT2gkqdRNiG9cVjg
         kfgXNAm8pTTCtDRDovsx24BsEyZM6Qpi2fmEezwrWwl9ezODexA3Z9fh/q/5oMSuTr2e
         +e9g==
X-Forwarded-Encrypted: i=1; AHgh+Rp4VTZKELWevv/ssjcZFQsztzWvPsAB4928SFwJsjoFXVtpsufgMYOfZstbYSbiCVk2/xO/BONUtfE1TMf8pt4bVKc=@vger.kernel.org
X-Gm-Message-State: AFuF++li7GZ2Kleqmim7bLfcYmXb4FYN27bKkd+IXZ80WeUvzJ1cvo3s
	UPQxVawRePBLVK7k/A+YywiLS+0+JY3VMe0Si/L/0nSP1RuJzlLmj1RQgU/0j9HI4etqifGR1F6
	B3UmSS2IlAlo8pH7pu3xl43hFMnwpUxdBS8U0BL1sJo8ebDcQQ7sxiVu9KJrq6ys4yzjMLHUO5A
	==
X-Gm-Gg: AR+sD109a5NnOUOLFA11qgx1zBKaXtZHv9ocVGZTmc+LFs9IeEsi7juYjx5dUx/jXUT
	/iWiWg1RLSSDgRg0uM9j+7mSW9b+Yl3Lnk/BJUaaFZFpjOgJ/vEK4oUOtCbxgocc1Fv/1vxBkw2
	L5Zlv7kex5l1AY97HokGiH5X/rmBRVL/QR0sxwnQ/PLgJOR2gH7MgZIp8OKpsMPPlj0R3vnYxAC
	7bxC33GwEmGlmFMk5hlftLwUMp3QHJ5uVg7mxL7LHWbdVd+d+N4EPRZ0sS6dLxLqZm0emD0XqEi
	IrR340lAg7/QHO1nTkYrRRCCGnelXyZJUYD60IMMn8eKxC58KZFR19NPZXSVaR3mN4RYD/G8dXr
	V6LU33yAmvmj5oBTokteYeZPmotAHNQdEooGN8mWTu65FhjEFKrrlvnmuJ+qbIiI7Q3PvGQ==
X-Received: by 2002:a05:6938:a089:20b0:c24:c250:a6b5 with SMTP id a640c23a62f3a-c250bc2db03mr1134927366b.12.1787825444011;
        Thu, 27 Aug 2026 03:10:44 -0700 (PDT)
X-Received: by 2002:a05:6938:a089:20b0:c24:c250:a6b5 with SMTP id a640c23a62f3a-c250bc2db03mr1134924066b.12.1787825443648;
        Thu, 27 Aug 2026 03:10:43 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5e0701sm723598966b.12.2026.08.27.03.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 03:10:43 -0700 (PDT)
Message-ID: <5672e2f74937266b7005ccb4450fc1b768c175fd.camel@redhat.com>
Subject: Re: [PATCH v6 3/9] rv: Add tlob model DOT file
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 27 Aug 2026 12:10:41 +0200
In-Reply-To: <9e27f8af4520800fd1f19a2b9e9c0a0f2250920a.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
	 <9e27f8af4520800fd1f19a2b9e9c0a0f2250920a.1787243842.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: VYAXpf8L2080RPqOSiuOeVPtCpbnpRN3iJ2Ez0Ab8AQ_1787825444
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-08-21 at 00:45 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
> +digraph state_automaton {
> +=09center =3D true;
> +=09size =3D "7,11";
> +=09{node [shape =3D plaintext, style=3Dinvis, label=3D""] "__init_stoppe=
d"};
> +=09{node [shape =3D plaintext] "running"};
> +=09{node [shape =3D plaintext] "waiting"};
> +=09{node [shape =3D plaintext] "sleeping"};
> +=09{node [shape =3D plaintext] "stopped"};

There's a convention to mark the final, which is usually also the
initial, state differently. Please do:

=09{node [shape =3D ellipse] "stopped"};

Somehow rvgen still gets it right, but it doesn't hurt to follow this
(undocumented, I know) convention.

Thanks,
Gabriele

