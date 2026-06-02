Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05633C73EC
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405025; cv=none; b=D7bf9U5okqR8wVyS8IbUk25vGBeZSp+Hnty7hqxGM3yZJEPwZmhRObrKx7IeUFsiPvYpIRPKBI03HPauJ+Ue/Qz27OiF1D+xVJLW/Qf8KOr9QmIa3gG9yyu2P1UUpZILB7eniHJrqQW/99CXRoVFSS1WgnXfIAf3QtOhBkh6UOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405025; c=relaxed/simple;
	bh=5qE0Q1N/cId0h6aXQKvCM93HNK3/YpWoqZH8mWBRn+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1kYHChWAAPy6Yo/hBPmQkUHvT34NypVTu7pWx1jk9I0yj8nx5yt2uGxdHg510Kl6NFCMIAR/c4XwKZskRkhSh5b7AeOR8eFiIffXIASPEph4sZw571v2cIIym/5fctWtidwoU0GAQRLRHgELkE9an3N0Z2YUImEmgVruNLXxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHz+rWfU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHz+rWfU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780405023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URY0btRgkwomK/7pXdQ7v1MqV+4Gsz0Ayn6nxrLoLfY=;
	b=OHz+rWfUrg9xsvuRyK2HIkDIoVodJ/zm5EGhiWUTTC9Ju5ZespGxlXloRgKRCks6kOfZRN
	cOQXj0ladlu5CKO1p0IKTUvxXmX2qh5yiOy/P2IaIUbF8K5TgD7bgyvDd2Cj9xSdJBaKsB
	mEZO0UzO0ADuQd2POgYUweQvFTXTEdI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-oZRAP_a9NpCBjnBCj1UBeg-1; Tue, 02 Jun 2026 08:57:01 -0400
X-MC-Unique: oZRAP_a9NpCBjnBCj1UBeg-1
X-Mimecast-MFC-AGG-ID: oZRAP_a9NpCBjnBCj1UBeg_1780405021
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bec440e6b9fso89030966b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 05:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405021; x=1781009821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=URY0btRgkwomK/7pXdQ7v1MqV+4Gsz0Ayn6nxrLoLfY=;
        b=V0qo1AUAXfEBHIWjFod0g7S5N5vOtGLCdVLd6u5pEYgumKNcEsqE4nMF6Pz5AWxwIP
         UrtNsSboFpb+CEka7qCQ2HHjJAJKAnj5loyuaHTKk9isGpSxHwMcc91wS2i51eB/B1Rx
         ToqtWcrTPYSUtZm2wXph4wxGpgLsL7hyO7PgI1StUoHhpKn1CzYBALqgcxLmD36WC5qH
         nTrE3Rk2j+WptouCl0nuqgH2y7Bk1PwOETx06t+mZF3xyKNsb7yi52RNp79bynQ/pqyR
         VbnDr4q98Y9sNRSZI1Ziw7vTDJJMiNvwN9efqWfbQLDHqsUndHKDGUgHsYzHeCWcqMun
         CvHg==
X-Forwarded-Encrypted: i=1; AFNElJ+/r4e8nTn4iqmrpttf9wqle/SNh+m3Yh5Yib8j3mhdybmPPvcjlb4uiSMCRhsJqW455IhQOR7FjUPDVy4Bj6ve+3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxapZvKsFh/iHhx77G/p28Mbm3qZPq9d9YDY/8DXNgDYycDfQrs
	saOYzS6eA1LiJTgYzQoz4Im5atpwJUfxx4RHiVyHLtz7im1rXNLw6QM/A/Gf4o/0YUqUtS2KO08
	Dbx7xuJxZzYAf04V9WfP20v4JDy//zWxOQ8HJjblVpZuVW0/8sqTniVmxZBoLz2czfq34p49uMB
	8m9L8ySfg00ZanqnhzDZ/8JBS3bbdnBxeKSMH7kb6U+Sr28K/Z
X-Gm-Gg: Acq92OGFDwK4DVOmIJ2yP67vzYvyEb+tv6gzRBSUSZCdpJMM1xf+IIdJ5dIABZly+QU
	6suk+avJ3MWQhH94dDbi9xPKIcibaU2Egy76NscLPibL4umnr66YrEpYZSykBIw8OmB3VEhRWSc
	ZyT+C7hzg6KZAAy+jmr1o1rAJScoPF5sqwR0ORquKIx3QCEMh6rH4XUg/nbg8f7n5juWScxC+SP
	J7pZFN87IPlBwM0
X-Received: by 2002:a17:907:d9e:b0:bd5:3ccd:557a with SMTP id a640c23a62f3a-beab38566aamr904460166b.42.1780405020684;
        Tue, 02 Jun 2026 05:57:00 -0700 (PDT)
X-Received: by 2002:a17:907:d9e:b0:bd5:3ccd:557a with SMTP id
 a640c23a62f3a-beab38566aamr904457666b.42.1780405020269; Tue, 02 Jun 2026
 05:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602125506.3325345-1-tglozar@redhat.com>
In-Reply-To: <20260602125506.3325345-1-tglozar@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 2 Jun 2026 14:56:49 +0200
X-Gm-Features: AVHnY4Jg3XVsZedgoTQLmF_qteXz42C-bUmhplmcXOFtV9C_OlTB3MkplM0PhEc
Message-ID: <CAP4=nvRpchSbV+1f84XznsqkcoM=VLW8HUH+PzrwNsXFfQ1yNw@mail.gmail.com>
Subject: Re: [PATCH] rtla: Fix parsing of multi-character short options
To: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qlODD2t4x5_aBNYWcBIT7BgkOJxPcQARrafX_68tLaA_1780405021
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 2. 6. 2026 v 14:55 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com=
> napsal:
>
> A bug was reported where the parsing of multi-character short options,
> be it a short option with an argument specified without space (e.g.
> "-p100") or multiple short options in one argument (e.g. -un), ignores
> options specific to individual tools.
>
> Furthermore, if the rest of the option is supposed to be an argument, it
> gets reinterpreted as a string of options. For example, -p100 gets
> interpreted as -100, which is due to hackish implementation read as
> --no-thread --no-irq --no-irq with timerlat hist, causing rtla to error
> out:
>
> $ rtla timerlat hist -p100
> no-irq and no-thread set, there is nothing to do here
>
> This behavior is caused by getopt_long() being called twice on each
> argument, once in common_parse_options(), once in [tool]_parse_args():
>
> - common_parse_options() calls getopt_long() with an array of options
>   common for all rtla tools, while suppressing errors (opterr =3D 0).
> - If the option fails to parse, common_parse_options() returns 0.
> - If 0 is returned from common_parse_options(), [tool]_parse_args()
>   calls getopt_long() again, with its own set of options.
>
> * [tool] means one of {osnoise,timerlat}_{top,hist}
>
> At least in glibc, getopt_long() increments its internal nextchar
> variable even if the option is not recognized. That means that in the
> case of "-p100", common_parse_options() sets nextchar pointing to '1',
> and timerlat_hist_parse_args() sees '1', not 'p'; the same then repeats
> for the first and second '0'.
>
> As there is no way to restore the correct internal state of
> getopt_long() reliably, fix the issue by merging the common options back
> to the longopt array and option string of the [tool]_parse_args()
> functions using a macro; only the switch part is left in the original
> function, which is renamed to set_common_option().
>
> Fixes: 850cd24cb6d6 ("tools/rtla: Add common_parse_options()")
> Reported-by: John Kacur <jkacur@redhat.com>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---

Forgot to add note to the original email: This fix is only for 7.1,
7.0 needs tweaking of the commit, 7.2 will remove the command line
parsing logic entirely and replace it with libsubcmd, where this
works.

Tomas

