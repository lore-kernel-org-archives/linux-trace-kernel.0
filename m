Received: from lf-1-128.ptr.blmpb.com (lf-1-128.ptr.blmpb.com [103.149.242.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5A208CA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 03:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736739245; cv=none; b=tp4lC2kqwisHMe7Gsjv/H4eCds7b7V047yXsMqYpoS3G+sJOYHTQfalB0fbgEmU1vRYzJy1dpZ02w/uGb1O3GTIotbKzsBF4djASUS5ShrumzigZoQsb7u1rssk8Kg8l4iE0NArrHi4sMTk2ejibQ77MEktliIRRch6e4bCR2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736739245; c=relaxed/simple;
	bh=Ybogo5xzG1fgCTV7Hj/lu//TPwnOLZ8cZLkoFIxDNto=;
	h=Date:Message-Id:Subject:Mime-Version:In-Reply-To:Content-Type:To:
	 Cc:From:References; b=QiXSB1zo4131q/HWrwcwyMusWD1VHz/0M0ECweWPplfkB2Jbky7PMiyIK6dRtZyj0H5F1yRHeGAdUPpwn2TsaYMT5cPN1F1Cm5W1URlUbrISQf5bYwEc8Pt7VyxgU5E0k2wBRdTcysbJG8EkN8cMKD7ATbS2T82Is92dwOlKJzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=puL7BQQl; arc=none smtp.client-ip=103.149.242.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="puL7BQQl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1736739032; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Ybogo5xzG1fgCTV7Hj/lu//TPwnOLZ8cZLkoFIxDNto=;
 b=puL7BQQlWYsjtDmaeQWy09SGA4Aepm9tzGi7b3h4OcAiIJ+bRosyUBqbmUoXoUN0dnLUgn
 jTG9h8TV35rXkqFKptFTQbmWF2qa+nkOJhWrabTWd7c3uJSgVtwz+gkHJqvufUka+rUIkd
 mHzhNGTRE+Rto63BDegdQymdPNAO3NWIeYQQ29Xm9/E+hfiyd+kDE2zqTBHUgM8VEMw7Op
 Ts9/YP00Gpg5fDkNErJtFEY9RgLIbKcO8EEEGpOBRP0kcwCwuNJyun+dgAemKswb4eFuV2
 CowHHvc4mcqrkIcwceREjSlg1C+OxRmNXDWS8hReaIgVDo/ljUtM/YmjGKJbgw==
Date: Mon, 13 Jan 2025 11:30:29 +0800
Message-Id: <e7232f59a3e6ab536c5bda8b4e74820d54649b7e.1b61be8b.e5fb.4fe7.8016.bcbdf32ff1ea@bytedance.com>
Subject: Re: [External] Re: [PATCH] hugetlbfs: check dir in trace_hugetlbfs_alloc_inode
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <b5c16ffd-d70f-48b1-b026-79dc5ff4ffaf@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "Hongbo Li" <lihongbo22@huawei.com>
Cc: "zhuxiaohui" <zhuxiaohui400@gmail.com>, <muchun.song@linux.dev>, 
	<rostedt@goodmis.org>, <mhiramat@kernel.org>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
From: =?utf-8?q?=E6=9C=B1=E6=99=93=E8=BE=89?= <zhuxiaohui.400@bytedance.com>
References: <20250113030702.58502-1-zhuxiaohui.400@bytedance.com>
	<b5c16ffd-d70f-48b1-b026-79dc5ff4ffaf@huawei.com>
X-Lms-Return-Path: <lba+1678488d6+7c7b7b+vger.kernel.org+zhuxiaohui.400@bytedance.com>

Got it, thanks

> From: "Hongbo Li"<lihongbo22@huawei.com>
> Date:=C2=A0 Mon, Jan 13, 2025, 11:29
> Subject:=C2=A0 [External] Re: [PATCH] hugetlbfs: check dir in trace_huget=
lbfs_alloc_inode
> To: "zhuxiaohui"<zhuxiaohui400@gmail.com>, <muchun.song@linux.dev>, <rost=
edt@goodmis.org>, <mhiramat@kernel.org>, <linux-mm@kvack.org>, <linux-kerne=
l@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
> Cc: "Xiaohui Zhu"<zhuxiaohui.400@bytedance.com>
> On 2025/1/13 11:07, zhuxiaohui wrote:

> > From: Xiaohui Zhu <zhuxiaohui.400@bytedance.com>

> >=C2=A0

> > Anonymous huge page has no corresponding directory inode,

> > which cause a null pointer crash when access dir with the stack

> >=C2=A0

> > =C2=A0 =C2=A0trace_hugetlbfs_alloc_inode

> > =C2=A0 =C2=A0hugetlbfs_get_inode

> > =C2=A0 =C2=A0hugetlb_file_setup

> > =C2=A0 =C2=A0ksys_mmap_pgoff

> >=C2=A0

> > Signed-off-by: Xiaohui Zhu <zhuxiaohui.400@bytedance.com>

> > ---

> > =C2=A0 include/trace/events/hugetlbfs.h | 4 +++-

> > =C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)

> >=C2=A0

> > diff --git a/include/trace/events/hugetlbfs.h b/include/trace/events/hu=
getlbfs.h

> > index 8331c904a9ba..5daa52053edc 100644

> > --- a/include/trace/events/hugetlbfs.h

> > +++ b/include/trace/events/hugetlbfs.h

> > @@ -23,7 +23,9 @@ TRACE_EVENT(hugetlbfs_alloc_inode,

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TP_fast_assign(

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __entry-=
>dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D inode->i_sb=
->s_dev;

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __entry-=
>ino =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D inode->i_in=
o;

> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__entry->dir =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dir->i_ino;

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__entry->dir =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0;

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dir)

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0__entry->dir =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D dir->i_ino;

> It has been fixed in [1] by Muchun.

> Thanks,

> Hongbo

>=C2=A0
> [1]=C2=A0

> https://lore.kernel.org/lkml/20250106033118.4640-1-songmuchun@bytedance.c=
om/T/

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __entry-=
>mode =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D mode;

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),

> >
>=C2=A0
