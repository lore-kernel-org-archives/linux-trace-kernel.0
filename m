Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC421B4257
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Nov 2025 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364440; cv=none; b=umHbZAMBM/G+INuCiJWFR8fR+BO8vt2grInqgWnD+HEYEe6cLw37Mm2TdKO7DAmCK52nKoO+N2eqVsnFxKRFbHo3zBE9XEgYZXAB939bF9K+ngMtVCFMEENHNAgGK5UOe+5upY9UvuG1c80LmT6X1XkkUgBzFTRgms0J8oNAo8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364440; c=relaxed/simple;
	bh=oKzqeX75cXd5bjNdRluJidxU0OV7Q1BkqLMIiyps68M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFKjh8hcfOzmfn/4B37VuCjTyJ75mwCTYMUup85bxXYzy7gadipsHCo8N+JDBDEIRXLoKvswrWoTsNQnRG5RmHcac5yQSaVXKhkSvTR1TzpdgvgG5/OIFSW3SgKFuuj7TaLRVv0SBw6tcc9opVDKxUJWzs+90mfCs8pNap+xC7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCyLqzoa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCyLqzoa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763364437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oKzqeX75cXd5bjNdRluJidxU0OV7Q1BkqLMIiyps68M=;
	b=XCyLqzoa/VMR9jk59T2O8DXI9pt4oeBtgzzes7CfRktnOJpOvMW/TUHZtCG2Ve64wjgSrV
	92nd8iNioEd3DfJ+hscxwe4l8YhDPTeGjzfYvcMRAkOcruafH/fPslzHcVmF9uDjutPHAX
	XpyEDFq+7+XFvBXxdymb1/cmqr8y+3s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-p6yq-qU0MpmEq8LYGmJWEQ-1; Mon, 17 Nov 2025 02:27:15 -0500
X-MC-Unique: p6yq-qU0MpmEq8LYGmJWEQ-1
X-Mimecast-MFC-AGG-ID: p6yq-qU0MpmEq8LYGmJWEQ_1763364434
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429cd1d0d98so2835230f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Nov 2025 23:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763364434; x=1763969234;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XfReGVYt8gedLXNHKQWA8lz0lxzQsS/hZAf8h+4C/Q=;
        b=QhlCvnscRVxQqtd3IEY3oC7ECcsK+wGYyLacT3+NnSRUnAaRpPsPdhx2FDDP6eDlsC
         SBKQwDwr8xAzF8QBA2mxwrLgujZJ0mn84lsnc2Ll9D3GnzlcPAE3ndKzJM9BB3AF8rpY
         PMUz1/4+pgKLU/9IfkEzjm8Gv2kyZTFlwnxtCNcpW5uhq42bpXXtoSJbDmT6hp1TpqWu
         MYLJVsKxxmzcWocPpakudXJkIwoSjyIb6bil5vf0PG4XXA00qVvFWCABnwyiErmceO78
         TX8bmJmstDqIm495EIQFESkVvo8q38Dj+TOqMuoCa2ftt9DkNVv2J0XN2n7Vkv9EJUMT
         +tAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+akdUeilTB/FvlsJXs1+ov5a3r/jcVmZ4AE0UeTHfB1WYcT1ncZxE1wUIAEQZ0UcWIWV23+i7/SmsKvyMEYeLpd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEU+c3P88HP0+3o2mldR60qICElvZJGV5PusomIahZ8i6YjptH
	7htxoQJjZRgS6/UXIydlC210B8VZ8YvnrdEpTjg/6driFn1iOIteg0LEd8NMLMGDjQ5WdN/qVcq
	KwfYh8/bwV+rq0TNOUL3FC1MpHZdJjgVU9JX6eqSGcToSQdhHrF9A7z8e9NdSYn0TF3D7I/wh0E
	i9sEGYbfz9
X-Gm-Gg: ASbGncvLM7V3JZwmo1azgBtdY/xt8uA1xbof8VYVM5DLRKVvPzAEWTWgZedkHGLc1da
	36qNgmpnwKB0KT/qmNMXblltUfiijdtv76N4IT8sKskS44+4kWR2HP9JzMuZuG7dsZNzk3hMUSL
	BwF8SAxaZjxbvTuZaw802QLsfGQgDfWaTF+QkOhJ9si9yAwIvK9q0+ltPs593ftFZRIOTfzCe4O
	fD27hNXveB+E5qrh1neKNyXxFmqv576eqm/20bLZG3TH3DFKYQwucAI8vmlmlf+oIpfCCQlLQew
	LI3DyFbxYjyDQgCq1m/3rjgC0xgOKyLSaDGJlVaVE4C6HTr1U1gGHM54HXTYhu/b5OIPlv5ziNN
	eQ5jhg6E2ZzgZfdzonkDlRrjk
X-Received: by 2002:a05:6000:2405:b0:42b:3a84:1ec3 with SMTP id ffacd0b85a97d-42b5937ff2emr11469719f8f.29.1763364434309;
        Sun, 16 Nov 2025 23:27:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgv9n+I5f56kePGfs3qeSxsWE5OOS7Br5LF/KAhCLZiPZpVH4cHIjXXCVIYo7Ir4788yuzDA==
X-Received: by 2002:a05:6000:2405:b0:42b:3a84:1ec3 with SMTP id ffacd0b85a97d-42b5937ff2emr11469693f8f.29.1763364433890;
        Sun, 16 Nov 2025 23:27:13 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae47sm24134429f8f.4.2025.11.16.23.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 23:27:13 -0800 (PST)
Message-ID: <cb44571efe8157f126e519b7cf1932ad7feda7fb.camel@redhat.com>
Subject: Re: [PATCH 2/2] rv: Convert to use __free
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 17 Nov 2025 08:27:11 +0100
In-Reply-To: <6b2a618815b45ac4ac09976ef4fb0bd3635c143d.1763306824.git.namcao@linutronix.de>
References: <cover.1763306824.git.namcao@linutronix.de>
	 <6b2a618815b45ac4ac09976ef4fb0bd3635c143d.1763306824.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1TEATxHTn8K18dXi1TP5ToiO03A7VR37ZT-dgpCEdVU_1763364434
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2025-11-16 at 15:35 +0000, Nam Cao wrote:
> Convert to use __free to tidy up the code.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Both patches look very neat, thanks!

I have a few comments on this one:

> ---
> =C2=A0kernel/trace/rv/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 65 +++++++++++++++--------------------
> =C2=A0kernel/trace/rv/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 6 ++--
> =C2=A0kernel/trace/rv/rv_reactors.c | 32 ++++++++---------
> =C2=A03 files changed, 46 insertions(+), 57 deletions(-)
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index b1059a3cf4fa..e83dc9f0c7bb 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -420,35 +420,28 @@ static const struct file_operations interface_desc_=
fops
> =3D {
> =C2=A0static int create_monitor_dir(struct rv_monitor *mon, struct rv_mon=
itor
> *parent)
> =C2=A0{
> ...=C2=A0
> +=09mon->root_d =3D dir;
> +=09retain_and_null_ptr(dir);

I think you could just save a line by doing:

+=09mon->root_d =3D no_free_ptr(dir);

> =C2=A0=09return 0;
> -
> -out_remove_root:
> -=09rv_remove(mon->root_d);
> -=09return retval;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -827,39 +820,37 @@ int __init rv_init_interface(void)
> =C2=A0{
> =C2=A0=09struct dentry *tmp;
> =C2=A0=09int retval;
> +=09struct dentry *root_dir __free(rv_remove) =3D rv_create_dir("rv",
> NULL);
> =C2=A0
> -=09rv_root.root_dir =3D rv_create_dir("rv", NULL);
> -=09if (!rv_root.root_dir)
> -=09=09goto out_err;
> +=09if (!root_dir)
> +=09=09return 1;
> =C2=A0
> -=09rv_root.monitors_dir =3D rv_create_dir("monitors", rv_root.root_dir);
> +=09rv_root.monitors_dir =3D rv_create_dir("monitors", root_dir);
> =C2=A0=09if (!rv_root.monitors_dir)
> -=09=09goto out_err;
> +=09=09return 1;
> =C2=A0
> -=09tmp =3D rv_create_file("available_monitors", RV_MODE_READ,
> rv_root.root_dir, NULL,
> +=09tmp =3D rv_create_file("available_monitors", RV_MODE_READ, root_dir,
> NULL,
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 &available_monitors_ops);
> =C2=A0=09if (!tmp)
> -=09=09goto out_err;
> +=09=09return 1;
> =C2=A0
> -=09tmp =3D rv_create_file("enabled_monitors", RV_MODE_WRITE,
> rv_root.root_dir, NULL,
> +=09tmp =3D rv_create_file("enabled_monitors", RV_MODE_WRITE, root_dir,
> NULL,
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 &enabled_monitors_ops);
> =C2=A0=09if (!tmp)
> -=09=09goto out_err;
> +=09=09return 1;
> =C2=A0
> -=09tmp =3D rv_create_file("monitoring_on", RV_MODE_WRITE,
> rv_root.root_dir, NULL,
> +=09tmp =3D rv_create_file("monitoring_on", RV_MODE_WRITE, root_dir, NULL=
,
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 &monitoring_on_fops);
> =C2=A0=09if (!tmp)
> -=09=09goto out_err;
> -=09retval =3D init_rv_reactors(rv_root.root_dir);
> +=09=09return 1;
> +=09retval =3D init_rv_reactors(root_dir);
> =C2=A0=09if (retval)
> -=09=09goto out_err;
> +=09=09return 1;
> =C2=A0
> =C2=A0=09turn_monitoring_on();
> =C2=A0
> -=09return 0;
> +=09rv_root.root_dir =3D root_dir;
> +=09retain_and_null_ptr(root_dir);

Same as above:

+=09mon->root_d =3D no_free_ptr(root_dir);

> =C2=A0
> -out_err:
> -=09rv_remove(rv_root.root_dir);
> -=09printk(KERN_ERR "RV: Error while creating the RV interface\n");

By removing this, you are also not logging in case of failure, right?
I'm still liking to be rid of goto's, but what about moving this error repo=
rting
to the caller tracer_init_tracefs() ?

> -=09return 1;
> +=09return 0;
> =C2=A0}
> diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
> index 1485a70c1bf4..8661d1b6ede4 100644
> --- a/kernel/trace/rv/rv.h
> +++ b/kernel/trace/rv/rv.h
> @@ -17,6 +17,8 @@ struct rv_interface {
> =C2=A0#define rv_create_file=09=09=09tracefs_create_file
> =C2=A0#define rv_remove=09=09=09tracefs_remove
> =C2=A0
> +DEFINE_FREE(rv_remove, struct dentry *, rv_remove(_T));

It's kind of idiomatic to do things like `if (_T) free(_T)` in those.
Although free (like tracefs_remove) checks for null, it's probably safer to=
 keep
it that way here as well (as the entire system, including the return_ptr ma=
gic
relies on it):

+DEFINE_FREE(rv_remove, struct dentry *, if (_T) rv_remove(_T));

> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.=
c
> index 37d1d37a27a3..ce7d22cbde57 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -438,30 +439,25 @@ static struct rv_reactor rv_nop =3D {
> =C2=A0
> =C2=A0int init_rv_reactors(struct dentry *root_dir)
> =C2=A0{
> -=09struct dentry *available, *reacting;
> =C2=A0=09int retval;
> =C2=A0
> -=09available =3D rv_create_file("available_reactors", RV_MODE_READ,
> root_dir, NULL,
> -=09=09=09=09=C2=A0=C2=A0 &available_reactors_ops);
> -=09if (!available)
> -=09=09goto out_err;
> +=09struct dentry *available __free(rv_remove) =3D
> +=09=09rv_create_file("available_reactors", RV_MODE_READ, root_dir,
> +=09=09=09=09NULL, &available_reactors_ops);
> =C2=A0
> -=09reacting =3D rv_create_file("reacting_on", RV_MODE_WRITE, root_dir,
> NULL, &reacting_on_fops);
> -=09if (!reacting)
> -=09=09goto rm_available;
> +=09struct dentry *reacting =3D
> +=09=09rv_create_file("reacting_on", RV_MODE_WRITE, root_dir, NULL,
> &reacting_on_fops);

Nothing is removing "reacting_on" in case of successive failure, is it?
Am I missing anything or couldn't we just set both variables to __free() ?

Thanks,
Gabriele

> +
> +=09if (!reacting || !available)
> +=09=09return -ENOMEM;
> =C2=A0
> =C2=A0=09retval =3D __rv_register_reactor(&rv_nop);
> =C2=A0=09if (retval)
> -=09=09goto rm_reacting;
> +=09=09return retval;
> =C2=A0
> =C2=A0=09turn_reacting_on();
> =C2=A0
> +=09retain_and_null_ptr(available);
> +=09retain_and_null_ptr(reacting);
> =C2=A0=09return 0;
> -
> -rm_reacting:
> -=09rv_remove(reacting);
> -rm_available:
> -=09rv_remove(available);
> -out_err:
> -=09return -ENOMEM;
> =C2=A0}

