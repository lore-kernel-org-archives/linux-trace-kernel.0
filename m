Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B51DFDE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715449; cv=none; b=ZXS0QPTUA6KTNsEVQV9TfuvXAV+VE1PWnbJ6W9ZyQvV4MzfNtpzndyeKLgGU8osdG7xlEbVSpfI4uKpdOvpX1nUpja4YCWq0EWReutDkEhMRA1ljYqBU2IkCAnTZPPmyFakQuT0GH6AQO1S2AG4XKzpMR1pw26NZKvtt9koErig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715449; c=relaxed/simple;
	bh=VmLOvKtpz8Fi6Pwt/icSJ05BvKLbLbH9FVoytCdF9F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9iFe+nK65OmNqSCdeLNKsj7iDZRN2P1nRKEoN8+v5GjcGFaRZOB8fdgi18BdQWlNjCKO1uysqGwQ5lGL9jodrfn2oC8PKlNKcxnHMrx5MKR4afpa3TU8xBZxuHTkBzX31FiQ5tJwu2s/A1ilhbm0K0XZdVwFt0CZCyRfpvR3m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOh4NQxS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOh4NQxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732715446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VmLOvKtpz8Fi6Pwt/icSJ05BvKLbLbH9FVoytCdF9F0=;
	b=HOh4NQxSZ2oEquxoJkhOw9gA8hGtmXQztCQszPuCaDM93x/z0zn5Z/Eod/fWQVlnsqXWT9
	dCSqPsD9/zzmbd+LR87PoHzKk6w9yQjyTkCegkEhFrFiwrSyXeeHJAJo82PkW74dPya4Vp
	4LjK24vPBdQpXSRzTOrnxaX+NdZJc0c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-WxgFVh1BPxetStxb7N2Fhg-1; Wed, 27 Nov 2024 08:50:45 -0500
X-MC-Unique: WxgFVh1BPxetStxb7N2Fhg-1
X-Mimecast-MFC-AGG-ID: WxgFVh1BPxetStxb7N2Fhg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa5438c6b13so233068066b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732715444; x=1733320244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmLOvKtpz8Fi6Pwt/icSJ05BvKLbLbH9FVoytCdF9F0=;
        b=Lyt6RaNBHPGjprMIcHC6k5/53EFQI4tK+hXOq7cCea6GrMYjOddKXEDqTqgVXfUs/8
         7z5lpc+0O/Ylb7Nm2JtzgBPsao/wv5z9wgP8h4Ug1YP9MOA+8svKAnTZApbkt27DUVVj
         nAKxdQ6Pgj+QEm48T9u3qKczlFJT/pQNhSBxRVoUsMoeJQ8jSi5CkEmeehIsYhVLVMix
         zbkf9CXOinAaTLRIK7yvxAUzHj397ubYMCx7CA31MlKJqvzKLs3+QHuryARs9/JAZqbf
         ztxxr4WoeQ2b75yBySQ3l+kl0QV98JoXrF5vSWbTZMUO4sDpVT2lGKcq6mAZX/H8d3A8
         ++sw==
X-Gm-Message-State: AOJu0YwfEo+40j8s1RRX9o8tjq5cnikHdi5WeSWqf+X7lmKq/ZSTL/IJ
	XZUQ07XYiypOs8P70od7uXzxHZN5XeLkcZKT8XbiyaKM81a8jpJ2AjYHKIVGroRqHwpUg7Ivh6p
	Eniy2p/7SfKUiTNGqgSarqgKxDoSqgOJf3aF/em5Zk934NGo8rKzSs3T+r19ea/Uwu8Dg1Zi1Qg
	61pgU8gxyqTcfVrZw+nf/B7jvj7uteHJdPL72AMoZ/ZGC4
X-Gm-Gg: ASbGnctBMuVff9GMTD3vzLChXr7tJN3VTkFpTfPgrTJGzlCRsiI3B8aBCJsysa+G2QQ
	ArNnt2s3tTc1S2aTaumwi1Dvl7yWFQyA90WrwQ5XzZYsxyJBUf2B+iapb9qE8SSM=
X-Received: by 2002:a17:907:77c8:b0:aa5:2858:addc with SMTP id a640c23a62f3a-aa580f25c5cmr214945466b.18.1732715444295;
        Wed, 27 Nov 2024 05:50:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjazrSJpXT3WQtUAce0m6TM358Mro/Sud5IZtPknd3QLTCf4Ede75aPwnsEYPw7KrosjIDGoPFoPt2ry9Xwrs=
X-Received: by 2002:a17:907:77c8:b0:aa5:2858:addc with SMTP id
 a640c23a62f3a-aa580f25c5cmr214944366b.18.1732715443979; Wed, 27 Nov 2024
 05:50:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127134130.51171-1-tglozar@redhat.com>
In-Reply-To: <20241127134130.51171-1-tglozar@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 27 Nov 2024 14:50:33 +0100
Message-ID: <CAP4=nvS0RuUH+RLWHBEQuFh=2-s43vxUw632-i_Lxd6h4+Gd7Q@mail.gmail.com>
Subject: Re: [PATCH v2] rtla/timerlat: Fix histogram ALL for zero samples
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3NONpyi9sV_K6dMfWEcpbs2CpEC8rjwfcJqhRG1tr6U_1732715444
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 27. 11. 2024 v 14:42 odes=C3=ADlatel <tglozar@redhat.com> napsal:
>
> Fix the bug by omitting max/min/avg when sample count is zero,
> displaying a dash instead, just like we already do for the individual
> CPUs. The logic is moved into a new function called
> format_summary_value, which is used for both the individual CPUs
> and for the overall summary.
>

Note that the code is still repeated 18 times =3D 3 latencies (user,
thread, irq) times 3 summaries (max, min, avg) * 2 kinds (per-cpu,
overall). Due to the way the storing of the values and the printing is
implemented, it is not straightforward to reduce this code duplicity.
There are 9 different fields: (max, min, avg) * (user, thread, irq) -
of timerlat_hist_cpu, and min/max/avg are grouped together per-CPU.

I will send another patch to remove the duplicity if I get an idea how
to deal with it. The duplicity was there also before and is thus not
in the scope of this fix.

Tomas

