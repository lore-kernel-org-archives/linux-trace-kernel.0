Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969671635B0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854563; cv=none; b=Zyt8wvwCUBqwxRM/aOF936Kx+MuEm5d4jClIxrWWThx39ZlWvB5LvEf4StRw+f7HEKG2Hs3ZCGQmeBGPLR0Px08uRI0i/SLZaf7wi12Qgavsi7rvvUh5n9mXVALsEdEGZ79w9bJuANgSdpkqVBQs6ifZj5u4Hj25k9oNov4EMa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854563; c=relaxed/simple;
	bh=mdyviDc2SZiHERUxq8FwGAUG2lksvejg1L3R6/TQq04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfamGsD0jwUP42VWutu2W/AA0KwxSBeV7+lAm/8k/1DAAeNTEIyupz23hwWElG3NpgzC+/1NvPLNH24nRNlYoDfuWuoaLr79wW5x5ktqubrRXUPdBdv8iABawhnxqmvEq670TffePJ8Mkuz3DHYpjmPhof7+DkSH1vPBdmnM5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CEmduPtL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEmduPtL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712854559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMWXkXzR0H7lOgn05ANda8bjR25lnib+pFQqcdAFtGw=;
	b=CEmduPtL3NP5XNR+oFsDnVOJaZoVwlx7dy2SpDMkrYd+ByLjBPDNySLL9ouFDlwrBxagu3
	BJkyt5CIUk3SQVwtjYimIGEWuF/N7Omn/wmbfHopdQCiAeWPKGQeIWT7U9sxB+ZjvYoz0W
	M/50ajYZgsI8RUEvSFEfgE31ub9wAJI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-UKsNTWISNGergumR3iTEDQ-1; Thu, 11 Apr 2024 12:55:58 -0400
X-MC-Unique: UKsNTWISNGergumR3iTEDQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343e775c794so3536136f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712854557; x=1713459357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMWXkXzR0H7lOgn05ANda8bjR25lnib+pFQqcdAFtGw=;
        b=OFKp7KAj8OLv5QiSKKQPlSMYe/Kds5Yp6GUYyLXgWmFDuAGo6PDSS2bwFzIyTVbJ7p
         MLtJnMUR8ymvYmw8rUwOPZPlq5gbjUg0h/Q8257SL8oXGM8DQjZ99LhmTQWynIyyjlme
         ZpZ/P1RRotnsT8aKA4EjzJp/7GXwPeFVaOzS43a9m/1mRljyEMxF8YKBXtdSeFwWqpDA
         bS2EO6Tgp562YJwZtq++H4k2T8tKvJhygBioTwh122BSBJd4hN0KuebDmMgIFxQAO9My
         BZYk3en0LoUAPXnI9zMDPUIXNciMbHHUO3H0AOmBmzV/+9z/YxreZc9/p7cP87mohLgb
         y2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5/FEAFT3F94exTk4qMiHFQyewYcXty1HSmO+PWiQbFUztPAgkUen1RIFbrAME5z6aTiOdkaQBh5mNPpZUix4CRSCA0ZW0JYAStI9VGwSIVcEH
X-Gm-Message-State: AOJu0Yzygkm4KrW20XQGhEuqZsWijO8LCLABUeRu3nN7tdGf5c/AaG9Z
	wd8KyNQ/PGJeBblR6duAVPgqg0cfV9lIIgNC/li8wTNxBk2HQqtX8Ux6d/bsoZ5hj/5AOey097B
	b9Zg5GXqaqmpEx1LTDdS9aSDtZDQ21NNAI0j4MfYQqeQipf3gkCcVlK8hh2YtANuI9aInu8tRb5
	XvXL1SahKq6r0a/NovAx6g667ox9cSE/0eAopwoC2g81f2
X-Received: by 2002:a5d:5143:0:b0:346:67fd:beeb with SMTP id u3-20020a5d5143000000b0034667fdbeebmr125071wrt.13.1712854556790;
        Thu, 11 Apr 2024 09:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD8Twrk+pSap7dr/hOyNv9dE7sPb5xWfugil3Ej7FN6UJvArBpNQmyBrQbHxp3h5Btn4P+dbeRSa2EBSrKO98=
X-Received: by 2002:a5d:5143:0:b0:346:67fd:beeb with SMTP id
 u3-20020a5d5143000000b0034667fdbeebmr125049wrt.13.1712854556481; Thu, 11 Apr
 2024 09:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405115815.3226315-1-pbonzini@redhat.com> <20240405115815.3226315-2-pbonzini@redhat.com>
 <ZhP3hDhe2Qwo9oCL@x1n>
In-Reply-To: <ZhP3hDhe2Qwo9oCL@x1n>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Apr 2024 18:55:44 +0200
Message-ID: <CABgObfYwwXy9gQap-PJyOrVCcUr-VfK90AKNaRe0VO-G00G8SQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: delete .change_pte MMU notifier callback
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nicholas Piggin <npiggin@gmail.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Sean Christopherson <seanjc@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 3:56=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
> Paolo,
>
> I may miss a bunch of details here (as I still remember some change_pte
> patches previously on the list..), however not sure whether we considered
> enable it?  Asked because I remember Andrea used to have a custom tree
> maintaining that part:
>
> https://github.com/aagit/aa/commit/c761078df7a77d13ddfaeebe56a0f4bc128b19=
68

The patch enables it only for KSM, so it would still require a bunch
of cleanups, for example I also would still use set_pte_at() in all
the places that are not KSM. This would at least fix the issue with
the poor documentation of where to use set_pte_at_notify() vs
set_pte_at().

With regard to the implementation, I like the idea of disabling the
invalidation on the MMU notifier side, but I would rather have
MMU_NOTIFIER_CHANGE_PTE as a separate field in the range instead of
overloading the event field.

> Maybe it can't be enabled for some reason that I overlooked in the curren=
t
> tree, or we just decided to not to?

I have just learnt about the patch, nobody had ever mentioned it even
though it's almost 2 years old... It's a lot of code though and no one
has ever reported an issue for over 10 years, so I think it's easiest
to just rip the code out.

Paolo

> Thanks,
>
> --
> Peter Xu
>

