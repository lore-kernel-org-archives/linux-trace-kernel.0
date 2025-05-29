Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866502222A8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 May 2025 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490771; cv=none; b=bNTMX34rLYPnk+jtHIukcqF0/bAblVoOx55KuGWed/G52Ac3l69ADM/icKyvI6/3AyiUjNw1Cbe2KFF9qtSfO3sU8p2pKhIQxmTXAM2Yg8ju/caV3OJInJjyGZq3gvnXWo5kuBJHKEtzbJ9zcrZyEPYFH99T9L2TKS4DgCs2+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490771; c=relaxed/simple;
	bh=jjBdYG5dDlk4ROjsfQyxf8vSTtJMMJIcoc8Ttyljtjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nkxz4g5NOSNIomwMN9lJ2xBHveY7RXqDb2soQnJaImQGDJzuMT47+HsSMfpEbst7V1V8mnNWgCpY9cJXoTaXz5TkaugTK0rV5jarRaLD8KRXIBlp8IL6BnBESbL7U4vCdSXxCrR0bwyallsmlW9EYE/5xAwSR4D1JNT43V0Md0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQxs0M8M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQxs0M8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748490768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hhA7GC2WW/+lJ32k1Z0Il2RFszCwZCLWK9Duc96zI4=;
	b=PQxs0M8Mr/58+3U/lORfJYDDaBetf+jKt2GTau1T1n5nH9WyeTcJR0YJ5dgOEC3gtbJy+3
	Byz9CFkkUMk0+vvnXPAwj17uAnl2GlBSqAauDds7SCL2vm/mFCiYW69omolyL1y3QwsQBT
	7phPyNtAnn+b6mN8fm/uE44Wdk5JM0I=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-bglr94kCNy-O_IMi577PrA-1; Wed, 28 May 2025 23:52:47 -0400
X-MC-Unique: bglr94kCNy-O_IMi577PrA-1
X-Mimecast-MFC-AGG-ID: bglr94kCNy-O_IMi577PrA_1748490767
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-70e6a0c35b7so8719887b3.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 20:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748490766; x=1749095566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hhA7GC2WW/+lJ32k1Z0Il2RFszCwZCLWK9Duc96zI4=;
        b=dD9gkUKzZzaJv7QAady02c7m+XwYU4N1XfqGFNC3RCXQwjAQ4ON7JgVZMavzwpz/Rk
         Mk/CowF/jFGDCCjUU7kn+/awATfgYLJxB6MS3CPxBvB5p3y/OUIta7eKmuJwKjSe5pyG
         cIpZ1yuxn92QReX4W1lBJj7yK64kQHlP3Fij3aK+JODlHA1Rdu/koOCk2dahxA/1vXBt
         Rcr9C6u3qCnH5kutjaQ1CQg152bhZLlap40jwCE8xXlfqgGa3EteWs4vqgrItiEb7TTw
         We/b+34P42909IIVHlHNh7/R2ezzpc7y1bA8unC7wzSIqxR/a4eX3+u6c6SotnizF00j
         Yl5A==
X-Forwarded-Encrypted: i=1; AJvYcCV3KpqgP47GMyX1BGRBR6IRJ8mb1DzbFkTpLp0IQ6v2lJPs3m40Lrdu7LzPCCVzjQZOCgacaoiI4bWW/2HP/6/iw7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx862eoTJyn7cywR0BcV3ddc6xHnZTkLbd6mDBdt+k3M66WLPLh
	nJDhilEf5BJZk4XSma0O6X0d5fo16ZBRSniTHwGlmbZCEcZH7mqq7dkhfVWyMhdsDN2MpK+pWrO
	g/AKBX6Xn8hA00ZIqIZoGbNpDz+S9kHPc/hNuOF3n31KOU/F3F1nf0ItbGnKrKxM0Km8hQocnwR
	NJjcWp9qys2zV81IzmDtlJTkPWlrXNhCJSyOlAWSvhfp27Bqvp
X-Gm-Gg: ASbGncsS2ShXPu3QVQKGoNeSLYgWG6R6t930NkKhuGU22LPQMv7bZhPDDXWEtibbUrI
	MbVqO7ZEXbySRRDvcwZMJNVSTrR1TQ/MB5x5HSj0wIIfAgE7a6NK23TF2Io+YhX3s0W7A7Ag=
X-Received: by 2002:a05:690c:6c84:b0:70c:9364:2c61 with SMTP id 00721157ae682-70e2d99acecmr259481107b3.9.1748490766706;
        Wed, 28 May 2025 20:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBHhgbNYXKNeLYZZxqGSVehk4q8NKnO868u4K0Pc9kRLFdHIZrfkpOjP7qA1+UiLAH4quPFQdOA6jB8tjDF2Q=
X-Received: by 2002:a05:690c:6c84:b0:70c:9364:2c61 with SMTP id
 00721157ae682-70e2d99acecmr259480667b3.9.1748490766362; Wed, 28 May 2025
 20:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515032226.128900-1-npache@redhat.com> <a956379a-7472-4972-bf3d-fe2b2b6715b5@linux.alibaba.com>
In-Reply-To: <a956379a-7472-4972-bf3d-fe2b2b6715b5@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 28 May 2025 21:52:20 -0600
X-Gm-Features: AX0GCFsiYEJ1VuiCFlFESTf-xqRr1WAwbgRTyelRq-SxIdDhpm-aFp66aQ0MKqc
Message-ID: <CAA1CXcDKOPk+7keQG43_0PzaAnVFLDrVNq=rnZK_m_QVFjk8og@mail.gmail.com>
Subject: Re: [PATCH v7 00/12] khugepaged: mTHP support
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: liXLBerONC5kUXQR7FIBBrevI8pXXuHDFNJ_5fVBjyI_1748490767
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 6:39=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/5/15 11:22, Nico Pache wrote:
> > The following series provides khugepaged and madvise collapse with the
> > capability to collapse anonymous memory regions to mTHPs.
> >
> > To achieve this we generalize the khugepaged functions to no longer dep=
end
> > on PMD_ORDER. Then during the PMD scan, we keep track of chunks of page=
s
> > (defined by KHUGEPAGED_MTHP_MIN_ORDER) that are utilized. This info is
> > tracked using a bitmap. After the PMD scan is done, we do binary recurs=
ion
> > on the bitmap to find the optimal mTHP sizes for the PMD range. The
> > restriction on max_ptes_none is removed during the scan, to make sure w=
e
> > account for the whole PMD range. When no mTHP size is enabled, the lega=
cy
> > behavior of khugepaged is maintained. max_ptes_none will be scaled by t=
he
> > attempted collapse order to determine how full a THP must be to be
> > eligible. If a mTHP collapse is attempted, but contains swapped out, or
> > shared pages, we dont perform the collapse.
> >
> > With the default max_ptes_none=3D511, the code should keep its most of =
its
> > original behavior. To exercise mTHP collapse we need to set
> > max_ptes_none<=3D255. With max_ptes_none > HPAGE_PMD_NR/2 you will
> > experience collapse "creep" and constantly promote mTHPs to the next
> > available size. This is due the fact that it will introduce at least 2x
> > the number of pages, and on a future scan will satisfy that condition o=
nce
> > again.
> >
> > Patch 1:     Refactor/rename hpage_collapse
> > Patch 2:     Some refactoring to combine madvise_collapse and khugepage=
d
> > Patch 3-5:   Generalize khugepaged functions for arbitrary orders
> > Patch 6-9:   The mTHP patches
> > Patch 10-11: Tracing/stats
> > Patch 12:    Documentation
>
> When I tested 64K mTHP collapse and disabled PMD-sized THP, I found that
> khugepaged couldn't scan and collapse 64K mTHP. I send out two fix
> patches[1], and with these patches applied, 64K mTHP collapse works
> well. I hope my two patches can be folded into your next version series
> if you think there are no issues. Thanks.

Thank you for looking into that and fixing it, I had originally
decided to only allow khugepaged to collapse to mTHP if the PMD size
was enabled as well. It was on my todo list :) I'll work on adding
your patches to my set, and do some proper testing again!
>
> [1]
> https://lore.kernel.org/all/ac9ed6d71b439611f9c94b3506a8ce975d4636e9.1748=
435162.git.baolin.wang@linux.alibaba.com/
>

