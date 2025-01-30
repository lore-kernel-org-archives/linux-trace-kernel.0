Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFDF196DB1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jan 2025 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269304; cv=none; b=fNeFkVwiJJTrRVSn8RZxO8l0PGu//ymht81IPLwgQ/tVuo/boNhYkHnHUE4L8CR6rzQUnB6/31DQl+0sUZRdK4a+pp93n6sID6ehnTq+MX23z/LUUMsVsJGZKkTo18MMuOglCUFB/lkGKS42O3v6vOu0FgjMvey3ICtiOivyvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269304; c=relaxed/simple;
	bh=i90LZEJP39KZzuaancmUFtDGdMy9w3zyTcWopQWmg60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZ7UehKNnIyPOxJEtHNKODhmjGFmAofz+RS1e/oep8NMyyWZHIV0YThsNuiQXFsT4wzQOz5vxJvVx/0SJTbH+x05QR1Vg/GLMbPkX/17MG0cXl9U1eQw0b0ypRMk8O3J3+WTRRZIQ2fCf7MVyB58V5H6WG9Q9ddBypvXD5UBFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0SDAGsb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0SDAGsb"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab6da1bb1a8so89111566b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jan 2025 12:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738269301; x=1738874101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i90LZEJP39KZzuaancmUFtDGdMy9w3zyTcWopQWmg60=;
        b=C0SDAGsb6aoxiIDl26VA28h6nEEWfzLSputwGsqgRGp/0q5KH4/B0nVzCAlLlQ45kA
         mN27ySAI//VFOz0+FNnTkUwbQNNdOLZIO6f+58MDqB9qvURN4cxEQp2//QNJaPcdosWn
         Oyqt3gMx+3wQRAy6cyLn5M3n8YAYPO3wycteGkxICxwACC+EIEBdpHR1x83ZE4mO0BCM
         nDKq7N8vxhABhZTuLruzsQZSlTOtuMhffpkL7orZXpr+0Q2FWb8vs8M6uQPkI4yLzfuC
         YrnebunTh0M+I3HUOy8VP31rUceAu8O1dyrmzNa8T/HrvgJT5IZ+pgQZrrrPT9y9Z2zU
         xQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738269301; x=1738874101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i90LZEJP39KZzuaancmUFtDGdMy9w3zyTcWopQWmg60=;
        b=nG9/qXm9J/fVY4o6x4pXsvnQ4dcwscAcb3JJlmyj30lb7nE50WQhBhpOZma9zd5ScG
         eV60Q8/sjbCFPLOhg8haVxWV4MiQuD89Rh/JZFPJVB3/y5KQW31AHOM8mopuQ7c0mKDi
         dFA9OuxKR1trZQWU0qPCILEB8VuxnNux598X7OPCBeau7HTOvSDzrhpWY2qiXlXWh7u2
         YV82DyfpcdjFcJG8DmKdaDPi3Gi1PlaYMUZFxDAAX9loFDZRSBnnvFIdCbKwNFexTGNG
         LSFiW2rGPuq6NbiGnQUc1newT1VZHGCXWr30g5BXo7su/pnj6GGtZxpxQg8T9AneYE/v
         zvUg==
X-Forwarded-Encrypted: i=1; AJvYcCXxd65ZOJjrhzXhYHIKjBUfn9RAJ8DpXNyBUTC6dVYIISzIvFmnX9chTxgntQkJ42+eNbsiIwFop8wg5+xnIl/uNSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz31MpelrPh7pEjVxlVaQCRtaId4J0ZRPYRjHDG+LhrgGBbWidU
	EcMgDgiFBovY87q0HeZb3PO5KMih4y8WtQz208ivjyDTpVgLOnOFQUoxRGWyBcSknPZqRXF2oAd
	fG8HJXABDMayIhBUhPEw9cy5tCtKgEXH/YNhM
X-Gm-Gg: ASbGncsdLqwDfM9Bfw2cxJbQalhlj9yLmQZkkIszRbRHxU2y+BYX2HZCMlyTS6NHSuj
	0Leiok3fCwpi4jLDt+DF47DDiTXE87bgKlj4XeklhwrdjV4qat7MBwkaRpCA94bwUKRDOy85vwm
	cCnpqCwIsaesuzMmAD0ylZbbFNuvUrAQ==
X-Google-Smtp-Source: AGHT+IGECMPAgyniOqYNB21R66I8EdMyOHzZpuuSW7CxtAKNGfo7YHvttie355d+QCVHN1qEbYdE+9qUUvFsylnBIlM=
X-Received: by 2002:a17:907:1c0e:b0:aab:8ca7:43df with SMTP id
 a640c23a62f3a-ab6cfe11fa5mr941990066b.39.1738269300801; Thu, 30 Jan 2025
 12:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com> <20250130100050.1868208-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250130100050.1868208-6-kirill.shutemov@linux.intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 30 Jan 2025 13:34:24 -0700
X-Gm-Features: AWEUYZl3-5-D2vyBu6SH4C2leVIlg1PIhkFjDOkk3Xxy6Plb6I0iqOiSPQjOIdU
Message-ID: <CAOUHufbZAp9jJb7AA_LF2sS9TbN-T4ssSrp2GbqWSAbf5rUCVg@mail.gmail.com>
Subject: Re: [PATCHv3 05/11] mm/truncate: Use folio_set_dropbehind() instead
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

On Thu, Jan 30, 2025 at 3:01=E2=80=AFAM Kirill A. Shutemov
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
