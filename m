Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F03BF676
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325987; cv=none; b=M6CeNPJCFlRFSjUcblDU6qEa9VahLtDIxj0YCEtg1HSH7oL72/Lpfc0CXSZEj08mExCR19xRdXTZf2b6Od8fbQxaWLs5pFP/oWZM51MwpvhKA9dtROTcTGvhr/rG2T7YkI6alBOchEYQMFe9kYcPw4xOaQVyp71ywVkAgnRfuOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325987; c=relaxed/simple;
	bh=WzrBFZqfu8DnkLEv7f5e1V0F1EgR/vAbRBb+8qRzHsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOM6lAnZW3xKRsQQE+LqplUM6zDKwb+/DYNQApGoCMy4dqy21cgA0hJw5Lub1REDFHIK9S8SY4gQBVEhIBnkI7k2ePwTHv0PaXAjTaNeFgxe+rXrQzsujGw2B9Exj9/G3PoUuW32uZSTf9cvp4jB9pndaIUfxfveyNYb53Aib2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cosvmb8g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cosvmb8g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780325985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kzh5a0tVq5+/8roSGK1F3W4YTaJGCvorVh1SK1J8QJA=;
	b=cosvmb8gNFWJk4+HEo2W9HkjhhyD2zY3JbmR+gTgPQRL5qfDIKSBdRSRBKC7Is2ypVxJoj
	jJ1oisarcUQUO2xEPXw1WnR5Fg8Lpjf0To7VfZp0jr9tC2mo1TZw24KivF8jxc41DRWWIj
	9TwZDTLm1Wgij+DkJBqI7AeKYb2NbK4=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-yaynjos5M5SCa-Sh8EnX-A-1; Mon, 01 Jun 2026 10:59:44 -0400
X-MC-Unique: yaynjos5M5SCa-Sh8EnX-A-1
X-Mimecast-MFC-AGG-ID: yaynjos5M5SCa-Sh8EnX-A_1780325983
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6607988ca90so1836667d50.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Jun 2026 07:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780325983; x=1780930783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kzh5a0tVq5+/8roSGK1F3W4YTaJGCvorVh1SK1J8QJA=;
        b=jkup2+rtUMEy/j6MLF1i9X29a0I6NcNRIY6x4gzxS5ji9/w2nRIQKIiU+PbvXkZqV9
         SFtCZIVh7dFsEW9d5SjvsSj6/ma9Crx6WBVhIH/eu9V9RZIl7Zc1E1ViZ04WhfgBNP9Q
         ojfQsWaC2qocSHxeJVRRAFS8a1YA9L8z06bBsiR7UwDRzvgE7VKzDCsok37Ohoc6Gl3k
         IaEXwzpdSs8agSVIyAo2u+gNaQZNOtBLA1OKwpHXUuHlQ/sI2ZBaGmOzgJfv5hO6i4vo
         OMe8BCNj/I/cOZfplu3CmzOlRd+otVX3O7WoKvoI55SJasP1nMOJBDJqYW0QAIZQVaBd
         +P1w==
X-Forwarded-Encrypted: i=1; AFNElJ/fJtIdNJSSICOWbzGhoYJfwfH8Dug6QWqUsAi4FsXcyslQ+NwoyUFS2zNeMNoz1rs4xryFq/uErx20OEOZ+4P57EY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9v7zMrrrhfP1DWeIVT7dBDWlyb/2z08a8QniynsSMzHdPa9Lx
	AJq26APHoUiZOB5F7+6oADUxsnMsx9Uz7jkZSTQHJ2VasyG7YqGHALv1s6g4oqX21PQ0LH4+5VZ
	GJU8gaYs+y59tKZdcBuCO2aPDqcYfXOCe4IbtWPuMJn0hgpL36mwi9IMxz15CtrI7m3oLHYCVM6
	C/fSKBibpugEOOuRYVO0AuvH+p653SFqiSEI+X0n9nsKnrpqx1
X-Gm-Gg: Acq92OF+OUqjcfZxsNjPFvdlTZD/wPZDs2WRhrzrRHgAqc/uQR3L2VWPaCaMFTYicT9
	95HU6XcCJ9NDuQ5gw25KtdXtOXE6hFjJqXXnhYEaXFzx064YmLajter0i43TVfAW3sjVBceLk0n
	DU9iINwiEJ9WNp1j7quKoNr7bTU/BZnZS5Ec4wtRdlhBtGdeIREkGY7coeS/TNCpEumgGI5QcDn
	2lhIQmypFYJXrIszg==
X-Received: by 2002:a05:690e:1593:10b0:65e:43a2:82a5 with SMTP id 956f58d0204a3-6605f9416camr7354324d50.55.1780325983504;
        Mon, 01 Jun 2026 07:59:43 -0700 (PDT)
X-Received: by 2002:a05:690e:1593:10b0:65e:43a2:82a5 with SMTP id
 956f58d0204a3-6605f9416camr7354269d50.55.1780325983033; Mon, 01 Jun 2026
 07:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024af56-5e99-4799-a586-e9ba756cecb9@kernel.org>
 <20260601032804.96122-1-lance.yang@linux.dev> <f5d38f64-ab92-496d-afd3-29ccc17fec2b@kernel.org>
 <616de1a8-1cfd-40b8-b04f-7b324be40bfd@linux.dev> <6b11bf0a-769c-4ef2-ac6f-2af38200a6bc@kernel.org>
 <baa0a462-46e0-44ab-b583-c722ad253afe@linux.dev> <06d9b665-945f-4967-9ed9-b06514478996@kernel.org>
In-Reply-To: <06d9b665-945f-4967-9ed9-b06514478996@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Mon, 1 Jun 2026 09:00:22 -0600
X-Gm-Features: AVHnY4L3QcDds9Bx9nzJC4wMJL4H0KRuHxJDPSKQUpwkRBzl7EaLMR0JWfpdnXo
Message-ID: <CAA1CXcAeEGOsqp-ywAQ7GMYQzXEeco-rUxUkk2hEF69HybC4=w@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v18 06/14] mm/khugepaged: generalize
 collapse_huge_page for mTHP collapse
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com, usama.arif@linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6-tmy22Bz7f3ceaAIfhxDc1xgxK5Amn5Dn9hfv6Ooes_1780325983
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 5:14=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
>
> On 6/1/26 12:47, Lance Yang wrote:
> >
> >
> > On 2026/6/1 18:23, David Hildenbrand (Arm) wrote:
> >> On 6/1/26 11:08, Lance Yang wrote:
> >>>
> >>>
> >>>
> >>> One small thing, I think we should probably keep the smp_wmb(), and j=
ust
> >>> move it before the earlier pmd_populate().
> >>>
> >>> IIUC, the ordering we want is still:
> >>>
> >>>    clear old PTEs
> >>>    smp_wmb()
> >>>    pmd_populate()
> >>>
> >>> so another CPU cannot walk through the re-installed PMD and still obs=
erve
> >>> the old PTEs, right?
> >>
> >> There is a smp_wmb() in __folio_mark_uptodate(), that should be suffic=
ient?
> >
> > Ah, cool! __folio_mark_uptodate() already does the job :P
> >
> > So yeah, no extra smp_wmb() needed here!
>
> Yeah. BTW, I think we'd need a spin_lock_nested(), so @Nico, treat my cod=
e as a
> draft.

Okay, I read the above and did some investigating.

I will try to implement and verify the changes you suggested :)

Or an even crazier idea... what if we ensure MIPS checks for PMD_none
before walking a PTE table?

-- Nico

>
> --
> Cheers,
>
> David
>

