Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2F255F39
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760406869; cv=none; b=KvS58PHRpijErtIyQ/adIj+Xn4EFxZRQch1gc414rOAoRsArSTCMTAWvfz2/4y9aDSo/TGTJuKjPpuXYRC8ajw4Y0L8pBbUA48LPvkYdegVd7ZNAC7EaHmc8wMcNSTfeXQSb9KzYRIlfxzBGMI/0lBkH/slSKODQV/U8wkFS47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760406869; c=relaxed/simple;
	bh=T5J7OmcAxaPiSEye30W0ZOJTUvh/8wOGnJoBjAsSIOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKeW2wkL3n9oGffoxx6zgOJvMJHrB6qLCiyGcbdAZPCd/Qo+6pA31KU+0uTzlHYpNCxpIi0dPFdFa9/KcW8SI1bhM00xw4SQ2XX68tQfCuZg7A2KaggKeO93JHusY2JlM4Z8ZWrLspQRftZZkhemKEhalAJ1E7ay6gzK84yhiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2xXydRP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2xXydRP"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6399706fd3cso7059333a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760406866; x=1761011666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik32QQu1F3n92X36Hdeq9+CsYS30S+qNycANq42cjDY=;
        b=m2xXydRPuFN1hEDeW8V68YP8RvUZPuHdnxdbZu7ruEc97eM1jE2dUtd5pNh8HkeAuF
         /KJs0b+YWUhvfQF6p+uXannI/pQHaHg0s66d407GmCdw6R5q0J+dRmdEStnq9uDosh9H
         r+M5ZFucZodnplRb9tetVK+cmXzp1qXJUx6yl6cqk1/RJxZ0B5HcrV9UWd9D5vakccQu
         XYZ/dLEMkMKOM2hyv42tX0iwbjrox8XVbv0chf/yIXq/3DC7AWk7xI+JrsqVyX907AyF
         TXZZi8Fy0MlbrPF+T2nML5vo5MzPNdti104Sx9Qw4fvk8VSagV87DzkEfqyT7Hp8fs+/
         4roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760406866; x=1761011666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik32QQu1F3n92X36Hdeq9+CsYS30S+qNycANq42cjDY=;
        b=kQz5sRn9PnUC+FPrJGNo/Dvz33fp7l45j1hX21m56q+NeFOv++Dj3CPLw88Hm6ZYqF
         dT0X9nEhptd7YRbm4py4aWh33iZdhIGqC3OLF2Yd24yQBTN+La0kaE96Wk6cFFe9zLnG
         eCO02FzthnQqMXz3nkyTDpmZyMEXrMaUcwn4Zu4Y/cXn2jHe+Sw90/5+eSM5Ik1nkdl+
         iNcfPPIpbcuYA23hvyVxm66zKpteHKy+mvBjj2PRam9G2EdTCkee2jWgkcBeLTEgFji+
         3HTeaD6l7ncdgbjNPk4PEdVnS08AyusIkixHak7pKfbIDs+cOF92jjgXKEVQ3mdHpe+e
         IAiw==
X-Forwarded-Encrypted: i=1; AJvYcCXI5mh20SHdUhGZKHnNyQGFD/m/nGlCEt6rMJ6F+OcToaxP5htASr00cbXjrKmGRTmQnmy9ecAwqPa/+eGm5yDso7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFLFl649YHKpBevgOPmc9KqQU1qv8QtA/Lmbjfn6qG4DDmCge
	jMQdSvuQC6iYOT9/1qTLSClMuAu4TzjliPIQRIr279OlECca5OF9Wzwxr39RGyiwNCefw6QuSyY
	Go53s49PxvaGDbkgLdBzT53FdIzwz+Bk=
X-Gm-Gg: ASbGncurroGSldJ2HytE52ma+cc6YdC0z5e5+1b/N/ykieo2JVGzFfO6PrwvMjrdxmI
	T6f/o268ommvllmOQlEZNeVSqIAzfRHg+3/ihfL/b2dOlQZnZI5Nq591cYCkt5ADmKzc+riAW6z
	VDTgtuf5rPN8lcTg/HrqVRzzaj35dSwGCUHKI6D7n5FB7uU93oeN0v1A+WccHeDXlOk1UbzlipJ
	aX6YNfPv/OFUN+459YaW5jxWHm5WJgoexKfnA==
X-Google-Smtp-Source: AGHT+IEIwL92OleUUPX8SMcFqaEBb3u6X2yfff0qC3j0KF5wSLhgWS1eaHLjQKiAE6ArF6J7UL6js8sAh5poiNQTYBY=
X-Received: by 2002:a17:907:d1d:b0:b41:873d:e226 with SMTP id
 a640c23a62f3a-b50aa48cabdmr2092647466b.1.1760406865724; Mon, 13 Oct 2025
 18:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com> <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
In-Reply-To: <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 14 Oct 2025 09:54:14 +0800
X-Gm-Features: AS18NWDaf7q3M1w8lIGQrPCBFol7jT1DFpi3r6Xob_q4wKIj2XFCbo4A4CQJ9Q4
Message-ID: <CAErzpmvOj_ecnN02EKuMtZ7ZTdxV_Uo4NOUG5+YS1uJsA0NG0w@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:40=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 13, 2025 at 6:16=E2=80=AFAM pengdonglin <dolinux.peng@gmail.c=
om> wrote:
> >
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Currently, when the funcgraph-args feature is in use, the
> > btf_find_by_name_kind function is invoked quite frequently. However,
> > this function only supports linear search. When the number of btf_type
> > entries to search through is large, such as in the vmlinux BTF which
> > contains over 80,000 named btf_types, it consumes a significant amount
> > of time.
> >
> > This patch optimizes the btf_find_by_name_kind lookup by sorting BTF
> > types according to their names and kinds. Additionally, it modifies
> > the search direction. Now, it first searches the BTF and then its base.
>
> Well, the latter is a meaningful change outside of sorting. Split it
> out and justify separately?

Thanks, I will split it out in v2.

>
> >
> > It should be noted that this change incurs some additional memory and
> > boot-time overhead. Therefore, the option is disabled by default.
> >
> > Here is a test case:
> >
> >  # echo 1 > options/funcgraph-args
> >  # echo function_graph > current_tracer
> >
> > Before:
> >  # time cat trace | wc -l
> >  124176
> >
> >  real    0m16.154s
> >  user    0m0.000s
> >  sys     0m15.962s
> >
> > After:
> >  # time cat trace | wc -l
> >  124176
> >
> >  real    0m0.948s
> >  user    0m0.000s
> >  sys     0m0.973s
> >
> > An improvement of more than 20 times can be observed.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
> > ---
> >  include/linux/btf.h |   1 +
> >  kernel/bpf/Kconfig  |  13 ++++
> >  kernel/bpf/btf.c    | 160 +++++++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 165 insertions(+), 9 deletions(-)
> >
>
> Just a few observations (if we decide to do the sorting of BTF by name
> in the kernel):
>
> - given we always know kind we are searching for, I'd sort by kind,
> then by name, it probably will be a touch faster because we'll be
> quickly skipping lots of elements clustered by kind we don't care
> about;

Good catch, thanks.

>
> - instead of having BPF_SORT_BTF_BY_NAME_KIND, we should probably just
> have a lazy sorting approach, and maybe employ a bit more
> sophisticated heuristic. E.g., not by number of BTF types (or at least
> not just by that), but by the total number of entries we had to skip
> to find something. For small BTFs we might not reach this budget ever.
> For vmlinux BTF we are almost definitely hitting it on
> first-second-third search. Once the condition is hit, allocate
> sorted_ids index, sort, remember. On subsequent searches use the
> index.

Thanks, I appreciate the suggestion and will include it in v2.
However, due to the
memory overhead, I believe a BPF_SORT_BTF_BY_NAME_KIND option might
be necessary.

>
> WDYT?
>
> [...]
>
> > +static void btf_sort_by_name_kind(struct btf *btf)
> > +{
> > +       const struct btf_type *t;
> > +       struct btf_sorted_ids *sorted_ids;
> > +       const char *name;
> > +       u32 *ids;
> > +       u32 total, cnt =3D 0;
> > +       u32 i, j =3D 0;
> > +
> > +       total =3D btf_type_cnt(btf);
> > +       for (i =3D btf->start_id; i < total; i++) {
> > +               t =3D btf_type_by_id(btf, i);
> > +               name =3D btf_name_by_offset(btf, t->name_off);
> > +               if (str_is_empty(name))
> > +                       continue;
> > +               cnt++;
> > +       }
> > +
> > +       /* Use linear search when the number is below the threshold */
> > +       if (cnt < 8)
>
> kind of a random threshold, at least give it a name

Thanks, I will fix it in v2.

>
> > +               return;
> > +
> > +       sorted_ids =3D kvmalloc(struct_size(sorted_ids, ids, cnt), GFP_=
KERNEL);
> > +       if (!sorted_ids) {
> > +               pr_warn("Failed to allocate memory for sorted_ids\n");
> > +               return;
> > +       }
>
> [...]
