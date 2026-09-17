Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DDB3BBFB4
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Sep 2026 05:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622499; cv=none; b=dwcAb49SD6vWWWoYto0BroWiRFtAlHALJSQP+cvoIAtFVse708cD9Mmse8EwTP9Zdh6XPM6BB0wsSWxCWAIgZsA1Y637SJQvMQ3OXP6EVgjo1JtrXZFpyCi6fCNbnZJAjTDAcd43PjLf4aftkO13RO/m5rBozBTOcpzb6n+0VT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622499; c=relaxed/simple;
	bh=ncpSYBZfy6fSP05xt/exBsegjUDdGuio3Ya9NjqO+nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usq7HrWEQUfxKss4h5bw4RNTK2v/PrG2OOb1hkV6jM9OsCSP/VlfYPO5lO4GJpb6mDylPhKQF3HBmTJ2Y4kkrHwHY6mHhw1iFvQCt8wMT/cXjdzuKqM8PZPUan/Npoiir1E8+hBdUHQliFT9L5AQ3sZYlRhyhNGYR46FOFJVwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAtV/HgE; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAtV/HgE"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so340674a91.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 22:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789622498; x=1790227298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wI0n1pAgEv0aYYQLyLwZm2yEnSd1ksUhBTNoBJK2fUc=;
        b=hAtV/HgE6gQam0WYvVRZfyJAz3TVgQMnT6iGBxws3VhtxajgASrMKH8FYZG7o+1qJy
         Pni6JA0sYuYoBS1cCR0lvsQfFnwSnc55V/dpTFSLBGkdut+OU28tLWL+jkPqJGmURKcb
         r4ujys8kO9Jl8TjW1hjpn5dsPMbvKvOxqjYo3g/chDC4f1l1rX5OBceWzup3C1xKugQf
         Pb5KcXMws9jqpVuULI6/qLszsD08tY02bldtwt8CFIRWuq6XlQDNg0MwrmTF0grTxFdO
         6SS9704apoXnKV8PX4QcwOIMigtIcxA7k9QgqPV7R6pGZjcQ0qcct2rag739ThNNKAAY
         +SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789622498; x=1790227298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wI0n1pAgEv0aYYQLyLwZm2yEnSd1ksUhBTNoBJK2fUc=;
        b=NgMjHxs4nsx8xCe36PUeHmT07PFdt77gjFZ/qzpmhHZ3KfSsrDUMr2vINhCfAIdb6E
         JTuSjYKnpRUcWAf3LNNTSe8culvvgvg9olLLjFmFhJX3Ogg7lwJfnrbDHAd3exHmvtmN
         mFX3NWx4VEm4YIFE/CfqtqWBz5VNaHxCjUDCfkm2vl4XOB1/dY9H3X3Foeg/ImDsVhPZ
         uh/aC6OUWaU0/A5BVuouheNVcyTTFiczZu9y7E/gGof0BNoJckfdqhM8kQfzRijaX4jL
         fHeSNQ+Sok47T7cmmd/yIuoU43hjh57OugU1rUyE8kF8QufTrMQ3BjCKROrf2mmm6S6m
         7iBA==
X-Forwarded-Encrypted: i=1; AKwUvBy7J8zhiFBg36z5sxvYaIDncspJyv5EtQJVt/b2phhkOYzALHNnqb/MoY6uezuclkV5pxEO//eniVHwndJq/v9Bao0=@vger.kernel.org
X-Gm-Message-State: AFuF++l0XSAJ1JGjNGVqKu+ftqBTB2Sgwga2GcnxP9AVDhFViTgB0ABd
	amiOlw6x59Uab8Fr/rebgyHh1g1dLjVKLle4b8PdnadvEOytCkqo7Do=
X-Gm-Gg: AYBFou1RbRE5fcC9Etp47YeyRCVGV6cBTC8Claid2EF6+tkILbtR6dlNVJPpsLvM6gX
	8jJZ9w7MnVOa83zdWZjCtKZ/YhWyb/rq775h6BM3lVE00/M4UN6lAtrdaqOTWtmw4/KSEDqIq4J
	lCc0aOqYZIaoAua/rMXIdAeL6Oi5hPU/GgPA9zwIXBNXwIbNHc0vAWAAH9pj/sQhZQW6bwz5acI
	3sw5tN050O3kxp+1DUHOU+EcToFCiSt2UWKGXXApOOzOoDi1uvRVSR+22l64vCZ7lMPZIOValZr
	h42Wxd1j8W0D/gTrUZFaefd6K8ruBmX69FfFGedSK8JNL33V4nhFHHBwjeTuIL6z+jLB2lqNzYj
	n0l8NlJb7Tv1b4Q9DT+RgU5DlfN2Jcr/Gtl2nVTM4d/uNo01EkH8Sru7Wkc/SmXe3caw4WK9sDY
	Fn6mghfTQ4Qr8rvRL837eq4tAa7g+dIeVPDBO2kruY8ffi/XgImseIOQ6l5DRRQMT6cUt/8fCjB
	sJmGEc+0oR7SOshq8z+tenCViQAgN3RPcJ6NoA=
X-Received: by 2002:a17:90b:39af:b0:398:c315:fa6f with SMTP id 98e67ed59e1d1-39e1e45cbd1mr11380577a91.14.1789622497706;
        Wed, 16 Sep 2026 22:21:37 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b6f9:c198:e14b:34c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3abada87sm1916280a91.14.2026.09.16.22.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 22:21:37 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] tracing: Print the bucket size as unsigned
Date: Thu, 17 Sep 2026 14:21:30 +0900
Message-ID: <20260917052130.371970-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054614.82A9B1F000FF@smtp.kernel.org>
References: <20260914053443.981201-1-donggeunyoo.kernel@gmail.com> <20260914053443.981201-2-donggeunyoo.kernel@gmail.com> <20260914054614.82A9B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 05:46:14 +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This isn't a bug introduced by this patch, but does the unsigned division
> in hist_field_bucket() break the bucketing logic for negative numbers?
>
> If the field is signed and negative, its 2's complement representation is
> large. Performing unsigned division via div64_ul() or an unsigned cast
> without checking hist_field->is_signed seems like it would calculate the
> remainder incorrectly. This would happen whenever a histogram is configured
> with buckets over a signed field that takes negative values, mapping them
> to the wrong bucket intervals.

Yes, and the two other issues in this mail are real as well. The 32-bit
truncation in DEFINE_HIST_FIELD_FN() and the one in hist_field_log2() are
posted:

  https://lore.kernel.org/all/20260917015532.103081-1-donggeunyoo.kernel@gmail.com/
  https://lore.kernel.org/all/20260917023834.216893-1-donggeunyoo.kernel@gmail.com/

This one I have not posted. When I went to write it, it turned out to need
more change than either of those, and I would rather hear what people think
of the approach first.

What it looks like today. The largest multiple of ten that fits in a u64 is
2^64 - 6, so with .buckets=10 over a signed field the groups below zero are
-6..-1, then -16..-7, then -26..-17: none of the boundaries fall on a
multiple of ten and the group next to zero holds six values. At the end of
the range the two ends meet. S64_MAX and S64_MIN are 9223372036854775807
and 9223372036854775808 unsigned, and both divide down to
9223372036854775800, so one group holds both.

One detail in the report is off. hist_field->is_signed is 0 on a .buckets
key even over a signed field. create_hist_field() takes the modifier
branch, copies size and type from operands[0] and stops. hist_debug on
"keys=arg.buckets=10" over an s32 field prints

  type: s32 ... is_signed: 0

The member that does carry it is hist_field->field->is_signed, which is
already what create_tracing_map_fields() passes to tracing_map_cmp_num() to
pick the sort comparator - so the tree orders such a key signed today while
grouping and printing it unsigned.

The rendering half of that is posted separately:

  https://lore.kernel.org/all/20260917045918.370993-1-donggeunyoo.kernel@gmail.com/

What I have for the grouping:

 - Take the signedness from hist_field->field->is_signed, so the grouping,
   the sort and the rendering all come from one place.

 - For a negative value, round toward negative infinity instead of dividing
   the two's complement. Boundaries then stay on multiples of the size on
   both sides of zero, so .buckets=10 groups -10..-1 and 0..9.

 - Clamp the lowest group at S64_MIN. The boundary below it is not
   representable in the u64 a key is stored in, so that group is short,
   the same way .buckets already has a short group at the top of an
   unsigned range. Its printed end has to come from the true boundary
   rather than start + size - 1, or it overlaps the group above it. With
   .buckets=10 it prints as

     { arg: ~ -9223372036854775808--9223372036854775801 } hitcount: 2

   and the next group starts at -9223372036854775800. With a size that
   divides 2^63 nothing is short.

 - Print the range signed, which cannot be done on its own: rendering
   today's grouping signed would name a range that does not contain
   S64_MIN.

Three things I would like an opinion on.

Should .buckets interpret signedness at all? histogram.rst says "in general
the semantics of a given field aren't interpreted when applying a modifier
to it", which reads against this. On the other side, the sort comparator is
already chosen from field->is_signed, so the tree does interpret it, just
not for grouping.

Is the short group at S64_MIN acceptable? I do not see a way to avoid it
that keeps the boundaries on multiples of the size, and anchoring the grid
at S64_MIN instead puts zero inside a group.

Is this a fix or a change? It alters what .buckets prints for any signed
field holding negative values. No ftrace selftest uses .buckets, but it is
still visible output, so I am not sure a Fixes: tag is the right framing.

I have it written and measured against three arms in QEMU if an RFC posting
would be more useful than this description.

Thanks,
Donggeun
