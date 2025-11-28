Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535D22333D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Nov 2025 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322322; cv=none; b=kWfwOAbQ9Gi3N+oSkiSS6/E0llSe1PfdBTGtuxyOgA3SPfNqdQRSt2u4cMp3SpefuSB5vn862ZDyyzNqIYMKpZXOWh2SyLV7IMfyF5Bj9TITtBym2PxBmoiJNZzV1L8C6B5yHINCJJ0dN3CEMJheV6BqXxZi73sRnL3bjWKQUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322322; c=relaxed/simple;
	bh=g6gZ69KHMbTGsZcNJI8VXZWGdc5rG+2mHogCEUq+Rso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bu3QUVR9A8ZcG72JR0BUD93ogI4YhbnBSsSvomQEsJQ9B3jN63EA1lY/oCoPhpKqNhf4pghnchnx0hMdvMxY2OtntSQprC/232DGQHuZspJAgikZOMUbjNOVqUXx8TiIdd2wLxFYfENjhCjtzUJ89RXBvMIQ9FVwY33/NGsnjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJZUNhrs; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJZUNhrs"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b1b8264c86so147891585a.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Nov 2025 01:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764322318; x=1764927118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI0OcmHjeFyb484sjgiydBSlKc/rrUkdQjscOLrNcP0=;
        b=QJZUNhrsGu0NbjLozUtwtVP+0Mz/46NZSq3uARD6wJ6r5zulYfu4RCuy/FpdCnGDkk
         5CizUQK7MZBbw7mII9J71e1tL7OVJAJj/2HABFA4JdGDd/xPChMoEIeQqApngY3JV/z8
         6wownLlG8LRLJPE3ie2P4v+YiqfBBJuh9zxlQhk41GEe9zTBXLYoPL6TL4SLwImAcvhN
         6b7/TNL9WRv95tzTqU7Sq9VsRTKkDVVeTyEaSlX7BnRYELKgzLzYMVsJR2J3MB/Zap2b
         pC1Vn3IQ5/j75n+hE0KyFRvD6HYs5w4CDfFCWqhgKEcH3T+VrCz+YnuMHrUOZoP29x69
         c0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764322318; x=1764927118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OI0OcmHjeFyb484sjgiydBSlKc/rrUkdQjscOLrNcP0=;
        b=VJDwMVa/JlLM8z00eII0jv0CRHsOgQGGvGgzTo561phxPMe3BpP0I2qMKz+AFBW9uI
         q/qU5+VjQ9vzr0tC9EeStBf+V+eKMph4tghWPvHzpg2d5wjMDqSJhj41ImaCpfCUjPts
         3lqrupTHOx19x3SSK1n2xDRhdp2QaqDDriJ5Saziyor6zdlZg8GmKO8NaN4OebHY74oA
         2Vbdd/TWbkNQTj448N+qJ7dWcT9CsuHvBiDCqHDwnXmpOp6df6gP6wgSAo2L2FT4AkhZ
         /ssv0eqmhZzltxKQalkSnj1o/Zya7XyntEq9+BXjhjKwfBQcWwTR/vPvEnHCWoIRpXNw
         ScXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGSkWRsemXWFHOsJkVXudxCo2qT3Mw4e72xc3+DXbWh+hhqyBaPRDuCruTgpERZE+vamyzOXmmIy/p/WdLPRhIjaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKumgtGfd0FP+BE/UXnVlW6LlPu3O8ngbb7oVRDm6dpRgHHr9V
	T1+7ODLx7M0rmdnkt+hSjMQa8Xna2qAqSQ9ByyF8nlnKdPTsJTozRNxvpKbz4avtpbZE/ylTH7G
	chHfO9emRw0LKLqIFTNiiZCPet8UhJWU=
X-Gm-Gg: ASbGncv9YJXzPw53y11rh2Wl5+PsChOtm/YMyrh7ivkbdsvJR49RQ5eCUAfBLIjwVh9
	rMYrZ03LKX1tT0sNi3UJ12YmgIMvRfHfoRoN6Ag+lrXO95yfWKc0rjUwB09l+AlwqgHDFHzhW2R
	EDLPs0dtXj5Ojint1nU9jq6H+vK62/P6abFe7o8ETvWo3/P9InKNY37ZB7iO1nEshqRVw9GiFi9
	DTCsO5WyLRVWq/iYrbPUu8g7Pi5yAQlbgpSS1IckfXanuoEowaIBiCHIhfzfa4k4Bqxj2+fY8xZ
	+Jz8
X-Google-Smtp-Source: AGHT+IE4dLyJsJbrTAn1B7Yr4GO+0YuLUAXeUBEruxFfx8P+JadOGQI4/wwbpqcWoRl4WtDLsxhuJc9tFjSM6xJVzGA=
X-Received: by 2002:a05:620a:2988:b0:8b2:74e5:b36 with SMTP id
 af79cd13be357-8b33d469d5emr3375756385a.68.1764322318278; Fri, 28 Nov 2025
 01:31:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128085215.550100-1-gxxa03070307@gmail.com>
In-Reply-To: <20251128085215.550100-1-gxxa03070307@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 28 Nov 2025 17:31:46 +0800
X-Gm-Features: AWmQ_bnxT-AMRvL6QfqA8HugYaI3Ly525_HuvsNqNPfROHBjXW-vjwdRajjQ0jk
Message-ID: <CAGsJ_4y0zc_nh2q=w4uR04vtveCf6L7+hgafznHuL8ByWbyNOQ@mail.gmail.com>
Subject: Re: [PATCH v4] dma-buf: add some tracepoints to debug.
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, kuba@kernel.org, 
	brauner@kernel.org, akpm@linux-foundation.org, 
	linux-trace-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 4:53=E2=80=AFPM Xiang Gao <gxxa03070307@gmail.com> =
wrote:
>
> From: gaoxiang17 <gaoxiang17@xiaomi.com>
>
> I want to track the status of dmabuf in real time in the production envir=
onment.
> But now we can only check it by traversing the fd in the process or dmabu=
f_list.

might be:

Since we can only inspect dmabuf by iterating over process FDs or the
dmabuf_list, we need to add our own tracepoints to track its status in
real time in production.

>
> For example:
>    binder:3031_4-18348   [005] ...1.   545.568275: dma_buf_export: exp_na=
me=3Dqcom,system name=3D(null) size=3D217088 ino=3D2750
>    binder:3031_4-18348   [005] ...1.   545.568284: dma_buf_fd: exp_name=
=3Dqcom,system name=3D(null) size=3D217088 ino=3D2750 fd=3D8
>    binder:3031_4-18348   [005] ...1.   545.568399: dma_buf_mmap_internal:=
 exp_name=3Dqcom,system name=3Dqcom,system size=3D28672 ino=3D2751
>      kworker/5:1-130     [005] ...1.   545.570193: dma_buf_put: exp_name=
=3Dqcom,system name=3Dab size=3D28672 ino=3D2751
>     RenderThread-18891   [005] ...1.   545.602994: dma_buf_get: exp_name=
=3Dqcom,system name=3Dab size=3D217088 ino=3D2750 fd=3D1087
>     RenderThread-9409    [000] .n.1.   545.745004: dma_buf_dynamic_attach=
: exp_name=3Dqcom,system name=3Dab size=3D217088 ino=3D2750 is_dynamic=3D0 =
dev_name=3Dkgsl-3d0
>     RenderThread-9409    [005] ...1.   545.747802: dma_buf_detach: exp_na=
me=3Dqcom,system name=3Dbq size=3D12771328 ino=3D2764 is_dynamic=3D0 dev_na=
me=3Dkgsl-3d0
>
> Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
> ---
>  drivers/dma-buf/dma-buf.c      |  48 +++++++++-
>  include/trace/events/dma_buf.h | 160 +++++++++++++++++++++++++++++++++
>  2 files changed, 207 insertions(+), 1 deletion(-)
>  create mode 100644 include/trace/events/dma_buf.h
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 2bcf9ceca997..6e04e12f149e 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -35,6 +35,9 @@
>
>  #include "dma-buf-sysfs-stats.h"
>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/dma_buf.h>
> +
>  static inline int is_dma_buf_file(struct file *);
>
>  static DEFINE_MUTEX(dmabuf_list_mutex);
> @@ -220,6 +223,11 @@ static int dma_buf_mmap_internal(struct file *file, =
struct vm_area_struct *vma)
>             dmabuf->size >> PAGE_SHIFT)
>                 return -EINVAL;
>
> +       if (trace_dma_buf_mmap_internal_enabled()) {
> +               guard(spinlock)(&dmabuf->name_lock);
> +               trace_dma_buf_mmap_internal(dmabuf);
> +       }
> +
>         return dmabuf->ops->mmap(dmabuf, vma);
>  }
>
> @@ -745,6 +753,11 @@ struct dma_buf *dma_buf_export(const struct dma_buf_=
export_info *exp_info)
>
>         __dma_buf_list_add(dmabuf);
>
> +       if (trace_dma_buf_export_enabled()) {
> +               guard(spinlock)(&dmabuf->name_lock);
> +               trace_dma_buf_export(dmabuf);
> +       }
> +

perhaps a macro similar to the one below

#define DMA_BUF_TRACE(FUNC, ...)                  \
    do {                                          \
        if (FUNC##_enabled()) {                   \
            guard(spinlock)(&dmabuf->name_lock); \
            FUNC(__VA_ARGS__);                    \
        }                                         \
    } while (0)


This would help us avoid duplicating a lot of code.

could be:
DMA_BUF_TRACE(trace_dma_buf_put, dmabuf);
DMA_BUF_TRACE(trace_dma_buf_attach, dmabuf, dev);

?
