Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C33C942B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787738389; cv=none; b=PLNrRMv0n3ns+k5vRif7+8qcuE+iASRbC41+l9WxuZBZyPrpEt7E6YeAcY9fI77tP/svEfSmGp++wS24JEBnpRlUVdP7Zs5/rv/5iW80XFMzhRArQxA8i7oLnupIy4dSpfzrDoy9foUmfS5Esp/RUVBuB7W+JJFcq6cYbL/srzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787738389; c=relaxed/simple;
	bh=6e6OjA+zNQxwlsTn1R8mNfyK3bd/UsQ2WupVSHAPhuE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CwQEWK/LpOqVDPfvBxJmrwgJs0vTjCj56cmTNqOsJUlDKdtMzZ6eOTM7KjWZAXPm/P1Dbi1BJEf/Qx0fPkQFdQW2yuM3lJFfDb2PmOA5FsdXJnFjeuO4o+gb9VIoU1nAm0th6Vx4jF9kJu5R7DbogeremydT7lypj9M4GRu2pO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfM0Cqud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfM0Cqud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF8B1F000E9;
	Wed, 26 Aug 2026 09:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787738387;
	bh=7e3g/MMvrAYsj/eE1u9f1r3nJ1mYwxXRBreXNfzRAZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TfM0CqudSB34Og5qQ/zGox5QZ/7mqjSnRo2v+vHwQ9kuUOHS+CENOSQ6o2lHJ2oVs
	 8XqoiuJWd2Z0UWutIAMu30aInvZRh8p2j9wVy9o2powpqFL/HLg7OTaRlMZU9YmwhF
	 e2OSCjZkgwKa/w1n/b2y/ED1zEjy3nBH4jHUeEqZpvtd5dTsG9RlS+axbabkcGttVp
	 G21DBZs18gP2aeMqokySckEOhr+xYeiJFA2mgDAQPo+NWSKkjK/Hc/ifQewuRpHq+2
	 VvCtzm09wq340E3xpzF8dB8NbxdWGgtCM8//eUYwq+YglHCfLexThvaxHP5HMuWkDm
	 9m7LfZpgHyntg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260826094528.3738023-2-vdonnefort@google.com>
References: <20260826094528.3738023-1-vdonnefort@google.com>
 <20260826094528.3738023-2-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 09:59:46 +0000
Message-Id: <20260826095947.4FF8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ring_buffer_read_page() incorrectly returns -1 for splice_read req=
uests on subbuf order mismatch
--

commit c4d6ee6f55f23c8ec6da6f812ec3b722b2b7f6b6
Author: Vincent Donnefort <vdonnefort@google.com>

tracing: Fix subbuf resize races with trace_pipe_raw readers

This commit modifies ring_buffer_alloc_read_page() and
ring_buffer_read_page() to handle dynamic resizing of trace ring
buffers, allowing readers to avoid stale size values. It introduces
a manual data copy fallback in ring_buffer_read_page() when the
subbuffer orders do not match.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
[ ... ]
> @@ -7183,7 +7218,8 @@ int ring_buffer_read_page(struct trace_buffer *buff=
er,
>  	 */
>  	if (read || (len < (size - read)) ||
>  	    cpu_buffer->reader_page =3D=3D cpu_buffer->commit_page ||
> -	    rb_is_static(cpu_buffer)) {
> +	    rb_is_static(cpu_buffer) ||
> +	    data_page->order !=3D reader->order) {
>  		struct buffer_data_page *rpage =3D cpu_buffer->reader_page->page;
>  		unsigned int rpos =3D read;
>  		unsigned int pos =3D 0;

[Severity: High]
Does this new condition break splice reads when the buffer order changes?

When tracing_buffers_splice_read() allocates a read page with the new order
and calls ring_buffer_read_page() with full=3D1, it will now enter this man=
ual
copy block because the subbuffer orders no longer match.

However, just a few lines down inside this block in ring_buffer_read_page(),
there is the following check:

        if (full &&
            (!read || (len < (size - read)) ||
             cpu_buffer->reader_page =3D=3D cpu_buffer->commit_page))
                return -1;

Since the reader page typically hasn't been partially read yet (read =3D=3D=
 0),
and full =3D=3D 1 from splice, this check evaluates to true and immediately
returns -1 instead of copying the data.

Because tracing_buffers_splice_read() loops and ultimately returns -EAGAIN
on failure, will this cause an infinite loop of -EAGAIN for userspace tools
trying to read across buffer resizes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826094528.3738=
023-1-vdonnefort@google.com?part=3D1
