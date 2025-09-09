Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C07322C69
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416028; cv=none; b=NYOq4043WVw0eK42me32xgUw1KDvr0odTLK0PcC00bhPA8qOSEGshTxqItfTdUn5FMvVDU+tdlKw3DlXuUE1puk3k8bIUEvGL0w4UUBWOnZ2RLv50QqZchHNkjhaP5TbbI38lBnrPtxuaFsmlkVU4YqtAqYvklbQN6PFvO9o6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416028; c=relaxed/simple;
	bh=uuso/3vYpXAYE9+SDc45AN6CBcVMJSAfWgR6ZO515y4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFK6/bO/0I9nqEhC4LWsdwE736kg9f9xL8MMNP4ype7QL2uRWxLF38JWflY2fDlGgmhXc9ji/ex9K/y0EesmIZnmRXryOAg1Sl9RVDxWG2W6nv+T5NvACw5fYGwPS4pzCQFw885yMf1MiflBl7ltY+cUa/DR+2xaY3SMxuatZi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOZUVMRi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOZUVMRi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757416026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uuso/3vYpXAYE9+SDc45AN6CBcVMJSAfWgR6ZO515y4=;
	b=gOZUVMRidpc7hmhB8pk/VaFEbVBnlmhm8I1jtnEKGx4FjztmPNCoehgMRzqczpKZjyPQRh
	tGtj/lDcXI0+XZ6LbR1U6wHiwQNfgd3EaWxfqpX2FtCiFts2u121Bcdu5DevWi89Xv/VDQ
	tEA8FIrm+cxd1hCTs+I/HUF6nwJVdLo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-k5adl0SsNWSSJn9ShkY4CA-1; Tue, 09 Sep 2025 07:07:03 -0400
X-MC-Unique: k5adl0SsNWSSJn9ShkY4CA-1
X-Mimecast-MFC-AGG-ID: k5adl0SsNWSSJn9ShkY4CA_1757416023
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3dbf3054ac4so3252252f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416022; x=1758020822;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F645HJ3vveFmp34mF8+WjlKqHIVzKpVZ1NP3PP0iotw=;
        b=bdbBlDTH1H0op06He+YoCNSqYFFS99apoPho27AuKFWiuua7iv4vExhHJq6wCAlkug
         avb2X8ajUqgRcyJlYXEAX0oKN3A+nAYt9Ot53lsHpSgoaxoeyITtuhHMs8m4rC6fcdlY
         slxqeSggU6eo2jHTm7F2oZseNYdd73/krGh0+khZ8ErjZaYh5hcmzUEQvAwFWDJLSTU9
         iebMfjuz6viUETY0/e28GX0qhlIX66mzMIsd0URMLOeiw8Zvl2l16TlMXxpnbGaAMblw
         cfgaarSh7RvbzfdiyGgWsLfUYN5pADjoOr69FxtINNRw+mPMGEQPmOexRcYaNCMwEqIZ
         3GrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUletlnQkNslpJrFkoEi1aEX/hmRLnmM2s3GQHbgHqBOv1qszoAwWrQ4alwT8/JySk7eZ3Xulj1ikiZitzrUUr3ois=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWpz7L/ARnV9594rKNuI2QVKR1IESlInOAQ9aLy9TQa5wKhHaD
	EyD7GblS59Uj1RgKooi9sHp8LHIzlxYoVqoB3b1ZKdXhaBAwVMPt6Ypjxrf0fO08q8nIoiLqcxd
	mYh0tmaP5Nehib3tkfLIuMzQ8Y5LXYyapfM4SeWuZ1ZB1PB736atZRGJ2be8n8tmhX50+WxJAxw
	==
X-Gm-Gg: ASbGncsh7V+NWfAE6jYKmRFU9ho+MbvFDL1gI4vKo6RU7fyCfp4Oy3psx5kSh2GL3AZ
	0Axpsymj2clO6IgMmhOKtzahBTliRYLdzQWPiKmGk/e2uO7dvEcLCGQnK9bTnoRxuxclrg+Urte
	Jyc5ICelvd3tKrG6WGOl0uT7OAbFZdqZQ5I+L8TG87+xbnl2A4m0A0z/AIkv65T/kLmqj2YgZDh
	yAbOCI1coZL5ZmE1xr96Mx7a6Wn3NrqPD0FNFSiD5z0tRww4s5vsRjCjZw3/qR9CY+nAlJwfmux
	L8oNMiz9wRQrjFVOxUAm0tO60KsvQJmi/eunVNnTLvjcAccyM5HYcY2+aRfbGzxdpQ==
X-Received: by 2002:a05:6000:3108:b0:3d6:212b:9ae2 with SMTP id ffacd0b85a97d-3e643ff9652mr9440729f8f.63.1757416022497;
        Tue, 09 Sep 2025 04:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeI98m17yynV1gNprmpuJG/4VqnfMA/ofoyol0VPV/L8nFCDCvGKffsiP06RboObT8nGFhQQ==
X-Received: by 2002:a05:6000:3108:b0:3d6:212b:9ae2 with SMTP id ffacd0b85a97d-3e643ff9652mr9440699f8f.63.1757416022037;
        Tue, 09 Sep 2025 04:07:02 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223898csm2306074f8f.39.2025.09.09.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:07:01 -0700 (PDT)
Message-ID: <93a46874ceadf0080891e06d930336e120f2d753.camel@redhat.com>
Subject: Re: [PATCH] rv/ltl_monitor: adapt handle_task_newtask to u64
 clone_flags
From: Gabriele Monaco <gmonaco@redhat.com>
To: schuster.simon@siemens-energy.com, Nam Cao <namcao@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, Christian Brauner
 <brauner@kernel.org>, Stephen Rothwell	 <sfr@canb.auug.org.au>
Cc: David Hildenbrand <david@redhat.com>, Lorenzo Stoakes	
 <lorenzo.stoakes@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel
 test robot <lkp@intel.com>
Date: Tue, 09 Sep 2025 13:06:59 +0200
In-Reply-To: <20250904-trace-task-newtask-fix-callbacks-v1-1-8edb3d557365@siemens-energy.com>
References: <20250904-trace-task-newtask-fix-callbacks-v1-1-8edb3d557365@siemens-energy.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jPaoYJ6AryJ8Ut_0OWpqpoRHqKn3F4KUF6TP4PB7Nns_1757416023
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-09-04 at 13:36 +0200, Simon Schuster via B4 Relay wrote:
> From: Simon Schuster <schuster.simon@siemens-energy.com>
>=20
> Since commit edd3cb05c00a ("copy_process: pass clone_flags as u64
> across
> calltree") the task_newtask trace event exposes clone_flags as u64 to
> its callbacks.
>=20
> However, ltl_monitor was not adapted, resulting in a faulty callback.
> This also resulted in an lkp build warning due to
> -Wincompatible-pointer-types.
>=20

Looks good to me, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Adding Nam (author of LTL) to the loop.

Gabriele

> Fixes: edd3cb05c00a ("copy_process: pass clone_flags as u64 across
> calltree")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes:
> https://lore.kernel.org/lkml/20250904113334.18822d43@canb.auug.org.au/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202509040134.bQVbm7ja-lkp@intel.com=
/
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
> ---
> I did further search for other in-tree users of the task_newtask
> callback, but the trace macros make it a bit harder. Yet, as far as I
> could see, there are none, so this patch hopefully resolves the
> problem
> for good. The other matches all relate to "tp_btf/task_newtask",
> which
> seems to be unaffected.
>=20
> With this patch, ARCH=3DS390 allmodconfig -- that originally tripped
> the
> LKP builds -- now builds without further -Wincompatible-pointer-types
> warnings.
>=20
> Sorry for causing this trouble, and thanks to Stephen Rothwell for
> testing/reporting.
> ---
> =C2=A0include/rv/ltl_monitor.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> index 67031a774e3d..5368cf5fd623 100644
> --- a/include/rv/ltl_monitor.h
> +++ b/include/rv/ltl_monitor.h
> @@ -56,7 +56,7 @@ static void ltl_task_init(struct task_struct *task,
> bool task_creation)
> =C2=A0=09ltl_atoms_fetch(task, mon);
> =C2=A0}
> =C2=A0
> -static void handle_task_newtask(void *data, struct task_struct
> *task, unsigned long flags)
> +static void handle_task_newtask(void *data, struct task_struct
> *task, u64 flags)
> =C2=A0{
> =C2=A0=09ltl_task_init(task, true);
> =C2=A0}
>=20
> ---
> base-commit: edd3cb05c00a040dc72bed20b14b5ba865188bce
> change-id: 20250904-trace-task-newtask-fix-callbacks-b158634c59da
>=20
> Best regards,

