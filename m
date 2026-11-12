Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794524823;
	b=Y1dk0uFYB0UGEOcQFLi3vg+I6qxRkvJMCwCiMkGVBd7GItIpuQKi7+rVYSPraA4lj20L
	 +4/OboW7WhH6UxyyWPxu+StLju9DZ42O0T55KlCo+YsCZFrQ/jvq/rVTqHsxhJ7P7Qcty
	 t0r3rSEa0NOA5Yy/2+B3HE8W9dppvwC9qaKKwFsCvqJOSVgSzNZOlulMf7dWoqzgZNkdr
	 k+J8ghHxr1q8BjASNJtqa163DIdGEaXbDOdF6PGn8x5Juey5vCMo6JAOzjTgHILIfUq4J
	 AEH8Ie0LQcNpQje3hThC6N9kbyRoDd0Exlbpj/dcJp17B5RXn0c2JDjhblTPGWwyxkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iq7zuX4mescGycMYtdVsnHt3n8ea5BUsLeUaRpIODWM=;
	b=hMUHdtY+9Bc8aO4zv8pBiyXIjKUppdd9ZqOXHLMtS2VX39ORQqhys2kKhLclgnbru0TU
	 GHfs6/8BT0m2jqxmZ+c6wNsMseP9VSlgvoSx0yCSa+pC16mq7Y0S6ixJTEmF2Rlctrw1u
	 GoU0z5ZAS8rkHIla65qK+PlhWNOZC897ozwl4nuczj98bqUfjMi2hjP8wRTtU9FYacQHt
	 dHq5nDvgKitjRf+5tiEZljZQEkNDA2bWUWTEmOO2NTIofSrvUBCahHjzLPdupNLUHuNIf
	 xOrW5x76bPnKab/2U7gdKPa9aHxzo+bV5vvJOw2YUT3zGqWLkc3I/sCLSztk00i446Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=irICtOrg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209E606A31C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 23:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E209E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=irICtOrg
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5383c97c8cfso10581cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 15:07:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794524822; cv=none;
        d=google.com; s=arc-20260327;
        b=YSnn1rt4xtznluSs5qy8wgcPLqdAq6Du0FnpBMQ5hyNkXHuwMZDlARGWyIaTHc05Vp
         ak+dYY6g6OBdh94SkSCSFfJtmcmtTerLHsBkfzTWbVNsvlXVY1sE30o+auADy4YWY3he
         S2uCz3Nx3yfl6e1kZMI1l90JW1RzTtjiB2V84/5s/BDDO3mriD5wkz59Q4RTCDmOc4PW
         Cmc4buXANmW3O5SYXGBDkAl/UyzIbC40RiPq7v0CtNS44M7pxOe0/6PbIyP6Lz31iqwp
         lyoydmtzZPFk7c2Lu4p5vK2MQxzJmnAyUnoRZcUaug2RHEcEfva7SxyGLXJgIos+xPQf
         ughg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iq7zuX4mescGycMYtdVsnHt3n8ea5BUsLeUaRpIODWM=;
        fh=XHAfYCgTPsUt1HUQE+1Ct87c0iettbIPn5QCSoDv+Hc=;
        b=GpEPmIqeyEjmuBY4eP8MbuXinJJGH8LcsBuea/cxeYqOwOFjBvFNGuPfeWdhTqxuVP
         ty75jaL2Wq1OaDYHz1itKe7YLKopdSe5e7Y/z45QVLh7tO2HsuLio2+7hj3IVO4bXRKi
         x11TBRdc4lUnIBn0XXijA36G7VpeMBRB7m+KUjBi+VSgCO5dITNQYrWF547vahUCfU8j
         C8wSUgynTzdSJy62KflGHnXWCYk6K9MotL3D3/b8WvP0+4eF2yGG3/1f3/sPxL243/BI
         5yo2FfjCaVCUj50hqx2BIKvg0XGaEYVvEBVJZF2Tp2+M63/pGlEgHZ15sdj46ymPeAnY
         e2eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794524822; x=1795129622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iq7zuX4mescGycMYtdVsnHt3n8ea5BUsLeUaRpIODWM=;
        b=irICtOrgRGFSY53WuIyzu8TvH4VAFbp2Bm9vZ4Z1Z94hZozwaMXLPxyJx/tlti2mVi
         ctcdxtiTUfyI8LFpkjubrWADm37oXauz/yIIo60ytVeIRG1VBoLNFIiuy0k+6Ju3jFQd
         7REtp4u2l3gQJoyCxJncqUbeCGAoNHXHbZ6REFJqvzb2PcXCrmukCEXpQXNOYn1sLXrs
         ICu8svIF5y41B/8N5MbGb9qnQrAt5rMNJoRqqozkRerVUe62lhc7jCnCfoDqB6sF60RT
         LV5VmLgNaudkTgH3dH1fHWPWHdcavn/h+HTTkV/FsVRJr8IIipcHA5Up6ArQIs0x8H9P
         b6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524822; x=1795129622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iq7zuX4mescGycMYtdVsnHt3n8ea5BUsLeUaRpIODWM=;
        b=HkbI2UMjdv9u/Dtb+l5MhEZyrIPQKDZ5i48A2uPDpBRhmhgrwGNar3TDYDGqHsZ/0a
         ahoTg8t9lRSimUspeaTunGEwwPWLp3W+784iyGOK6lqyb99tm3g1tD4Hy0A/iNYVJ82y
         /nUl3eO9M+ekE2FWS9IT+vq4g7WAm6J84lRLPFvEViGICykNKxzmgcvXcRGNXsajsAIj
         lvCkHdn2ryCT30LS4e0nH/uoSxY2u2NOuJGR5IrF4uWVl1DWxXuvi+jqWnVO0d992ubg
         JMi6olXDBZTkcIAUmpnxfE6wu4dhcqe7aEjdACLkd2x9ZQmTKYymMthdqnxuVKaFMKKH
         E3SA==
X-Forwarded-Encrypted: i=1; AL+hErHwX4qYAqHMf5u/f32rVqgCXv1koc53HGS+EeNRzYiW/QOkS3sZBZMCvQaSYxBLYdeR4UQYRV6C153rVhZRGeB08CY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EQQRDQzREZ0p29a45pHsvD5uHtc3wH8JPKA+C0BlT0AOduxfV
	h0Gmz4JU1+TtbgC0tgTYq9Fc7yJQyw3kypm5iSr0I2BLoRtm37HbSBHMry+xnAAVB9CM7qKBsvB
	EU+hAGKl6fu9kLVHiDju7cwlNUZYQF5NbQiiTyqpD
X-Gm-Gg: AYBFou0oe6T8VAC9jW0SsUwvN9VKxpkaXeFgeDDqvC0il6Rv9UP4f9FMZVOxfWCpemW
	YaAPcUq9fyAntac9FPNltoE8MNTALqfe3G9brB3sfAhqxZwqJuya/bjieWMXpi5HfTOk7oU7c+7
	7yRqn1J1kpT5dBrCzEHFiw8qLiQZt9NyZzsc7llQna//NFXtjfb8mtlujM8H8vFSdqDf6D/vXx6
	uAITTC+BvCs2HOJoWK4fjqyazJVl9mfWhhqV2qdxwag1loJkANjxVwcGeQEaxi2e+DsfvBebee0
	J0i6MiXp0soYJhY9pWTYJPVevxFH0WO0CBHBkf3XxDjoZ2toKfoDCp1t1yNNYDG/VdIx1xePOOW
	ES11uIYcedFwr+vCvF8t4tu/dePI+Oqrshw2tKYAfTJ/2hn/bgYNCjgKPMRToCI9t1uER1P8DVa
	WlAJfN5lqwat1u
X-Received: by 2002:a05:622a:4885:b0:536:3ee4:81cd with SMTP id
 d75a77b69052e-55adb2a6457mr5607171cf.4.1794524821197; Thu, 12 Nov 2026
 15:07:01 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260730-rfc-nt-demote-v2-0-452dbe3b5073@zptcorp.com>
 <20261103223025.2482227-1-nhuhuan@google.com> <7CF5AD15-B833-44E1-A9FE-C8E12F8C9E82@nvidia.com>
In-Reply-To: <7CF5AD15-B833-44E1-A9FE-C8E12F8C9E82@nvidia.com>
From: Huan Nguyen <nhuhuan@google.com>
Date: Thu, 12 Nov 2026 15:06:23 -0800
X-Gm-Features: AclHuK8R0WzJXR4yHYxHSMICSWxLr-x7bnN-BX27nSJiTtbJXgPCv-FYzS8TYcg
Message-ID: <CALwWd5vAtSSuFoex37AzDBcK0RaBP3fbbst_fy9BGBQ5jr-K1g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/3] mm: use non-temporal stores for demotion
To: Zi Yan <ziy@nvidia.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, trondmy@kernel.org, anna@kernel.org, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, jackmanb@google.com, hannes@cmpxchg.org, 
	shivankg@amd.com, rientjes@google.com, dave@stgolabs.net, nifan.cxl@gmail.com, 
	fvdl@google.com, jic23@kernel.org, rkodsara@amd.com, bharata@amd.com, 
	sj@kernel.org, weixugc@google.com, xuezhengchu@huawei.com, 
	yiannis@zptcorp.com, yiannis.nikolakop@gmail.com, 
	dimitrios.palyvos@zptcorp.com, alirad.malek@zptcorp.com, ryan.roberts@arm.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 4:09=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 3 Nov 2026, at 17:30, Huan Nguyen wrote:
>
> > This series continues the non-temporal demotion work originally posted
> > by Yiannis Nikolakopoulos [1].
> >
> > Motivation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Memory tier demotion moves cold folios from local DRAM to slower memory
> > tiers, such as CXL or remote NUMA nodes. Standard store instructions
> > force the CPU to allocate cache lines for cold data that is unlikely to
> > be referenced in the near term.
> >
> > Using non-temporal stores and prefetching on x86 bypasses CPU cache
> > allocation, protecting active workload working sets and improving
> > demotion throughput.
> >
> > Changes in v3
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > - Unified MCE-safe NT copy (addressing v2 Open #1):
> >   Implement copy_mc_page_nt() in x86 assembly to provide machine-check
> >   safe copying using non-temporal stores (movnti) and prefetchnta.
> >
> > - Architecture abstraction (addressing v2 Open #2):
> >   v2 relied on memcpy_flushcache(), which lacks non-temporal stores on
> >   architectures like arm64. RFC v3 replaces this with a dedicated
> >   __HAVE_ARCH_COPY_PAGE_NT interface and generic fallback, enabling
> >   architectures to plug in native non-temporal routines independently.
> >
> > - Memory ordering:
> >   Add a wmb() barrier at the end of folio_mc_copy_nt() to ensure weakly
> >   ordered non-temporal stores are drained before page tables are update=
d.
> >
> > Discussions
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Migration mode vs. migration control refactoring:
> >    Currently, this series introduces MIGRATE_ASYNC_NONTEMPORAL into
> >    enum migrate_mode. In parallel, Shivank Garg's migration refactoring
> >    series [2] consolidates migration arguments into migrate_control.
> >    Once that lands, demotion can simply rely on the migration reason
> >    instead of adding a dedicated migration mode and helper.
>
> If that is the ultimate goal, why not do it in this series to avoid
> code churn? You probably can coordinate with Shivank on how to move
> the migration control refactoring code to this series.

Thanks for the suggestion. I reached out to Shivank and we are
coordinating on this.

Best,
Huan
