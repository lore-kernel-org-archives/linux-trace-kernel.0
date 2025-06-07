Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0D21ABD4
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Jun 2025 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749301088; cv=none; b=dPt2lLcye4hsfDh+IIzD10KtSIM00jnvpjieFGPW+Kk1qtlTpcxbw1Xj/3c5l3UvkCeCnLM2lOXX8hMlQYacdAFurNgadusFBJZkaoKDuaHrA18aUH1UEfhuulvZpt6T/ZiShfHbVO3Dg4RTeyJdQu1QlpRwJzG4fGt3xUJpTjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749301088; c=relaxed/simple;
	bh=V4cryWcS+Nj3c10ZcXrTgRlQMw2t7rBwE5/Fuk6/am0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIuT7NT19KvgAmFnycslQTlplaYPMuxlszipOjmaAfP4/RmgyxBr+MKPt6BV2ji7/8UuKb1ltsYXNNv9Bj+1B6TZLZYkMLpEkATw4z8uOdhXN1oaVKl4EWf+e2JEUzRR1I7/q/EUyq4WtAtPh14ZpaBPFzoBuvPopTOfkO4kpK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dr5fNeFO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dr5fNeFO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749301085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUlpd1tc6ViQoEOVd98R/NTIIePNhea6XdH/630s6S4=;
	b=Dr5fNeFOe3/FV84z6D/Y3p1fhuvB7T4cEx7+txR2kdhqxH4ln1/FqLfOwvJTMpVCphaLRV
	u1BVIi55JMSBgAR4vzLn7emjgZeomQS0+yCAyjFP9K9bk4SO6tqTC2Hivkzcw+TunCt/Mt
	+z5xRGob/9/1wk1XEpp08dr/KwKgisg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-uyZeYUIRP9O847BmqHsYog-1; Sat, 07 Jun 2025 08:58:03 -0400
X-MC-Unique: uyZeYUIRP9O847BmqHsYog-1
X-Mimecast-MFC-AGG-ID: uyZeYUIRP9O847BmqHsYog_1749301083
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-70e5e6ab756so42885717b3.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Jun 2025 05:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749301083; x=1749905883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUlpd1tc6ViQoEOVd98R/NTIIePNhea6XdH/630s6S4=;
        b=hIqI8m2R+P4bZImqxI66UYc+r7+TnOfAJOLbVDN6J9IuZtW7WPHeHD4zbef7YbRklS
         Aa9lhzBr30gxWykdZTc6lN+SrAxqQYHagfSgjWQ7Jx4pbjqEg99O1A1FlH+i/s04Ec0L
         73KvFz52cqbKuPjhioVr0/58U3BUskcdXOV+CpptNeCbMhyArn1+4zy0LwSUVI8YKJT8
         pfqUATItHu2isqUpFSMhU40PMZ5ZBl+7UO8ckK8oUhebGa6HPLlrxv27NeuoLkuGr9to
         G+TL+ObPbUAmDihHZV+Dri9XCnaVgu6ni42IJWk6ydxkkvreB0UpjuvP9FjXLfi9D52X
         xxag==
X-Forwarded-Encrypted: i=1; AJvYcCU9/BFewhZkt6LokohTPluph86HQTNE1KTK9zkqXnhAbAjmnvSj0MIEOUzxcnGKDNtV3QIKTt1M/+UCT+BduoeiqBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgnvIl+Rf3UqyuieYnYLwizq//iVs4+O2Fht5veosRntu7n61F
	thxyiFQn9lzd8/IDqZmtQ1iQUkdn3ukXeRq1oZhPTWomJwL9VLkM8GQE4pFZsJnskcUQf33u5Qv
	WF82+nqv3dvD6GnwuoH5xEQke74miLxEijogt1MV8S2rleJc9LBbNll0SkdWPjGODm+oWBN4HGr
	5v9gPC4KgPPe/QRrVY/p4Xsw8eOuWYoKFl6YxfDsRrBOtZ8SLS
X-Gm-Gg: ASbGncuBI647Pp2j420zHOZ63iJtPrwUahljA3YLA/WXmYUgXEAzWcqqrE4gk+KeM3B
	7QlLtejvc1H1XFl5j1wYNhHqe+H1eHwAP5dT7As6OCeAexz24xrKCJoKPADU0qpKhEyrwiXE=
X-Received: by 2002:a05:690c:64ca:b0:703:b3b8:1ca1 with SMTP id 00721157ae682-710f762d3d7mr95493917b3.5.1749301083325;
        Sat, 07 Jun 2025 05:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzPMOgCNk3VE9SsfKXmuZM+nB+7y+ADlZL68LpA3zUBsqHZyGJebHmJUwK+oL+gqMhq7Kjom+gmPFEsKAmSD0=
X-Received: by 2002:a05:690c:64ca:b0:703:b3b8:1ca1 with SMTP id
 00721157ae682-710f762d3d7mr95493637b3.5.1749301083000; Sat, 07 Jun 2025
 05:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515032226.128900-1-npache@redhat.com> <20250515032226.128900-13-npache@redhat.com>
 <bc8f72f3-01d9-43db-a632-1f4b9a1d5276@arm.com>
In-Reply-To: <bc8f72f3-01d9-43db-a632-1f4b9a1d5276@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Sat, 7 Jun 2025 06:57:36 -0600
X-Gm-Features: AX0GCFt-sIirhVY_s3fqNEN_w8JX_uHJd6OXJSEG9XOqi8-7-ivm0tpji4jWrKU
Message-ID: <CAA1CXcDOEdJRvZMu2Fyy4wsdy8k8nj4c45s4JanO9HzyJgyXOw@mail.gmail.com>
Subject: Re: [PATCH v7 12/12] Documentation: mm: update the admin guide for
 mTHP collapse
To: Dev Jain <dev.jain@arm.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, 
	Bagas Sanjaya <bagasdotme@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: esogY_7e_QPaLvz4sIyWR_4f4VD74vUOr7012qifwNQ_1749301083
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 12:45=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
>
> On 15/05/25 8:52 am, Nico Pache wrote:
>
> Now that we can collapse to mTHPs lets update the admin guide to
> reflect these changes and provide proper guidence on how to utilize it.
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index dff8d5985f0f..5c63fe51b3ad 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
>
>
> We need to modify/remove the following paragraph:
>
> khugepaged currently only searches for opportunities to collapse to
> PMD-sized THP and no attempt is made to collapse to other THP
> sizes.
On this version this is currently still true, but once I add Baolin's
patch it will not be true. Thanks for the reminder :)

-- Nico

