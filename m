Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51D30DD2D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424951; cv=none; b=c/ZX8i/NV0TZkQ+ND6SZ1kebF50phHGyOfOw+1j9d6ij1IBoYSX+dyLRWa7z5m1drlhHvXj9rKdkv9V5LGELA+yNTIo4VhHpGT1rXkdytZYvF+bJ81OpCjgFrUmey0jHrGAI4IvfpJeeSy8C0BqYejbWS3/boXT/+4YE1JJCWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424951; c=relaxed/simple;
	bh=7Ac1LDGZCZe+vN2GK1B70ffNIX5rSDeEh0mtzJmm0Fc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxdsceRq8CmD7K0PDE4cTU4nDP43M8dWiws5ysQ71kwf2Qz9UQw0g2DGiIPhTubU2sKD1ynldUTv1U2V6DZIlDf6lKi0Cq0RNShpvew6ADGMTFcMoCUgzjQq2sGO/kNBb56r+vHQm0qd0jpcUOkkEzGIoN0WzZ7eSSHBoP9kDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iygYsAKO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iygYsAKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760424948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ac1LDGZCZe+vN2GK1B70ffNIX5rSDeEh0mtzJmm0Fc=;
	b=iygYsAKOO4mz3agg0KSUe6Ldcw3Atal6/MBhfgG0Tt4Dwtnxsy3IUPDGeBj9V5sX7jZT3P
	Hs1vdy7PF4g3QWOe03jtYnacvJE75oFr6ofqzsb5+8Eff3FZ+NEFkegdfC2u6QAMi94A5U
	va501/WOeIBfvLtN3Yz445OwRwQ8dV4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-8SV25HNpOP2o4pgsCm3zNQ-1; Tue, 14 Oct 2025 02:55:47 -0400
X-MC-Unique: 8SV25HNpOP2o4pgsCm3zNQ-1
X-Mimecast-MFC-AGG-ID: 8SV25HNpOP2o4pgsCm3zNQ_1760424946
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e25f5ed85so41894325e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760424946; x=1761029746;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJiiSCVG4H+MF2iq6yuseKw1PPLKK214MGsS71Xr3io=;
        b=J8OkFqGBJrKHU6Aub/5QkZea1znveU1p/PzqHXBLkxWVfVVf1V3MNxLYkWphSQn1HD
         jVFNsj+lT5UHTlU8+3tp31lZJ/eMjCjbs5kyazubUUF2c7CYKs7EaNCW9B9tSN//HzLa
         Thyj0TkVEB6VPuJsxoP/xHW2L/ntKcGLedgx3NFatC7cdV6PvEx85LTJ1lbx2IZ/gBH4
         TMk1zS8oFVXhsWPN4u9Ess0q8zs2DRt60RNIFH0yydm6PIuzK7wRq152WRlrkFp1tt74
         YoYKmXaBI+dgBImQ8D3fZ6/mjcBGIyLkDIsIu+y39ZMJUiodeqWRSe6IXfh0XGFfCRij
         516Q==
X-Gm-Message-State: AOJu0Yzyqvdl9M4+JKPWKa+b/rr+j4zSOxUL4UO0Ji1713Kv1O7NJ0IZ
	rxXYyNuHoDdW8PCI2kLbBP+vwgV7cMVIBv5ykE2/I6jqYQzrSE7YafvPi86MkLcX0n7OuOcwS3s
	8k0BCwBhCBNj8fHgKyUbcBN39FInHeD4dIEcdXKGS5AigKu7NEL24xG7PbhjYarvb5innog7SBA
	==
X-Gm-Gg: ASbGnctka8MXyQqJh2Suf7FwDDgNO2IOQKnmP21NsZcps7YGf+s3vm4ftQqdJvJrNdY
	MQRjv5V6K7JyErZCCpvZ5KwW6ti2zM81VCMRsc5DInF0MoQGU4xkJuFqhEsRQso/E+sQfBKef/W
	Yr/DCQp3AIF7ZH09XCmsHoOMos4FNWGUcLbgfEUv1xwMukxDc0sMjybpnUWpHDAgJW7Zg+LZt9n
	9WFm0mjPE50Qo8oPL43VuoJ38iMlv9jPpjYK/llcTGR95823AnSwl8dcAgxWlJzMIZf7TpTQXFm
	R/M/djJ4A82jXKkG4hNshmWQn1qCi22mERifynNYxm3zxqwgvsquVbk5pPO+m52YEw==
X-Received: by 2002:a05:600c:8b6a:b0:46f:b42e:ed88 with SMTP id 5b1f17b1804b1-46fb42eee4fmr122418905e9.41.1760424946175;
        Mon, 13 Oct 2025 23:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFlbUjRO9R/NpxxXldayXIglwjuXec+Uez9hxiwOvKHT+csT8ueG+UPjaUZgLVeIy5qL+RIQ==
X-Received: by 2002:a05:600c:8b6a:b0:46f:b42e:ed88 with SMTP id 5b1f17b1804b1-46fb42eee4fmr122418765e9.41.1760424945788;
        Mon, 13 Oct 2025 23:55:45 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab4e22d8sm142757855e9.5.2025.10.13.23.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 23:55:45 -0700 (PDT)
Message-ID: <1a0d9a427b36d4bcff992dfb8694436cd24d6af3.camel@redhat.com>
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>,
 Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Oct 2025 08:55:44 +0200
In-Reply-To: <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
	 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4TM6lFs2CM1CamOSfRkZsC-ZmbaaDxPj6CDJXNM7C-g_1760424946
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-10-14 at 07:51 +0200, Thomas Wei=C3=9Fschuh wrote:
> Reactors can be called from any context through tracepoints.
> When developing reactors care needs to be taken to only call APIs which
> are safe. As the tracepoints used during testing may not actually be
> called from restrictive contexts lockdep may not be helpful.
>=20
> Add explicit overrides to help lockdep find invalid code patterns.
>=20
> The usage of LD_WAIT_FREE will trigger lockdep warnings in the panic
> reactor. These are indeed valid warnings but they are out of scope for
> RV and will instead be fixed by the printk subsystem.

Looks like a nice addition!
If I get it correctly, this patch does trigger a lockdep warning with the
current state of the kernel. Is there a plan of fixing the warning in print=
k?
I assume this series would need to wait for that or did you have other idea=
s?

Thanks,
Gabriele

>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/rv_reactors.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.=
c
> index
> 8c02426bc3bd944265f809e431283d1a20d56a8c..d9d335ae9badaa320f1d35dd159a033=
c3a30
> eb1a 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -61,6 +61,7 @@
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk
> =C2=A0 */
> =C2=A0
> +#include <linux/lockdep.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0
> =C2=A0#include "rv.h"
> @@ -480,6 +481,7 @@ int init_rv_reactors(struct dentry *root_dir)
> =C2=A0
> =C2=A0void rv_react(struct rv_monitor *monitor, const char *msg, ...)
> =C2=A0{
> +=09static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
> =C2=A0=09va_list args;
> =C2=A0
> =C2=A0=09if (!rv_reacting_on() || !monitor->react)
> @@ -487,7 +489,9 @@ void rv_react(struct rv_monitor *monitor, const char =
*msg,
> ...)
> =C2=A0
> =C2=A0=09va_start(args, msg);
> =C2=A0
> +=09lock_map_acquire_try(&rv_react_map);
> =C2=A0=09monitor->react(msg, args);
> +=09lock_map_release(&rv_react_map);
> =C2=A0
> =C2=A0=09va_end(args);
> =C2=A0}

