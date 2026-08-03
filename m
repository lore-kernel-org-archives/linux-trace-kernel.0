Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85FC30D3F8
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787846; cv=pass; b=HbBl5jZEXqGywsrfIVgH1o2zTR/h8oIplh4cQSo47hXKq5d5SsDfcutnxH6SJ94H/GUE9KN8HUl5kpdIgP6GjzIbtbupFOyFEOXHf968EePuPiuH/J7ygrFjF5A5kqMjG5/x2ZkXTvtm/hWoSvUiGhRE4BeZ3aZHr+jqwm+WIIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787846; c=relaxed/simple;
	bh=yE4EwCQrkXlFctZl89cEfORwn+um7MwgGT0lNHpkVuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTPMqrOF437p+QLwnjTyCDQ+RUzLL29V1ndH2SbLfyW1iDUXOAHZyuwrdAzij/E9FUVGmoZHPJCDFrMcp0We3DvCZz0aiRH1wdOkUpm0ohSmHonBc1uaQe3D2GgTb1F46dzUdfd3kJlsq+kM1gQOuUpJB00/HUkttSuWY5x8jdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s16jQowG; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s16jQowG"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84864086bfeso4044841b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Aug 2026 13:10:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785787844; cv=none;
        d=google.com; s=arc-20260327;
        b=ba416PN+PJl5vYvJIELF9IxhzROuXJqyE/KvJmzlCzmdawOXyMJXmoPzz7osatKtvW
         C6oo3joENCJEPHEMCTX7/8eABkul199mz9CDx3hFvPDnsVAsZAU+2wGyDeSzQ5PRh/2P
         6eK6ClEsZc3lXy1cpqPjNIUdvDJQI6HtZl6EpWcicMnCgoErDb7HRKQlDodxFzyeJqHY
         KoGbSOOS6tAlXx9VgEZQld49vY/2D7vfBRmJK8NN3CdB80LILN+oMYfdwk9zxW6Pt3N/
         5yzP5PJdXW5a3l545hxX9Dpo+fEYIdunUmMUFdsDt7TqTyzXaiuECcbB7hjev2IJTr57
         w51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Or8YB/iS1IR9SFO+eCt6jFUyhlxTtdwHdXKK3jrL690=;
        fh=p7AEoWAxEfsldJSFSRBMPkKz++iZAq/inUllwYXQZQk=;
        b=SSLgUvfI6DuV+/zhvl6qia7y77dHtO/nF9UgzT03+Db3Dnu3FylQ5eOEM3RKxLRRyp
         1BK+uW8yDsUIguAafAS0NRGtZ8NHegk0193rOGxach7nVbxCAj9WTUitvDoIq54gTCq0
         TP3B5ecol55LEOv4b33z/mzMkZQVwDVa8wuGwQ2OhGgmC3bdeU6cQMOr0VzjT3Wtvh2H
         tOt4WmTs5QeIMoIhEy4gqpTTlTxOiJSudTOUUbC5CvwWsP3mxZKhidkn83h94oa68gHY
         naaSEtUrKcfd/EdVUmECaagnQg01RvlQQQJZjgStKWGSb4lmVU+2x2WNq96BUnRSfLht
         De5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785787844; x=1786392644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Or8YB/iS1IR9SFO+eCt6jFUyhlxTtdwHdXKK3jrL690=;
        b=s16jQowG8x1icf+2NoA+4KEZhbF77g1wsebQNsHoVONq6MqqKxHQjPpaDoUqADn+Hg
         bmW6GwuMOKnT5YMgYrkzpYcUVZnt9F5h2WS/F+cXspwLQaYUtqnwe4wCuYLTUNxQcktN
         /6rfj4m8yG6dRn217Gyxk5YWU5J5X7wfKnorB1gJ+MNnkst12AyrIU1xUrHsF0rkEngA
         9a/1ttordOqqmicOEWQzRj31BmERbN6H+kcczZcv/k8qzmpeua+zASuz9QVBohED7rMj
         vy78101WwWSFPjxM2u6+0JinOh7FMEgk/lKIs3Zc8+FkpZM6vEXebOmRkzTJcMSg2CXU
         H/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785787844; x=1786392644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Or8YB/iS1IR9SFO+eCt6jFUyhlxTtdwHdXKK3jrL690=;
        b=a8c0Z7sBjydxtlROvGXanvnGVtwqQmJviDLlZJYNN2OV1rjV72AO+ghMq4cL18rURd
         oMf+h5JsQACjmrjtp8hDKCpR1hEIekAKL7qG1zcfJtmCLnm/mCGMZJj+JDebtbEVgbfl
         +cc12tYNmMltuayd6xAqPbsImumIfdsqk4QQsvmj305zf8Go7hkIYUeutSqi6YfoJX6o
         3NrFyZWkoFFjq+4qhgRCIiZpSP4uIp+r0gVDL8x00SnrTBhjLEp3907dzxAIvm7dGIlr
         C4KFEvI7pgtr5RjL1YmPy628oqpN79yQYl2s81bvP4EM3XvxLEo2MLQTKdwvfQVaa7Cw
         f6Zw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7VmFKBOZmmKh/KjpkFcMy3GL75SF1M5xehHVDvQHX4cVjG5Cwn5EHQ2cX/JWYtbEb8nghXsShgllYx8hboBJjkpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3ycTpM6q1rFHJn5E2B91ukFI6+1SMCintd20CbmbF1gP7yT9
	LCNtQbttgvcgLPxiqahQUVXDsgU6OPQtChEhemxwALmq9ZSbx4ch37ME56uBPQeKj43cxjMHNg5
	sMc1jJzjSljz4PF0JgonKcQmsvAKj9HY=
X-Gm-Gg: AR+sD11KCKsRZoe7xikju+wMNIlFVYvuYthCJXjVJ43Ri5OKnyr5kq9hTQIxOdwu48L
	tCFdEz5G38aB1Zat2HeVTLAdFYSv+Bw8f/F6qkFyXhubW7n0XZNSXZvgH+pkNtHlz8jwQ/bONRI
	mPPsuxFFT+WH1L+m+BI5iz5+AW155rLaOg4EaqdczehU/YGK6f+zfC8lNMrDq8RpEDL0Gjq4jzj
	3/NxzCysmdabNGxBoI55qx1jZ2kX87EG9T7KiEYx/ImUl26kYf2AdejhSs2Qe/MMvYqX6shqsXs
	nQbwk8SvOiFILamiwra53UbYTyZrhQuKfgZ5kV4xnuSj6dCr+UDmHwokWEoynyZB849pgQ70iH/
	nAEb8s2wuScBdvBD+qox0vLrjKLq9dCfdHz1M3rRtoQ==
X-Received: by 2002:a05:6a00:410a:b0:848:2f84:739 with SMTP id
 d2e1a72fcca58-84ee4960de6mr10407856b3a.76.1785787843886; Mon, 03 Aug 2026
 13:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-b4-fix_btf_tracefs-v2-1-6b66da8dc103@meta.com>
In-Reply-To: <20260730-b4-fix_btf_tracefs-v2-1-6b66da8dc103@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 3 Aug 2026 13:10:27 -0700
X-Gm-Features: AUfX_mza3LRmAzFtia5BzQBO5N5wE20rFpI8s-AgwGjpL9M0w6YZNe3TZXihsm4
Message-ID: <CAEf4BzasGK651xFBzSXgqzkiqrui-U0a+pGkO6E=Mim9zAyviA@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Make per-template BTF id lists file-local
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, broonie@kernel.org, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 5:18=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> DECLARE_EVENT_CLASS emitted __bpf_trace_btf_ids_<call> through
> BTF_ID_LIST_GLOBAL, i.e. a global symbol named after the event class.
> The class name is not unique across the kernel, so the symbol
> multiply-defines whenever two translation units instantiate the same
> class.
>
> Switch to the file-local BTF_ID_LIST: the list is reached
> only through the event_class_<call>.btf_ids pointer, initialised in the
> same unit, so tracefs readers never reference the symbol by name and
> resolve_btfids still fills the now-local .BTF_ids entries.
>
> The handcrafted syscall classes are the one cross-unit consumer: give
> them their own local BTF_ID_LIST rather than importing the generated
> sys_{enter,exit} lists.
>
> Fixes: eadc0725ab8d3 ("tracing: Expose tracepoint BTF ids via tracefs")
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/all/ff58b01c-3f5e-4d55-be82-609d2faaf12e@=
sirena.org.uk/
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
> Changes in v2:
> - Emit the per-class BTF id list only under CONFIG_DEBUG_INFO_BTF;
>   without BTF the ids are unresolved and BTF_ID_LIST falls back to a
>   128-entry (512-byte) per-class stub, adding hundreds of KB of BSS
>   across the ~1000 event classes (reported in review of v1).
> - Link to v1: https://patch.msgid.link/20260730-b4-fix_btf_tracefs-v1-1-5=
f10b728f51e@meta.com
> ---
> Changes in v2:
> - Emit the per-class BTF id list only under CONFIG_DEBUG_INFO_BTF;
> without BTF the ids are unresolved and BTF_ID_LIST falls back to a
> 128-entry stub.
> - Remove verbose comments (Andrii)
> - Link to v1: https://patch.msgid.link/20260730-b4-fix_btf_tracefs-v1-1-5=
f10b728f51e@meta.com
> ---
>  include/trace/trace_events.h  |  7 +++----
>  kernel/trace/trace_syscalls.c | 27 ++++++++++++++-------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


[...]
