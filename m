Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862B040F75A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379131; cv=pass; b=smcm0T+Ke/kINqON+aHM4SDTex1pwBRu9esmFt1UZYPGdkC7afp8OfdTkV5UndDSrM8VMzmiZfR+mIiGMVCB5+DO2WEFse/ZGbu8Zz/0kQcDvmO8QBGCDa3Nmv7k5tYur6jrmowrdxCCjq0+AgXeD44ILtDLsAACK7VKzlxgVkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379131; c=relaxed/simple;
	bh=vvgNKu9uyv9I5R9kHg2ihehIkxNH8NosNyyy4+wPpsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dmfo1QAuAZWsgJuQq32JHaNG3eICI9kuCbXvLRL7Slc6qx8m4iX0WUDAcLl0Q8kWCHx8bx1l0n7DEDbY2VU+y0yZm5y8BE52hqkPFuiNAldRoeMp4pYZRtpIM65ZAO7MVGt1MFt0bvSG4hFSOqIjp6xvyKi/mYB+CQs/d0fzL4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnSX4srl; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnSX4srl"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c10e86e52so429541cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 09:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786379128; cv=none;
        d=google.com; s=arc-20260327;
        b=XoVox2rLy8LFAQi/IvpXy2pLQO8sp5suggkQHHouMo8AW2dbBC/AfDRhPMKuGFXTyS
         uAOa/xHkthB9QIl2o8pM35ug2xy0+4LFM34mxfAqdkGHFvfKRhf847ZSHBWahP4FnsUK
         ocwFoLBmcDPS8JD1YrColaEbVuxFoxShD72Gd80XqQRRKlX32VeM7dEZ5RrqPdge8YRk
         SuWCWe+PvXVbpzEAhF6VanHZQBMenmNwwZ03sN5DWyXD9HMxNFJCgDfJORzJBm6JUYo9
         YBLn7duesd96P24ZOCa4UYGuNgPtYROmRyyzJ4J+VXrlEZw/GnIfgon+DWvNCLgebQXa
         4DTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oQBA7RZMWG8pbHKGdFOSfTUai8Qp0mhMLH3fVjxyT/A=;
        fh=S8Np9F/AlFfF01NqG583wCaSV2J4qSydXqv+5CH94Uc=;
        b=LYzlfpj+JlzISAUKD/m8X/zR/NZs1sIn9lO+dFJSpdF+kbPmAb5PHEb3hn0RvsMXha
         sR8FObPBxXopkFgryD4VN/i7J7qRDNxEnb9Oq7Xe4xkAv2jEZB8m94KgYg7gzYJVQrW5
         gNP4RLMWvePBFI/yWLac585gTKYqDxDP1FUgxBhdRPo9/zU319yPX51zi3Z9QSOQiANJ
         VNa0HYdEuAGhZDnGMTnybNNrAn5iYoFv8XC3GezZgkaEBkocrJyMY1b9fK9PXuLElZAn
         3iJdbaFs7WFhE50KkZKoduDVKrAgWSTDh0blErp+NTgIr12eXAGrz4PvlqpX52/569TK
         ldHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786379128; x=1786983928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oQBA7RZMWG8pbHKGdFOSfTUai8Qp0mhMLH3fVjxyT/A=;
        b=cnSX4srljyHNxtz8+ebQsbPLVxspqfpoIqSLmsWAildeeNYgXoHZa7KGoAxUyX77W8
         D4KguptuceXODwM8sSDS3p0s/amPy4tk+0ZFSm55MxazfgCDZe3PeT+WxElOCjKq6roJ
         r4vSyIRR9ejNSjq49zaOp9cMSJmbiSZC3WBoxA53w7seEAZpUaGyTpMnkkdcP1xyK+wX
         VYAwX8Auqw00xcAkHeGfaFPwoYNXnXXfhtwyP1COxg5ltXdanflWeA8lr2oOomNqfTA1
         Hwi7+82yfHl6cT+dEZ5OgCgY09gNanMzX3aOPmbj/3VwMfiwJkmXH1dCPDhOCNdC48cZ
         8Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786379128; x=1786983928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oQBA7RZMWG8pbHKGdFOSfTUai8Qp0mhMLH3fVjxyT/A=;
        b=MkHazYCthFJ6a5gSTDztYCeVnnMgd3XNLWzgrtlPs3CwnpIaVtHrDAXPZkVWcqQWVE
         d9Ucb9Jb1gitALPWEPzPK8dxA5iHNbvxcZpwqamZBmCgLKy/Dboo1F8dqTLYpyP4tPE8
         y/AEYYYQaJIB6pUUN9cTQ/LOL9swkDnHSvZI909U1ZLEtEIsNCa44iRqNPH7NHBvZzhU
         JszDXw6IXqZrz9MK7VBr8Nb+/VH/Qu4xvgqzG0uxrYx2SGIqA2lkfKRitqndEH5IPzGV
         9/7LH4duDJ7WGQv+o/2TNSBVpCiC9qNrMXKoFFwTVYUy/4jKNwOP3UKFlHwtlFJrev94
         a9CA==
X-Forwarded-Encrypted: i=1; AHgh+RolRjmqnvXp4es35R5PGDJjjKIqo+ckf6750aSFobgHD7orIEyhJHk4KhLkDmONIwi9ICepAi5Wdx68BTiDxh35JN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0yBWZzhF5HdlnZdccHXqYN/+2fUqXdw/84oNhDZYN9QqUyji
	Ap7BEmCTCRGJuVfeV2u/uHG8/yH1W/rVWdW9zhNG6Wx5ocxkN1mQPrWuzACYr/mGv7Vn/IaryH4
	q5FlSSI2fk76qMSjkJlJZw4LgbiFWLjHEr5CXGjb0
X-Gm-Gg: AR+sD10Igf8Y6WBI9nzKVe6UWNYzl2LbT8gM2g+x/GB9Qo+obPEymxGkTfimkLUH8z1
	3ltRacD80L6cvq2f0QKrgtPh/DufMQX/eJEFopX5iLWIhzHLVNmx1ZZrDQAOJDiF+F1y/o4HqLb
	S/R+olytiPpv7yYCvGwAZnBHJKY8RAQ37mvlLxsJ8Oz0mBBzYXcOOJJ7raEM8r5jSWIoJz2/L7Z
	DH8tqphLPo2oLyX6RNiLoFfxaZgzaLUAJQMf9lL9y71HeYPNfY6Cs2h66vblkLf+pCUbqMaI8jv
	vEiEr0ww5sMC5aYxAt/G6oIYR67J7rBOWtTHvM6F32c=
X-Received: by 2002:a05:622a:1b06:b0:516:3f51:81cb with SMTP id
 d75a77b69052e-52d2817b938mr34999921cf.13.1786379127554; Mon, 10 Aug 2026
 09:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-3-ab318a350404@kernel.org>
 <CAJuCfpGjE66Duhw0r8H0GKBFDExjroRar6n5MgVOOQjz4ZfTuA@mail.gmail.com> <anmNojqwGzdiLkIm@lucifer>
In-Reply-To: <anmNojqwGzdiLkIm@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 10 Aug 2026 09:25:16 -0700
X-Gm-Features: AUfX_mz9WU1SPgoH6YTV3DTKwNKGMKFcURK6j4M8chTMyTH0jJu5GwZ0wv2wrtI
Message-ID: <CAJuCfpHtaeeqn9UbnG1U0iA8uhrcQpEG8g8+G_RybVbwoOE0sA@mail.gmail.com>
Subject: Re: [PATCH v4 03/20] mm: introduce linear_anon_page_index()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 1:40=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Sat, Aug 08, 2026 at 05:49:48PM -0700, Suren Baghdasaryan wrote:
> > On Thu, Aug 6, 2026 at 1:23=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kerne=
l.org> wrote:
> > >
> > > This function provides the anonymous equivalent of linear_page_index(=
),
> > > instead offsetting based on the anonymous page offset of the VMA.
> > >
> > > It is valid only for anonymous or MAP_PRIVATE file-backed mappings, i=
n
> > > other words CoW mappings.
> > >
> > > For pure anon VMAs, this will be equal to linear_page_index().
> > >
> > > Assert that both of these invariants are true In linear_anon_page_ind=
ex()
> >
> > s/In/in
>
> Ack. I ran these patches through claude several times and it didn't get t=
his ;)
> the machines are not taking over just yet...
>
> Andrew - could you change this in-place? Thanks!
>
> > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > index c6fc783aaee5..0adfa6605653 100644
> > > --- a/include/linux/pagemap.h
> > > +++ b/include/linux/pagemap.h
> > > @@ -1094,10 +1094,44 @@ static inline pgoff_t linear_page_delta(const=
 struct vm_area_struct *vma,
> > >  static inline pgoff_t linear_page_index(const struct vm_area_struct =
*vma,
> > >                                         const unsigned long address)
> > >  {
> > > -       pgoff_t pgoff;
> > > +       return linear_page_delta(vma, address) + vma_start_pgoff(vma)=
;
> > > +}
> > > +
> > > +static inline pgoff_t __linear_anon_page_index(const struct vm_area_=
struct *vma,
> > > +               const unsigned long address)
> > > +{
> > > +       return linear_page_delta(vma, address) + vma_start_anon_pgoff=
(vma);
> > > +}
> > > +
> > > +/**
> > > + * linear_anon_page_index() - Determine the absolute anonymous page =
offset of
> > > + * @address within @vma.
> > > + * @vma: An anonymous or MAP_PRIVATE file-backed VMA in which @addre=
ss resides.
> > > + * @address: The address whose absolute page offset is required.
> > > + *
> > > + * This returns the anonymous page offset of @address, which is the =
page offset
> > > + * the address possessed at the time the VMA was first faulted.
> > > + *
> > > + * For anonymous mappings, this returns the same value as linear_pag=
e_index().
> > > + *
> > > + * For MAP_PRIVATE file-backed mappings, this returns the anonymous =
page offset
> > > + * of @address, which is the page offset the address possessed at th=
e time the
> > > + * VMA was first faulted.
> > > + *
> > > + * It is not valid to call this function for shared file-backed mapp=
ings.
> > > + *
> > > + * Returns: The absolute anonymous page offset of @address within @v=
ma.
> > > + */
> > > +static inline pgoff_t linear_anon_page_index(const struct vm_area_st=
ruct *vma,
> > > +               const unsigned long address)
> > > +{
> > > +       const pgoff_t pgoff =3D __linear_anon_page_index(vma, address=
);
> > > +
> > > +       VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
> >
> > As discussed off the list, this assertion works even for read-only
> > anon mappings because, as you said, "there's no such thing as a pure
> > anon mapping that is !VMA_MAYWRITE_BIT, there is no way to achieve
> > that."
> > It took me some time to see that after reading your discussion with
> > David at [1] and [2], and I don't think it's very intuitive. Could you
> > please add a comment explaining that? Maybe add a comment at
> > vma_is_cow_mapping() definition since you are using the same assertion
> > in another patch of this series?
>
> Sure will do! It is very confusing stuff (and I was duly confused also at
> first).
>
> To save a respin (unless there's more stuff I need to address) I will pro=
bably
> reply to the relevant patch with a proposed new comment.

Sounds good!

>
> >
> > [1] https://lore.kernel.org/linux-mm/anBjpdMicqaGADr-@lucifer/
> > [2] https://lore.kernel.org/linux-mm/anLyhaI6kW-EWk13@lucifer/
>
> --
> Cheers, Lorenzo
