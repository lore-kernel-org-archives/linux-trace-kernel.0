Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5E1EEF9
	for <linux-trace-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299884; cv=none; b=tFJs4Y6rRXsC+IHDDUxsDsEnDAO2iTQFRpr4AcK9ky+N9wnZlEaEOaAnub4XumEipVN6Jsl///YBGqF53i5ZpX5rMzHXEFhxO1UrYwB71rS8fZMMo4pa/2+eRUI8JOKwRm+5N9A34ULyyq6lfIghRvILdLHDvQ6qUwvbhpy2fgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299884; c=relaxed/simple;
	bh=JjbB3Jm5B9RQihNCMKSK+B8I5hhLMbxQKcU07xlJc6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCv+rs4o2DT1KQ1we7F/JyW0u1u/dVrix+o72Ii0w7nCaxNl6ZHLC+12hFxvYtb+M1qnUBvTDUsASwJt7H+/WUPbKFXioXBAqZ8dTg7OZapV/AwVuZV3k++wySuxSODWVy+M4F9hR5f18ii70USBmfGouSK/ZK/xETYNAPIXNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Qo9K6/RH; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Qo9K6/RH"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748g7Sk013632
	for <linux-trace-kernel@vger.kernel.org>; Mon, 4 Aug 2025 05:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=JjbB
	3Jm5B9RQihNCMKSK+B8I5hhLMbxQKcU07xlJc6o=; b=Qo9K6/RHGpbdoHXEsTCC
	4lgHR38vJx6A/fYq+9r70zqU8KQ5BWR4s8qkP5owJN1Rzx2AGT81eNV7YmuXKB2Z
	NFkCuuDF/AuBdAnf6/d2LyWRtzjsvZVVUp1ukSItfRwYe2wWSqzJDUsUL3toXqj+
	xaS2jVayqJ2lMP1lZKJ+8bwaLcbKjwOXoYkQR1Wax3Zd7RTcAxMZrk1D0Ule9e8B
	6qf072uYGmDZ9kWtdbJ7vB7d0WV4iFeSuDhEKcm8wSdtCdSfUfwDaSxIDEkF9Mlp
	YNnsEgk5XoFKttCFX8i9vob5+gMVKBB4z24F3leGupjciyntk6mbnWqpJBsFDPA3
	LQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 489er31979-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:15:45 -0400 (EDT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-707cf1b0ecbso55708107b3.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298944; x=1754903744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjbB3Jm5B9RQihNCMKSK+B8I5hhLMbxQKcU07xlJc6o=;
        b=azahbRB99LaLQa9Mhlnditq90ImHfRAs56VZ4us3pSAOcJ/lE7mjn+dxw5O3rOq84e
         9GAmq42J43gi4GfxTgoBdBHVT7AnWN7G3PoYfm601Bm6kxgOXjOoOhC7OeDI//jerc9U
         n06uwCQ8kwkyEqGW/ssCFdoGiohKfsW5JmfYD5jYwYKvROvAi1wx6OAV/E2XFZtu953P
         3Z8Gm5vIjiH/LJhldbicP62fvC3TTIYAQU/6C7RyL+GhGDtVBqTzSx2bYf4WtkyodJZ+
         tvvbXdE12N+gsK13IRLSH6QrHTnn3kjmSaTxXiJeR8RUfU0hiPC8OxsXbRbzZnOYHXUi
         NAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzEFLfdCdeUvxhRqIfZN+nVZqxL6Ax4Ivku+6ao/6d42lq7ykSEDphfw6cM1qB9ldnHmkLkwc+f2DrtNfKEPvy0Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwNkShO0D/uIfZmSDpUQ1KTojO/5XCA6LGXv5dr3PsRxX6bZTv
	6Abfc+V3L1T1dfdZGO14YGB6sTxdWTWU0JgWhaEX408IAP9TBiiFnnL7nhYLqAiaoaY/wJc977d
	hYp+kgWYQuzvxLmQey5RihpSUgAZtsbW002gjQb2tBYfJ72CDnhqsGqrWF0oaS7J9OyKNNNTUsh
	RA2vul6/rPUps5K/PX0D53VRHDozIUJ8LHw3aurF47OhMN
X-Gm-Gg: ASbGncu7P6TsHod7XcfxeW9v5DOXtjavn+OESuHsq88/cpBP29KQ8P6wu1IhGeYAU7O
	x/3LeCK7ZVJJQwA6h5yktFXZmKcPPJw3uaWH3ly/uWM6xAQCSqxYaRAWH+HIVDb1W1f0j0qwJvf
	ZX6SM4stF7c9Px04/kH9VQ
X-Received: by 2002:a05:690c:4609:b0:719:53fd:79aa with SMTP id 00721157ae682-71b7f84a212mr77213127b3.22.1754298943861;
        Mon, 04 Aug 2025 02:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+UZiZI74WScdHweh6AGanV37GHLhD9Nzf23TmEE2bGp8nqgrqm6GaV8J3VbW+KzNd4CNom3Wtj+ghqdeWtRM=
X-Received: by 2002:a05:690c:4609:b0:719:53fd:79aa with SMTP id
 00721157ae682-71b7f84a212mr77212667b3.22.1754298943210; Mon, 04 Aug 2025
 02:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu> <CAKha_srZTXfQkizBzvrdpWs6Txw2PSgRAqT6QC8gom=PaitYNg@mail.gmail.com>
In-Reply-To: <CAKha_srZTXfQkizBzvrdpWs6Txw2PSgRAqT6QC8gom=PaitYNg@mail.gmail.com>
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 4 Aug 2025 12:15:32 +0300
X-Gm-Features: Ac12FXwhQmrmOOkID7nOJYCapFm0MAKFQQ0J4rVnNl_CTjL5U175u7m4uf07P64
Message-ID: <CAKha_soQ7VUvHk7cz0SmX8_GYdWS3nrPm-e2NyU=AH1qXiKqgQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86, mm: minor tlb_flush tracepoint adjustments
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA0OSBTYWx0ZWRfX3Rpfk2iYuCbd
 NGwsfYghUIRmJiBhO4A07OVXMWLqAFQ/HkpQjF+2nT05zCYA8SrKvUxHtuqJV8bmCPDXBUf1HC8
 uSmbQAgq3LWpy0IYkUWdfMcMvMzXk6jhu2Hun8zMAFUvog4u9EetqzldszuRXrNUS1OG3k9zfKJ
 0+vEYvXaFkBdxHXNqOlK0tLRk5b6yAWk7KcEklmzdwDq24EPSqY79mcsVrb8jzJMZiW/rlRQ8Qq
 Cd5lLzys19drTIe5VFcLIb9Kjdc8tn0DO5uJ+5AOCluMZW+c8u/9EcZK0GqPSTO5xILq/JFz/6l
 xtpUdTyYmzxR9WXpeEpmExe+CsMr87ozGYjwMcLx7aGO0ia5NRXXekEb5l4zdHnZrjrYEmE3g5/
 V3CgspOG
X-Proofpoint-ORIG-GUID: _Ymkr75vJyW2sfENWQhvlNOIshs8HRYY
X-Proofpoint-GUID: _Ymkr75vJyW2sfENWQhvlNOIshs8HRYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=787 phishscore=0 bulkscore=10 clxscore=1015
 impostorscore=0 lowpriorityscore=10 priorityscore=1501 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2505280000 definitions=main-2508040049

Hi Andrew,

On Tue, Jun 17, 2025 at 11:43=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> =
wrote:
>
> On Wed, May 28, 2025 at 1:35=E2=80=AFAM Tal Zussman <tz2294@columbia.edu>=
 wrote:
> >
> > One minor fix and one minor cleanup related to the tlb_flush tracepoint=
.
> >
> > As an aside, include/trace/events/tlb.h isn't covered by MAINTAINERS,
> > along with other mm related files under include/trace/events/. Flagging
> > this since I see there's a recent effort to overhaul the mm MAINTAINERS
> > entries.
> >
> > It's been a while since I've submitted patches to the mailing list --
> > please let me know if anything looks off. Thanks!
>
> I don't see this series in any of the mm trees -- anything else that need=
s to be
> done to get this in?

Just wanted to follow up on this, as it seems like this series missed the
-mm branches for 6.17.

Thanks,
Tal
