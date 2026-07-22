Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602B3655CA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731361; cv=none; b=ZBJ6xcc6DAG4PqFWmtUdjKNPJap8OCWWy/nWR84h4YyjYoFm+KEc4a8/ok3tqfeP/tzFewcaelfGZjtr3MMJJc54PfL/lvtbduLkNr34ERrP4WK+Xx6wVT4eOXQs1iGqpz/RmjOL4pXQilkvsMLzKpRIGor8raWwDfA3uzs50fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731361; c=relaxed/simple;
	bh=5/47GD4lDjaUBdswEbKsUSqJnIBZ1MWTg6Mpw+okSIU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxZAjfGcjwiqyXdgaLXhAyGZYRVWJaD0WubQiOrCoRO72eEhvsJFWOF2zcBzgSTp2ovkYOiQq0zV0E5ZxUBh/DyP4e9KqGL1h1BrfBViGMERVe5/lrF8TRc6CEvUrT8d/vMbZHVTLQQOBbwkRp69G7EIaGEfKDopArc93eL9BCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6GNvYxv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6GNvYxv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784731358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CrHG93/sb4TsAWAEUHiyyrqk79fy28Sa07vJ60geQ2U=;
	b=i6GNvYxvU9GVB3P2kZlJf3kQa9s6YjLmwtzh8P7nHryETKb8oCMJ7qbvwBKR8TiPgIap35
	dFpmgTQxefYS4CNwB6mm9KAOMy1ueGcQhgGg2stFoGcI6wcPAPScptL56muylk34x0KcPt
	1knroXprCeYeCxG0Ya0EsGQUnroQ6cI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-nlpbjR_zM6aATSAi12EPUg-1; Wed, 22 Jul 2026 10:42:37 -0400
X-MC-Unique: nlpbjR_zM6aATSAi12EPUg-1
X-Mimecast-MFC-AGG-ID: nlpbjR_zM6aATSAi12EPUg_1784731356
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15f4732dfaso1392195766b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 07:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784731356; x=1785336156;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fv7S9xnzeNkgckKPxKGiukDkgSkYwdABYq3Cxat9xRM=;
        b=fD33rfoap63aF68Ruu4YZnCGlXy4vB1X/RLgqL6fHYyvAbsWj3Ut9Z1wMzYjtK99xl
         czypg/GQQ+n950A03Mkp4nq7nA+968UaJKkK+kLMZo9x84VNz36XNxtCcWZRdZ2r6tsE
         AxeZqosP2X4VpCszzW0oQN8sjzpETYIr4wLeOF+cOeAyrCBy6ZZkuSjpoOjdUpugnwUB
         lb6DFyBBm7rDOMZQall1STsIMTvGTouwLlY++1hYAH7ZjVlXMC5tmX7xmYVqwr9h4t42
         k8VHej0WmbrBPFl4llluIicvLZRu+ZNQ5onnvzc7nGeW4mWm8eHn82ecL7tjRC4Ykw4G
         J7qw==
X-Forwarded-Encrypted: i=1; AHgh+RpghxSoQpKKGddFZPGbMqs4KYgdJCe8JwN1AzYhHUbyf7lVOHRNKbDYA5QM189WXbrJM5CeON2NSbDAtRrltSVluaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Kr4m91f8dpBH4XHIx/Uc7fGoQZnEF9eI35RWnMzLfVqpKy3u
	kJqxW1W8PX6q36MAOX6yV2ukSnWkW4v7gvUMFsOAZOiOGk/oJKcf5QFajDfFLTJ0AYqzEiN13RN
	4ID9YJpRHdiTfKiICtAeN/oyMv3PouonIpcOUU5Q5Yr/+8qYdtPkLAINp+FTGCKj0k0T2UdNTBr
	8hgRkvhXgv
X-Gm-Gg: AR+sD11xE+D+bzZkadI70KA3XdJDJOxVMuwu4+23IKHMstIhIrEC6heT4CGaMcaDWFH
	DsJda06EuVAAy2pMfGgFGyS2XZL+VmaLd0aobU45Ntm46tC2dqXA+q7ec9pjR7sgq8Ms/ZMyVZN
	U9rgzgofF/Qa8vm5wEk1EItGxrjsQfqA+47M0pVCVsamYIgach4/+K5TtChzqLNbqPAqBioiZki
	nD7JMjfbs/ufjorBM0MDQmYjopP+RLnmUQWOE55KB5xNggazvLHdW/Qv/8jNxMBD6w9SJMGnrcz
	/Pdt+xArta3DNA+pOQzEY/CCn5wWMao1dzZ6+7p98MxzsnmQaAqpZtSOAG4e1uhHAHDXfXGlfot
	mM2e/xyPGLuoyMmWkaBOn2+/b9skBPagFhyIxnUOG5dgtKZtGq1MeCjBPzMTmzkqzBxO4vw==
X-Received: by 2002:a17:907:c0b:b0:c16:e54:9cbb with SMTP id a640c23a62f3a-c16b46fda3bmr1113247466b.25.1784731355890;
        Wed, 22 Jul 2026 07:42:35 -0700 (PDT)
X-Received: by 2002:a17:907:c0b:b0:c16:e54:9cbb with SMTP id a640c23a62f3a-c16b46fda3bmr1113245266b.25.1784731355431;
        Wed, 22 Jul 2026 07:42:35 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac936dsm122446266b.22.2026.07.22.07.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:42:35 -0700 (PDT)
Message-ID: <7dbb7caf3364c3efe29264d51b208097df10c327.camel@redhat.com>
Subject: Re: [PATCH v4 7/8] rv/tlob: add KUnit tests for the tlob monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 22 Jul 2026 16:42:33 +0200
In-Reply-To: <18ab97e8a248e55dfeef5daa49daa407bf58dc56.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
	 <18ab97e8a248e55dfeef5daa49daa407bf58dc56.1783524627.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: _Xxd3wL0rKV06KC1IIGqZIPFjO1PyVWm4RFMoWE7SnU_1784731356
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-08 at 23:38 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>

...

> +++ b/kernel/trace/rv/monitors/tlob/.kunitconfig
> @@ -0,0 +1,8 @@
> +CONFIG_FTRACE=3Dy
> +CONFIG_HIGH_RES_TIMERS=3Dy
> +CONFIG_KUNIT=3Dy
> +CONFIG_MODULES=3Dy
> +CONFIG_RV=3Dy
> +CONFIG_RV_MON_TLOB=3Dy
> +CONFIG_TLOB_KUNIT_TEST=3Dy
> +CONFIG_UPROBES=3Dy

Let's perhaps drop here what isn't a (mostly) direct dependency and make
it slimmer? Others are requirements of those anyway (and if they stop
being so, they aren't required for the test either).

  CONFIG_KUNIT=3Dy
  CONFIG_UPROBES=3Dy
  CONFIG_RV=3Dy
  CONFIG_RV_MON_TLOB=3Dy
  CONFIG_TLOB_KUNIT_TEST=3Dy

> diff --git a/kernel/trace/rv/monitors/tlob/Kconfig
> b/kernel/trace/rv/monitors/tlob/Kconfig
> index aa43382073d2..402ef2e5c076 100644
> --- a/kernel/trace/rv/monitors/tlob/Kconfig
> +++ b/kernel/trace/rv/monitors/tlob/Kconfig
> @@ -10,3 +10,10 @@ config RV_MON_TLOB
> =C2=A0=09=C2=A0 monitor.=C2=A0 tlob tracks per-task elapsed wall-clock ti=
me across a
> =C2=A0=09=C2=A0 user-delimited code section and emits error_env_tlob when=
 the
> =C2=A0=09=C2=A0 elapsed time exceeds a configurable per-invocation budget=
.
> +
> +config TLOB_KUNIT_TEST
> +=09tristate "KUnit tests for tlob monitor" if !KUNIT_ALL_TESTS
> +=09depends on RV_MON_TLOB && KUNIT
> +=09default KUNIT_ALL_TESTS
> +=09help
> +=09=C2=A0 Enable KUnit unit tests for the tlob RV monitor.
> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c
> b/kernel/trace/rv/monitors/tlob/tlob.c
> index b45e84195131..a6f9c371646c 100644
> --- a/kernel/trace/rv/monitors/tlob/tlob.c
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
> @@ -708,7 +708,7 @@ static ssize_t tlob_monitor_read(struct file *file,
> =C2=A0 * PATH may contain ':'; the last ':' separates path from offset.
> =C2=A0 * Returns 0, -EINVAL, or -ERANGE.
> =C2=A0 */
> -static int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
> +VISIBLE_IF_KUNIT int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
> =C2=A0=09=09=09=09=C2=A0 char **path_out,
> =C2=A0=09=09=09=09=C2=A0 loff_t *start_out, loff_t *stop_out)
> =C2=A0{
> @@ -782,6 +782,7 @@ static int tlob_parse_uprobe_line(char *buf, u64 *thr=
_out,
> =C2=A0=09*stop_out=C2=A0 =3D (loff_t)stop_val;
> =C2=A0=09return 0;
> =C2=A0}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_parse_uprobe_line);
> =C2=A0
> =C2=A0/*
> =C2=A0 * Parse "-PATH:OFFSET_START" (ftrace uprobe_events removal convent=
ion).
> @@ -810,8 +811,9 @@ VISIBLE_IF_KUNIT int tlob_parse_remove_line(char *buf=
,
> char **path_out,
> =C2=A0=09*start_out =3D (loff_t)off;
> =C2=A0=09return 0;
> =C2=A0}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_parse_remove_line);
> =C2=A0
> -VISIBLE_IF_KUNIT int tlob_create_or_delete_uprobe(char *buf)
> +static int tlob_create_or_delete_uprobe(char *buf)

That's a nit, but probably all the VISIBLE_IF_KUNIT /
EXPORT_SYMBOL_IF_KUNIT should be added by this patch alone.

And definitely tlob_create_or_delete_uprobe shouldn't have it in the
earlier patch just for it to be removed here.

> =C2=A0{
> =C2=A0=09loff_t offset_start, offset_stop;
> =C2=A0=09u64 threshold_ns;
> @@ -836,7 +838,6 @@ VISIBLE_IF_KUNIT int tlob_create_or_delete_uprobe(cha=
r
> *buf)
> =C2=A0=09mutex_unlock(&tlob_uprobe_mutex);
> =C2=A0=09return ret;
> =C2=A0}
> -EXPORT_SYMBOL_IF_KUNIT(tlob_create_or_delete_uprobe);
> =C2=A0
> =C2=A0static ssize_t tlob_monitor_write(struct file *file,
> =C2=A0=09=09=09=09=C2=A0 const char __user *ubuf,
> diff --git a/kernel/trace/rv/monitors/tlob/tlob.h
> b/kernel/trace/rv/monitors/tlob/tlob.h
> index fceeba748c85..15bdf3b7fade 100644
> --- a/kernel/trace/rv/monitors/tlob/tlob.h
> +++ b/kernel/trace/rv/monitors/tlob/tlob.h
> @@ -145,7 +145,9 @@ int tlob_start_task(struct task_struct *task, u64
> threshold_ns);
> =C2=A0int tlob_stop_task(struct task_struct *task);
> =C2=A0
> =C2=A0#if IS_ENABLED(CONFIG_KUNIT)

Any reason not to use IS_ENABLED(CONFIG_TLOB_KUNIT_TEST) ?

> -int tlob_create_or_delete_uprobe(char *buf);
> +int tlob_parse_uprobe_line(char *buf, u64 *thr_out, char **path_out,
> +=09=09=09=C2=A0=C2=A0 loff_t *start_out, loff_t *stop_out);
> +int tlob_parse_remove_line(char *buf, char **path_out, loff_t *start_out=
);

Same here, those can all be exported in this patch, no need to mention
any KUNIT stuff earlier.

> =C2=A0#endif /* CONFIG_KUNIT */
> =C2=A0
> =C2=A0#endif /* _RV_TLOB_H */
> diff --git a/kernel/trace/rv/monitors/tlob/tlob_kunit.c
> b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
> new file mode 100644
> index 000000000000..7448f3fab959
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for the tlob RV monitor.
> + *
> + */

Besides the minor nits above, tests look good.

Thanks,
Gabriele

> +#include <kunit/test.h>
> +
> +#include "tlob.h"
> +
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> +
> +/* Valid "p PATH:START STOP threshold=3DNS" lines. */
> +static const char * const tlob_parse_valid[] =3D {
> +=09"p /usr/bin/myapp:4768 4848 threshold=3D5000000",
> +=09"p /usr/bin/myapp:0x12a0 0x12f0 threshold=3D10000000",
> +=09"p /opt/my:app/bin:0x100 0x200 threshold=3D1000000",
> +};
> +
> +/* Malformed "p ..." lines that must be rejected with -EINVAL. */
> +static const char * const tlob_parse_invalid[] =3D {
> +=09"p :0x100 0x200 threshold=3D5000",
> +=09"p /usr/bin/myapp:0x100 threshold=3D5000",
> +=09"p /usr/bin/myapp:-1 0x200 threshold=3D5000",
> +=09"p /usr/bin/myapp:0x100 -1 threshold=3D5000000",=09/* negative stop
> offset */
> +=09"p /usr/bin/myapp:0x100 0x200",
> +=09"p /usr/bin/myapp:0x100 0x100 threshold=3D5000",
> +};
> +
> +/* threshold_ns out of valid range =3D> -ERANGE. */
> +static const char * const tlob_parse_out_of_range[] =3D {
> +=09"p /usr/bin/myapp:0x100 0x200 threshold=3D0",
> +=09"p /usr/bin/myapp:0x100 0x200 threshold=3D999",
> +=09"p /usr/bin/myapp:0x100 0x200 threshold=3D3600000000001",
> +};
> +
> +/* Valid "-PATH:OFFSET_START" remove lines. */
> +static const char * const tlob_remove_valid[] =3D {
> +=09"-/usr/bin/myapp:0x100",
> +=09"-/opt/my:app/bin:0x200",
> +};
> +
> +/* Malformed remove lines that must be rejected with -EINVAL. */
> +static const char * const tlob_remove_invalid[] =3D {
> +=09"-usr/bin/myapp:0x100",
> +=09"-/usr/bin/myapp",
> +=09"-/:0x100",
> +=09"-/usr/bin/myapp:-1",=09/* negative offset */
> +=09"-/usr/bin/myapp:abc",
> +};
> +
> +static void tlob_parse_valid_accepted(struct kunit *test)
> +{
> +=09u64 thr;
> +=09char *path;
> +=09loff_t start, stop;
> +=09char buf[128];
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_parse_valid); i++) {
> +=09=09strscpy(buf, tlob_parse_valid[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_EQ(test, tlob_parse_uprobe_line(buf, &thr,
> &path,
> +=09=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 &start, &stop),
> 0);
> +=09}
> +}
> +
> +static void tlob_parse_invalid_rejected(struct kunit *test)
> +{
> +=09u64 thr;
> +=09char *path;
> +=09loff_t start, stop;
> +=09char buf[128];
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_parse_invalid); i++) {
> +=09=09strscpy(buf, tlob_parse_invalid[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_EQ(test, tlob_parse_uprobe_line(buf, &thr,
> &path,
> +=09=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 &start, &stop),
> -EINVAL);
> +=09}
> +}
> +
> +static void tlob_parse_out_of_range_rejected(struct kunit *test)
> +{
> +=09u64 thr;
> +=09char *path;
> +=09loff_t start, stop;
> +=09char buf[128];
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_parse_out_of_range); i++) {
> +=09=09strscpy(buf, tlob_parse_out_of_range[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_EQ(test, tlob_parse_uprobe_line(buf, &thr,
> &path,
> +=09=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 &start, &stop),
> -ERANGE);
> +=09}
> +}
> +
> +static void tlob_remove_valid_accepted(struct kunit *test)
> +{
> +=09char *path;
> +=09loff_t start;
> +=09char buf[128];
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_remove_valid); i++) {
> +=09=09strscpy(buf, tlob_remove_valid[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_EQ(test, tlob_parse_remove_line(buf, &path,
> &start), 0);
> +=09}
> +}
> +
> +static void tlob_remove_invalid_rejected(struct kunit *test)
> +{
> +=09char *path;
> +=09loff_t start;
> +=09char buf[128];
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_remove_invalid); i++) {
> +=09=09strscpy(buf, tlob_remove_invalid[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_EQ(test, tlob_parse_remove_line(buf, &path,
> &start), -EINVAL);
> +=09}
> +}
> +
> +static struct kunit_case tlob_parse_cases[] =3D {
> +=09KUNIT_CASE(tlob_parse_valid_accepted),
> +=09KUNIT_CASE(tlob_parse_invalid_rejected),
> +=09KUNIT_CASE(tlob_parse_out_of_range_rejected),
> +=09KUNIT_CASE(tlob_remove_valid_accepted),
> +=09KUNIT_CASE(tlob_remove_invalid_rejected),
> +=09{}
> +};
> +
> +static struct kunit_suite tlob_parse_suite =3D {
> +=09.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "tlob_parse",
> +=09.test_cases =3D tlob_parse_cases,
> +};
> +
> +kunit_test_suite(tlob_parse_suite);
> +
> +MODULE_DESCRIPTION("KUnit tests for the tlob RV monitor");
> +MODULE_LICENSE("GPL");

