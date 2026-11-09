Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193377;
	b=DDUhsnLnaYZGe+P3AQ7Ix6a1IKeMfRgqMIiGf5FPbQvQLDP7TdS6wI/9xxj0RrNivHHZ
	 X8dZBnviu71wmt50aIy/E1Yq1wonnPxzWIL5+Q/B1GyEHNkwN9mqKlAntFliFW8WP2LHQ
	 9vbLwKrqN/pbKtF07guN2Y+VvM6Z2xwHcjlypYiTDjK/FE1tODk4qWSTR9oiJWBINI7OY
	 7zm+m7WXKmHdEmBa/Yrgj/rPKdYdlzxpOE2RHqa0cBAGIZgJKe4jjrklwsHUAYtBRZ2hl
	 RnQ708tHZNBp7TAtV35fd7VfAPqjpdHCtW8kBt49pCxakunaihww3S7XopQU3Kyds3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193377;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8+irdWFDVMJN3sZzC3iudEd39fyAx2E4wIvGiSORdQE=;
	b=WV+GVA3U5DVZTcaVo2kgNx4SnyaNZpFYnG5ZFf8XiR8w8ndh3RdKU90WL2j1uq9/iC0A
	 mF90GIIbSYlcFdhyAVPNGhb3wRAoZp/z8cM1JmjpkSEu8ARsAsyGhyzl8splfYp+pStMm
	 UG0Rv1/YvZRS2dOjAt8RKI8Cl/ym72rFISgwJpPhnv3yaa0d5oR0o/eFavP/AXk2DpkLJ
	 BLszFqEOjd2t58Y2rn8W+dpSqfaWQHF0G/HuZy7tLHIvad4LEBprAy/8u0xSGF0Pxtms4
	 f+hOBxnQONYC5LxPmwq2v+GwjfW6O2OWs4PVvz3Z7qQ23qvSbyHV6qVAn10CtqjMAWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvvTkv8g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016D606A31C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 03:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvvTkv8g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1845C1F0089F;
	Mon,  9 Nov 2026 03:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794193377;
	bh=8+irdWFDVMJN3sZzC3iudEd39fyAx2E4wIvGiSORdQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bvvTkv8gRI0d7m8z54/Wg/bJHLSHyixgYrsiDzxdXp2/T9W1RlbnyyBD6WLUd9llC
	 UYIeYuQeip0zv6R2CfW4YFF+nMgup+sYmTKArnf8Ii7AaSKAvphQJj77i6IXxXX1Od
	 VijjTj8IyHXerdupa4R+egf1cmfefBHUyzCX1I8pH7h3rd3UAMtHR22DTIG/zLFnJ7
	 7z2JFLpIAaw0TFqHavJ9d9w8KLy9tcisTTgGHJ1RED61sH2OjTFwKBAka17e+1nXoM
	 L2hJDgtfsKCn2wJeMbXE8LvHZlLFF7ouZZActgM+QpsxOVW1lm/wBj3kYamop72/hv
	 Ikl4O1CzgXJ3Q==
Message-ID: <sashiko-outbox-204360@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ring-buffer: Reset per-CPU buffer state in
 ring_buffer_subbuf_order_set()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Liu" <847807867@qq.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <tencent_1C5982E4E79A087063C5142622DDF7A4B909@qq.com>
References: <6af009ed.4dd4714a.f8d02.000d.GAE@google.com>
 <tencent_1C5982E4E79A087063C5142622DDF7A4B909@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 03:02:56 +0000
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
- [Low] ring-buffer: wrong Fixes commit in
  ring_buffer_subbuf_order_set() fix
--

commit 2d978229f2f9c796f8090fdee8cc2744974a320c
Author: Shuai Liu <847807867@qq.com>

> ring-buffer: Reset per-CPU buffer state in ring_buffer_subbuf_order_set()
>
> ring_buffer_subbuf_order_set() replaces every page of a ring buffer
> with newly allocated empty pages when the sub-buffer order changes.
> However, it does not reset the per-CPU accounting of the discarded
> pages. The stale counters (pages_read, pages_touched, pages_lost,
> entries, ...) continue to describe pages that no longer exist.
>
> A full waiter (e.g. poll on per_cpu/*/trace_pipe_raw with
> buffer_percent set) then causes ring_buffer_nr_dirty_pages() to read
> the stale accounting, and the invariant pages_read <=3D pages_touched -
> pages_lost + 1 can be violated, which trips the WARN_ON_ONCE() there:
>
>   WARNING: kernel/trace/ring_buffer.c:866 at ring_buffer_nr_dirty_pages
>
> Since the old pages are gone, the buffer state after swapping in the
> new pages is equivalent to a freshly allocated buffer. Replace the
> manual head/tail/commit page assignment and the rb_head_page_activate()
> call with rb_reset_cpu(), which performs the same page setup and also
> resets all per-CPU accounting.
>
> Verified on QEMU (x86_64, v7.4-rc2): enable sched_switch events,
> partially consume trace_pipe, set buffer_subbuf_size_kb to 32, then
> poll trace_pipe_raw with buffer_percent=3D50 while writing events. The
> unpatched kernel triggers the WARN above, while the patched kernel
> does not, and the per-CPU stats report a clean buffer after the order
> change.
>
> Fixes: 2808e31ec12e5 ("ring-buffer: Add interface for configuring trace s=
ub buffer size")
> Reported-by: syzbot+008851bf625629489e75@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D008851bf625629489e75
> Link: https://lore.kernel.org/linux-trace-kernel/6af009ed.4dd4714a.f8d02.=
000d.GAE@google.com/
> Signed-off-by: Shuai Liu <847807867@qq.com>

[Severity: Low]
2808e31ec12e ("ring-buffer: Add interface for configuring trace sub buffer
size") only added a stub for ring_buffer_subbuf_order_set(), and
f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
initially implemented it by allocating fresh ring_buffer_per_cpu structures
with zeroed counters.  The in-place page swap that leaves stale per-CPU
accounting was introduced in 8e7b58c27b3c ("ring-buffer: Just update the
subbuffers when changing their allocation order").

Should the Fixes tag be:

  Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changi=
ng their allocation order")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_1C5982E4E79=
A087063C5142622DDF7A4B909@qq.com?part=3D1
