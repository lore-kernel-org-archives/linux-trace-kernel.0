Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4F722688C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Jun 2025 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748991135; cv=none; b=oFH/jxZMWe2s10xRPauKrtj0Vtqmk5CZBq9OfhpZJo1Y8yEvlAkeThcHzWbzwbks3cRBjyxtjrUNqWjbOZUU2ABbvv0cXtQuRxKPHs8sxdrDAb5DcyQ7Yr95KKnEE035SdSpafqTLrILuEqvr4KdmE93FoEpp9SqoOldgT7tH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748991135; c=relaxed/simple;
	bh=rBJESAen2/336gzkRJUKRf4MYNXtUStN64nk0QAbCAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGsSQQtRL6BvvKVl52Bxa4JQ+1oBO2JWeb1D+QySaknlFqK1GMaaShwQDv1LdZQrMa6TsQ/AwNSDMWT9Sw1iCErCGb+6B+p48dZ9LU8ebHIH23b0OjCq4ahEyi5ezd+hypPsT7YMni/d6BlrRtYClb1ObL5tYhOsoZeQBmF5tTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=qHbA2fdT; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="qHbA2fdT"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553MjFtg023362
	for <linux-trace-kernel@vger.kernel.org>; Tue, 3 Jun 2025 18:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=FVSotnmnXR4SmQn/DBaX0Q1rjfCHRW+1YsxRp5tC60E=;
 b=qHbA2fdTqJRkHHzntkOvbjSmKGwK5HZAlnEIAuNyeR9jJ/l/r7czeTHSx8mReqcKF2G6
 HUGIhFkx/pI5+pHOVBiwEjszLVhJXkMAMqpgb4b2WFwagJNotYgkSvq1OH3y4GJYbVng
 OCwWLYWVPLujFS70cXRH3QbRmIxTo+G0y6chgb5qhDSkDUHOgjdm0DUuV6D+2reP44ar
 q0fXjdlW3zNceJGWplmOUlS7JDxAWupomwQbHeay78yaO+L77gYNZIz2ficzuvQnRkCY
 WrKHq+PjZ2lN/VkrzMrTlLjAF/sbwWAaX5nYHu+QJsIvGNC9Q6p8ICDkd8SHWdU7lAgT tA== 
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 471fu7v6rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Jun 2025 18:52:13 -0400
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-70e74da64f0so92060937b3.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Jun 2025 15:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748991132; x=1749595932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVSotnmnXR4SmQn/DBaX0Q1rjfCHRW+1YsxRp5tC60E=;
        b=i6xdr/n2P9BBDnzd2hfwvHT7/5dYYlKRf1ZxEXe8lXnnLnBNUUIgkkxTNYSGbrGGRg
         Jx6VT3ST53YONKpLY3LhDhB1gTX0ge8WFuiEUhuyqzboPPGw20t8+oTRBYcdq44avYw9
         ZExkgW6sPRAAAbheWgH7DxTZdbW3+jqmdxU5GGnaZN1iYs47ErYHKcrV1I/0br2qQg5V
         dgra9lOVjW2xAolggFmPHy9Vx+JbVG6qvnCAnraEG9RfwOxpKviSA5PPCdl1Xu1heFKg
         AARdceGc8g5ptqsGkKmTI4IGGl3QztLUO4NWogcRyUtk4ojMvnNv5MOdSVAX43hSeGDA
         ryIA==
X-Forwarded-Encrypted: i=1; AJvYcCVbZgqi/By2bFE1h1h7J70I7BMy4QZs87pGf8NDp81S3O8RRgVNCdRSRTQuRADjivyzVLOZmAYCQeZ1k6k4vFP8/L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyvCzVOdL2AI6IUG1W4P7OFS/e1g14eA1vxLCWDs0qqWqfNW6b
	rRTBtGkzWFIKcjBeRmqn9l3swBDp0LXU8KzTHUzL7i2oL00+kOTNuSkNhZM5eYBhL2zW0QekbPO
	JDnc3Mxz6KvLT+YD8E8WZckt8yeyHlKSGaNIP4RauGWx3dkq2SR+4SKt/UPX/7/fGH/Um3Cr5Hx
	jFf6LalNMM0smmZBynR1qKnMqGsV1Ts6g3qdDG8mIzpyRY
X-Gm-Gg: ASbGncv+rPIKesSGXi2cOpqPnBVp3pJgAd9Obkcn17scgJE1zB5ioqugt1rC9Ftw00d
	vEJtQ26lBpGYpjXnXRGBUBeVve4Z63kujYyBgifT5CVHHPnlQvDW4EHZlv7+t65otmT+E
X-Received: by 2002:a05:690c:6408:b0:70e:86a:ae1e with SMTP id 00721157ae682-710d9afcef2mr8600747b3.22.1748991131959;
        Tue, 03 Jun 2025 15:52:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ8exRmH1gDSzLvdylKgTYA2DJ2Au5CkYn+G3oI2WkdeKhka06CmsxC9VBY8GcCo46KqJfEvgUwE5AP+avdh0=
X-Received: by 2002:a05:690c:6408:b0:70e:86a:ae1e with SMTP id
 00721157ae682-710d9afcef2mr8600477b3.22.1748991131612; Tue, 03 Jun 2025
 15:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu> <ce048e11-f79d-44a6-bacc-46e1ebc34b24@redhat.com>
In-Reply-To: <ce048e11-f79d-44a6-bacc-46e1ebc34b24@redhat.com>
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 3 Jun 2025 18:52:01 -0400
X-Gm-Features: AX0GCFvlcvk6GZ5vr9c9WM9ggD6hEwhQPwTxd6NWVo7g3KskF8CKB6yJVu2Zysw
Message-ID: <CAKha_sp8xoB3nYjot0_iZvE3UT1KQgWJ2BynoxUy-=_y1mhqZg@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86, mm: minor tlb_flush tracepoint adjustments
To: David Hildenbrand <david@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        x86@kernel.org, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: el6ziM0AdZDVeh-WtikLxDczR4aBG3GR
X-Proofpoint-ORIG-GUID: el6ziM0AdZDVeh-WtikLxDczR4aBG3GR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE5NyBTYWx0ZWRfX5XxRUbu43R3F bb0ki1IO5t5CV0kPSKNSfF7c9u3YnYi3m7BdVRJLVJn6sbi0r/Ej3XNNLXaNIfgkwig+peE217N BWL52NUBeLtGD3TDJD1hTf59yegeNncZC7TyBVg3aqC2GyhvCenp9p8Shen6RhdQ/1achOCg++J
 1mYaZeM/Z83GKtr7NziYLFYU3WjC8c1aLawcCDr/APuRrlbyYSv+jT34bKMj86vPUeAKICTFrWz H6k4R2ZO9DT1ZxqQdl/9qUmoVAIbPWVmKDs1C8JWqaxSrXGG9oE2BVGozwbUr3LyGL/ZqdyIc6Q YNrqesYE5FU9zT9/Xns+ckBA3yld+Ahy+KWlV4OfdL97g3MBDlenMwtQpse2BrOQT01yONAVSwF KXeIFhmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=10
 mlxscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=811
 phishscore=0 lowpriorityscore=10 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506030197

Sent a patch here:
https://lore.kernel.org/linux-mm/20250603-tlb-maintainers-v1-1-726d193c6693=
@columbia.edu/

Thanks!

On Wed, May 28, 2025 at 5:09=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 28.=E2=80=8A05.=E2=80=8A25 07:=E2=80=8A35, Tal Zussman wrote: > One mi=
nor fix and one minor cleanup related to the tlb_flush tracepoint. > > As a=
n aside, include/trace/events/tlb.=E2=80=8Ah isn't covered by MAINTAINERS, =
> along with other mm related files under
> ZjQcmQRYFpfptBannerStart
> This Message Is From an External Sender
> This message came from outside your organization.
>
> ZjQcmQRYFpfptBannerEnd
>
> On 28.05.25 07:35, Tal Zussman wrote:
> > One minor fix and one minor cleanup related to the tlb_flush tracepoint=
.
> >
> > As an aside, include/trace/events/tlb.h isn't covered by MAINTAINERS,
> > along with other mm related files under include/trace/events/. Flagging
> > this since I see there's a recent effort to overhaul the mm MAINTAINERS
> > entries.
>
> Thanks for pointing that out.
>
> It should likely go under "MMU GATHER AND TLB INVALIDATION"
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0ecc6063b2b5e..0e88ea5de5b73 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16509,6 +16509,7 @@ L:      linux-mm@kvack.org
>   S:     Maintained
>   F:     arch/*/include/asm/tlb.h
>   F:     include/asm-generic/tlb.h
> +F:     include/trace/events/tlb.h
>   F:     mm/mmu_gather.c
>
>   MN88472 MEDIA DRIVER
>
>
> --
> Cheers,
>
> David / dhildenb
>
