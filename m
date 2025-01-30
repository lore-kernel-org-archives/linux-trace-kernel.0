Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52841196DB1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jan 2025 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269457; cv=none; b=kfyY1xa4KHLmt6QJeIifeuVcn8wU8GDUuRynDFGXWyofSL9fzvErCpGOFgC5hA3hnBcWsdVfAgwNLB6P+o39gfRI7JWhbFBGewf/PhIW1l/QvUMTrv/gCHlWwq0+7OCqilRaNYd6CD6A88EXPaRS1tU5HMiRe1emrlZ/FzBZJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269457; c=relaxed/simple;
	bh=xT8Ut8gLz6JZTplLJnZjKEdD7Di9InMwjf2e/4aq99k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdtqGy8utpn+1EUPrN4q4u4z739tTYnpuXuQAAYCPe/eYs0C/PD/40WkNJfGdBQ3So8pGb6UtpgqSV8uie8yBWSYOsVSKtg+VlKYUAsxEe1PHwuwUguHj4DLOCQiTuIgQRepj0jUSOxGWpCJW/8MX5z6rRNTn8USeGMtkR1l8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7tWGvBt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7tWGvBt"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab69bba49e2so203416366b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jan 2025 12:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738269453; x=1738874253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT8Ut8gLz6JZTplLJnZjKEdD7Di9InMwjf2e/4aq99k=;
        b=v7tWGvBtWDgymFPE9TJ8ePUVMVQNn7yOt1pquGABTZEmIXPVd/SngyRtfl7jC9s90R
         Hwtd8LkajRsTmTK+bkwi8f8OrW+WRBwnJET91aYi9JUaRw5Y1VvhAQifqbtS32N5LkMi
         qvYxpB4kK/PAlp1m8Aru+cnBvytkoSj80SEDE26tga+nuTmrea2W1kiYKaXa3JwgzDx+
         5Tc7vMY6xEkLJByJhXYpSb0fHQi1paGIUiCtSLMQAPwEoqiZ5LNR71q4dJcGUnCMZqWE
         /lI7nQa4Qetv0qJZDVLFibXqX2qogVTvN4k7a5lHaF7VuOMwNj/92t/xwx8FQIy36FkF
         NJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738269453; x=1738874253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xT8Ut8gLz6JZTplLJnZjKEdD7Di9InMwjf2e/4aq99k=;
        b=alM/bSjYPbRaWvZN93QKeJCzQSOjXU7W2Sgt4bdZzYWWCFv3j7ezpEyboroBomZx7a
         oFZnS7B2+cxLUJ1CbYiXj6fP68YxTpS2oiIakuGxX4FuKsF3zysuklo7s2EfQY6zbgEk
         QXqzVJWkWyeJsLC7eG4hXtq70CTIUqHmVf6p8nqzfHYvOZGWPDbYAzBaSrhgtUEyihYK
         9YzJ4tND5ZxomH9F4BhN7O2EB8lhrsgLiu1lIqfujMKrfDLaSffcj5x4c1svbRr50xCP
         J/gAx5GEeaU67o6FaIisy8qQrZh7udC9z6YzKvKWgK5lGg9LUGa9W+kvsc6XRreHrjQF
         FwrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd2M6COm4T78yeNeI2L1qlvzQ+fNz9a40DPsAUED4VUaDG0id3MHIZyQAajqDK+85H5Y4SKlopl/itmwNSK74cu2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3t8FHCp8orHKgp6H15rV9tZQY2zPbLI/UVKrP7uCTbTW/q0Ne
	DaBrvEu/1BUY7YfzO+BKha94y0sVXSdXVfkPHWCQCVgB873MP8x9liSwcmHSEkZ5BLYVLxSXNPu
	Ge6m11oVkztHYg1hloy5ICc7s6OsevnWw6xuJ
X-Gm-Gg: ASbGnctD7ylF1gRIIoV3yA+Y+ongPPPEkR+Bx9TlLtyIHLMIsCq6u7+Bh+DdPwE4q5/
	2t4enYJcXx5QQ0Eqt+wLgqB/WpK7uLlNNUYd0cJcRGNnh0MJvaUIRiAluWIF8L0xxVIwYDKypsc
	orPPx+tj1t0nXpJ/SDf1ejxV6leFxknQ==
X-Google-Smtp-Source: AGHT+IHgOIJu66b5+FkCjUTqLe+kFJ5pnzkiI2EWbnmTxxfuYeBlU3TGfepPLf9b4v1IsOlZVSVianh0S1Lnh6AsAs4=
X-Received: by 2002:a05:6402:4311:b0:5db:f5e9:6760 with SMTP id
 4fb4d7f45d1cf-5dc5efa8bcdmr18615952a12.2.1738269453403; Thu, 30 Jan 2025
 12:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com> <20250130100050.1868208-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250130100050.1868208-2-kirill.shutemov@linux.intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 30 Jan 2025 13:36:57 -0700
X-Gm-Features: AWEUYZk-T3PmFiMQXizTQSxtfw262HuFGqWt0YvgioLZEIzF4uEgK1GJyl43NpI
Message-ID: <CAOUHufaap0fbU5LGhvm66Dh7jiBjsJiKPmLjVje=BkoB3C8ToQ@mail.gmail.com>
Subject: Re: [PATCHv3 01/11] mm/migrate: Transfer PG_dropbehind to the new folio
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

On Thu, Jan 30, 2025 at 3:01=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Do not lose the flag on page migration.
>
> Ideally, these folios should be freed instead of migration. But it
> requires to find right spot do this and proper testing.
>
> Transfer the flag for now.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yu Zhao <yuzhao@google.com>
