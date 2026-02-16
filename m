Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6871305047
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771230541; cv=none; b=I+pmhoHF/fUKSIeC9HoFfwCINxUzYZTaWtMlqI+MDhMyVoKzPGWLJn5qEe4++HD/4fqEVE3irjE/fOP/+CDIWd33LKUqv7Frct3I7fv2L3ZsHDMT6Srbz8UKtMn/hq8LgGKWUNdkE1fpJi8uAX1FsQoJqpZfdMJmyMAPwgmq1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771230541; c=relaxed/simple;
	bh=jEDIHsAHgXlslEu2Ek6+JbJQSc36YkGcmdi2FbPtBt0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u23lL6prSCAvAa03Dd1VQhbxVydraHOl35S2NESRHG0ei5wcpx2No8c1XIK+YqwNIYf2rv+lpZZ3+Dx+1To4Lt5Wd3phsYMzCnMGbvxORgwD89OesK/8JqSF10cXeOFVDYZRUz4wpvXCl3E7VuK82q15mat9h2VrQOGxUJDAens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hX311ud9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hX311ud9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771230538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i3kuAKgGuKAnDt+udOFrf66VnmwjMl4ahSYtl30p46A=;
	b=hX311ud9fEcEGCJzmRQ/D5VgZVYPw5dJjjM7w5D9JaeDD9+AUGrk0TGkOjFxmlhKdDbicB
	arbxbzXbfJ+F0XB1tyONM8VaCDEQZz7PAJXYDIAG466XtncybPS95aGZRDMtxXN13BaQIm
	nI28CfTzy0rU2IF3oQAw3rUV+jsWk8U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-e2q98kB8O5GL_cZ-ss6XBw-1; Mon, 16 Feb 2026 03:28:57 -0500
X-MC-Unique: e2q98kB8O5GL_cZ-ss6XBw-1
X-Mimecast-MFC-AGG-ID: e2q98kB8O5GL_cZ-ss6XBw_1771230536
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43591aacca2so2729790f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 00:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771230536; x=1771835336;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zn8lHgOj3PQH5ymkw9IyWSJJ057nAg9wijGHmfAwHIE=;
        b=m60WMeZeuhmm+2wHUGIOtpXExpH6+M6nGzryrSBnoDxv2LV74lGk8II16PEAVlTmwZ
         wtNPjPylpKiLFyVufPDzFHaDZhYi/ZIz3PMGq5ZHW9fht0JoNshjOkIwlyNqTTm5KvmB
         OGph6juQ1MNcJ+Ti0cSO8tu9Vo7T5x8LOz+q1Rrshy8pTQ5UOkB6/zNF1lf1jGr4DR5W
         tcZI6u2pFEfzStcOiECQ2rZfm+cO5qM6YB3lJ1h1cJWMdSScU0ryxaW3YUmmURDRsin1
         jD5k5F+jC7odqhkIEEwAmIekrnTIFpc75UOaz9FLEw9YEPT/X4PA5xvKuuex2pWilS80
         F7mg==
X-Forwarded-Encrypted: i=1; AJvYcCXvPpWMWToAyI+DwmVH+TCg4wiT49JOiI2wViryHvKOl5s6XM0ePE7K20sULpiUKfc4nLKTnlnxgac94Hmln8WcsfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+opkEZTpZG/81Wz4glma6t7r3VoImRyJg/A8A8st5Sb7jesM
	XhgM40YgNa20W3bxP+GjAohZwJd2CiqMRjd8qUc7zMryK4MKTVeebzj3grubWqWS/qXNPjS6Y+3
	b2TbXROb4gbhfFq+6/DXCulT2GO01VYJKWE7azA2n5sw4NISWvFfFrXdVZnCpMFlY2wkofrcIl0
	e3XZV/womq
X-Gm-Gg: AZuq6aIOesavChpEKBxV3QCIElH7S8w4u+vPVzGLV6RWQLeaFzNUXLj/08e5Ow9CJVI
	rVixAmWgSks92rcqtxshVQIs19z4uZ/CR16nFtQAbgNvnQlEzCrd398pfDa2JC9EKlMKwBSBcMr
	FbsnSQGD4HRdZQpPxnO+kjs86lHWJkwlxQp1ui9OSVXluf26nowbHXIPP46MAApKt5c8gDlMDXp
	TQJTfFZHc+M6PZPiXSo+cCWy96ttx1fMBOlR7/1XSJu7OCrl3JlMknuUja9YWWQieeryVk/MlBj
	lS6AhCZ5Uq6PlA5EepPdb5Zfeb4GuCKmZe88M5VxCct2ik/bJPAe6XvfqTvRtbX6tLQTvVLqaDG
	lUPAlfYCifqgyn/w2s3CUCO2MTrfEHdfcngVTQznsA/+CC6YLGfzPnSuNfsZCLdL1kZU/Ws9tXD
	OMrprOPVBjbQcTaGP1Pe+l
X-Received: by 2002:a05:6000:2dc8:b0:437:6839:d5e with SMTP id ffacd0b85a97d-437978c75e1mr17117323f8f.13.1771230535699;
        Mon, 16 Feb 2026 00:28:55 -0800 (PST)
X-Received: by 2002:a05:6000:2dc8:b0:437:6839:d5e with SMTP id ffacd0b85a97d-437978c75e1mr17117296f8f.13.1771230535274;
        Mon, 16 Feb 2026 00:28:55 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abd793sm25294755f8f.25.2026.02.16.00.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 00:28:54 -0800 (PST)
Message-ID: <628790bb5ee45c8968550a54388862f020d014ff.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix multiple definition of __pcpu_unique_da_mon_this
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 16 Feb 2026 09:28:53 +0100
In-Reply-To: <20260216074727.741822-1-mikhail.v.gavrilov@gmail.com>
References: <20260216074727.741822-1-mikhail.v.gavrilov@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7d--f5h2omD_MzXMczNuGy3Vl3XJ4-clTqYolBSfOP0_1771230536
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-02-16 at 12:47 +0500, Mikhail Gavrilov wrote:
> The refactoring in commit 30984ccf31b7 ("rv: Refactor da_monitor to
> minimise macros") replaced per-monitor unique variable names
> (da_mon_##name) with a fixed name (da_mon_this).
>=20
> While this works for 'static' variables (each translation unit gets its
> own copy), DEFINE_PER_CPU internally generates a non-static dummy
> variable __pcpu_unique_<n> for each per-cpu definition. When multiple
> per-cpu monitors (e.g. sco and sts) are built-in simultaneously, they
> all produce the same __pcpu_unique_da_mon_this symbol, causing a link
> error:
>=20
> =C2=A0 ld: kernel/trace/rv/monitors/sts/sts.o: multiple definition of
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 `__pcpu_unique_da_mon_this';
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/trace/rv/monitors/sco/sco.o: first =
defined here
>=20
> Fix this by introducing a DA_MON_NAME macro that expands to a
> per-monitor unique name (da_mon_<MONITOR_NAME>) via the existing
> CONCATENATE helper. This restores the uniqueness that was present
> before the refactoring.

Thanks Mikhail,

I just got a report but you were faster sending the patch!

The __pcpu_unique_ variable (and with it the requirement for per-cpu variab=
les
to be unique although static) exists:
* for modules on specific achitectures (alpha)
* if the kernel is built with CONFIG_DEBUG_FORCE_WEAK_PER_CPU (e.g. Fedora'=
s
debug kernel)

Could you mention this in the commit message?
Also, it's alright using a unique name also for global monitors although no=
t
required, but please add a comment stating why this is needed at least for =
CPU
variables, to avoid the next "refactoring" to change it again. Something li=
ke:

  Per-cpu variables requires a unique name although static in some configur=
ations

Other than that, the change looks good.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

>=20
> Fixes: 30984ccf31b7 ("rv: Refactor da_monitor to minimise macros")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
> =C2=A0include/rv/da_monitor.h | 11 ++++++-----
> =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index db11d41bb438..f6da07863ed8 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -19,6 +19,7 @@
> =C2=A0#include <linux/stringify.h>
> =C2=A0#include <linux/bug.h>
> =C2=A0#include <linux/sched.h>
> +#define DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)
> =C2=A0
> =C2=A0static struct rv_monitor rv_this;
> =C2=A0
> @@ -183,14 +184,14 @@ static inline bool da_event(struct da_monitor *da_m=
on,
> struct task_struct *tsk,
> =C2=A0/*
> =C2=A0 * global monitor (a single variable)
> =C2=A0 */
> -static struct da_monitor da_mon_this;
> +static struct da_monitor DA_MON_NAME;
> =C2=A0
> =C2=A0/*
> =C2=A0 * da_get_monitor - return the global monitor address
> =C2=A0 */
> =C2=A0static struct da_monitor *da_get_monitor(void)
> =C2=A0{
> -=09return &da_mon_this;
> +=09return &DA_MON_NAME;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -223,14 +224,14 @@ static inline void da_monitor_destroy(void) { }
> =C2=A0/*
> =C2=A0 * per-cpu monitor variables
> =C2=A0 */
> -static DEFINE_PER_CPU(struct da_monitor, da_mon_this);
> +static DEFINE_PER_CPU(struct da_monitor, DA_MON_NAME);
> =C2=A0
> =C2=A0/*
> =C2=A0 * da_get_monitor - return current CPU monitor address
> =C2=A0 */
> =C2=A0static struct da_monitor *da_get_monitor(void)
> =C2=A0{
> -=09return this_cpu_ptr(&da_mon_this);
> +=09return this_cpu_ptr(&DA_MON_NAME);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -242,7 +243,7 @@ static void da_monitor_reset_all(void)
> =C2=A0=09int cpu;
> =C2=A0
> =C2=A0=09for_each_cpu(cpu, cpu_online_mask) {
> -=09=09da_mon =3D per_cpu_ptr(&da_mon_this, cpu);
> +=09=09da_mon =3D per_cpu_ptr(&DA_MON_NAME, cpu);
> =C2=A0=09=09da_monitor_reset(da_mon);
> =C2=A0=09}
> =C2=A0}

