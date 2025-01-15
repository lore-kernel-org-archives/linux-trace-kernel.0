Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08631DA11B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974327; cv=none; b=Zob4V/J+5R9RkX8GxCowjgjGEOvVoDE3lJ0CpadsgaWbRvVaGGWP8/4PqaE53iUcD7ywHVHVMyvA4+NmFIynd2tiG8wiXBP4TEmumsEz26nhpiHdkFenCipeOfVZ+5dchLNVtoyw6yd/3/PV5ILTaetV+57iiOxE4eh/YX0uTPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974327; c=relaxed/simple;
	bh=wpDHiR0bXsDBwMbTlH1GqxYsn52KOd85vJTdbko6Ftk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIhE5WtG8JoiU+Y2tzsj6BgLPALH+iFbYLlAcKM5OKMVkQmas7fvCQnUajz1qvUNbIf9Swy6OCMEXecG4sH60E6x7fYymEnJKwZSKJJ3F9tP8VYoboB2va7AiXqCqzYL82NAQb46oLPlGRKfDUy6T/2SdMlQnJkCQ9ChmFGMaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rl0PiRgm; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rl0PiRgm"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4aff620b232so38535137.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 12:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736974324; x=1737579124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpDHiR0bXsDBwMbTlH1GqxYsn52KOd85vJTdbko6Ftk=;
        b=Rl0PiRgmJ2aa9WknDv1tB9zUSs5cTfTRokme8z9m2ePJjTN+yYWyKWpqyISrZTydEC
         Sc4iz1b1MIJg34/L/s3LYPzyJLSewZ3d28GyB5/xjh+p3yvFj169qBDwwVskHk7qRuSF
         jjkJx9YzZNVJssWH1palOuwn5MXZ5EAJPfRH6LEy1RjRl+B9EeKJJ4jPjzE/H5yDAZP4
         yFosU9zdCIBuRTUVmh9DPjUgOsADN+lzw9zIr/LufrbnM/qXRpWytU261LGkwD/MgCO/
         A6LNjjD95o5cPfRKo5KCvwejW+YJ8MfdVbRToZQId/i+TZD57jSpY5lC6E/36SqpXjcJ
         CNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736974324; x=1737579124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpDHiR0bXsDBwMbTlH1GqxYsn52KOd85vJTdbko6Ftk=;
        b=vn5iyi2wHQvxT4fI/nEoqtd0d4jxMVhWrZnBwpedWiMjyeW51cOMqQlcDQxA8LhxJu
         8bvXdZrd4rKnDvr3OUw0WwlECxzygy+PL5gwEy3QJy0lGaBRUs3/ESBzAkk5Z65X7dxH
         +mEe2YD1wYHOnqFHY1L5sjWU+qQ3IxQc/svd83noMDMrVfjLjvdUPBqbm/UeQ84v3weg
         Z8fpjwzYyzlzTmsuqbvlRrPxUTlyb0yoHMePw07SgMWRpFHO//6GJm7LQYM+vH9Lb1Jn
         AlzATSCjeagGMxKVr26qsArhqvK8obGNPmvgOHCbqmZQGu0vnMap8XMXiROnCCM/9cI5
         fX+g==
X-Forwarded-Encrypted: i=1; AJvYcCUslNcw1DfYfLg+TAlRZcSrq6Nr9uchNtQtMIJXkB8UBfpqNucfLqbdiuBaruf5xoC7iJ1j+RbtHTRH7Psa6lUWb0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPeFwqdIbK35hs7F1LUe4StLjoOMvQPxAIWhSVaVF9kMxq/Jas
	ouwZUN1+4G1X2b+/Qb0K+n0s0ZKArLMvh4jqA2+2OW18Evq0Vb5cDPNpibr7LDugm92ICcN8FTa
	tWeH5z0a8bdk4U9YHytGbEZ7710WGXdfa13kE
X-Gm-Gg: ASbGncuR7fMewJvv4aOUoLPzeBpHkuDTQerXESJvJMdiNIgr895IVPMSxVVd/pIXPrw
	QHLT7+gFgIN1PQuprnpn9B6xTpJIqJyTCZANJUn0+BLocLPDtRgJqmuj5QRl1lShRQY8R
X-Google-Smtp-Source: AGHT+IHGJFSTuM3b37+opctt2tHn7VfsuBf4+beVaoaeJuq2++z1RLzVhsDuXLrd9Ee3ASMK9Iz4XTd2JqH50R6dmnc=
X-Received: by 2002:a05:6102:b06:b0:4af:adf8:523f with SMTP id
 ada2fe7eead31-4b3d0f97294mr22811598137.9.1736974323734; Wed, 15 Jan 2025
 12:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com> <20250115093135.3288234-10-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250115093135.3288234-10-kirill.shutemov@linux.intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 15 Jan 2025 13:51:27 -0700
X-Gm-Features: AbW1kvYv76oC6MvIVQyrimg9-wYM-36QWhw54pvoHz-UApVxWVH0m4ZuWq7_GXQ
Message-ID: <CAOUHufbet0=S=9e06jMeoSPef3GzoFm2V-k_NJYbdq2yJe6LRA@mail.gmail.com>
Subject: Re: [PATCHv2 09/11] mm: Remove PG_reclaim
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
> Nobody sets the flag anymore.
>
> Remove the PG_reclaim, making PG_readhead exclusive user of the page
> flag bit.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yu Zhao <yuzhao@google.com>
