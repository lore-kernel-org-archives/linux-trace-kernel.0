Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89F2F6904
	for <linux-trace-kernel@vger.kernel.org>; Sun,  3 May 2026 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798202; cv=pass; b=i/zua7194cxFb1Vz5cP5EvdMznl1nIV1m0y6FiNR9iHm3KTZCnMBhVXqaMCjnicVEk2Rtt9ioq762M4SpZYXzOKRWw+YFFvLe9myvp9orSelIUywv4THbz0gniO+94hRepRV6wRUDIO7qZ2zuD0ojF6pqDa1gIEPB4qL8LvOZL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798202; c=relaxed/simple;
	bh=tlo3CfrEZfjT/l5W/KRdUq9N5GWBRjSLTaNyx4k8SPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiN7I6kAa1AgfnbthQxztkQgg9fL4e0Vz7QatSix98A0rkGkw8ecIaUfOQGenTrJxFd9vToV/H0p28a5fQQE55Wdnj3lES7+AfoPB5nFVtx5kyixcWsEORRPgd0bsm7m9MBawZQyy2KA1AYq2R1fpwtqpjk29WwLBxcmKgwjNbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4rbT5XX; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4rbT5XX"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-794719afcd4so28671107b3.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 03 May 2026 01:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777798200; cv=none;
        d=google.com; s=arc-20240605;
        b=QAqFyNhiBCAqwEjufvZ2nRcXaIbkMmJrpyGcW3B9YDx+mbitpXUdsq9+OnlijcMRZJ
         PWe9WgfZ3XPyy1ZNFEDhviu0rZGdmmFizGUbxQ5TOiJJiILW1066EKQUtTn3Qm7SOqUY
         8FPtU7kY0hUCNoZnhxvJBQpgXy04Gh8Tna5LRsnqCAOMGJwXjhhCSc/HTaV/ZEXuZmxU
         OPTLrRy3D8OXV3p3FbffPI3xayIpUtnrWtUrm70kiubYJiuMwJf8pvK0cF+3k9//vPpC
         XcbnFZzLDgJd6MWJ3JtHBLzXSjHRvlNEnF0tCf5C/wqyjAw/Ncn/KtkuV95VPY8Pz7sJ
         OKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UYhb9baFBR6o9OGq4IFHLmu9xz5Pzrd2VZ/EOlbeyq8=;
        fh=nQ+YHUY6MbqCir3nTCaIgArVEBDf4nouq5Ov7k3bSA8=;
        b=OE3PUyyeisg8iEfXUucFedjJPuAUkd5huFNpNnUmGPAbgOX6zt16MrGKtDi72fih4o
         kRS6b2shEmBOJQNE6ZTmH11riDd77tQzIlZ1MmLgDlg+6MUGP5ME+7JEt8rVxFJSm2n+
         bP0+dx6kIf+6Mf5MnHKCrAywvAMYmA3mzCAxS7nNHUAiEAbbg6DXCiX2O75vhbfgEtp9
         Ptzv5kQp1qvG/6FcBysXz7wAm4ULeeYdfBeIJtNdXdw4DN4xr36xPdIluV8yvzJAeFmv
         tzkDvZ5OOqo5eV0UeBAb7zJlWJmZGpk8gKSGCiQb9vdU4gpbSSUZYP13/BFOgzv0ZKOu
         a+yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777798200; x=1778403000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYhb9baFBR6o9OGq4IFHLmu9xz5Pzrd2VZ/EOlbeyq8=;
        b=C4rbT5XXqkKRKV60ePxD+E8vCokuxMkr9nkWA5npXhj88SIuKew+QypOu3CEUqqm4G
         SwgHDEVJdYK57ApqfhUVObeT5rAifisZ9q2MNuBLUPvhIodf3OlQREneJsFz8rmQHqM3
         qXQ/J/OkTKIeTCbu8OWc7a949VwK3Pq08J6gp3X/d3oOS52N5TXdui9l6wYaTuQ+Xw0x
         w2PwGVxYgyRRTAeoTD+hXoLwosGExBWN8UO26lNTzVNfP0Qez5gb89S55hZNcIRK+RD9
         ejbrSqBO0zU8uTeAVZpR2etEDkYtsXnMbQ1LO8sQn7FhicFyvWff6nulzPUfjS5GcMFo
         +CDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777798200; x=1778403000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UYhb9baFBR6o9OGq4IFHLmu9xz5Pzrd2VZ/EOlbeyq8=;
        b=XvRct4DvI2S+xzl1IUA/7AZlFahHJ03UIvb8TvopWlWzdkbpve+tGjjkrHduQgh2tg
         6rPPEw+8EJhHIjk1uHygMgKYTbGE8oT/ibAdgtxhrANyFsFpyf9CAxK0YSowik0nl6fI
         aOHxj+DF+DArvIq6k51M9N5Q6bFZjPhNdrIrZO9JY4ngJWTV38qTf37Gd5tTR1xfds2M
         /+Ldu5Cfb3q22EApHLYRZ8ECJKzIvhDvYfZWoXN9ycB1K80HweGdCny5X3Li8qK05wHB
         KiW34BWlOizt9/2fQRc4iSDdgGZkZ+M6qVlua+YaNfF+4F7D+GyKtuGrO2ZdIyeKXldo
         7kaA==
X-Forwarded-Encrypted: i=1; AFNElJ80Q3IkDXONGO/L5zaIZPwCKgve2tW+IbeXnX0iBsVzhcqBZ6XDH1c2pzUbPcR/dQmhcsidT5G+P3dxJSjemY/Fsww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ+3ILbDDBneJ9Yz5f6/io4MeohrmThbcSzOtOsijens+P8SRd
	g1jN7A3LUmD1dlmUlu5b+emI3bgnIJ31X+sIiLTUUSKd/RQFY8EAmdvpcYEhumv2HAjWWHH51no
	P1SBLXfYkvM6KgrUkN+yR65WsnP2Ait4=
X-Gm-Gg: AeBDievHzR2VH89HPYSYXJqRv4NKxQCgilPI+YnKBn9wvhMW6Em22Gzuc0cm9v/fVn7
	FXaLSmZcHzwM7BwGSOQVsnx0czBS/fls5HP82OYPf1kwr8/FEGg2iEUqbzQ0gMHMZMhJLtiXdhQ
	oB8wiYhKCvjPxIIqjqxSpZiACnVBN8K1oNwbxUcDZ6E/gE7PMTipPwDdm+jehVi1OG8z8keSL3x
	231TQzzsSUPWJOPrpN93fE3TJynZ6W1AwOkcpP+q5xSkalatS171DTMnrFBJMpDOrVuKKzs1kBx
	5rd8q4WjijUFwpET9hSQM3n4S6O2IzRiCdaIUOyOsn8WSh+9IkN/ctItC+ETL42bo3uLxxsmVD6
	TiVz9NO8=
X-Received: by 2002:a05:690c:6e10:b0:7ba:eefe:9f75 with SMTP id
 00721157ae682-7bd770b1895mr57297587b3.31.1777798199821; Sun, 03 May 2026
 01:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322051838.1137822-1-kartikey406@gmail.com> <b568c125-d827-42f3-97ab-521a8648d917@acm.org>
In-Reply-To: <b568c125-d827-42f3-97ab-521a8648d917@acm.org>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 3 May 2026 14:19:48 +0530
X-Gm-Features: AVHnY4Ixs9j4Qj2R7ePkxuBH66nLGz2BdshqH7DhtquBCQcxHfipYyS9qlXw-0k
Message-ID: <CADhLXY7Md_V9gMc4xY7gBN4fe2pPa7c1NSr5d4p6ongkoX15eg@mail.gmail.com>
Subject: Re: [PATCH] blktrace: reject buf_size smaller than blk_io_trace
To: Bart Van Assche <bvanassche@acm.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 11:22=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 3/22/26 6:18 AM, Deepanshu Kartikey wrote:
> > Closes: https://syzkaller.appspot.com/bug?extid=3Ded8bc247f231c1a48e21
> > [ ... ]
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > index 8cd2520b4c99..6cc7d83ed1c2 100644
> > --- a/kernel/trace/blktrace.c
> > +++ b/kernel/trace/blktrace.c
> > @@ -773,7 +773,7 @@ int blk_trace_setup(struct request_queue *q, char *=
name, dev_t dev,
> >       if (ret)
> >               return -EFAULT;
> >
> > -     if (!buts.buf_size || !buts.buf_nr)
> > +     if (buts.buf_size < sizeof(struct blk_io_trace) || !buts.buf_nr)
> >               return -EINVAL;
> >
> >       buts2 =3D (struct blk_user_trace_setup2) {
>
> Why sizeof(struct blk_io_trace) instead of sizeof(struct blk_io_trace2)?
> Even sizeof(struct blk_io_trace2) is too small if any additional data is
> included.
>
> Additionally, how can this patch fix the issue mentioned in the linked
> syzbot report? Is the syzbot link correct? From the syzbot report:
>
> Oops: general protection fault, probably for non-canonical address
> 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> RIP: 0010:bvec_set_page include/linux/bvec.h:44 [inline]
> RIP: 0010:__bio_add_page block/bio.c:992 [inline]
> RIP: 0010:bio_add_page+0x462/0x6e0 block/bio.c:1048
> Call Trace:
>   <TASK>
>   bio_add_folio+0x64/0x90 block/bio.c:1084
>   io_submit_add_bh fs/ext4/page-io.c:465 [inline]
>   ext4_bio_write_folio+0x1446/0x1ea0 fs/ext4/page-io.c:603
>   mpage_map_and_submit_buffers fs/ext4/inode.c:2326 [inline]
>   mpage_map_and_submit_extent fs/ext4/inode.c:2516 [inline]
>   ext4_do_writepages+0x207e/0x46e0 fs/ext4/inode.c:2928
>   ext4_writepages+0x241/0x3b0 fs/ext4/inode.c:3022
>   do_writepages+0x32e/0x550 mm/page-writeback.c:2554
>   __writeback_single_inode+0x133/0x11a0 fs/fs-writeback.c:1750
>   writeback_sb_inodes+0x992/0x1a20 fs/fs-writeback.c:2042
>   __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2118
>   wb_writeback+0x46a/0xb70 fs/fs-writeback.c:2229
>   wb_check_start_all fs/fs-writeback.c:2355 [inline]
>   wb_do_writeback fs/fs-writeback.c:2381 [inline]
>   wb_workfn+0x95b/0xf50 fs/fs-writeback.c:2414
>   process_one_work+0x9ab/0x1780 kernel/workqueue.c:3288
>   process_scheduled_works kernel/workqueue.c:3379 [inline]
>   worker_thread+0xba8/0x11e0 kernel/workqueue.c:3465
>   kthread+0x388/0x470 kernel/kthread.c:436
>   ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
>
> Thanks,
>
> Bart.

Hi Bart,

Thank you for the review.

You are right on both points:

1. The minimum size check should use
   sizeof(struct blk_io_trace2) as it is
   the larger of the two structs. We will
   fix this in v2.

2. The connection between buf_size being
   too small and the ext4 null-ptr-deref
   is not clearly established. We will
   remove the syzbot link from the commit
   message in v2.

Will send v2 shortly.

Thanks,
Deepanshu Kartikey
