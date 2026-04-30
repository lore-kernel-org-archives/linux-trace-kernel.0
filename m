Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8D477E40
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Apr 2026 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576349; cv=pass; b=T/dNWMK7m6VjQ0I+fMXvLsFWGXqnIw7MajqzwHOh0q3HevLHm6+4l9mt1Avokq0ubRUWl8B6ot42OOJ6YV8c816TlSFCAPimfY60mDsmlSYq6o3IypO62O3o1v5eQnJMjsFyhVojg7cv3zNT3Vcp5MFLOfpYJzFomn41Ugaxif8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576349; c=relaxed/simple;
	bh=N8xqxPiz+Lc8RbIzGx9Onv6CwKKtwUHfXe/yYDo0xXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlM6YSjMABCuy/WhnHAHGe+1esPkGl1+GurDzKyBl6/fYB5LN9y5T1WYFp1HYmDoggkCom3FAQzRh9+JK6sP+viurAwUCYVoUVGzSvQyjTGj7Zfn/bkzaIorn/bCejjc1swTnqDlOzk36Gg/lkVlB0PBFBR86pUHV99afPtf6WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2ObAaWQ; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2ObAaWQ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso2086a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Apr 2026 12:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777576346; cv=none;
        d=google.com; s=arc-20240605;
        b=fo3AgYtHeRJ0v/RiDhEcLkhoaD7uZu1U8H/zkCJLZr+lUpkpopMzGC5GqUVZOczU34
         lUqn6X6YCJ/TlcUyGXwyd2d05ypD2wahYqAAf59AuNf2UEht4YnGBnVANnYyLSXD4c3U
         7e8Pqqpkc2XOU77DQ5LgDn5MAzrBfJQbWvhD/kUWfZI4eR02Y4ZjmA7eAgZa+lQLso96
         kp8KZUMDFhcUz9O7k7eIHr0bb7OU2wWI9Txy1TuXOHRRusXsKwh/plyLGTz/rWHbI7nJ
         CX+svEa6O7Q1RamuR3ddSb8PHRXkUobZUZcyqDzGIopXEU8QKm1BMvmu523Hoe81ugJ2
         MOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8xqxPiz+Lc8RbIzGx9Onv6CwKKtwUHfXe/yYDo0xXQ=;
        fh=yu20QsVd3hHmzUpVwiH/EEkFSzF7AY3XON3EctQsUgc=;
        b=PqFwgaNRUcyjSmbh81bhFZBjgHLv+lTjOt6+0RcLK70UsnY//B/Gj/y/sMyXSa8bKX
         ndwxapLiHdD/du5q9XNVKNsBWohNxDIqqdwvgqrB4gXdltx+tMY7RPO8cet0iOg8Ni8K
         Pw4I2Mkit0N9qFo3+35aKw9YFoMhm/aNDdz/m7a6i4LOMfps1D90W2PjpcXYR8spGLTw
         Ygz1FWFBuOoDBW6q6KkQ5a8bXtNL9rryNvLwb/2+xFJ7FVaRC5vC+Pyxp05W63l6rMvU
         CoHBr9oU2K0x74hlcaPCBqOgC92WYMFbv1sHtMNz3XjcHakhUgUyDJSmts6D1+9itFvT
         upcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777576346; x=1778181146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8xqxPiz+Lc8RbIzGx9Onv6CwKKtwUHfXe/yYDo0xXQ=;
        b=E2ObAaWQqCJy5F8njMCcuQYFtbkvEgUS5MnL79pcVF+gS0U5yPCgjU4Xvyu1HmuiAG
         wecYrrYhzNgDyY7n8hcfrUsATGvuv+F73GQcNY4SMT9inCxPp8/7YTKrEvOM7AqMeIw7
         A0u1EcllpoxfPMj4+NWM2qGlmIP9AU0aF0uyIGb4SWhMl8LepoUt8K6mm5PDt2UvAEcM
         IjL4aHE9CpEgQwXjt13Bne2cn7NPN9ElotS+DGZ8bFO+Z8d2rH1LIaJJg4kZ2ea2xLxv
         WBci8HIyDgIbDl+WhXxNGe8/A0kbQ38XCdaG0gvgqxuuYUSbheVnYR66sCopOp5zjM4p
         EuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576346; x=1778181146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8xqxPiz+Lc8RbIzGx9Onv6CwKKtwUHfXe/yYDo0xXQ=;
        b=rbwyu0DMjojHNvb+7dXBmWiViyQ0xdTvNWBdxNiNX+yM3sRTozuW8zJk95imJCYNfl
         vaMHOuHb9OwCDdyAIakFNTwGl/mJ6eJuClEI8jT2EBB4rNzVrYfZaPAyxIqiRl8beNBT
         KSZeVD6VnmyzxB7PZmKJeBLtwNNZcP43PwaIZR/IfBHtkP7YOppi3+TlKeR1wPM3Sfog
         iwt+Tn/qLyPcIEHRQPjEZ72Jxn0PQsDM9u3tlqwfJ4NYjphnURVSnA/t4xrtPjt6baIk
         pnX++8p9OWmBKxkL3EKIwsB4NNgNGKO+grzozcpL3z8flnmT0Etilfp0k0GAZJBGTghd
         c0uQ==
X-Forwarded-Encrypted: i=1; AFNElJ8b+bt3mTvJOdW8WL3JJ31lMSzyKzskrs/5D7hdUcXEVfJaFV/CDdxxAFP3vSBv6OLX7Pwyo6FeqD5FxIZWobp1fVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFnnwD2SIPfc0XqzylVCAQn9JSydq/HLGvqUNRA/3zNy8pz874
	4YLyilF0FpB195jLxHFyvzsm6qND1/UbrLf5Cav3OypLZApq8avPu5LtUz2UYHgjQi8uvJdLWun
	1U5vBn93Ke/gLoTf2UJfxjcrFx3fKypxcaykTodsC
X-Gm-Gg: AeBDieu9mTLg9S0YG2aqVp93WMF8YrrXbeyWrGlyKIAtqRfaPyuA/Tl/QPQwKxk/Fsb
	0n+IFq/fiv85+TKI6OWJk685unQRo+FFrRdMwRO09JRJbkM2ADe8V11QF3+QbNrohqBw/fm0PpA
	hd2JjFGaUQ0fzaV84Wx5PGv6ABUahMT0x4EM6T8VvYlroCFmEaJgfqm8jjG2du2Nu/nOWASw66e
	H1Fdq18bW3ya0RZSieyUZiDyypLYqggTRAZdg75wS/i5N+eXxwDrwNh1nLw5qvzPxregrvutGj2
	yx5ZWYGZeDSTKwfhOWKoaYvi08SXDSmmaYiM3pc2aIg7TXn+257jdTEwsg==
X-Received: by 2002:aa7:c499:0:b0:678:8834:1b49 with SMTP id
 4fb4d7f45d1cf-67b92d3d685mr6855a12.1.1777576346007; Thu, 30 Apr 2026 12:12:26
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429131522.4049054-1-dtominac@cisco.com> <889e4186-9f75-45d3-bd9a-1c90b218a635@kernel.org>
 <afIiqR5CqYRId0N0@redhat.com> <afJz3l6435DHLorn@goliath> <afMeAs6upm8kLCYb@redhat.com>
 <2d815203-a81e-40b4-92ba-31832c84c20b@kernel.org> <afOjk9igx9nlc9cg@redhat.com>
In-Reply-To: <afOjk9igx9nlc9cg@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 30 Apr 2026 21:11:49 +0200
X-Gm-Features: AVHnY4K-YxCsSWEfMM3euP0MFRxkho2vVQKGYi2YKLesi4gZWVCDrwbxNVlDvgE
Message-ID: <CAG48ez1B7ubv6yJWA4CoSm3AzzyiNHzcAz0ByX_VhCqaA+iQTw@mail.gmail.com>
Subject: Re: [PATCH] mm/madvise: preserve uprobe breakpoints across MADV_DONTNEED
To: Oleg Nesterov <oleg@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, "Daniel Walker (danielwa)" <danielwa@cisco.com>, 
	"Darko Tominac -X (dtominac - GLOBALLOGIC INC at Cisco)" <dtominac@cisco.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, 
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 8:47=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
> _In that case_. Instead of this patch (which, rightly or not, I personall=
y dislike
> in any case), can't MADV_DONTNEED paths check MMF_HAS_UPROBES or vma_has_=
uprobes()
> to decide whether .even_cows should be true?

The manpage currently essentially guarantees that MADV_DONTNEED
discards CoW pages. I think it would be a bad idea to change that
documented behavior without a strong reason, especially if that means
we'd have to add more special cases to the UAPI contract.
