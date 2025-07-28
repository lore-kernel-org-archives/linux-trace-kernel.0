Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B33237163
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693149; cv=none; b=OU8uySawiNUWDMkHNLqAJ5+S2hXPHX4UqBLDbDCWxg4iSKrq7Kj0ICKfPOEFZ8qOgY3AN/w9susHg/TYTFcf0Iv7rEHoTaTa0R/y3CDAFBrbfJqARCuua0QqsVb4VK2PoDy3qPpBrV1yEtxzHWRPtMJEU9xslBxu/BkQpyHX7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693149; c=relaxed/simple;
	bh=BuyNmQaiHhB7QblmPXdj69bJYc3NIEYedjz2UyGC22U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zj5N+rYimJZ4txn7ARXszwAZ5v9K+cUrpA8JPR59dbo/gfRgf9rozFxGsAPi7eJJAiLxu0Lc1u8RmE32e3051SfeUopjQrXgdLqhJYX5ydp50fgw6CUlE5BZdkiVyXsaY0WqFwRe1LhSJvk7wVsOe2o5RWp/c72kMvJq69zCp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COPXc3Od; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COPXc3Od"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753693146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BuyNmQaiHhB7QblmPXdj69bJYc3NIEYedjz2UyGC22U=;
	b=COPXc3OdBjqhwrPtaWBbnjCZPG3bJHbJJ0svkOcC5UZ7gmUsFXj1QnBEUP8C3yISxCM9W7
	9ls4u2SaaxPMUY31DY1As3VaPvxFIDZaTBzTDrBVyu4eHlckJjeKGRNYE+l206tqgkQCms
	sW32xzYeJC+tebIPoPlI+zu3b4A/0Qs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-7I_rG9rRMSaI4lkoLowfhQ-1; Mon, 28 Jul 2025 04:59:05 -0400
X-MC-Unique: 7I_rG9rRMSaI4lkoLowfhQ-1
X-Mimecast-MFC-AGG-ID: 7I_rG9rRMSaI4lkoLowfhQ_1753693144
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso29124655e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753693144; x=1754297944;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrr7x9fAxuAGHE+0RbZWBm6ofiZmwJUP/auBwMym0tU=;
        b=tIYy10BGqFdx6LSda5DWI8KiKAnBqbQ8ytDD1YTIbOBk/HB31iC8xCb7+J5Bx7gN/8
         4q9nnfFT7VQwBE89l/mEnO4ENqVbNQEuJNJrmkHow3sK4uDlSHw8s6xhPfK+gbH0aKH+
         hAC70E/FniOC059EJWvZijA/EU4T9hDQOOOGKjfrcRUddR5ZGIR6nKHaHRvnUdsMailz
         zUeYkAi9M/B/0ZPtVNdnHZobwwqbVMJPXW88D1FiqGNC+AYg2OMTx0iJEhyS+MYSQGDW
         MskcSYIgJ6EfRs5RF3betsT6eqgX3pZwM8e79HrfociBpiPW7jPymGrxX/kFpHFJnAIZ
         up2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYc5QGYb5NU3DH0M2W39SaOKCsOGB6LMW/k8JRrHijIAT2vHja3N/SJsi+vESzlH8v1I2w64Hnc2ajaTx0/W8lt30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGPv5WmLbx5BlZ5e+X5bvOpgXobd2SRTlwktY2awceZE3n/eZ
	jJtHSIhYeaPPsRGek1giA3TyPbBY7tOuMUKfuPaMxWq+pheuYMkVHy2nBqyWdxQvRx654SYJqO9
	hKyJbI+5h0qO6+lTtFyBUQWQKguukP3U0kNuTeiAlCpqngnh6YANXOoj25VbFPSEFvJXASSPz3A
	==
X-Gm-Gg: ASbGncvwOQAuJK+ufWyVvGZB66iJwQpy6feP3qeA/N/YDiQVnSDX37xg62ifnrIOcmA
	I0XFBCWqkd88CjbddhoZzAzsc5YmzjddR0BSBUfzSw3v+BMUFlVTHrF6GEWHsPu6rdzbQDag2EC
	IwImFoeX9e2XUyBvVKYBaV4SzUl7SG900oovmMIX/znmM0e4AHsKO5PH62A5VVrYG2nyW2Vdtpd
	Yhs7IoiyRbtrzUmdAxsPqKShm9aPw6eF4pd4GQx+jIItRZxUI5qSAT8nTWjMq0Mj2IWOmIv27wc
	O4XrvvuMB/jDXuUKv3UJ+3nmOaNMCF+R5vHxfSHsjECmhLS/Qc37iwGJaZIU/hi0aQ==
X-Received: by 2002:a05:600c:3ace:b0:456:25aa:e9b0 with SMTP id 5b1f17b1804b1-4587654b626mr107756265e9.16.1753693143735;
        Mon, 28 Jul 2025 01:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6V4rBC01wlsEfxp2PWoqkhk1+LmJwURJ+0I/kuFMiJMXfQcv8SKtfyaP6HZn+rsWH0Gy7cA==
X-Received: by 2002:a05:600c:3ace:b0:456:25aa:e9b0 with SMTP id 5b1f17b1804b1-4587654b626mr107755945e9.16.1753693143200;
        Mon, 28 Jul 2025 01:59:03 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b7811b82c6sm6553721f8f.49.2025.07.28.01.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 01:59:02 -0700 (PDT)
Message-ID: <786688d8a5ab0d5228d271861416d49cc3a8ebc3.camel@redhat.com>
Subject: Re: [PATCH 1/2] rv: Fix wrong type cast in monitors_show()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 28 Jul 2025 10:59:01 +0200
In-Reply-To: <35e49e97696007919ceacf73796487a2e15a3d02.1753625621.git.namcao@linutronix.de>
References: <cover.1753625621.git.namcao@linutronix.de>
	 <35e49e97696007919ceacf73796487a2e15a3d02.1753625621.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: AzQ4jlfLmfuUqyW8JU-AiLkdZjx_mBPwIEIU4eOJi4k_1753693144
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2025-07-27 at 19:31 +0200, Nam Cao wrote:
> Argument 'p' of monitors_show() is not a pointer to struct
> rv_monitor, it is actually a pointer to the list_head inside struct
> rv_monitor. Therefore it is wrong to cast 'p' to struct rv_monitor *.
>=20
> This wrong type cast has been there since the beginning. But it still
> worked because the list_head was the first field in struct
> rv_monitor_def. This is no longer true since commit 24cbfe18d55a
> ("rv: Merge struct rv_monitor_def into struct rv_monitor") moved the
> list_head, and this wrong type cast became a functional problem.
>=20
> Properly use container_of() instead.
>=20
> Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct
> rv_monitor")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/rv.c | 2 +-
>=20
> @@ -458,7 +458,7 @@ static int create_monitor_dir(struct rv_monitor
> *mon, struct rv_monitor *parent)
> =C2=A0 */
> =C2=A0static int monitors_show(struct seq_file *m, void *p)
> =C2=A0{
> -=09struct rv_monitor *mon =3D p;
> +=09struct rv_monitor *mon =3D container_of(p, struct rv_monitor,
> list);
> =C2=A0

Good catch, thanks! The container_of is the way to go.
Do you have valid reasons not to move the list_head to the top? It's
not a big deal but it would save computing and summing the offset. It
doesn't seem name (the current first element) really needs to stay
there.

Thanks,
Gabriele

> =C2=A0=09if (mon->parent)
> =C2=A0=09=09seq_printf(m, "%s:%s\n", mon->parent->name, mon-
> >name);

