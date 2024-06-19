Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDAF153820
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819843; cv=none; b=X42MUM1duLeF5AyoBw9/deBqH/E15IlN0CP+LQ8KuVbfrGuFKloHHb48GnASwL45dv9CH2M4/Z59RlWHl0L6Rsbvx2NiOiu+TNLVBQQABP+zJHh3c29tUG2R5VAbLjDRDVC6rcAx8iKbUeiEwMMwVenUkyXOlB6jkR2ul7Mqh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819843; c=relaxed/simple;
	bh=cOST1LD2L/IX7IsCCJXvuJQMIXuM5uZcCpA50xbBDuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzZ2kb9bRLigfPXyXwu8jsg0Maq3woiEJEVq9d9NKL0gECWQQ939EsqeEEO0qpN32uFhEcEjLWXB7ktMkvtIR6Ld8mGj07eWBUNRdtDZNNBtCZP8mBiP4UIw+3pUkPtfxgGsBbTFTa8mphIrT2jlox8SwEp9glI5AKw9SuMvoBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W1uIjQxm; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W1uIjQxm"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cc9b887f1so84469e87.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718819840; x=1719424640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N8Kayv4g6koIn38mbeG+B2azD4AgtkWZC+a18KeR3Ss=;
        b=W1uIjQxmaOD/MhrLCRSRm0fbIco7Hp0GIDfsFINT93DZoJTi1bdrr+r8ywfP+RAbmX
         /3N9YFSTNOHmbhtkiq9bbGR0Q/54Yo2vX5nWVtvbdocxMUVS5tw4J+zjJZaKu57LW42L
         fOr4f6xGI8C4hwZMSlZ4F5T7MvvSJUu2DwCYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718819840; x=1719424640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8Kayv4g6koIn38mbeG+B2azD4AgtkWZC+a18KeR3Ss=;
        b=P2D54oyVLkQ5e6vK7a0m9U0Y+dO8IOlQBi7moTLaBiRHkRM+K7ceCYxEFanF7MrJHG
         PT8WYBwkW77aTorEYGKFg+8iV8k+GZSOKHo6mdmLjK7Oc9VvPkjyF3Y/ZahyWRPjT92O
         gACanc6nZYtr0vja3rJKz7klaqFrju6OlMkepFovZIwI3wNXTMyd84pozMF7IwJBpZl+
         FARNG8rhe7mmPYfZzfMGkVD02b36eZNZl1S35HKXP/k23GpvG+0nC+qr4vuBFkFv94RB
         UeYcmjt9Z/V/+wcUjz0VqhEYTX/KOm/PB255J+Bqaw8w4+YMR+tvWrGoewsyYU0YAoTa
         Gx2w==
X-Forwarded-Encrypted: i=1; AJvYcCWdidxGLWNe4IaOCp+/JemLbQfHvdzXrGXE9F+t/HBHFL2o94ZPULFQR9l9n5yPqecFniMRSPV9iwn0JqKGicddNBc6Mi9G0pGeJYGsd712S7uE
X-Gm-Message-State: AOJu0Yx5OGo7a4DjzwlPda3JIyFGqFr5hgshfK7t89AVOt++gFTQLKOy
	vf1eLE/fvDJkwIme84xOZBBt9Ds+x9b/HPBl0jhQ4EnYpOGRrWSXW/TPecKYnHkAgrgeCyanPXN
	X9TeOtq/r8OT5My7N8H/I6tK+BXcoWFv7LQ4=
X-Google-Smtp-Source: AGHT+IEgCS86JnQXRyN0nE0BGQEBVqiPjOVoriIOkC3n4X0reg2XiAoY/sbyO3Xu8SPKVUrmNpIW/ln1WidijI4MmP4=
X-Received: by 2002:a05:6512:3f0d:b0:52c:818c:13b8 with SMTP id
 2adb3069b0e04-52ccaa587c8mr2438161e87.4.1718819839758; Wed, 19 Jun 2024
 10:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618093656.1944210-1-takayas@chromium.org> <20240618155320.75807db5@rorschach.local.home>
In-Reply-To: <20240618155320.75807db5@rorschach.local.home>
From: Takaya Saeki <takayas@chromium.org>
Date: Thu, 20 Jun 2024 02:57:08 +0900
Message-ID: <CAH9xa6cNT6VwQoQwcop3uLOHLF8xqX=D8HQ7x4C1Aw3qNr=2_A@mail.gmail.com>
Subject: Re: [PATCH] filemap: add trace events for get_pages, map_pages, and fault
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Junichi Uekawa <uekawa@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Thanks Steven for trying it out.

> I can see it bringing down the number of pages needed to be saved dramatically.

Yes, I agree.
However, note that wc does not count the size of the page caches
correctly since 'get_map_pages' gives you a range. In your example of
the less command, actually the total sizes of page_cache_size and
get_map_pages look the same.

Instead of less, running a large binary such as Chrome (232MB) gives
us a better example. '# trace-cmd record -e filemap chrome --version'
showed 58% reduction from 42MB to 17MB in my environment.
- Total size of mm_filemap_add_to_page_cache: 42,958,848 bytes
- With mm_filemap_map_pages and mm_filemap_get_pages: 17,993,728 bytes

By the way,  'mm_filemap_map_pages' traces a range requested to
populate, which includes pages that are not in caches yet and thus are
skipped. So, you need to calculate the intersection with
mm_filemap_add_to_page_cache to see page caches that are actually
mapped.
I'm wondering if we should put a trace event per each successful page
mapping event as mm_filemap_add_to_page_cache does, by putting an
event inside the page map loop.
