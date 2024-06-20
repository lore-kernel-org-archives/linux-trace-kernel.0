Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904715A866
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874078; cv=none; b=DxMhRVJX1TCHc/eSmj6/EAHQO/aG+zp1Eyf6s0vxvPE5OM4dFVJUIM0kLJSLzqNBirCR77cDylThB2KQkbIvRmbQ8h2ODrWu5JpNnvYpu08Wc7nNovF45Z0nsSSeRPA2UVFuho8FJ60y5mPOJgYDC9iox++FT1zutbjGn/Tpqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874078; c=relaxed/simple;
	bh=wvjuFU7W414jubVBbYupAK//Gvt1g9N5iqVrvVU/lM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFDTyCDG8T+v7plhjxNAWr34XwZWPC1jmxUHuAUKdnXxOBavtkmyazlviIbsFT80UMl04Y90IVL8ln0pMWkojPtOXTkCf0N1XoDrFfjBbfrvqnVcSFwCSFV4YjI/60cyZdt4E1E5aDX4vlfAEJvanDa2W44D+5/TIUJupzHoAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XnLui9VW; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnLui9VW"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c9f892aeaso344410fac.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718874076; x=1719478876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvjuFU7W414jubVBbYupAK//Gvt1g9N5iqVrvVU/lM8=;
        b=XnLui9VWTe1N11xn3OXvZYAM3HMsKklvlHKph5Ei28zTpbjcPSOqxbilJ84OARqbnK
         2IToaYZFHnFBA1q+K236pT3qjBCBAMttuXkpTg/a/MDI6KIv1it1QrlwOAxWEuzl+ZyL
         C2PBhXyQbBWyS+L41HcJI4U5pQSZQ7GOlGsHGjOX1DAkUm7TmiJ6rTCYpawcUgCuTfEB
         1KkFuPf5PS3f3+Ra+oqIij/s59mRY5AhQXQlWxY8JfHXDbh9c9RugimCQmlnhzBPkB4d
         44SY6dhutzp+MtfR238JdYjzuqCWBHqVXoMuBi2m6YmNcwUmb/iTUh2zrgAHhL5Lse/I
         h4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874076; x=1719478876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvjuFU7W414jubVBbYupAK//Gvt1g9N5iqVrvVU/lM8=;
        b=HUn+98vXU9TDZWZD8PC/d37/4ldEJ64MZvwzcCAt8GaqvvYISmljF4/yc510vWu5hK
         cAAFIzPG4aNLq82MaUVLO8vULqUlOJ7x4QQHMEnFLREzdOX1MGf8qD+UQgGF+3VByfMI
         84bSq8fle3ty09/Utb5HPi4SH2QvRSkdZm9jqT+pZBGAJRV02ZV8JU/RVRkI7tqXHmFM
         vLotjyRMoz6RslAda0XupWYUtOUbnjwwy5TJNyLYcTkz4vBJrsLQUoJzcqaYqE0yyPmn
         Vsn/LAwS+KKnhSeUhvk/DWWvxwnW0XuLnrMbv+NWDsSjS2XiF3gd4G/Vyi70Aui5GKZu
         agUw==
X-Forwarded-Encrypted: i=1; AJvYcCUGvCKSzqGPKpHUy85DCbzV5P6suW+DIWWcWCPTjUS6k+juxU7MdGMlep8zsbjF4MVH44FxyS8pdVhSgkim4NmK8wAq2fW2YtpezcQWbRYkDTIG
X-Gm-Message-State: AOJu0Yx1pyRos7fZRFYp6RSU5B+PVaSo4Ru3xYUYcPwLVdfIqh5p9cBg
	NXO5BMNX0Ftf33DrExn2E6eciuzGWCKF//3VW7zYgZqY8iRD908f77kYwLRLAYo9+N8uaB/8Bj6
	hQpyRnwgrlA1F20WMHtzDOp/qCFU42e91AxE7
X-Google-Smtp-Source: AGHT+IEdmrRM4Gbu+d4I3hoRKq+4aL4Fg6hfbxGg0ziYrJZB/rZ9bgxi2fl+hGtqtzvIL6W2TRHW+Qf+Zm5AY3puluQ=
X-Received: by 2002:a05:6870:3a0f:b0:259:f03c:4e91 with SMTP id
 586e51a60fabf-25c949cd968mr4093311fac.8.1718874075898; Thu, 20 Jun 2024
 02:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-18-iii@linux.ibm.com>
In-Reply-To: <20240619154530.163232-18-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 11:00:39 +0200
Message-ID: <CAG_fn=VbO5m18MU6v4-YCbC03dBuBGBRTzi7sEvZCL6vSDG=9w@mail.gmail.com>
Subject: Re: [PATCH v5 17/37] mm: slub: Disable KMSAN when checking the
 padding bytes
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 5:45=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Even though the KMSAN warnings generated by memchr_inv() are suppressed
> by metadata_access_enable(), its return value may still be poisoned.
>
> The reason is that the last iteration of memchr_inv() returns
> `*start !=3D value ? start : NULL`, where *start is poisoned. Because of
> this, somewhat counterintuitively, the shadow value computed by
> visitSelectInst() is equal to `(uintptr_t)start`.
>
> One possibility to fix this, since the intention behind guarding
> memchr_inv() behind metadata_access_enable() is to touch poisoned
> metadata without triggering KMSAN, is to unpoison its return value.
> However, this approach is too fragile. So simply disable the KMSAN
> checks in the respective functions.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
