Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD870511195
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541269; cv=none; b=ARCGzdyFbv/v6U78vADGtQLwHzVVXlHDuZNWGf6ZSg4Z1jTJzRGPPKfyA0EnxWQzhhnaXMAwzGfY56F2oLbFXMKS9d8FY8y2f12e6DWf2dT92Z32oIOf1+a9T6ynQ4QBBPWRlNh2rJapWbijO3dYD0KlD/40/MFQqQDPUiZzCGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541269; c=relaxed/simple;
	bh=WSGOooSvdPOErmQWMRFYSK2TyyHL9KpqPruDb8it6EQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HgNJFY/JEcWQ911I8d2A1ti/FAvfjQADe+19l9cDAJyB+PpFQ19Pr7bGxzaDaHYPo/7CfAj6y3jpctR+RAnRi1g9GoKNCl9c9mDbzIt9AlqsCDN9WNeae85uDye9CKCEVHIRZLC84xdqViVW8tWerZQsKRg+E+SPpIxRnBGj5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9nTB7qI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9nTB7qI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812081F00A3D;
	Fri,  4 Sep 2026 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541267;
	bh=X1Isb3de5hryf2dhPlQfVHAwmfQ6DRvCnwCrsX0Bx7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z9nTB7qIczSXow9r8DYbLF0ovMM8BafI06LtTQDE04ErASphO7PGeDkHhuFqd02qZ
	 jh61yCJekUivD6EaH/Js6a4lUnyEFjkAEpa60c7er4EPwxV3D+q9ZJW1C5Dw9m0FkA
	 qk/cryoAUxN5QgrRl+g4GIMqSqpMD1E5eDbEgOpmJuwsY0OiiLGZz1z74bWjXTyYER
	 PD1q/XBWvfJ9nyZ2wt51qZroXWBl7avyxHO43TDM4gMUQ98bKw1kIT7ysGLALY06jm
	 KLwnf3lBEJmaUZc+E2aImoV4LOUBB7sXbtP6jPKMhVcm0cNziM+oy4IJGBKWOiDCDC
	 GyHlmH6tt3ZcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/4] ring-buffer: Allow splice reads on static
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904164450.1345852-2-vdonnefort@google.com>
References: <20260904164450.1345852-1-vdonnefort@google.com>
 <20260904164450.1345852-2-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:01:07 +0000
Message-Id: <20260904170107.812081F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double fetch vulnerability in ring_buffer_read_page() when par=
sing events from remote/static buffers leads to out-of-bounds memcpy.
--

commit c069a5fa2bee1114a0a60482e4b506024892ddbd
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Allow splice reads on static buffers

ring_buffer_read_page() rejects splice (full=3D1) reads on static buffers
because the !read check assumes unread pages must be swapped. This commit
changes the logic to allow memcpy for static buffers, returning an error
only when the writer is still on the reader page.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index b0963ac6fd167..84fd4cdd486f8 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7193,15 +7193,8 @@ int ring_buffer_read_page(struct trace_buffer *buf=
fer,
>  		unsigned int event_size;
>  		unsigned int flags =3D 0;
> =20
> -		/*
> -		 * If a full page is expected, this can still be returned
> -		 * if there's been a previous partial read and the
> -		 * rest of the page can be read and the commit page is off
> -		 * the reader page.
> -		 */
> -		if (full &&
> -		    (!read || (len < (size - read)) ||
> -		     cpu_buffer->reader_page =3D=3D cpu_buffer->commit_page))
> +		/* If a full page is requested, it cannot be the commit page */
> +		if (full && cpu_buffer->reader_page =3D=3D cpu_buffer->commit_page)
>  			return -1;
> =20
>  		if (len > (size - read))

[Severity: Critical]
This is a pre-existing issue, but is there a double fetch vulnerability when
parsing events from remote or static buffers?

In ring_buffer_read_page(), when reading from remote buffers, the event
pointer directly references shared memory. The event size is first fetched
and validated against the remaining length:

    event_size =3D rb_event_ts_length(event);
    if (len < event_size)
        return -1;

Inside the do-while loop, it is refetched and used directly in memcpy():

    do {
        event_size =3D rb_event_length(event);
        memcpy(dpage->data + pos, rpage->data + rpos, event_size);
        ...
        event_size =3D rb_event_ts_length(event);
    } while (len >=3D event_size);

If a malicious remote writer (such as an untrusted guest VM) modifies the
length fields in shared memory between the initial check and the memcpy(),
can event_size become arbitrarily large?

Could this bypass the bounds check and cause an out-of-bounds read from
rpage->data and a massive out-of-bounds write to dpage->data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904164450.1345=
852-1-vdonnefort@google.com?part=3D1
