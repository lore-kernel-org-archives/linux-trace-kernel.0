Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76047A45
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Dec 2023 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ZwJTXD3"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c32bea30dso985e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703094916; x=1703699716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXBfEAuqKBSMS1c3GRv3ur+swt6j3InHmy9rp0ZP3us=;
        b=0ZwJTXD3Yl+expwUFvwXOJx4ZYg1UmIPK3MClewdBJqzeA9Sd0sUEUq+kPw7sxkh00
         pZI+KAXUCru/zg6YoqPImRgocVAHOLqSk5k2FVzZ3HlV3r/7dglUOqDht28WLZc/vnZc
         mWCRgskRZ8mpy51RxdF2pqaKNjEqVjMAi+BUCBqW41Ghdt7XarKu9eZ26hK7O0GkKKw0
         4tYWA1MzICBld5pyr5IIxpzl5OGs6VCy97CPpaMYSRkXtkCy2DBkN3Yvlalf0KQ2bvtE
         3EGHHilvPWIS+0zXbSsTQ58pz24JENqCrEZkIlQcziQTg6M/WIl6ap9Dbylps6zjybnA
         uStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703094916; x=1703699716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXBfEAuqKBSMS1c3GRv3ur+swt6j3InHmy9rp0ZP3us=;
        b=RR3yRXFttA0zUh6gEUb9nr/8sO3U8JnGSpoaWxd58F1M56/zNQ1JrtV/ATICxWJ2oC
         CNx6xYKju5YngCvAvpGY4hpBCKmquaD2zWcNSL5saI8PS/K73uaBNg2dYT31XJQwEziq
         Ev7ylInMHXRezWQFhEmFgK6qZym8PuzPtyEb5ZvuqiLu/Xcy0jtFvyzLS1I/S9yL+tbS
         yQAK1rSHJTM2yNtvHLSqP239wil+fjZoe1+/7yInNWgHT32Gxo1LW6zBrKo+HIiKScus
         OYG0DjQQvqMv2h0i00kA8ycyfGJ3On+HDFr/N0S1kM7Gn6DY+AGHPr0w8lLddeyE5xF3
         7ZyQ==
X-Gm-Message-State: AOJu0Yxmkh0Am1wzbmzv4LDyl+TrwTLDK3lmuv3gOkm8mD98uwHJDXmI
	588/c25GCONp3f5J8PddR2tJYe3wxSZoQPZOxIWKx4EizVhs
X-Google-Smtp-Source: AGHT+IHq8UHmJLiFOiMTsnij3nN2uawkD9E8P3p56H86OZir+aqGDEi/SFQXCqkznhc09wtdn2Bmjx7O0qVLrF3dxlU=
X-Received: by 2002:a05:600c:3b9d:b0:40d:1bcf:1abf with SMTP id
 n29-20020a05600c3b9d00b0040d1bcf1abfmr207456wms.6.1703094915775; Wed, 20 Dec
 2023 09:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220012123.2787-1-cuibixuan@vivo.com> <20231220012123.2787-3-cuibixuan@vivo.com>
In-Reply-To: <20231220012123.2787-3-cuibixuan@vivo.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 20 Dec 2023 10:54:37 -0700
Message-ID: <CAOUHufZjxjra9Cfw8YC2eA-xsikPw=K5=1ew55hKTdYhMwjUig@mail.gmail.com>
Subject: Re: [PATCH -next v4 2/2] mm: vmscan: add new event to trace shrink lru
To: Bixuan Cui <cuibixuan@vivo.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 6:22=E2=80=AFPM Bixuan Cui <cuibixuan@vivo.com> wro=
te:
>
> From: cuibixuan <cuibixuan@vivo.com>
>
> Add a new event to calculate the shrink_inactive_list()/shrink_active_lis=
t()
> execution time.
>
> Example of output:
>          kswapd0-103     [007] .....  1098.353020: mm_vmscan_lru_shrink_a=
ctive_start: nid=3D0
>          kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_a=
ctive_end: nid=3D0 nr_taken=3D32 nr_active=3D0 nr_deactivated=3D32 nr_refer=
enced=3D0 priority=3D6 flags=3DRECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>          kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_i=
nactive_start: nid=3D0
>          kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_i=
nactive_end: nid=3D0 nr_scanned=3D32 nr_reclaimed=3D0 nr_dirty=3D0 nr_write=
back=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D0 nr_activate=
_file=3D0 nr_ref_keep=3D32 nr_unmap_fail=3D0 priority=3D6 flags=3DRECLAIM_W=
B_ANON|RECLAIM_WB_ASYNC
>          kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_i=
nactive_start: nid=3D0
>          kswapd0-103     [007] .....  1098.353162: mm_vmscan_lru_shrink_i=
nactive_end: nid=3D0 nr_scanned=3D32 nr_reclaimed=3D21 nr_dirty=3D0 nr_writ=
eback=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D0 nr_activat=
e_file=3D0 nr_ref_keep=3D11 nr_unmap_fail=3D0 priority=3D6 flags=3DRECLAIM_=
WB_FILE|RECLAIM_WB_ASYNC
>
> Signed-off-by: Bixuan Cui <cuibixuan@vivo.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> v4: Add Reviewed-by and Changlog to every patch.

Where did Andrew provide his Reviewed-by?

> v2: Modify trace_mm_vmscan_lru_shrink_inactive() in evict_folios() at the=
 same time to fix build error.

The reason v3 was NAK'ed was not mentioned or fixed in v4.

So NAK again.
