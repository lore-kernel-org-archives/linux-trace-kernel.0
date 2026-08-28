Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7863AAF6F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909664; cv=none; b=guwNTs6rGMzqDaeMFtNrkf9sO2NKdCt0ghH6+7XZPhmU6yqKCBUzgEQC64JYYXxMrWul8n0Zrm4x2qegaXEs0he/XoBN5tS1e/5lTKJSqNdxlDnV5s3rSSsRgrkcgT9ICmZ2/PFK1wtpwZj493pSSneE6MCt1v9xVKr4br5lCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909664; c=relaxed/simple;
	bh=w+bvbS2fsEv6VKwHf4Xt2iOFxShfK9H0CK7MeZZwasY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXYgxBiZfOzST9s99fLbQD3rg5wFrs05TIlfr8z32QVnblqLvFdpvLuZShRmckGTyL9w8R0pkGamDUymeroZNKbbs1d2/u2KBOUrrPHGKG+uMNioyp1UxOD4ocF0xyI2cVnKiSP9FikN2qKQJU+RD6GeNDzwnkHr1qEFJMqEwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJ8y1UHj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJ8y1UHj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787909650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n2NYqoZD5CkbRbDcCdYOWI7GvglFMu6udNQ5b8KC0Tg=;
	b=OJ8y1UHjn4Wu2honDHExuscQx9ITNwGxZVKYiyjqo2IADgNyQLWi+XhX0dD/we/PlPWWaH
	/2aRfUpyxgnrGsZrSuwZL7QjBx603a20ASCPVnmRPCNpYyVPYLIDh9JSyTM6aMh9yhvT7P
	96d9KpK8doMg/vI21NRUhZGAWSfrbFI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-j28cDZfJN0qcLyFrCNK3tg-1; Fri, 28 Aug 2026 05:34:08 -0400
X-MC-Unique: j28cDZfJN0qcLyFrCNK3tg-1
X-Mimecast-MFC-AGG-ID: j28cDZfJN0qcLyFrCNK3tg_1787909647
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c20262b5e10so92024166b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 02:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787909647; x=1788514447;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dQTICCJXl2X0WGp329fFXq3Nl3Kt6Nfx6kVTjp8/j+w=;
        b=Wq7uDwkOjlXelfhz4BTNeQ50jIppP1xi71jXTJt1VEmHI9W23Ysoj4gX9yU5JPAG5J
         JINVsT4rETbwG3z5/j473fTk0w93JKNA9XgMsCu3NXOB9fUoWGU/2FRxXF5Oftiq7Gqb
         wtuZjUnt9q0hJTbpeGfDnCX16KoKNocNRMVk9V9EokrV/tyMpETBCsHrZP3mq5S+oI/g
         6JnuNJYOAnp7fwVEQrVTTYfQklCn370SgBIFhVnO8fZQi01xCnWaNQkUTNnqZ2H4/tjc
         Fj93PSQ8TZ6TUBv0eEI6fFNhOU195CbtMdwgwDddEicncfQqrzQFKPm0doKeTkvtbYKo
         B+sg==
X-Forwarded-Encrypted: i=1; AHgh+Rpn1NeUKK9Rx7X2xz8Kxk4O2UT0VoRksjBJeWFqOZ8UnnAiW7be4hblv97B2fled3LDkJrBb7wyOxpTl2l5EjgMVqE=@vger.kernel.org
X-Gm-Message-State: AFuF++kwLlVC4UW8xTLSzMoCy79BrZxA1IFA8Rpkul/NBOekVnK9rwxn
	oTq2gVGgDIKk4yjT/XRukc2SmET/kETisdEwyBW3CCxE086LZgua843hS7PVuVsI78MNQFzpgWH
	LK0VnXBH1U+A2G4AC5qQW9Ps+9r+RsKVaLsSWPRFviQeEQVLDzFhjmQ79uRVMTNoFgnG3Xroa5w
	==
X-Gm-Gg: AR+sD134RKsztYRPg5MMop2bdv2SVPouFMxEOSz6DYNhfJs63DOAqq0Uhh1sGfMtB36
	cE1PVRgwYBu1fHgOgCbSdXN343xo7RemjxL/QICgJM6idRknA7p7d+w2o4BvD1A6Wf3f6WUqozm
	No/eEEe3aNe/0+PpYZ5acghu8pvkLGxgPp1iJLx8J/TBgbhra3qRR8MKH26FuKoMLbPTOrntid3
	IjUZ02u0viKWQYUXS2mfDCXBikgzqj+AQPKiAgGe5ZzSVUxFV5s9/ProCBxJ1bPn6Bo3e7k3uMh
	R9Yzelg/ouJS45W1NixyjxR3WKn5Kjratq1xy7LAvU+1hKy7vu48Y+Rx0I3pFAd6QTFFXUNcroJ
	kFVvBQzNPiaXjwLVTUg4Mgy8ap39fwrwKJVrreGjW1qBUb00Za/FssevgRneb4XMPdluMXg==
X-Received: by 2002:a17:907:e1d3:10b0:c16:8799:fcb4 with SMTP id a640c23a62f3a-c25571a63c1mr257802266b.19.1787909645882;
        Fri, 28 Aug 2026 02:34:05 -0700 (PDT)
X-Received: by 2002:a17:907:e1d3:10b0:c16:8799:fcb4 with SMTP id a640c23a62f3a-c25571a63c1mr257783066b.19.1787909643887;
        Fri, 28 Aug 2026 02:34:03 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee0b233sm59809966b.11.2026.08.28.02.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:34:03 -0700 (PDT)
Message-ID: <acbfc93eb94f5a2dfb0bd7fded98619fa750d27d.camel@redhat.com>
Subject: Re: [PATCH v6 7/9] rv: Add KUnit tests for the tlob monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 28 Aug 2026 11:34:01 +0200
In-Reply-To: <aa1cd3f917a0a2a782abe6f1faf51547fb09224a.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
	 <aa1cd3f917a0a2a782abe6f1faf51547fb09224a.1787243842.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: QGatN5du1dfugWNoH6AwrsWZWwBWme-C4-ndOh4bPlw_1787909647
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-08-21 at 00:45 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add a test case to the shared rv_monitors_test.c suite (gated by the
> existing CONFIG_RV_MONITORS_KUNIT_TEST, same as nomiss/sco/etc.)
> covering the uprobe-line parser.
>=20
> tlob_parse_uprobe_line() and tlob_parse_remove_line() stay static and
> unconditional: production code (tlob_create_or_delete_uprobe()) always
> needs them, so they can't be compiled out, and un-hiding them via
> VISIBLE_IF_KUNIT would tie their linkage to CONFIG_KUNIT while nothing
> else in tlob.c depends on it. Instead, expose them to the test only
> through a const rv_tlob_kunit_ops struct of function pointers, built
> and exported the same way nomiss.c/sco.c expose their rv_<mon>_ops:
> the struct itself, its declaration in tlob_kunit.h, and its use in
> tlob_kunit.c are all gated on the single CONFIG_RV_MONITORS_KUNIT_TEST
> symbol, so there is no separate prototype to go out of sync with a
> visibility macro.
>=20
> tlob_kunit.c follows the monitors/*/*_kunit.c convention: one
> rv_test_tlob() case textually included into rv_monitors_test.c,
> guarded by IS_REACHABLE(CONFIG_RV_MON_TLOB) with an rv_test_stub()
> fallback so the shared suite still builds when RV_MON_TLOB=3Dn (that
> symbol is independent of CONFIG_RV_MONITORS_KUNIT_TEST). Drop the
> per-monitor TLOB_KUNIT_TEST Kconfig entry, .kunitconfig, and Makefile
> line that a standalone test module would have needed.
>=20
> Cases cover valid inputs, malformed paths and offsets (including
> negative values), out-of-range thresholds, and valid and invalid
> remove lines.
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---

Tests look good, however this commit message is overdoing it.
Try to avoid mentioning implementation details in commit messages, especial=
ly
those referring to older versions of the same patch (you do it often but th=
is
really stands out).

Good commit messages usually state the problem and delineate how the soluti=
on
addresses it, without repeating what's done in the patch but explaining the
ideas behind it. Here you aren't really addressing a problem (you're adding=
 a
/feature/), so you can even be shorter. Remember to focus on /what/ is done
rather than /how/. This is sufficient:

  rv: Add KUnit tests for the tlob monitor

  Add a test case to the shared rv_monitors_test.c suite covering
  the uprobe-line parser in the tlob monitor.

  Cases cover valid inputs, malformed paths and offsets (including
  negative values), out-of-range thresholds, and valid and invalid
  remove lines.

I suggest you find some AI skills to write commit messages more tailored to=
 the
kernel if that's how you write commit messages. caveman-commit [1] usually =
does
a decent job, though it's more generic and needs some changes. You can even=
 get
one written by your agent based on some (arguably) good commit messages you=
 find
with git log (e.g. filter by author or subsystem).


Anyway this is minor (but address it in v7!), the patch looks good:

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

[1] - https://github.com/JuliusBrussee/caveman

> =C2=A0kernel/trace/rv/monitors/tlob/tlob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 24 ++++--
> =C2=A0kernel/trace/rv/monitors/tlob/tlob_kunit.c | 87 +++++++++++++++++++=
+++
> =C2=A0kernel/trace/rv/monitors/tlob/tlob_kunit.h | 17 +++++
> =C2=A0kernel/trace/rv/rv_monitors_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +
> =C2=A04 files changed, 122 insertions(+), 8 deletions(-)
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob_kunit.h
>=20
> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c
> b/kernel/trace/rv/monitors/tlob/tlob.c
> index 08b1bee884cc..18150cbf57a5 100644
> --- a/kernel/trace/rv/monitors/tlob/tlob.c
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
> @@ -20,7 +20,6 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/rv.h>
> =C2=A0#include <linux/slab.h>
> -#include <kunit/visibility.h>
> =C2=A0#include <rv/instrumentation.h>
> =C2=A0#include <rv/rv_uprobe.h>
> =C2=A0#include <rv.h>
> @@ -877,9 +876,9 @@ static ssize_t tlob_monitor_read(struct file *file,
> =C2=A0 * PATH may contain ':'; the last ':' separates path from offset.
> =C2=A0 * Returns 0, -EINVAL, or -ERANGE.
> =C2=A0 */
> -VISIBLE_IF_KUNIT int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
> -=09=09=09=09=09=C2=A0=C2=A0=C2=A0 char **path_out,
> -=09=09=09=09=09=C2=A0=C2=A0=C2=A0 loff_t *start_out, loff_t
> *stop_out)
> +static int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
> +=09=09=09=09=C2=A0 char **path_out,
> +=09=09=09=09=C2=A0 loff_t *start_out, loff_t *stop_out)
> =C2=A0{
> =C2=A0=09unsigned long long thr =3D 0, stop_val =3D 0;
> =C2=A0=09long long start_val;
> @@ -951,13 +950,12 @@ VISIBLE_IF_KUNIT int tlob_parse_uprobe_line(char *b=
uf,
> u64 *thr_out,
> =C2=A0=09*stop_out=C2=A0 =3D (loff_t)stop_val;
> =C2=A0=09return 0;
> =C2=A0}
> -EXPORT_SYMBOL_IF_KUNIT(tlob_parse_uprobe_line);
> =C2=A0
> =C2=A0/*
> =C2=A0 * Parse "-PATH:OFFSET_START" (ftrace uprobe_events removal convent=
ion).
> =C2=A0 */
> -VISIBLE_IF_KUNIT int tlob_parse_remove_line(char *buf, char **path_out,
> -=09=09=09=09=09=C2=A0=C2=A0=C2=A0 loff_t *start_out)
> +static int tlob_parse_remove_line(char *buf, char **path_out,
> +=09=09=09=09=C2=A0 loff_t *start_out)
> =C2=A0{
> =C2=A0=09char *binpath, *colon;
> =C2=A0=09long long off;
> @@ -980,7 +978,17 @@ VISIBLE_IF_KUNIT int tlob_parse_remove_line(char *bu=
f,
> char **path_out,
> =C2=A0=09*start_out =3D (loff_t)off;
> =C2=A0=09return 0;
> =C2=A0}
> -EXPORT_SYMBOL_IF_KUNIT(tlob_parse_remove_line);
> +
> +#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
> +#include <kunit/visibility.h>
> +#include "tlob_kunit.h"
> +
> +const struct rv_tlob_kunit_ops rv_tlob_kunit_ops =3D {
> +=09.parse_uprobe_line =3D tlob_parse_uprobe_line,
> +=09.parse_remove_line =3D tlob_parse_remove_line,
> +};
> +EXPORT_SYMBOL_IF_KUNIT(rv_tlob_kunit_ops);
> +#endif
> =C2=A0
> =C2=A0static int tlob_create_or_delete_uprobe(char *buf)
> =C2=A0{
> diff --git a/kernel/trace/rv/monitors/tlob/tlob_kunit.c
> b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
> new file mode 100644
> index 000000000000..a8987fba2533
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob_kunit.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include "tlob_kunit.h"
> +
> +#if IS_REACHABLE(CONFIG_RV_MON_TLOB)
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
> +static void rv_test_tlob(struct kunit *test)
> +{
> +=09u64 thr;
> +=09char *path;
> +=09loff_t start, stop;
> +=09char buf[128];
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_parse_valid); i++) {
> +=09=09strscpy(buf, tlob_parse_valid[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_EQ(test,
> rv_tlob_kunit_ops.parse_uprobe_line(buf, &thr, &path,
> +=09=09=09=09=09=09=09=09=09=C2=A0
> &start, &stop), 0);
> +=09}
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_parse_invalid); i++) {
> +=09=09strscpy(buf, tlob_parse_invalid[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_EQ(test,
> rv_tlob_kunit_ops.parse_uprobe_line(buf, &thr, &path,
> +=09=09=09=09=09=09=09=09=09=C2=A0
> &start, &stop), -EINVAL);
> +=09}
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_parse_out_of_range); i++) {
> +=09=09strscpy(buf, tlob_parse_out_of_range[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_EQ(test,
> rv_tlob_kunit_ops.parse_uprobe_line(buf, &thr, &path,
> +=09=09=09=09=09=09=09=09=09=C2=A0
> &start, &stop), -ERANGE);
> +=09}
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_remove_valid); i++) {
> +=09=09strscpy(buf, tlob_remove_valid[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_EQ(test,
> rv_tlob_kunit_ops.parse_remove_line(buf, &path, &start), 0);
> +=09}
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(tlob_remove_invalid); i++) {
> +=09=09strscpy(buf, tlob_remove_invalid[i], sizeof(buf));
> +=09=09KUNIT_EXPECT_EQ(test,
> rv_tlob_kunit_ops.parse_remove_line(buf, &path, &start),
> +=09=09=09=09-EINVAL);
> +=09}
> +}
> +
> +#else
> +#define rv_test_tlob rv_test_stub
> +#endif
> diff --git a/kernel/trace/rv/monitors/tlob/tlob_kunit.h
> b/kernel/trace/rv/monitors/tlob/tlob_kunit.h
> new file mode 100644
> index 000000000000..4c1081871ea3
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob_kunit.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __TLOB_KUNIT_H
> +#define __TLOB_KUNIT_H
> +
> +#if IS_ENABLED(CONFIG_RV_MONITORS_KUNIT_TEST)
> +
> +#include <linux/types.h>
> +
> +extern const struct rv_tlob_kunit_ops {
> +=09int (*parse_uprobe_line)(char *buf, u64 *thr_out, char **path_out,
> +=09=09=09=09 loff_t *start_out, loff_t *stop_out);
> +=09int (*parse_remove_line)(char *buf, char **path_out, loff_t
> *start_out);
> +} rv_tlob_kunit_ops;
> +
> +#endif
> +
> +#endif /* __TLOB_KUNIT_H */
> diff --git a/kernel/trace/rv/rv_monitors_test.c
> b/kernel/trace/rv/rv_monitors_test.c
> index 3ad11195e664..791df0fe03e3 100644
> --- a/kernel/trace/rv/rv_monitors_test.c
> +++ b/kernel/trace/rv/rv_monitors_test.c
> @@ -153,6 +153,7 @@ static void rv_test_dummy(struct kunit *test)
> =C2=A0#include "monitors/nomiss/nomiss_kunit.c"
> =C2=A0#include "monitors/pagefault/pagefault_kunit.c"
> =C2=A0#include "monitors/sleep/sleep_kunit.c"
> +#include "monitors/tlob/tlob_kunit.c"
> =C2=A0
> =C2=A0static struct kunit_case rv_mon_test_cases[] =3D {
> =C2=A0=09KUNIT_CASE(rv_test_dummy),
> @@ -163,6 +164,7 @@ static struct kunit_case rv_mon_test_cases[] =3D {
> =C2=A0=09KUNIT_CASE(rv_test_nomiss),
> =C2=A0=09KUNIT_CASE(rv_test_pagefault),
> =C2=A0=09KUNIT_CASE(rv_test_sleep),
> +=09KUNIT_CASE(rv_test_tlob),
> =C2=A0=09{}
> =C2=A0};
> =C2=A0

