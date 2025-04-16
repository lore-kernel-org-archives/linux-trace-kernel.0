Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7059941A8F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Apr 2025 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788772; cv=none; b=FWIklpoOTFHyw//rofGLDurnEom5WymQ1cBe0FKeON0dQ+wxWGvKb4thfRT3Fg7/KmR5BIbkIG8Yjgv5K+GAdaFeWqimoM46t4EeJy+5EWRZ/u2U9viVtpb1m2mSPTruiuBNy6xpd3/3yEP8oU6Wf8pnfJVKbLIeSVe39oanq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788772; c=relaxed/simple;
	bh=yxzP7E6MnBhLTSjlwoGokkZsjRMDqwGfN1YVGKNoRp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJy27tmgrZhh5p2A+/HWli0+dZScKjV87bIBsJ2/x3S02EaVPcrJVOUXGD7p8gjFX09dGYdRFp7h4wL7cCRJLaiL58qWi+q3nhjcYiTM00mok0O/D9eYi8n8eSA16tDUD2StMPcSgngPm8XtlmOzvOshPhRvz4dctZmhTFTXpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WAheLoWw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAheLoWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744788769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yxzP7E6MnBhLTSjlwoGokkZsjRMDqwGfN1YVGKNoRp8=;
	b=WAheLoWwhxRe46JjorApAreEH2cvJJQVk4fpNcqWLHzpuCIakAVE+hz519YUMm/7RCIIc+
	K4lIpFRL5u9ey4UVe4mToKZ0ZJigJUEa6/hjxrymiZCye+BH/z3Qda43XOZS54lO4/qvv0
	38722foXynoi8pSCjYHN3GjYtqSxKsg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-zSmkILArP_KHv6AUFN7M_Q-1; Wed, 16 Apr 2025 03:32:47 -0400
X-MC-Unique: zSmkILArP_KHv6AUFN7M_Q-1
X-Mimecast-MFC-AGG-ID: zSmkILArP_KHv6AUFN7M_Q_1744788766
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d51bd9b41so50973165e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Apr 2025 00:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744788766; x=1745393566;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0A4GO9T7R+GL3F6FsynwLGzzh5CQAzLkMXyqJ24/ilA=;
        b=bPKGUYgPs/2++nC+9l7fBwfB3YDymgcbTl29QP0Dz6lxhBd+ZNTNoujYnITHWt94Qu
         kabDS4a5JYHhwUT85ArLY400b3O8pIAjmSEsyTYld0Hd4eBJ8/+GJIdEuKrRmMBFgy/1
         8S5DDbaXy2mUC91sOMRdbLYp1m6TE+8cofbMkuUntjjJDbKf1/ZmPgDwa/B58vs1aw4P
         CA4kyz3ohTwcdltlF2bxB4Ntj6rFOck/Wwz+uzjE81RxdfVRdVSSVVg8sLAsElYOs0W8
         fybYHJ9OmieHtuOBZTKRDYPMBU00a2Za+REEwgwtJvMjUqtA36QZF2IlTjopyaxrZSsC
         BUTw==
X-Forwarded-Encrypted: i=1; AJvYcCXcOSWau/03+ez1RmZ5UiFtNzZoVz2QqbAr1pHMgPUfZPCLP0p3vMHtdi5ZWu13o0dG/3t7qPkodLf+If81hdKchZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMX9UJ4UW7hQiJG8cvzvnpwbU8S1bmRDFzV/bbI0p+e6GVefPw
	+n1n37MQbOvqGDn6rGOGp09Z3IthLX19nuFsvkbnSx8ZdFzW8c9H4yesp3dAPXkEOYmPt3YxYlB
	IMmcTE1YRaTQ6sAfn4638BrSr61CxCUX+mjqMu7f7B/8lkK4aP4zAHZc4Ld4SoLK8IySkRw==
X-Gm-Gg: ASbGncvrJ1ho5mQe8IbDC0FMeW5aKvl9GNVeqED3DJFL86f4b+LFATi/1BqnNjgu15P
	SuppN2GfdO6MdAZV1j7JAcUplw3eimcYRO45aOA78Z8o65xVApr/gBYG/q+qBvvSQHwPjMrr5UB
	BZObS2xYa8Z+jIxHFN/yhu95kP82NMCjQBxNCGcHQHfaXeazpiRzbPc0SMGhKarbM1O63N+hU11
	qNcPn4G9FHk2ZkXtY3WifMQv7O04fzA8IBZtX7JoOSkJ0TsQgzlwwgOABOAAW9czp6RSU1V0bIG
	zV6ywqLRIYA+Dj7uC3FT7Faza+1WO/C9C66M0p8=
X-Received: by 2002:a05:600c:1ca3:b0:43c:fe85:e4ba with SMTP id 5b1f17b1804b1-4405d637b49mr7022995e9.15.1744788766438;
        Wed, 16 Apr 2025 00:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpgOubVpqmfu4fejPJV6V8Nwg67cOnxzrVkwTeijWdi/xhMjO+aOdeIusjgVXu1pNG62MdLw==
X-Received: by 2002:a05:600c:1ca3:b0:43c:fe85:e4ba with SMTP id 5b1f17b1804b1-4405d637b49mr7022655e9.15.1744788766065;
        Wed, 16 Apr 2025 00:32:46 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b53ef95sm12536365e9.36.2025.04.16.00.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 00:32:45 -0700 (PDT)
Message-ID: <0a41e42243d2c102b159bed4b231f143bda02243.camel@redhat.com>
Subject: Re: [PATCH v3 14/22] rv: Add rtapp container monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Date: Wed, 16 Apr 2025 09:32:43 +0200
In-Reply-To: <7d1a7337879b991ed454d1457d44a15dabc4b3f7.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
	 <7d1a7337879b991ed454d1457d44a15dabc4b3f7.1744785335.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZIIdDh_PLK21AnJtB-5tpSnxgtztCkhofR0TTpgMipc_1744788766
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2025-04-16 at 08:51 +0200, Nam Cao wrote:
> Add the container "rtapp" which is the monitor collection for
> detecting
> problems with real-time applications. The monitors will be added in
> the
> follow-up commits.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0kernel/trace/rv/monitors/rtapp/Kconfig |=C2=A0 6 +++++
> =C2=A0kernel/trace/rv/monitors/rtapp/rtapp.c | 34
> ++++++++++++++++++++++++++
> =C2=A0kernel/trace/rv/monitors/rtapp/rtapp.h |=C2=A0 3 +++
> =C2=A05 files changed, 45 insertions(+)
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rtapp/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.h
>=20
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 6e157f964991..5c407d291661 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -41,6 +41,7 @@ source "kernel/trace/rv/monitors/snroc/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/scpd/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/snep/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/sncid/Kconfig"
> +source "kernel/trace/rv/monitors/rtapp/Kconfig"
> =C2=A0# Add new monitors here
> =C2=A0
> =C2=A0config RV_REACTORS
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index f9b2cd0483c3..9b28c2419995 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_RV_MON_SNROC) +=3D
> monitors/snroc/snroc.o
> =C2=A0obj-$(CONFIG_RV_MON_SCPD) +=3D monitors/scpd/scpd.o
> =C2=A0obj-$(CONFIG_RV_MON_SNEP) +=3D monitors/snep/snep.o
> =C2=A0obj-$(CONFIG_RV_MON_SNCID) +=3D monitors/sncid/sncid.o
> +obj-$(CONFIG_RV_MON_RTAPP) +=3D monitors/rtapp/rtapp.o
> =C2=A0# Add new monitors here
> =C2=A0obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> diff --git a/kernel/trace/rv/monitors/rtapp/Kconfig
> b/kernel/trace/rv/monitors/rtapp/Kconfig
> new file mode 100644
> index 000000000000..94689d66a79c
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp/Kconfig
> @@ -0,0 +1,6 @@
> +config RV_MON_RTAPP
> +=09depends on RV
=09depends on RV_PER_TASK_MONITORS >=3D 2

Not sure we want to be that picky, but what about making sure we can
run the monitor in its entirety?
Ignore this if your use case doesn't expect both monitors to be run
together.

Other than that
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> +=09bool "rtapp monitor"
> +=09help
> +=09=C2=A0 Collection of monitors to check for common problems with
> real-time application that cause
> +=09=C2=A0 unexpected latency.
> diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.c
> b/kernel/trace/rv/monitors/rtapp/rtapp.c
> new file mode 100644
> index 000000000000..193c9d8dc0af
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp/rtapp.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/rv.h>
> +
> +#define MODULE_NAME "rtapp"
> +
> +#include "rtapp.h"
> +
> +struct rv_monitor rv_rtapp;
> +
> +struct rv_monitor rv_rtapp =3D {
> +=09.name =3D "rtapp",
> +=09.description =3D "Collection of monitors for detecting
> problems with real-time applications",
> +};
> +
> +static int __init register_rtapp(void)
> +{
> +=09rv_register_monitor(&rv_rtapp, NULL);
> +=09return 0;
> +}
> +
> +static void __exit unregister_rtapp(void)
> +{
> +=09rv_unregister_monitor(&rv_rtapp);
> +}
> +
> +module_init(register_rtapp);
> +module_exit(unregister_rtapp);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
> +MODULE_DESCRIPTION("Collection of monitors for detecting problems
> with real-time applications");
> diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.h
> b/kernel/trace/rv/monitors/rtapp/rtapp.h
> new file mode 100644
> index 000000000000..4c200d67c7f6
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp/rtapp.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +extern struct rv_monitor rv_rtapp;

