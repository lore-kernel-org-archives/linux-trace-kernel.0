Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132DA29CE6
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412597; cv=none; b=HdFOQx5CIWZTcsKNRflrPPwIdgRokgePPOM7tUk25SMk3cnOTcmeNYJlbpGhMzWZZTZMJhqOdzxA+TqK/oq5/O1WKxnCkaUfeVbhj2kQDIMx+Wz6fltwFH+baUxKlgeS9EXqraOHLjOQOK5rGHeZcXeXrcxGPBQNxRyFr6GUSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412597; c=relaxed/simple;
	bh=l+M4Y/o1H8Mcv1YNx9VuHR1Yf1uCiW690U8nQKGjsgM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5gwRIzBP+JmMasStGvsgbpc7DnPOVZywEDbWiqmlhzjCV6qUzb1nb8IEapAe+++hwGGaTgPcHu4CRWFabDKRudLv8ne8wa8J3d7NQHTM3nNES+tt2SvlrLllhLJny5z67QvXBlpm96AsUnakTzP/jpwwddg3qSRvwAR+p2B5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyXyZo2y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyXyZo2y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754412594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+M4Y/o1H8Mcv1YNx9VuHR1Yf1uCiW690U8nQKGjsgM=;
	b=dyXyZo2y37rFNBPLMz5hhKS1VPg0LZQTqAbeKMaW8k8jMPmXvXqZe8RRBCGZ2+UX/cU5Y6
	2XzXZJXdshwk/lyYxiu2Tt59iS1C7V+ySboRPHvOfFOUH8X//SqharRbqmrciW9yggkRLh
	+/vp1e/XM0yA9sQkT/UZQ5GDjcYQ7N0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-ChrKi4DOPiWb151jRBoL7w-1; Tue, 05 Aug 2025 12:49:53 -0400
X-MC-Unique: ChrKi4DOPiWb151jRBoL7w-1
X-Mimecast-MFC-AGG-ID: ChrKi4DOPiWb151jRBoL7w_1754412593
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e40c0ffb1bso45239965ab.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754412593; x=1755017393;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+M4Y/o1H8Mcv1YNx9VuHR1Yf1uCiW690U8nQKGjsgM=;
        b=VtUwaDm3P1akDUvLTLPIJQADPhORGEoidsK+bbw+LWeH8EZnon7Ownmv4zlMGls0YY
         aAIPxFV/S9UM6HpTRHXDbIibVtaB6dUGKhJ86ThiyJkgX82ow3yJIrmeNaFwY1Jy+Dqv
         X8QC897DLYP5wYcy5ACMrGUwVkNArSUXVppIkdv2ImvBuHKFWu3QPWSbrGU1H1f+IwjU
         VaPYgxqxnadj+TO80m4kCAN7hlq+/4tkTQM86bEkDPgHM41th1e58HSR2T7hK3E651ok
         ftE+UWwveCpVeap2to9rlq3jr2f9lw22caJ4Ho7r8qIjQvNWuMkYBV/pTGwg/DuYDZj2
         hYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV57hI/F6vsVToZKow+0LkmZT9/ZnLV0H1W/BPukBoQpSqjbCGSohOpG51TAl6srHFkqSgnWxbqozlbqEnTrQSV9ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YySm4XHiXU2/3T2TGXANoTaqYluK5RGrrE4iW81AdbItDNgjF0N
	TxrNZ0CYRKJ09ob6T5FkEr5pcRls1TdbS1fOeGyGHNZ+IKmvrcTDPjAerVDD+wqwTLyD24FSjN+
	Xey3+RRrerFhtdOBSzlG6uTYbDCphNHTA6lHIMwArM27kxZaH/tsBwqlqbCT/Nc7cDTgR4X2nZQ
	==
X-Gm-Gg: ASbGnctD/9FJWoLP5QYrnynb2J5D6hAt7llP3wCTGws+U2u4qD3Op0PdySj7tG/7hFa
	1gj59aPip5gGn6hHHMh4SqBJxkuAqPxNbzC2GSfHyWV61JPavy7FhXlXDqP+f5n2r++DQk1q9RJ
	OSEdo7oWOM+VaFo1ttO99/8gVeWvfbMrfzl47Qs6jyCSH9q1ehkvmBb8911NjxP5DoIlCAl0sae
	opJ1e555EtqFNDFad+cH2rgTGEDy9H6Ar0Zw8vX9bMb8KF4iePenDDUWYMJDFPnX0q2JgVQq1Vt
	Vei5imy2MYi6TqNbJ1jRtTihN1tl5Tj/A7WLqjBzjt5/SZXBp+eGoyy/eqJGBs97pU9b9Pw=
X-Received: by 2002:a05:6e02:b:b0:3e2:aafc:a7f with SMTP id e9e14a558f8ab-3e416122d83mr293423255ab.7.1754412593018;
        Tue, 05 Aug 2025 09:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkPZOoL5lfzhmEQ9P7S/kqjcyKFzOgHwdkMcJAPTqhlbXfksERnKXCLEw+tCLYbmu/SFyNjw==
X-Received: by 2002:a05:6e02:b:b0:3e2:aafc:a7f with SMTP id e9e14a558f8ab-3e416122d83mr293422335ab.7.1754412592444;
        Tue, 05 Aug 2025 09:49:52 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55d5da1csm4057918173.65.2025.08.05.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:49:52 -0700 (PDT)
Message-ID: <540bd149b88a543e306762fbf00c366a4f9670ce.camel@redhat.com>
Subject: Re: [PATCH v2] tools/rtla: Consolidate common parameters into
 shared structure
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
  John Kacur <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, Dan
 Carpenter <dan.carpenter@linaro.org>,  Jan Stancek <jstancek@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Date: Tue, 05 Aug 2025 11:49:50 -0500
In-Reply-To: <CADDUTFzWBkrKx6=fOMXp=y5cyecOvWLx5jZG6m3BMTAvL067Wg@mail.gmail.com>
References: <20250726072455.289445-1-costa.shul@redhat.com>
	 <0faa958ef9cc4b834a5ecdc92acd89520f522d44.camel@redhat.com>
	 <CADDUTFzWBkrKx6=fOMXp=y5cyecOvWLx5jZG6m3BMTAvL067Wg@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: esLKtT2NI_yJ3Jo_owGyURxJqr-5vxiV0v3Rd7nT4iQ_1754412593
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-08-05 at 10:03 +0300, Costa Shulyupin wrote:
> On Mon, 4 Aug 2025 at 21:18, Crystal Wood <crwood@redhat.com> wrote:
> > If you want, I could rebase that on this and use container_of() to for =
tool-
> > specific params... but then that adds complexity with the top and hist-
> > specific params, most of which are common between timerlat and osnoise
> > (and not merged by this patch).
> I=E2=80=99d appreciate it if you could rebase your patchset on top of thi=
s one.

OK.

> This patch is just the first; I=E2=80=99ve intentionally kept it minimal =
to
> ease integration.
> My goal is to refactor rtla and submit a series of follow-up patches
> to reduce code duplication.

I have consolidation patches that are just about ready to submit; I'll
try to get them polished and pushed soon.

> So we might want to just keep it simple with one big struct.
> This is a god object anti-pattern.

I know, but I was trying to weigh that against pragmatism and churn
reduction, at least for an initial refactoring -- particularly given
that my motivation was to make it easier to make a timerlat-specific
feature work on osnoise as well.

-Crystal

