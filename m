Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C85031E846
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146586; cv=pass; b=Be3S1Z0nucf4U4OC/xpkSTQg2wgZhlJqzfWdvk6KDKX8ilSFmRfJ7y367IF75+kkKLWvfJYjdWLp7eCxv42/sbb9uIeEk74BugLnLhSqwftz9vTEtXJz5SriudDRK/JDZ9pubjDOX1OJ//E5lmKZDgzSQT5ruJYZzSfZsazh0+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146586; c=relaxed/simple;
	bh=fHv9nb6iULfu1kpZZZ3/tja1IfLrDwnxvWfhWvPh78Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fs5LKiUUm4jDSLfstyemNivImjH2XCa8dNUJ2BxwiU0PNWYmG+3ZvXYzmPHn0XuMZCdIhlpQQfZaFUOaUej3M5rGmbEdvAGQH/711MalXS0bSrwCiPXpYNXroSx227aw7Oa+etXcHAJwTdT/rOxoeYCsXAh+nxOaIbdCMG0vZ/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=def7eKdt; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="def7eKdt"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65318dafbcbso2813118d50.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 16:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779146584; cv=none;
        d=google.com; s=arc-20240605;
        b=H/JS/gOXn9R2/Zm54I1BA3KK0ORRaHgZ1FT3yqbfeHrGhmBF0vNMGYLvXECKkG4k3V
         kCp3Wv/npddzw7b6PcnvWg9FzFXdxom6AY0FH8bHrIvVo8kXDjNI9cIK3jOwiRGJMwie
         A64t2pEDhW6Tqdb7FzywKvTtwB18V63byoI1EB6LuPtQFPYOR7+/pXEQGkAVhyFFRFFb
         5iHJU2Fk0xctvhSTrTrmuhJPlzCsUKzWmkpzm4eY+ogNHyOZanFX3zwgro7RdvL8+fm9
         uNNdiBUQFwgfbC8heO9Wt/bB4gl6QMbBgNtBD14BpiSzfw87urdi4CIsUQJ6A91m51hs
         Kexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=whXJS7vOoJNpViQnsykoSQi+3tpMsWSRBjO6ajJAbGg=;
        fh=2yT22A4WVJxlLXn+NgUUyl2Dn5O1b1qldtFoZ1GEhdE=;
        b=Ypfsws+dsSVgXPNeMSpJw4GMc2LkaIoQaeQwFPi3smu8kn58E0x9PH2XJ4vpSPyfpP
         HXVADMa0YT7LKH8iApebr2rpwRnxi0LnXJ6erHh20Krb3K24i3I4tgHFeURq+mxyHe2i
         RxZKGuFwGKnGqIsK53t+tX81zXzseufwRzVbiEyYgUa7zBS9pad922AS7SWDk2NLvhEY
         DsbnBh4BNT5tpiBsEM8dbbvMII45Fvo+R9RnCe44Yyt7OpZ123ErdMn8slsCqd+HYl+X
         EvTwCUCNZcHSb0ppZs+Ik9dvMmnoNC0Of7EOMTWk0D10Cz/dVEVh6M9zpSbGlEallG8H
         o36A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1779146584; x=1779751384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whXJS7vOoJNpViQnsykoSQi+3tpMsWSRBjO6ajJAbGg=;
        b=def7eKdt7Gh7glxtnfZ5Cc1HaYw8eiAWU8bfVnk5d6ZAsUrqUQSPqITUziDA/mY+vS
         SmbYiPdc4t5+XZS+bN9qi/CV+hmCsbLTmBeiTQhzZTrZnh4vpd1254IJNtHaPyeYitj5
         G9vJGq411pvSeSu1mDYYKr6ur3Cnm+zSnMDZ9IVjTyl7i+gi9ewY3/z0HxnCcoBq/HSg
         uDEIqOed4Z4por91il98FIJmP5mVAe4UdIMNBlf5k61azk7buH9Gmj+g6XYnmPg3nPcT
         Kz9dFqhR9sXmr0R7y1AAd6/Hj0qc55PZIKvDkiVNDZ4SA0sZBVdtNceImG03ZyU9m7AE
         Cl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779146584; x=1779751384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=whXJS7vOoJNpViQnsykoSQi+3tpMsWSRBjO6ajJAbGg=;
        b=PrXXxrh8GXX/W2TlMWe2zML59F/HWtUujJ+3slWKkeeNcQbxzD/PPQQGp88c3VHOZW
         3RYwmo00KGrtIBC7J1EviGgXYWWn1M+l6o8nHW9zdzJ8j0Z3GnIceKZFogyADoFk+nzj
         7Soyo5OF6u5j7Px/+LScEDYfpBx/m/pCFq9XCsZxZ/9cht3Cpf21PI1ymR/Ijfqd2p3K
         wKBhGw1ADQveOMiIq1YURCxWKDEbe7W13C37qItxLrl1p9NU21HJws8dT6PGhAK0Qa6s
         L9Zrqqq9JQ9FZcTY0Z1K1VsTWZO9ININU5bYCSSvOUz0c9mlQ++wrXhCR9QDnbJWJjJR
         Ting==
X-Forwarded-Encrypted: i=1; AFNElJ/c9E4OcX8oEoLZMl26rEB/Yo72OPzaJzrvyPj9X2PRctM19aVLspjZoJ0W2z0bVLbZu8Mf+MJ/HsH3HB3pWuMV+TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW6bb7rAnRsqksrLRwiQd/8kxdDvfJzNMNvec8NIB4RA0TXV99
	Bkaz9PynPCDYjjwNxhNQBclsArut0E7a2MTO5bclIHK8KCctbLrZmi3VT4azSoWe/+3jnkCyoF3
	BrbVxV64uqfWVC4aWd1G/RjCjnlAf91CHSQcRC5OkWg==
X-Gm-Gg: Acq92OHtii5RpdpHuD6reUN+9mDo3F6svjZqeP6frTByjZ5NwXzjRL3ML7wwje2rz7f
	40YB4oWCIczL8o+GMsnTrBD7UGy/6IbqK7EU7NjKb/LPgyzyRNJM1NdTibGH/X7siqIaTzGswWf
	cvbiGkLIitanQs0xhZ1Mx8MIV/lLtnu0yG0Tlhx2e1WqnE74vavZrVvsOf9qwi+BcC4A5qv19sm
	s9tMOMRekAEdK6YVkGTIPYUq+eKCRf3ySVnXx2eVJFhM+qhjo5Xc4v+jOYqGRRXvdZ+wxLNzo5P
	tiNiwhi1/ECODhApup1r
X-Received: by 2002:a05:690e:d4c:b0:651:bacc:77c with SMTP id
 956f58d0204a3-65e227046a4mr14553366d50.26.1779146584210; Mon, 18 May 2026
 16:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515135946.2238888-1-vineeth@bitbyteword.org>
 <9fde73e7-0108-48d7-a1a0-ccc9776beb5c@acm.org> <20260515145048.1c021bc9@gandalf.local.home>
 <ebdc020e-419d-458a-9211-36f22af0c1d9@acm.org>
In-Reply-To: <ebdc020e-419d-458a-9211-36f22af0c1d9@acm.org>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 18 May 2026 19:22:53 -0400
X-Gm-Features: AVHnY4J2BTXARqZMS-S-7ea43B88qOe7-XZuDC_7_fnPjVKwEJzab2MdP2OY_Cg
Message-ID: <CAO7JXPhMTKpC_8e-C8M13wdqrC3Re6Ad_DqkzGjKrVuH8YNh8g@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] scsi: ufs: Use trace_call__##name() at guarded
 tracepoint call sites
To: Bart Van Assche <bvanassche@acm.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 3:22=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 5/15/26 11:50 AM, Steven Rostedt wrote:
> > On Fri, 15 May 2026 08:27:27 -0700
> > Bart Van Assche <bvanassche@acm.org> wrote:
> >
> >> On 5/15/26 6:59 AM, Vineeth Pillai (Google) wrote:
> >>>    static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba,
> >>> @@ -432,8 +432,8 @@ static void ufshcd_add_query_upiu_trace(struct uf=
s_hba *hba,
> >>>     if (!trace_ufshcd_upiu_enabled())
> >>>             return;
> >>>
> >>> -   trace_ufshcd_upiu(hba, str_t, &rq_rsp->header,
> >>> -                     &rq_rsp->qr, UFS_TSF_OSF);
> >>> +   trace_call__ufshcd_upiu(hba, str_t, &rq_rsp->header,
> >>> +                          &rq_rsp->qr, UFS_TSF_OSF);
> >>>    }
> >>
> >> Instead of making this change, please remove the
> >> trace_ufshcd_upiu_enabled() call because it is redundant.
> >
> > You mean to remove the ufshcd_add_query_upiu_trace() function and just =
use
> > a tracepoint where it is called?
>
> That would be even better.
>
Will do.

> >>>    static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned=
 int tag,
> >>> @@ -445,15 +445,15 @@ static void ufshcd_add_tm_upiu_trace(struct ufs=
_hba *hba, unsigned int tag,
> >>>             return;
> >>>
> >>>     if (str_t =3D=3D UFS_TM_SEND)
> >>> -           trace_ufshcd_upiu(hba, str_t,
> >>> -                             &descp->upiu_req.req_header,
> >>> -                             &descp->upiu_req.input_param1,
> >>> -                             UFS_TSF_TM_INPUT);
> >>> +           trace_call__ufshcd_upiu(hba, str_t,
> >>> +                                   &descp->upiu_req.req_header,
> >>> +                                   &descp->upiu_req.input_param1,
> >>> +                                   UFS_TSF_TM_INPUT);
> >>>     else
> >>> -           trace_ufshcd_upiu(hba, str_t,
> >>> -                             &descp->upiu_rsp.rsp_header,
> >>> -                             &descp->upiu_rsp.output_param1,
> >>> -                             UFS_TSF_TM_OUTPUT);
> >>> +           trace_call__ufshcd_upiu(hba, str_t,
> >>> +                                   &descp->upiu_rsp.rsp_header,
> >>> +                                   &descp->upiu_rsp.output_param1,
> >>> +                                   UFS_TSF_TM_OUTPUT);
> >>>    }
> >>
> >> Same comment here: I think it would be better to remove the
> >> trace_ufshcd_upiu_enabled() call rather than
> >> changing trace_ufshcd_upiu() into trace_call__ufshcd_upiu().
> >
> > Well, removing it here would mean placing the if (str =3D=3D UFS_TM_SEN=
D) into
> > the code and processing it even when tracing is disabled. With the
> > trace_*_enabled() helper, it's all a nop.
>
> The ufshcd_add_tm_upiu_trace() function is only called from the UFS
> error handler and hence is not performance sensitive. The execution of
> an additional if-test in this function is not a concern at all.
>
Sure, I shall change this.

Thanks,
Vineeth
