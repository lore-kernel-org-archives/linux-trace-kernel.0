Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360CD1917F0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763008836; cv=none; b=u7xDjrv44jXx2TuNQNpUzBm1/lIhS2eJWv12E064SizzQPfcKVvOgrYDwE18oiXzkaLYH/poi1KNc4FKMQs/ZO5wuf5WF2gHZjzMVMnJgCY/cuLttk41nAqY/pGtIQWIBVP8sEbvGcELhFYUhVuVre4p4AZweL0UTgmlZyUBx7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763008836; c=relaxed/simple;
	bh=juu52SAGCZwSkv94b8hvBh3dmTjc+fF26d4odP+mFag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0Hb8y4LcsXNmp/b+JQW+Sfut6OoStHDlMLlWXeoQ+MdUkFxMxR6x35lJRscnO8DoJoXuOrXjmP5OyN3yhZnzyMxMpPXqSPq+TvsIMEFA7PP7tuUsdKzZZXTEmN/Fi+Il9P4yVWHkM3Pg4JaLeYHr3Wj4WOcRRoE306ej4P969I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPu7h28w; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPu7h28w"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29555415c5fso4562805ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763008834; x=1763613634; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDmPn0Nf9DwhMNzLqfPhzr9P36pEvch2Q8c/oMsgpUY=;
        b=FPu7h28w5Bd7nPim9PcqKY2VEjzhmMTF01nGfSGnJv4fgOw8lmKEzMPEEWaACULMzd
         vto5rZQWjyzOPC+geQDWJO6vbIsdF5mQjiEDJScJe5WmvyDlz+uRrHXiEloSRnoHYnxk
         S7nW7O7dK8FN7LlSPkuYvZx9BO7mg6u4zKupS9ynUjxj2emMKcej1CZIcvv0XSwBBPYT
         5TUDnY+5mO3fzQCm7rNHzZkBF5dHDOxbp7MZQcKR2GZxIDAq3Z684GKbVrordU9velSl
         Ri1WcvlQqy1gSxln84sbitZ4XCAo6CwnwyHaidumbeJqYnjuCR1Er35JkFtow9j8Rw2B
         4rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763008834; x=1763613634;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDmPn0Nf9DwhMNzLqfPhzr9P36pEvch2Q8c/oMsgpUY=;
        b=wKmR3Gjag1yEnmmnhMhGnZMb4rXl3atWqDOwt8vmOSxcqUJICy8b9WnGkWNsDh4IKt
         c5YEe6An3SUg8VPn1wuu6tSAmX8NEMC6D0nxsqNGGXTGiZHI6YL6P9QUlDv4RRdLFRZg
         xjoDwllBcgZx9uaHBC6cwHpfpiF0NoXEQ4eQqNJuxd1nw1SlvYwxpQWgdgUX5sFPSCcX
         D30BVfm6ZyMRtXova9SqNPzfufheZ4z2ltwjknp8gtOns68NTB9lb/GSEXRn4nTHMP9o
         27iYtezqQLAMoReFuko4f2Rge2bZBHIog0Q2KkS3u++iiX+OJkR3xSyltHWlGsxqLJuU
         LOsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV+52GfVaaOiYQ2nfRTaj1y4NudvSAd4qKiAVeneD5ubGUJMzonKiZngPqpFgH7KOi+H62d/+ydL1b6Ukt6G1q+UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFSxiOuwv5hteQpUkRDzfPUd3+su70v8hcTvWVK6zEeL+WbDE
	4wewzHClsv8Y/RJhsfEjr2hXyC8pZOhUbISDDzN1CTo0MA8mJ0RI1tyJ
X-Gm-Gg: ASbGncvI6lbd+/XMgic7Cdp+kNYHbrgGzeV+5IVrxaNhO8XfJXyxRr9pl6iuTH+qein
	WGCuK+P59AnyxJWXGxKyFjTWkRLxz+JsYtyG6votVcAAkPhc0faG8E8FR3tBq35kRiUYJ+mblmW
	HtqKfGjY2eBs8gqgjm30Ldk+qnujggMAcaQfmJnAtwgUuCdziy6Kun7rMWBW79XedaGgItcvezs
	uXW28MaKE+9iwuzWLFYG0ZhRDGXX6M9g6lih+qU0Dsx3c/NLH6bEFX8XEDU/ULQu5/9wnjq1kWb
	8TyGYgFUhoHX2Nj4gmCFEVSLzQ7p1Na4U/nRfuLfKxZlQJGq3/o+o/MrgsgaEYH4VF593rtxhxU
	yCWmaSfUYg9/qSzlRNUmOEHwjLFTwdpV0uVtjdGYQuRAcfqUBruLgyOjvavasBp/pI0HVjMsvfk
	kReRVuK/3a2iFSlyh9/BT62w==
X-Google-Smtp-Source: AGHT+IF0ZSMjJ2Lc8kz3EXKwlmPjL5NLaFbg0SkOYJJftW8mAPB0mC+cHp/6QWluZgrL5V9rxEgvaA==
X-Received: by 2002:a17:902:e788:b0:297:e69d:86ac with SMTP id d9443c01a7336-2984edc8d1bmr74152995ad.39.1763008834480;
        Wed, 12 Nov 2025 20:40:34 -0800 (PST)
Received: from localhost ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d68sm8683655ad.61.2025.11.12.20.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 20:40:33 -0800 (PST)
Date: Thu, 13 Nov 2025 12:40:30 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev,
	workflows@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v8 00/27] mm/ksw: Introduce KStackWatch debugging tool
Message-ID: <aRVhL91rSZXyZ83D@ndev>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
 <aRIh4pBs7KCDhQOp@casper.infradead.org>
 <aRLmGxKVvfl5N792@ndev>
 <aRTv0eHfX0j8vJOW@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRTv0eHfX0j8vJOW@casper.infradead.org>

On Wed, Nov 12, 2025 at 08:36:33PM +0000, Matthew Wilcox wrote:
> [dropping all the individual email addresses; leaving only the
> mailing lists]
> 
> On Wed, Nov 12, 2025 at 10:14:29AM +0800, Jinchao Wang wrote:
> > On Mon, Nov 10, 2025 at 05:33:22PM +0000, Matthew Wilcox wrote:
> > > On Tue, Nov 11, 2025 at 12:35:55AM +0800, Jinchao Wang wrote:
> > > > Earlier this year, I debugged a stack corruption panic that revealed the
> > > > limitations of existing debugging tools. The bug persisted for 739 days
> > > > before being fixed (CVE-2025-22036), and my reproduction scenario
> > > > differed from the CVE report—highlighting how unpredictably these bugs
> > > > manifest.
> > > 
> > > Well, this demonstrates the dangers of keeping this problem siloed
> > > within your own exfat group.  The fix made in 1bb7ff4204b6 is wrong!
> > > It was fixed properly in 7375f22495e7 which lists its Fixes: as
> > > Linux-2.6.12-rc2, but that's simply the beginning of git history.
> > > It's actually been there since v2.4.6.4 where it's documented as simply:
> > > 
> > >       - some subtle fs/buffer.c race conditions (Andrew Morton, me)
> > > 
> > > As far as I can tell the changes made in 1bb7ff4204b6 should be
> > > reverted.
> > 
> > Thank you for the correction and the detailed history. I wasn't aware this
> > dated back to v2.4.6.4. I'm not part of the exfat group; I simply
> > encountered a bug that 1bb7ff4204b6 happened to resolve in my scenario.
> > The timeline actually illustrates the exact problem KStackWatch addresses:
> > a bug introduced in 2001, partially addressed in 2025, then properly fixed
> > months later. The 24-year gap suggests these silent stack corruptions are
> > extremely difficult to locate.
> 
> I think that's a misdiagnosis caused by not understanding the limited
> circumstances in which the problem occurs.  To hit this problem, you
> have to have a buffer_head allocated on the stack.  That doesn't happen
> in many places:
> 
> fs/buffer.c:    struct buffer_head tmp = {
> fs/direct-io.c: struct buffer_head map_bh = { 0, };
> fs/ext2/super.c:        struct buffer_head tmp_bh;
> fs/ext2/super.c:        struct buffer_head tmp_bh;
> fs/ext4/mballoc-test.c: struct buffer_head bitmap_bh;
> fs/ext4/mballoc-test.c: struct buffer_head gd_bh;
> fs/gfs2/bmap.c: struct buffer_head bh;
> fs/gfs2/bmap.c: struct buffer_head bh;
> fs/isofs/inode.c:       struct buffer_head dummy;
> fs/jfs/super.c: struct buffer_head tmp_bh;
> fs/jfs/super.c: struct buffer_head tmp_bh;
> fs/mpage.c:     struct buffer_head map_bh;
> fs/mpage.c:     struct buffer_head map_bh;
> 
> It's far more common for buffer_heads to be allocated from slab and
> attached to folios.  The other necessary condition to hit this problem
> is that get_block() has to actually read the data from disk.  That's
> not normal either!  Most filesystems just fill in the metadata about
> the block and defer the actual read to when the data is wanted.  That's
> the high-performance way to do it.
> 
> So our opportunity to catch this bug was highly limited by the fact that
> we just don't run the codepaths that would allow it to trigger.
> 
> > > > Initially, I enabled KASAN, but the bug did not reproduce. Reviewing the
> > > > code in __blk_flush_plug(), I found it difficult to trace all logic
> > > > paths due to indirect function calls through function pointers.
> > > 
> > > So why is the solution here not simply to fix KASAN instead of this
> > > giant patch series?
> > 
> > KASAN caught 7375f22495e7 because put_bh() accessed bh->b_count after
> > wait_on_buffer() of another thread returned—the stack was invalid.
> > In 1bb7ff4204b6 and my case, corruption occurred before the victim
> > function of another thread returned. The stack remained valid to KASAN,
> > so no warning triggered. This is timing-dependent, not a KASAN deficiency.
> 
> I agree that it's a narrow race window, but nevertheless KASAN did catch
> it with ntfs and not with exfat.  The KASAN documentation states that
> it can catch this kind of bug:
> 
> Generic KASAN supports finding bugs in all of slab, page_alloc, vmap, vmalloc,
> stack, and global memory.
> 
> Software Tag-Based KASAN supports slab, page_alloc, vmalloc, and stack memory.
> 
> Hardware Tag-Based KASAN supports slab, page_alloc, and non-executable vmalloc
> memory.
> 
> (hm, were you using hwkasan instead of swkasan, and that's why you
> couldn't see it?)
> 
You're right that these conditions are narrow. However, when these bugs
hit, they're severe and extremely difficult to debug. This year alone,
this specific buffer_head bug was hit at least twice: 1bb7ff4204b6 and my
case. Over 24 years, others likely encountered it but lacked tools to
pinpoint the root cause.

I used software KASAN for the exfat case, but the bug didn't reproduce,
likely due to timing changes from the overhead. More fundamentally, the
corruption was in-bounds within active stack frames, which KASAN cannot
detect by design.

Beyond buffer_head, I encountered another stack corruption bug in network
drivers this year. Without KStackWatch, I had to manually instrument the
code to locate where corruption occurred.

These issues may be more common than they appear. Given Linux's massive
user base combined with the kernel's huge codebase and the large volume of
driver code, both in-tree and out-of-tree, even narrow conditions will be
hit.

Since posting earlier versions, several developers have contacted me about
using KStackWatch for their own issues. KStackWatch fills a gap: it can
pinpoint in-bounds stack corruption with much lower overhead than KASAN.
