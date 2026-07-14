Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BFC34B1B0
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028462; cv=none; b=KI62eS1VOhOxC4i8WbGcLgJTpm7INEqcS2oVJ0zropscW2gTxAI2j9U5M/+8gl9gJb6ublDDATjJW/nEQIP5cY1Pnu8/DhyhaJ6Gj7BZpKOXUst7TkJHAFr9Dcua2Rm50kD6LXEGIFk/VDUovW4S/L9S/Fl35ZRgwUM1mEiobOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028462; c=relaxed/simple;
	bh=8FpXIZbIvCOL/Y2WIkI1wgYWU4ve+510YZPxYoOY1Qg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPF1TKNBSgW4NkcJfPwvutokeC43AVRc6JkJvYkr3IhY1uLeRp5JdGsxVslpu3WKmH/4IormLB4yBeCQToXrcC37aR7yL8wh6Hv9na/Vup2TP+8QZlq/yvBgNAiSsgctluMrfTK1ZT5yHgXceJU2qkRk5279MC2mCejKh33DSFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMefBQkv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMefBQkv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784028459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5z40T2Pq6ETNbP7Mj4Df6HRrMyaspES8JIJSA+gOhjs=;
	b=aMefBQkvy2c96ZdpWD1dFCR8DEVEVloDGTCFwelCzAOHtAUGrKNk+VP2reIjgZ5DHn/2V/
	EtDoY612QfWXTI/TS6zSbk1uf9N+MU4O9VAvD0mzZAfvgTVwOnGZ7kyj45ZjTZ86HgO/GK
	djT2iqmku3199jp/saKybQpmlsOi6Nc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-wrVD9bfoMmaY_4HA8ypPcA-1; Tue, 14 Jul 2026 07:27:38 -0400
X-MC-Unique: wrVD9bfoMmaY_4HA8ypPcA-1
X-Mimecast-MFC-AGG-ID: wrVD9bfoMmaY_4HA8ypPcA_1784028457
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493e3ecd385so10466765e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 04:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784028457; x=1784633257;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mOCeEIDjrJmW55shxej4yEgZqWUxITngxGMI8YJa6sA=;
        b=WDCDuknpoTusPkLAcSUNXlxTgwMA3TT4dqsBCKyx81Lbq4+2gGkp8zEnpq84sBSKtp
         ehUTeMALF8/OLKYzrC9ZkWxJWQfLY+OUKAtOTA3zQ3befVaOc8dxufbaOJ0Cnn3mVRTt
         vi6tXUOgX+TE+THNgTSyWrxVX2rVsB59R5xC2XYIcE1Sbh9fRoX+P9QMnyC0JIwszKun
         bbuzoeelHQSFa/hXRXbuu4gcaL2cWMJ4IewPPe2dJpiS3yQ46yH034HJOzySYFzLaP4a
         11b7q4wdjUIp8vAyNY0j3KeZTZgS1eoOJFHM0z67DPYwS9XwhzLhdBs490gZizM+uZUP
         ZsYw==
X-Forwarded-Encrypted: i=1; AHgh+RoGwr5WHRYeZdX/jg2W0O9ELjq7pCwdU0u3zZOu4koZkAh/pTp9wv3kWX8putFT8yXZlZQ/ndYb6wWglzFKMynjRIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5GihxJZTksR5NSPjJ0k5e5h58wkLBaC+fieVYpdX88lV2wpqV
	Xmez8WDx/S5+tIVYPpLd4qAKq3DiqI5+jKuLB+KWLJwgs08utIqNnn5XnTtsmPbmVDejQS7n5h7
	Eyz/EQ3ASRPbOrKgt43/upVyzqnIs1d0UfBJVB0OtstdshKNjWh1XBboP71zENwoOxIlQroiG2m
	J0YtYYHUNb
X-Gm-Gg: AfdE7cllBJQaD39fqN44IL9TYnCLjUiHNxUUm91Zc65QtHfktmF0gucbUxOkh94GQ7F
	+ISzI6hhaS2AG3OIgmxftuGDO3tX18zErW4LRpsLJai/7kgcE6qBAbch/juP26Njd9t3fnfxvIQ
	Sc1+8TQY60KyHBmGfen5XNR9sh79ijK3teWSzKG5DV/RHj5oqxNucVhQxEJuLYXuXFiCHpe0qzw
	BpWo8U1LOgEA1vb+AjzgBryWsyQBev5s8gtq5cihkQpNpU7OdgSdS0wxQUmyZdosym9k0CH/yJi
	Di6P4/xl4C0HK/B3ki5Xp1Or5LRZVoGyS33mi/REDceDpnRrVC0pYkBII3+v82UXtvXFViUUpxF
	rALRrH1OSfdDI9yGQeuh610C3YTYsmZ+anc4Qow==
X-Received: by 2002:a05:600c:6610:b0:493:ee57:1207 with SMTP id 5b1f17b1804b1-493f87e489amr134511815e9.10.1784028457025;
        Tue, 14 Jul 2026 04:27:37 -0700 (PDT)
X-Received: by 2002:a05:600c:6610:b0:493:ee57:1207 with SMTP id 5b1f17b1804b1-493f87e489amr134511455e9.10.1784028456562;
        Tue, 14 Jul 2026 04:27:36 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.33.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950871cbd6sm80723875e9.3.2026.07.14.04.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:27:36 -0700 (PDT)
Message-ID: <3ea6ffdd144ce4b38d4a198550afed9516777f85.camel@redhat.com>
Subject: Re: [PATCH] rv: Simplify task monitor slot management
From: Gabriele Monaco <gmonaco@redhat.com>
To: liqiang <liqiang01@kylinos.cn>, linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, 	linux-kernel@vger.kernel.org
Date: Tue, 14 Jul 2026 13:27:34 +0200
In-Reply-To: <20260714083315.1371676-1-liqiang01@kylinos.cn>
References: <20260714083315.1371676-1-liqiang01@kylinos.cn>
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
X-Mimecast-MFC-PROC-ID: Dza65boRMF32D6aKy0nCWnQAOM3H-0lw85aobxgMZXo_1784028457
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-07-14 at 16:33 +0800, liqiang wrote:
> The slot array already tracks allocation and task_monitor_count
> duplicates that state. On an invalid second release, the old code
> warns but still decrements the counter, corrupting later allocations.
>=20
> Use the slot array as the sole source of truth. Return after warning
> about an unused slot, and return -EBUSY when no slot is free.
>=20
> Signed-off-by: liqiang <liqiang01@kylinos.cn>

Thanks for the patch! It looks good to me:

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

However, your signoff should include a "known identity" [1]. For most peopl=
e
this is an official name and surname (Li Qiang ?).

You could probably just reply with the new signoff, but it's probably bette=
r you
send a V2 with it updated. Feel free to also include my review tag.

I suggest you configure git accordingly e.g.:

  git config set user.name "Name Surname"
  git commit --amend --reset-author --signoff
  # will open an editor from there remove the old signoff and add the revie=
w tag

Thanks,
Gabriele

[1] -
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign=
-your-work-the-developer-s-certificate-of-origin

> ---
> =C2=A0kernel/trace/rv/rv.c | 18 +++++-------------
> =C2=A01 file changed, 5 insertions(+), 13 deletions(-)
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index ee4e68102f17..187d87d5991c 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -164,7 +164,6 @@ struct dentry *get_monitors_root(void)
> =C2=A0 */
> =C2=A0LIST_HEAD(rv_monitors_list);
> =C2=A0
> -static int task_monitor_count;
> =C2=A0static bool task_monitor_slots[CONFIG_RV_PER_TASK_MONITORS];
> =C2=A0
> =C2=A0int rv_get_task_monitor_slot(void)
> @@ -173,21 +172,14 @@ int rv_get_task_monitor_slot(void)
> =C2=A0
> =C2=A0=09lockdep_assert_held(&rv_interface_lock);
> =C2=A0
> -=09if (task_monitor_count =3D=3D CONFIG_RV_PER_TASK_MONITORS)
> -=09=09return -EBUSY;
> -
> -=09task_monitor_count++;
> -
> =C2=A0=09for (i =3D 0; i < CONFIG_RV_PER_TASK_MONITORS; i++) {
> -=09=09if (task_monitor_slots[i] =3D=3D false) {
> +=09=09if (!task_monitor_slots[i]) {
> =C2=A0=09=09=09task_monitor_slots[i] =3D true;
> =C2=A0=09=09=09return i;
> =C2=A0=09=09}
> =C2=A0=09}
> =C2=A0
> -=09WARN_ONCE(1, "RV task_monitor_count and slots are out of sync\n");
> -
> -=09return -EINVAL;
> +=09return -EBUSY;
> =C2=A0}
> =C2=A0
> =C2=A0void rv_put_task_monitor_slot(int slot)
> @@ -199,10 +191,10 @@ void rv_put_task_monitor_slot(int slot)
> =C2=A0=09=09return;
> =C2=A0=09}
> =C2=A0
> -=09WARN_ONCE(!task_monitor_slots[slot], "RV releasing unused
> task_monitor_slots: %d\n",
> -=09=09=C2=A0 slot);
> +=09if (WARN_ONCE(!task_monitor_slots[slot],
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "RV releasing unused task monitor s=
lot: %d\n", slot))
> +=09=09return;
> =C2=A0
> -=09task_monitor_count--;
> =C2=A0=09task_monitor_slots[slot] =3D false;
> =C2=A0}
> =C2=A0

