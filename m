Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A471D959E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973830; cv=none; b=SQO+WepN445bRDrYuvilHN5GBvIgRsAA6DqoPiF/L+KMrEnQS131igW+Uptkr3yOE1o4EkQJEIA680NFUpASp5EZegI0t8PIISAVasqWj1ElTSlYXQgD2l1aef6YzzWgO54O1Buf8BaC3ydyzxc0jImwQ1jUier17dYZ2rD2Tlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973830; c=relaxed/simple;
	bh=DmN+bSaJrXFtcRNihUwnk0h3safybjPC3LRXiDGWxb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/SZYRRVfYakGRWiCoC2EAMiLLIRUQ1JauTjN+hbeo20aARs7+1i8FH6tG9uYUZhnPDphdpUyqd2VWWEwHu+OGcKZS7dKCr8MaLYRqtZXae6D3h4y4pksVvo1Vl84UYMO0/jS89AJh3gTj9TLhjqYuviQ/jc8xSyO0frn5vwwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVh7bpVF; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVh7bpVF"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-85bad9e0214so72032241.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 12:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736973827; x=1737578627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmN+bSaJrXFtcRNihUwnk0h3safybjPC3LRXiDGWxb8=;
        b=SVh7bpVFoIsFKb9kpG2Pe8BhY8YLfrRU7Nc8si8TJwA6Zy3mq9GENmR/N0zsNj0mFn
         nzwg79K5LFyFyCg/vDCZC+JBvnpAGpEh0QMxJg4Ig4ThH4oO17Ud2EUi3c4aV3M1R2lh
         0MWlEHNQkeT9jDSiKCPGhkPtIf2WT1XLbXhS9xs5qmBC0TUpDOevY6ZSM34UBJ/B9QA1
         w9hnb4AnyP/CjM0LZ/ZlfkgLiNOthJV1RAUR8mj58z1xul0F772cUr/s93lqSBEIwB45
         qSIo2E+ZmBQrDDEsVKU5dS65Z0HZGWeL+5N59pTZd/3JQqkKUMvxOTDNBqbj7np/x++q
         zkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736973827; x=1737578627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmN+bSaJrXFtcRNihUwnk0h3safybjPC3LRXiDGWxb8=;
        b=H9hIMzmep/YtLNsBa8qfTVI54y7zc7DL3QmdHGjTwdU0ULFa8Hh6wdYk0A7FS6H6Ea
         LnePLuieXDscfjgk9bpudyZkHVKnmIJ8DnE7lyVU4Z5nImFLu0cf8YqdAzij/ZSbFSc4
         ezZILeUiQQO27Lb6xFrXE6mbopPZRpW4qcirg3eGQhPFACOovt+zQVFwGPZt1B3g2JeV
         WCJeB0koZ9H4hSAMivMk1glRMkQHMWE/ir5IBn2bVbLpCe9sbn14G0RXCqdO0tF0gDd2
         U07STCC3uKwDpHFnwcGYH1WuLQdG764JgvvQUpqvBUiHYbmX4XREktTQpP8nwMyrbWm2
         3ldg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9Uf0AjUaDXJ2G5d/1DZ54W/mRWapbdPr0ZswBhddu3RhtuWANunXCQWj3FvqDZtRCWKafZe5TzNHAs4IgeAFxZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQ0kOoln4aM6E1wgygmZPQJ3VwXNFSD6Ilz3iRiiHg9PQuqP7
	N3Pa972ZnqGJDhNEFXy6NbAN/x7RLrMNOjU/EfjimGBHZyidbLu/3nNpF/gNGHVMWaYVMq20yw+
	LXJ2FuO2q33yfMX9nS3yS0H0x9P+x2yTH6a6+
X-Gm-Gg: ASbGncuVr50WKYZFf3U5VN4cuWQ7TWkaijsv42EhOoWzf63rm31zTxij1rC1dy/AUKm
	FE4Eha2i/JbElc8QRYgQ0rVbvOIaQdppChDXu17LYufG4pWs9UdGlXNqJvUp5EsSGDGsK
X-Google-Smtp-Source: AGHT+IGi0hs5f6CvB2IN226MXTm0Ra44UaWAgyGn2Hb2ZqR78sF/nuVzUSwuhQqEnx/3viOFB5AlpGvLLyrmeG3geiE=
X-Received: by 2002:a05:6102:26c7:b0:4b1:1a24:e19c with SMTP id
 ada2fe7eead31-4b3d0d9f91emr28490986137.7.1736973827247; Wed, 15 Jan 2025
 12:43:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com> <20250115093135.3288234-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250115093135.3288234-6-kirill.shutemov@linux.intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 15 Jan 2025 13:43:10 -0700
X-Gm-Features: AbW1kvZhKsd-4bholfmYoUBqn5JymeZ06XAaCDHVg7uCmb3oxbCKX29QDQ6N-Rk
Message-ID: <CAOUHufa1vRhiwCNvVa+ztcrFix9keAgbV0E7BxFN9VKAZ+7Z5A@mail.gmail.com>
Subject: Re: [PATCHv2 05/11] mm/truncate: Use folio_set_dropbehind() instead
 of deactivate_file_folio()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Airlie <airlied@gmail.com>, David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 2:32=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> The recently introduced PG_dropbehind allows for freeing folios
> immediately after writeback. Unlike PG_reclaim, it does not need vmscan
> to be involved to get the folio freed.
>
> The new flag allows to replace whole deactivate_file_folio() machinery
> with simple folio_set_dropbehind().
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yu Zhao <yuzhao@google.com>
