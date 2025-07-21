Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F428DB71
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753093772; cv=none; b=XvFFdyqDwFsas/+Zz2piz/M9IYvm3LC6VPSKklA0YtQGuIIlh7GmDMP8e3ZdTXNfyfzSpjOas4Jtk0RiKVloWPbGrIsay0UhHMNK+76d9hLQgO+VPDPMHIMQZ7KcmtsfiHNQyDieduAeMGNMDa6cVNSfps/E7YfLCxBWZgOWMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753093772; c=relaxed/simple;
	bh=PRkT7S8uMLS47IzMRZXM9PaRd0orJ3jyzQK0Am5FysU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3Z2f+1kPq3dI3Q1JvGcobhQpToV3i33o12EZiMCYhHUUrTeaM3E0QHpTf6LGt62IWaGNh0/Elcmyuvau8pGTY4hPgVe9hT8HjstOx1l1ZThvnk01065oDKpYTjWikznOj+co35hSHRvrs38Lk358Bnbbg+rGNPzdJId1tJyi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BU7+Pved; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BU7+Pved"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753093770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PRkT7S8uMLS47IzMRZXM9PaRd0orJ3jyzQK0Am5FysU=;
	b=BU7+PvedMH/q14Qgo9Zm858u3gnyqEk8QKiSGmfVOR1XGquuNL/0bZCGRt/gPuAIq7Jmv0
	aLK4yzFGM1mUyGNwC3VF1Zwu/aLjgfP3W/lx6ndIwOAPgNxg1H4w+9+bjTPnwIsXRiJ5kA
	7GAvpGnup4Iw5aQI5F8ZYU22pV+dNOE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-jnVMN5f0OyCdVEcZXmMqNQ-1; Mon, 21 Jul 2025 06:29:28 -0400
X-MC-Unique: jnVMN5f0OyCdVEcZXmMqNQ-1
X-Mimecast-MFC-AGG-ID: jnVMN5f0OyCdVEcZXmMqNQ_1753093768
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso27767865e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753093767; x=1753698567;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=282c4e20Cm5//xykvNprwI9eqYR3vWB4V/uzt6kPX9A=;
        b=rnjfWSjp65EZllRFnOXgRYoAsDuKAsOQdSjlMo2hSY+hbGd+Xj95U0z0yHfVEPhDcR
         FOZooAcprO0SHWMGlGGRO4UE/PCKB9CVuJfhPhDIMlYSzG6Qr/u+Hkj3cFtENvPEYK1t
         coQXXfSgLp+CVeWUoA1k/dELKeBmY209DE9669rqaFT3SHO7lSRuT/o2dBVsjxO/knuJ
         NAMx9yQRn7iVIRe7ouXmrDNsGPMToPzz0jowMKoMASRrH4euU6QRWyLY/J/1KCllDJNw
         KBSVcPyFfyx5nyo3fSnTlX1w1WXVPtOIkBbgZUww3fOTbwiI1SIATBOe2aTl7q1e+Jvq
         XOkw==
X-Forwarded-Encrypted: i=1; AJvYcCXQEUYpolRGEQQtb1hrBEHww/wUTeYJfoo7xDrs216ZKUByUe5c94SzoELPCTbhyVCA8MBN/+H93ct+MkW8gXUaWVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvtDFcLYrtWOulFf/BYzORSLahscOY0yE3uuj6CDb25x8AlKQ
	LSmyvgyN7bIG1uypcGmyGB5AydPDtZsFq4qtLT/9XovcUDBpFYpFm/Ur2uXAgECp7ElMAUfprjB
	yIsuBExW38A6itJ9S3+WS0XumcjJ9MQNiWupkG7CgEx50PwHYehuo0+7pCRfEuWEF9XPmqP3GPT
	5gLSciydFE
X-Gm-Gg: ASbGncsb4n3kcXncAdwnteMng4/zdKSHKx68fla7bl+qonkqlLUNmAPyG7dZ2Uxf1yd
	Q4uaTzgYvveutWrEvFps9B5tynSLvY091L6Sk4qtB7PfGRiXHWPafJHt7sr4xX+p2QsseCMwfri
	MIHHM1Cl3qotmEE55DFlb0cOeNL/rZDQW8O7OGGlSxAL6Br/+mw2CTEJMsAw27OwCi5iBj9t19J
	kb518zySwk2PxC6ONDt3Iy9VoXWg0bz1MVHSh/JdcLYQ1UIVsmlrzSpPu5ZIFbBpRjX2PRE34FR
	3Dn7WIleLi1MQjwkYX+GU7ncVrOTG1/ST3UVDS8kn62ANte9szIfEMwtZrK07rl84Q==
X-Received: by 2002:a05:600c:35cd:b0:456:1a87:a6cb with SMTP id 5b1f17b1804b1-4562e38aa91mr189518255e9.19.1753093767480;
        Mon, 21 Jul 2025 03:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUZF1yPXucXa22pT/Lxe8aaOn7Ve/eK1Ei+g1OE/VFjIqSyWgPIM3By95bNU6CqdBa9EHz5A==
X-Received: by 2002:a05:600c:35cd:b0:456:1a87:a6cb with SMTP id 5b1f17b1804b1-4562e38aa91mr189517935e9.19.1753093767008;
        Mon, 21 Jul 2025 03:29:27 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b7521e9sm98187635e9.29.2025.07.21.03.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:29:26 -0700 (PDT)
Message-ID: <feae7a189afa69091816074dcf66a496b11bdd38.camel@redhat.com>
Subject: Re: [PATCH 5/6] rv: Remove the nop reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 12:29:24 +0200
In-Reply-To: <21a530ffb705887d7aed18255572521e5b880bc0.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <21a530ffb705887d7aed18255572521e5b880bc0.1753091084.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: e6Q52FYW11g8FH8Sk_V5HRJOIx2bCmMSK1jSUh5izL8_1753093768
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-07-21 at 11:47 +0200, Nam Cao wrote:
> As suggested by the name, the nop reactor does not do anything. It is
> the
> default reactor when nothing else is selected.
>=20
> However, the monitors already null-check the reactor function
> pointers.
> Thus, instead of a nop reactor, just set the react function pointer
> to
> NULL. The nop reactor can then be removed.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Thanks for the patch, I'd need to go through this a bit more in detail.

As far as I remember, the only way to disable reaction is to set it to
the nop reactor.
With your patch the behaviour changes and, to disable the reactor, you
now need to write an empty string, this should be documented somewhere,
at the very least. Perhaps userspace tools (tools/verification/rv)
might break and would need adaptation.

We could still remove the kernel side implementation, but from
userspace (tracefs) we might want to keep the nop reactor available,
setting it would set the reactor to NULL under the hood.

If you really want to change also the user space interface, we might
want to imitate other tracefs features and use something like printk /
!printk to enable/disable a reactor.

What do you think? Did I miss anything here?

Thanks,
Gabriele

> ---
> =C2=A0kernel/trace/rv/rv_reactors.c | 63 ++++++--------------------------=
-
> --
> =C2=A01 file changed, 11 insertions(+), 52 deletions(-)
>=20
> diff --git a/kernel/trace/rv/rv_reactors.c
> b/kernel/trace/rv/rv_reactors.c
> index a8e849e6cd85..aee622e4b833 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -70,17 +70,6 @@
> =C2=A0 */
> =C2=A0static LIST_HEAD(rv_reactors_list);
> =C2=A0
> -static struct rv_reactor *get_reactor_rdef_by_name(char *name)
> -{
> -=09struct rv_reactor *r;
> -
> -=09list_for_each_entry(r, &rv_reactors_list, list) {
> -=09=09if (strcmp(name, r->name) =3D=3D 0)
> -=09=09=09return r;
> -=09}
> -=09return NULL;
> -}
> -
> =C2=A0/*
> =C2=A0 * Available reactors seq functions.
> =C2=A0 */
> @@ -174,7 +163,7 @@ static void monitor_swap_reactors_single(struct
> rv_monitor *mon,
> =C2=A0
> =C2=A0=09mon->reactor =3D reactor;
> =C2=A0=09mon->reacting =3D reacting;
> -=09mon->react =3D reactor->react;
> +=09mon->react =3D reactor ? reactor->react : NULL;
> =C2=A0
> =C2=A0=09/* enable only once if iterating through a container */
> =C2=A0=09if (monitor_enabled && !nested)
> @@ -210,10 +199,15 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0=09struct rv_reactor *reactor;
> =C2=A0=09struct seq_file *seq_f;
> =C2=A0=09int retval =3D -EINVAL;
> -=09bool enable;
> =C2=A0=09char *ptr;
> =C2=A0=09int len;
> =C2=A0
> +=09/*
> +=09 * See monitor_reactors_open()
> +=09 */
> +=09seq_f =3D file->private_data;
> +=09mon =3D seq_f->private;
> +
> =C2=A0=09if (count < 1 || count > MAX_RV_REACTOR_NAME_SIZE + 1)
> =C2=A0=09=09return -EINVAL;
> =C2=A0
> @@ -226,14 +220,10 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0=09ptr =3D strim(buff);
> =C2=A0
> =C2=A0=09len =3D strlen(ptr);
> -=09if (!len)
> +=09if (!len) {
> +=09=09monitor_swap_reactors(mon, NULL, false);
> =C2=A0=09=09return count;
> -
> -=09/*
> -=09 * See monitor_reactors_open()
> -=09 */
> -=09seq_f =3D file->private_data;
> -=09mon =3D seq_f->private;
> +=09}
> =C2=A0
> =C2=A0=09mutex_lock(&rv_interface_lock);
> =C2=A0
> @@ -243,12 +233,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0=09=09if (strcmp(ptr, reactor->name) !=3D 0)
> =C2=A0=09=09=09continue;
> =C2=A0
> -=09=09if (strcmp(reactor->name, "nop"))
> -=09=09=09enable =3D false;
> -=09=09else
> -=09=09=09enable =3D true;
> -
> -=09=09monitor_swap_reactors(mon, reactor, enable);
> +=09=09monitor_swap_reactors(mon, reactor, true);
> =C2=A0
> =C2=A0=09=09retval =3D count;
> =C2=A0=09=09break;
> @@ -435,32 +420,12 @@ int reactor_populate_monitor(struct rv_monitor
> *mon)
> =C2=A0=09if (!tmp)
> =C2=A0=09=09return -ENOMEM;
> =C2=A0
> -=09/*
> -=09 * Configure as the rv_nop reactor.
> -=09 */
> -=09mon->reactor =3D get_reactor_rdef_by_name("nop");
> -=09mon->reacting =3D false;
> -
> =C2=A0=09return 0;
> =C2=A0}
> =C2=A0
> -/*
> - * Nop reactor register
> - */
> -__printf(1, 2) static void rv_nop_reaction(const char *msg, ...)
> -{
> -}
> -
> -static struct rv_reactor rv_nop =3D {
> -=09.name =3D "nop",
> -=09.description =3D "no-operation reactor: do nothing.",
> -=09.react =3D rv_nop_reaction
> -};
> -
> =C2=A0int init_rv_reactors(struct dentry *root_dir)
> =C2=A0{
> =C2=A0=09struct dentry *available, *reacting;
> -=09int retval;
> =C2=A0
> =C2=A0=09available =3D rv_create_file("available_reactors",
> RV_MODE_READ, root_dir, NULL,
> =C2=A0=09=09=09=09=C2=A0=C2=A0 &available_reactors_ops);
> @@ -471,16 +436,10 @@ int init_rv_reactors(struct dentry *root_dir)
> =C2=A0=09if (!reacting)
> =C2=A0=09=09goto rm_available;
> =C2=A0
> -=09retval =3D __rv_register_reactor(&rv_nop);
> -=09if (retval)
> -=09=09goto rm_reacting;
> -
> =C2=A0=09turn_reacting_on();
> =C2=A0
> =C2=A0=09return 0;
> =C2=A0
> -rm_reacting:
> -=09rv_remove(reacting);
> =C2=A0rm_available:
> =C2=A0=09rv_remove(available);
> =C2=A0out_err:

