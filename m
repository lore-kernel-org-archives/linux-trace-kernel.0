Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFE221FA0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484330; cv=none; b=ueup13NRFjLh6STMWtu3nxMyF5cf78su5bcPUkubv32VR3jRv+rlUJvH4TbtrYVr03IKwPQr5N0dEESNL8o2V97OurMD5ZG63a5BVp340gChat2bBGDGy/UKSnQIWJpNegFopooy0ZOEyGcTJjY9vFyf/aMJA/THp+KBtksuTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484330; c=relaxed/simple;
	bh=AvfHEuh1vdd6Rnvmp0mKItr2TcKVCUNpW2isZVtulII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGJUJT7Bi6Qs8cZb5lN4qHzDeHszZqLCX9qwFxrynQVBW3RNXEHEEJ7YpiN23MhF23d2i6fHPY1l7B1vdTPJpLLSzdU2TUhSiu+seabCGJTTwhW8yN67l27PcOv0taZORN+Tf2y17slai/lI9Eer68EB6lEiNk5t5FC61ARQcEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFXNFX8C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFXNFX8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754484327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AvfHEuh1vdd6Rnvmp0mKItr2TcKVCUNpW2isZVtulII=;
	b=bFXNFX8CpoTgOwrb8fr/xQu5q2BkPfcsEcTNo0ycRFy2CG4REqiDytFQ2N6iRoWSNUGQd/
	FwHDaeNuFpYgRTfE5K7VQ/Jbc/DxI/EfXuq05igoUlZ8lV6ekF9jAZqS2QHy7f+uornUF6
	YRNGZrSdvSSRMHduUQZrMzvs40khF0k=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-01UspkC7MhW0Dc-cQMij_g-1; Wed, 06 Aug 2025 08:45:26 -0400
X-MC-Unique: 01UspkC7MhW0Dc-cQMij_g-1
X-Mimecast-MFC-AGG-ID: 01UspkC7MhW0Dc-cQMij_g_1754484326
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af117ffc70so110359861cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 Aug 2025 05:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754484326; x=1755089126;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMjNHNQ0G5LG4I1RqSHiwTb0enyDrEvAe+FlJh6jMwA=;
        b=GoW5FvWQIns24Te5aCbaWn/HngoYHNjCxfrmoTmkBDGCAdgMnSY0/nJUNC3sm8DoTn
         7Mp6bMRxLcejs2UpX7I80Qq1JTvGhTJ5uHJnJWP1/KcRbOT3BEGcmnpfrbHDttykUFEJ
         XNhkl/TEeDUXvrTyCCoYviTkIJ95q7FvG0fwtOVHXB/+nZDC/HRcGNzBDJjf8pvCAFUO
         yhMqMeCH27GmhaOUOeH2Et4nUFvrQ4+/mhpBqcvaMG8Yhh5Ga+aNvIZM9vaPenQARXlq
         n7WhX8hDhl+ZXda045qNUHR54uFI9q0cmera2BGDzrjj9uTnJo5oGWqNX5Ts3xMJfYcg
         cUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5d3tv7q1eMwJVO7FOvHlS5gU3IT20uJ0ZlUYBA2CpbFZwJRT/HDxMWDbWP+YIfoDgmzlWDdrxXRBB/UusUVVF26Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/Eme7t60HY7eYnpPS7VeshznjtWRMPkVDwhJm8wF1jl9Opgn
	yzfI1nNg9n3XucBDiJ6RdptaomoIlm+yuikRYOI1TMIkr27UsRagES37VDsr6Q6Nmg7sXtxhvUH
	aucJQxl8kicfFKvkbbZOG5Y+RYEziy+axDk0x+ClaS52QG82Xn3nW4eUqOZboVOw3BE8UjW68nQ
	==
X-Gm-Gg: ASbGncvQ22e1N0UowDDhOTIMsFkfRRYvR8e9R4bt/W/EgQ4joKWy1M7jxpWkOB0XX26
	DNX04fgtHVYpD2V2HmPQuX+Ie+wKhZ5z+1DgHczpa8UTdQ9VAFooLFG4/eD33WwdZs5Zc1ggnSI
	QOXR3Jk9SSMOzmVntBvv67OeBzx9aB9tsB6Zu/cs+89NdE9624klVT+pxYaGQszSXRkwmu5akEr
	jNwoi8Bcc9n4n77uoTbIA/+RxWjmjAdfv8ew3E5UDNqoZpEL0mCeA/yvTCr8O38QN+TUD68mFdD
	mqFEK/iw8qIXKxXj2g+AHwBuCIiBgpn5yh3QzJW6S64YOmA+qCSl4xki6d0aJSUx2Q==
X-Received: by 2002:a05:622a:355:b0:4b0:8f6e:d728 with SMTP id d75a77b69052e-4b09138c9c0mr38195631cf.21.1754484325736;
        Wed, 06 Aug 2025 05:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTMYU08BgHnXR1+czy5QcVCMHzz8YG+OtEkdxRx4oxsXU/v8COQ+2pdCxkJHBTMz4Q6mU6DQ==
X-Received: by 2002:a05:622a:355:b0:4b0:8f6e:d728 with SMTP id d75a77b69052e-4b09138c9c0mr38195381cf.21.1754484325386;
        Wed, 06 Aug 2025 05:45:25 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm19326441cf.53.2025.08.06.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:45:25 -0700 (PDT)
Message-ID: <8f379f2072ee12afda37455aa0ad4e37d53c4f2d.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix wrong type cast in enabled_monitors_next()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Aug 2025 14:45:22 +0200
In-Reply-To: <20250806120911.989365-1-namcao@linutronix.de>
References: <20250806120911.989365-1-namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: SbQJc72ZGu0mfyL7PGl4BcRX_IE1x2PhGQxDaSRoAeQ_1754484326
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2025-08-06 at 14:09 +0200, Nam Cao wrote:
> Argument 'p' of enabled_monitors_next() is not a pointer to struct
> rv_monitor, it is actually a pointer to the list_head inside struct
> rv_monitor. Therefore it is wrong to cast 'p' to struct rv_monitor *.
>=20
> This wrong type cast has been there since the beginning. But it still
> worked because the list_head was the first field in struct
> rv_monitor_def.
> This is no longer true since commit 24cbfe18d55a ("rv: Merge struct
> rv_monitor_def into struct rv_monitor") moved the list_head, and this
> wrong type cast became a functional problem.
>=20
> Properly use container_of() instead.

Good catch, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

>=20
> Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct
> rv_monitor")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/rv.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index bd7d56dbf6c2..6ce3495164d8 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -495,7 +495,7 @@ static void *available_monitors_next(struct
> seq_file *m, void *p, loff_t *pos)
> =C2=A0 */
> =C2=A0static void *enabled_monitors_next(struct seq_file *m, void *p,
> loff_t *pos)
> =C2=A0{
> -=09struct rv_monitor *mon =3D p;
> +=09struct rv_monitor *mon =3D container_of(p, struct rv_monitor,
> list);
> =C2=A0
> =C2=A0=09(*pos)++;
> =C2=A0

