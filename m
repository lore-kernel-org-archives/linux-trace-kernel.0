Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794541878;
	b=zI4/+hg/ykZXYanSOvQT3kAQfWtaPQnki9mWDoqxUt3JEagWxJptIG4nUVZyan5YuwiA
	 ew+G8f9qHfo27nHeN+cbNe5Lekw0Cf+BV52R1pHD6RzmNHAm8L2dQq4TRN78rV8nahuOL
	 5jlVsUDrvUs3TUTg4Jbi/eyhUsFVOUBkTda2sFWWHABYIQEUel90k978Itqgpw0I2aRk5
	 OOkCzEVbs3fJeNzaumlSzOEUO17Ox7oiZPU1P4xDH4fRDIWG0BHv6kT0AmWFH2uaKcpJA
	 1UyUoSzioy11Q4284WZVuySvVNabfpjoIyoL1IAgPLM9PgKP79n0ifqI+GMg11+Ld8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794541878;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I6jOQNaLzFFms70iQYBE9RRMQscvUFWqlwHWt0WG6zM=;
	b=PeG3IfffBzQWbRjTdvLcO96uUW9myBQ4LzEWohlADPE6v/ag5s5992GvRHvQBZUoXdhx
	 oJHZDBIpwbU58mYKDhGVAKIi53LTHxFtizEu15vZPqWKwa9w1ZaRKlIscdiiO/YBZ+/6J
	 23OTd3FW4nXgpY186tq4InSyUPkANSnc4M8WKknZ8G/iVtW7TDZwjlAe6jbQWxTSIqW/v
	 DLPiNdexvXR3YY2dXDRkAFgWnvZQnXwROcU2AXWZC1ynJZEP8qkX3q50KZ7hQR8PK9ONN
	 PURAsq82qPzUQOVPvYWONfd15fE0/WU0I2AK+p+WHgoxMO5DEO6ydPzD3tpqG0xMFUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3nWHGAZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24C606A327
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3nWHGAZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588781F000C4;
	Fri, 13 Nov 2026 03:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794541877;
	bh=I6jOQNaLzFFms70iQYBE9RRMQscvUFWqlwHWt0WG6zM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X3nWHGAZp0Flsz+47po49maX/Rip9/8hHV2GGdL0c+eB7AXHJQcXAHvtXd5HEUmM6
	 bRzdL3imephurxRJoOxB4K4XQNHQ4Le+266KFsoYEUu1ueMT3+qM2KXc5DPA+a0w6n
	 kvgdwNQVHhY28qllHrqYstXE4JqGPfrv8lkIZCmojsj4YidD1rtUWE64KuSsAuYclz
	 NCmwzRP0r4EZOaCGJmDxrgrvuupAtf8wU0h3d3S1z/RbYEtDcf+6sGweAjpFd8MNj6
	 Zi70F20e54b/Cxc8dJFSQXGeZe00SSL5dU4a//S1BYKTIh3ekyDy9ltXk8jeVIHsEo
	 13DN7wxTyTPJg==
Message-ID: <sashiko-outbox-212140@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] tracing: ring-buffer: fix stale reader-page link
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoli Zhang" <26031212468@stu.xidian.edu.cn>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261113033612.1349-1-26031212468@stu.xidian.edu.cn>
References: <20261113033612.1349-1-26031212468@stu.xidian.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 03:51:16 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] tracing: ring-buffer: reply text in changelog and missing Fixes
  trailer
--

commit c4296f8629e0420816a4b5f1c95a30a1141d5523
Author: Haoli Zhang <26031212468@stu.xidian.edu.cn>

> tracing: ring-buffer: fix stale reader-page link
>
> Hi Steve,
>
> Thanks for reviewing v3. I apologize for adding unnecessary NMI reader
> coordination and skip handling. You noted the report is unrelated to NMI
> reads. The lockless NMI path is only a best-effort crash-dump path.
> I have removed that complexity and dropped the Fixes tag.
>
> The report shows rb_is_reader_page() dereferencing a freed page through
> page->list.prev->next. During shrink, reader_page is detached from the
> ring list and can retain a previous link to a page being removed. Redirect
> that link to the surviving tail page while identifying pages to remove,
> before any removed page is freed.
>
> This change does not add work to the normal writer fast path or alter NMI
> reader behavior.
>
> Reported-by: syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D37e1793bdb0061ea3a47
> Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>

[Severity: Low]
The opening paragraph ("Hi Steve, ...") is a personal reply to a reviewer
and should go below the "---" separator line so it is not recorded in git
history.

Also, since commit 83f40318dab0 ("ring-buffer: Make removal of ring buffer
pages atomic") rewrote rb_remove_pages() to unlink pages in place without
calling rb_reset_cpu() to reinitialize cpu_buffer->reader_page->list,
should this include:

  Fixes: 83f40318dab0 ("ring-buffer: Make removal of ring buffer pages atom=
ic")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113033612.1349=
-1-26031212468@stu.xidian.edu.cn?part=3D1
