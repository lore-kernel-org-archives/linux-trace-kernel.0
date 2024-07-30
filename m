Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEB51662F4;
	Tue, 30 Jul 2024 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370850; cv=none; b=XOY620Oq01/Zli0UOk1LI/1IDuMvzE5ClyWP2eaN9E4iVCFkxIyvbKw9GTlUswq/baduz4F0lRN/G21JovEUtvm/6tB7sle91v4T7seHTJKQpe2iI6jNL5OYWw4Bh+lD9MqIBj9htsmAhMIKoV4jskjo1tEkpycKn/nGjKxUYQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370850; c=relaxed/simple;
	bh=T+wqOMncPU5566Aq43m8Kn3oC2LLyjUFyvLENezdgnc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDx9QVmN0DbREdH9h2do3O6D0CSyulg85EA6XrD38wOn/A3JD2gYqQAhHUX1pWjtQisN3MiTj4MQIZe4JVjbVFrEZj4o+HS19ECUQH5CPEfgMkEXVy7uJt8g5i5SBfkbGapD8f8N3sRdbxbR9jbthnn7Rva41LQPv5Z1CiEpy3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcVlKfiJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcVlKfiJ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281f00e70cso19487595e9.1;
        Tue, 30 Jul 2024 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722370847; x=1722975647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RKVifo/aFEZbEctWXQe9iw3Yvg5xoSAtnKA57D70UCs=;
        b=dcVlKfiJXPB/ufXMbkGn8uJS33iqmaNHl/RExEIFwxTz9DrcSHNo2kBkxptsBEgIWQ
         bOeF8VyEPhpSShYOZ8N7vqejjfEMNxS+18mdvcYiYv2+mlo2epCXbX62/qgUKinBmRn5
         ecu+HmEi+d/bBfBEClo1k7nHjwTX9HXcw0nvPxstSUXoAwShEFQrW3KBfSvFydqQJwhK
         +RDKGoBlUHZjblI75qDNTe7wYizMbXEkAwoH7JF28kDML1xsE2g4tWsQzMxfzufKB4FQ
         nm/8wFzutV+Zlaz5I8heTziwwHx+yeBPQnKrOPmfYZlfX/VdTt9BrnyzOF4BQ1ZojSZ6
         cLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722370847; x=1722975647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKVifo/aFEZbEctWXQe9iw3Yvg5xoSAtnKA57D70UCs=;
        b=hyfdQVzYduMwtAG8Pu5LpZofSiTRuFtpkBU9baQ90EHpF9ed9EzvGmB18oZt307zmL
         ZoeVrgcCExzOOnl1BkqCX0nXto7iLUopFzkdFukYaU00svyaa+LRdgGm/LRpwGpksYqW
         cc1IhvtbpPvvKWVtaxwHyh5bPJHvxm3LB01TeyIAIMH6hg/kv0/OXkTnm0N/FJttOne/
         RoS9+nXaB/DGLyAwFLRZLplz3osLKraZ38Ba8AuGN1c5foFZrLZl1MvLwOgBnLUuCgYr
         Mv/+X2Vi0V4S4N1cGCGEcUsN6n9FzuwjX5uNhVFj0D4FuoCKFK+lXnAYE7NYR8NCDAyb
         buqg==
X-Forwarded-Encrypted: i=1; AJvYcCV5bokCGsqAgd5qMPJKGayU7cG7zmWiUnrFnBduIfjOgelhCK9gHopTCOkC7GKyZfe/yStwcSjXBZiyGB5cJd1cFzOLuRv7Lt5NeT1w2emE6u6Ep8Uxsq1OKIsqRMTeS3i2NumZjoYbKWwfbf0DgFZR
X-Gm-Message-State: AOJu0Yz0t9bqknS4NLNsjkGWF3NrO12T9PCUMRZdt+Q3YQ4Pv/WkKEv6
	1K/ivUwBExBZpsoECND0KKVTPGCPrH7eamrYJM876ik5Tno9AOgU
X-Google-Smtp-Source: AGHT+IEUn18ey6uw5TnXYAgpUThwbcBKWTdcxmdNWW41ueelbabaOKFo4fstejdq/yO9ZEhl3/kz/A==
X-Received: by 2002:a05:600c:3042:b0:426:6e86:f82 with SMTP id 5b1f17b1804b1-42811da94cemr82126925e9.22.1722370846805;
        Tue, 30 Jul 2024 13:20:46 -0700 (PDT)
Received: from krava (85-193-35-46.rib.o2.cz. [85.193.35.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42824ae7a59sm21370855e9.1.2024.07.30.13.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 13:20:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 30 Jul 2024 22:20:44 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org,
	peterz@infradead.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] uprobes: simplify _unregister paths
Message-ID: <ZqlLHEJpN36yh8F3@krava>
References: <20240730123421.GA9085@redhat.com>
 <CAEf4BzadOamfkR+ww-4F2romXJzMo96V6=MTgqN1G+p5CXuOmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzadOamfkR+ww-4F2romXJzMo96V6=MTgqN1G+p5CXuOmw@mail.gmail.com>

On Tue, Jul 30, 2024 at 08:10:27AM -0700, Andrii Nakryiko wrote:
> On Tue, Jul 30, 2024 at 5:34 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On top of
> >
> >         [PATCH v2 0/5] uprobes: misc cleanups/simplifications
> >         https://lore.kernel.org/all/20240729134444.GA12293@redhat.com/
> >
> > I sent yesterday.
> >
> > Oleg.
> > ---
> >
> 
> Both patch sets look good to me. It would be nice to get them applied
> ASAP to have a stable uprobes code base to work on. Rebasing is
> painful and error-prone.

lgtm, +1 for having them applied soon

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
