Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159F313E1B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210925; cv=none; b=gWgbVnQXT0Duo1JtHblLlb5t+gQHCTySivX1tgKbqLCZvmfOwICKl1vYvJhOPNQbQpzb7b1UD6Tke58pheLKc9SaJYemfoJhjjm2Oeizs9HtExYl9S1POLii+i41BnjUaJbAQV4o1WVHZEiXs65jrDrJMqEZahhy0TVZQjnShhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210925; c=relaxed/simple;
	bh=MjopfM6zKfXfv97zUg4k3gKM2XwfKig6ByXDbihgQ2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d21MFb69UO5g/BVtlRB8aR9woY+wB0KYhMzJw/havfp6R1LUjQ28E8e/8qiHqTc38xJMsfPuk1ggT1R1kZntmq+kJU5TOLVKVcWtLKgG75KBXisaqqFwS+zsIvWnOSlO+dO96XbKkfBFu6Ek1FbHOu+CC6ztfOB0nlWe/VGFP58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTniQnn1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTniQnn1"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2699ed6d473so141245ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210923; x=1758815723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fB56UEO0mNP2hRYBRO1UDnRhREYhvCPXWZ0EMOooGbY=;
        b=XTniQnn1LQUeVXVkXCIo3LNLGbS+G9UgXGsPMp4lZMx4cWk1CLhNGiG+461rdJ7kWu
         xJyJYa9c+4+doCrf6YeIW4V/vC3QunuOfshrh0p1ZdD739EMYwZO/RSXAUVx/Y2ROe/W
         NuLtYM3FGfRlgIzQBcPuoqWioSDJ6k0EMTlomW2CLtEWdAcVWpSpJIXjMyzhHnnYukCW
         OJgNFaSgVmSYXzfGpe/fsSuALyDoGM2wPUmsE6Kf/bSzdkRnIBi6Yt+cltuytQg4nFph
         xGGNA15ZXKlhJ8D1GLawQgIyQVf1hBS8rTQvZvH5m7TkWLJ5lFrcGdmfcgVD8UwaFcsL
         vmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210923; x=1758815723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB56UEO0mNP2hRYBRO1UDnRhREYhvCPXWZ0EMOooGbY=;
        b=fZAvBdz0LxCBYIvkDy1CYi0AskVj5Z+xgMWIp/qUyn2GPQr/4s7S35IyTRciaIqbZW
         ef2i3nc3FxeXrWszk5L14f4LrGGgZxlUYEWwxSXmROsZdu48ZFwcpFZ8VD7XS3xE0Ctt
         LNxuK8VYrckwnwK7x0UZMIXqvKh8IguCF8R8/hqJcxdjmq4vDzzqzExsnnJHvLUin/UM
         Sg9u6wImngxE/zOxhN1N+Lk+OxfAVdU/0m4oRbnyC0NhAI0wpK2cSbHdQGxhxo7h+wPF
         BsdL9fbckc/ioZfa94TbqrTiAsqNzCEVPFvMFLAYJl4zbP9NSyxteMzcxDej5Hew3GVP
         Uhsw==
X-Forwarded-Encrypted: i=1; AJvYcCVnGM6MqmD7KRffvtw/G87kjd5GvAd+RRdrtBa5HHUPP7I4a6X0lFW5VTnYqqTYCKLmE0X26cIKHSHeObi0QHGLa4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzejCRmvdsfQ5IV6hXlog9I2EgnLKcg9LYIfL+qASb+C0uCBcI1
	ul4s1O0HaD9YPQ5BWwoX57rA2RExXXvrV4Tnkyn9b70A9egix+KuM7oy7DbPhrl2JU9mhckkSFk
	UpCw3rKujqAOVtzI1syzzHSIxSib78+Ep1xDXZSfJ
X-Gm-Gg: ASbGncs6MuRbGMqq+DWhqgbR1WS3aPBvl/arZW+p9WQ0Blq2RgESHNdJHoZ2E3EHOjB
	Mw3j8MWO2+1y7v7984gFTzMy4avidWEzm3NSt9JVv3dogaM+B/657SPHK5JHKm+MW05E+bOTfuZ
	mmHgtnXjoLQzaiF4nSkX/OuAY8YCXYE/GKxY0+epPjoXwQt+MXv0qHlwPg4nAMQeweir8B0icUi
	sgLuxzVo5L+WEmzCVRRjwhOBaIg16YnUFyCuIQuHSAfapCmo4ZhhuVVG+Zj4CQ=
X-Google-Smtp-Source: AGHT+IHtle2Bol/8iJ1CI7SONgmRyw+7KDNF3rjHCoT0hB77tatWLPJOO/VLwsIgvGtPKBGy3m8lRqkiHkO7GeZDCgQ=
X-Received: by 2002:a17:902:ea06:b0:265:cb5f:3a66 with SMTP id
 d9443c01a7336-26808aeb835mr11034625ad.13.1758210922376; Thu, 18 Sep 2025
 08:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-8-kaleshsingh@google.com> <385df771-961c-4fc1-971c-81314c231f5d@lucifer.local>
 <53ade9bf-5cdb-49b6-b8c9-1f653c861bde@lucifer.local>
In-Reply-To: <53ade9bf-5cdb-49b6-b8c9-1f653c861bde@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 18 Sep 2025 08:55:10 -0700
X-Gm-Features: AS18NWDy23QFicFxq7eonAAZapCtI7hAuF1vOI9oXz3unSnA7mgzsm9MtU96rN4
Message-ID: <CAC_TJvdRf3xJg7FgTzAxa-ZrHkGA0G3dEDVWWWttg3ri2B-FNw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] mm/tracing: introduce max_vma_count_exceeded trace event
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, david@redhat.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:52=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
>
> On Thu, Sep 18, 2025 at 02:42:16PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Sep 15, 2025 at 09:36:38AM -0700, Kalesh Singh wrote:
> > > Needed observability on in field devices can be collected with minima=
l
> > > overhead and can be toggled on and off. Event driven telemetry can be
> > > done with tracepoint BPF programs.
> > >
> > > The process comm is provided for aggregation across devices and tgid =
is
> > > to enable per-process aggregation per device.
> > >
> > > This allows for observing the distribution of such problems in the
> > > field, to deduce if there are legitimate bugs or if a bump to the lim=
it is
> > > warranted.
> >
> > It's not really a bug though is it? It's somebody running out of resour=
ces.
> >
> > I'm not sure how useful this is really. But I'm open to being convinced=
!
> >
> > I also wonder if this is better as a statistic? You'd figure out it was=
 a
> > problem that way too right?
> >
> > >
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Cc: Mike Rapoport <rppt@kernel.org>
> > > Cc: Minchan Kim <minchan@kernel.org>
> > > Cc: Pedro Falcato <pfalcato@suse.de>
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> >
> > This breaks the VMA tests, please make sure to always check them:
> >
> > cc -I../shared -I. -I../../include -I../../arch/x86/include -I../../../=
lib -g -Og -Wall -D_LGPL_SOURCE -fsanitize=3Daddress -fsanitize=3Dundefined=
    -c -o vma.o vma.c
> > In file included from vma.c:33:
> > ../../../mm/vma.c:10:10: fatal error: trace/events/vma.h: No such file =
or directory
> >    10 | #include <trace/events/vma.h>
> >       |          ^~~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make: *** [<builtin>: vma.o] Error 1
>
> Trivial build fix:
>
> ----8<----
> From fe4c30abbd302ccc628ec92381ac10cea31c6d85 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Thu, 18 Sep 2025 14:47:10 +0100
> Subject: [PATCH] fix
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.c                         | 2 --
>  mm/vma_internal.h                | 2 ++
>  tools/testing/vma/vma_internal.h | 4 ++++
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 26046b28cdda..a11d29a2ddc0 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -7,8 +7,6 @@
>  #include "vma_internal.h"
>  #include "vma.h"
>
> -#include <trace/events/vma.h>
> -
>  struct mmap_state {
>         struct mm_struct *mm;
>         struct vma_iterator *vmi;
> diff --git a/mm/vma_internal.h b/mm/vma_internal.h
> index 2f05735ff190..2f5ba679f43d 100644
> --- a/mm/vma_internal.h
> +++ b/mm/vma_internal.h
> @@ -47,6 +47,8 @@
>  #include <linux/uprobes.h>
>  #include <linux/userfaultfd_k.h>
>
> +#include <trace/events/vma.h>
> +
>  #include <asm/current.h>
>  #include <asm/tlb.h>
>
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_int=
ernal.h
> index 07f4108c5e4c..c08c91861b9a 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -1661,4 +1661,8 @@ static inline void vma_count_dec(struct mm_struct *=
mm)
>         vma_count_sub(mm, 1);
>  }
>
> +static void trace_max_vma_count_exceeded(struct task_struct *task)
> +{
> +}
> +
>  #endif /* __MM_VMA_INTERNAL_H */

I made a point to build and run your tests, seems I forgot to actually
test it with this last patch.

Thanks for the fix.

--Kalesh

> --
> 2.51.0
