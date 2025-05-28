Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC02135AD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748413689; cv=none; b=R4lh3hmrevcpXMQ+eYw02M6psUzu0GUdknsxZGVYrM89GYy7AkEZ5DY1tMYAm3JP7n3lHD4Wdu3ip2Gfs/2Pxshtn2D2+dsZ9h6Ec6ArIOdkFRTPoREb2YoG1vwm1eJKeGYVssc+BGh/6T3myAih6X64e4Y2/ggYu6UCJHFrcz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748413689; c=relaxed/simple;
	bh=Cm2WQBvGDdnbOhUgw+aqFyv8b2NNJSYKPCbP57tCM44=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U9YDYCWzIalqElYInv2XvodxoAQHPi6Q5QI7WxeJWlEkJo46PSvBecgNfiw2GsvJmiG/FYNysbiE0BObOc4PskEY6jiu6DmYo3i7a66auNrB7+/L3+iGdYz7bQ8IM2YDGFUY8vM5ckcauU+akWZYWFSIzrbiSuqNiSv9SzpQyGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Od+WsNEX; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Od+WsNEX"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S3wtqV008486
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 01:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=pps01;
 bh=+k25hQ+WqRqC0OyADCvElYmO8j09G9PUeHVk4OknG6k=;
 b=Od+WsNEXXnkcV/qxx9G41BPSIRFL838DSkgi8K9RiEA00nJxC8bWNmML9Inf8JQ1FWSu
 mq6N5ibt42e4Y2kSo7VWve3lLx60kDwoYk5o4cd3mgstS/NfGSLFAQv2hbri7SnLmzyl
 /2YVwdAPE3j3e7AWKBzervUtFJ7y6SaXyB6PYw1xW5ZGurlFJoVlDinhYNUSqYMZJ+iT
 h7M46NFZTEGCbte/s8xBxoGOiVZUXFHTMECWd+DLqDvTwTKLkNYet6vSzYhDUS6mnuX2
 AZnq/k2t+s5nMtvaXOXPWgd7DpesAM71nG5Yeqj/lmTqyz+7I2nGPRo64jpVZxgB5CIo 5g== 
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 46ua0hr37c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 01:35:54 -0400
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7caee990722so678314785a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 22:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748410553; x=1749015353;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+k25hQ+WqRqC0OyADCvElYmO8j09G9PUeHVk4OknG6k=;
        b=B5bGxVhIzuCy92n1bB2iarCRhEXf0q4a/kIAz0994jHPfJ5Vh53BlI66D759/2068H
         EGaV1A2KNnDHmMHP1xw6pyf5ud7WJ+ACDZbzZwZ/ZOu2Ef/6+mk+FIce0PnFu8uqCJAZ
         jDM2iS6si+Hpnf2jKHAhzlof7hQK6PMKUMDOJlsQQlx/+h3bUJQfkQwpYoxz94MIcRfj
         cGL/uEw/2TmdvuVMD7Pc0DFT4LQCczsLHkcT+TDU6fmHdvlhYNII3PFQdQZ61sChw1bk
         m7u2RQDoqtRdrc8BDePxqH/EzmvvbAV6a32d8FbQh/c2x5rDtvhJgL+UAuB7Fm0xr5QI
         Pg+w==
X-Forwarded-Encrypted: i=1; AJvYcCUTOXyp80+WAG5sPOaXGoinMJ2xl9n3jgBfqicFPz/534+XtRbh6QO5FQDtCztMNOESoZC65oIrqEnm/3TeGwLR2JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmSYgYpm4Cub6Bc9Ro+y4zBuCSyhNqJoaQ4G2Q4SwP0mgCcGs
	RT2mMYYoBOtGbS4f6y50r+D0q7ACIi7cKHLVbkUr8VpypqYTFrr/LQXAgTyZS4uf5UU4t+wtEzM
	0Bum8G9EHthHoFqJBpQHgRnnRacEx4gvQDB136YOM8XKZJ1qrIOCG3UlHNQBZSJA65TyzFg==
X-Gm-Gg: ASbGncuJENu2iSFPoP4Rx1iTjgMGXwwZ8khvAnwHgMLF2PnHB5ul4/rmVflDyhbaINh
	417qWrdaNsMCgzlpJawa6MpmeBxE8I2XE+sj7NpU6bFeq7/1iQQzpOK9QwKIC3AK1Ypl10wkh/v
	yOgeuJ6gcvHRVaLiQEedFNgnZ+QE6JbFk+9BGn5AmAcqb0n2NbP0dBpJ67yCbKN+f7UBGVJ0bsv
	GYYV0diYE1l+vWDrU7wdo+2OfYU1e7iYbFaJJ1lQYCZD5tm/rVIW8qCIHdF/0hs0otXyR61GMeR
	e4klKgzpOj49jygQ3sXRPErR+vk82hF+JSH8gYWGDql42Z7SrAcZ2vejpw==
X-Received: by 2002:a05:620a:24d0:b0:7c9:256d:f6b6 with SMTP id af79cd13be357-7ceecbb2686mr1914477285a.2.1748410553317;
        Tue, 27 May 2025 22:35:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVuanXo3wXM1AX9euh5YA4q4C5WI95jrYBXUd0zPpPyjkxWttoX1vBdNABMij4617XeYMiIA==
X-Received: by 2002:a05:620a:24d0:b0:7c9:256d:f6b6 with SMTP id af79cd13be357-7ceecbb2686mr1914475185a.2.1748410552889;
        Tue, 27 May 2025 22:35:52 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cfb82001f9sm32382585a.9.2025.05.27.22.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 22:35:52 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/2] x86, mm: minor tlb_flush tracepoint adjustments
Date: Wed, 28 May 2025 01:35:35 -0400
Message-Id: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKegNmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyML3ZKcJN2SosTkVN20zArd1CTLJLO0ZPOkJCMzJaCegqJUoDDYvOj
 Y2loAZIudhV8AAAA=
X-Change-ID: 20250528-tlb-trace-fix-eb9b6fc7bb26
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748410551; l=908;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Cm2WQBvGDdnbOhUgw+aqFyv8b2NNJSYKPCbP57tCM44=;
 b=t2kcAbnO83WgTaP1+e0Xmrvb/1e3wCGsl/ur/UfmoDHLjqvpZ6+9YD9IiDQAfOi+5BEGffmrJ
 4Q7nzNi4c3LBjStISxcXmR0FGALu6M7RYfgif4DEn9BM0zbysG3p6/A
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: 0COmtJuwLmR342Fw0kxKEoVo9nLyepoM
X-Proofpoint-ORIG-GUID: 0COmtJuwLmR342Fw0kxKEoVo9nLyepoM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA0OCBTYWx0ZWRfXwhIgKYmfKaN9 yh4cljPZqbj/lIquiSu8sgQ8L6nlOotOFZeGzyMb22WpFCreSbEvpCqKHa9Yo/OCcUxMWz+42Xf Ijby3BQJSmY+HMH/aQJBDD7EZGhWP+mjMnVDSNOqt061PyFjxC+XnxsYN9N74v6ukRe/LevX0JK
 xxcS7hebBjDr+uO8K/viCtxPlH3RBvIDrGoVSyjB6A0YX45dkDDBLl7UoHBp7aCuIyLmcXdvqmh fQ5El5I4B8+Py2CDDs2/O8dTyG8gkiY8EW8mYx5DAK9XaPHuCH2T7exJ6BHhx9TuHD9R5Gtvfp5 N6eATBL6dheJrDXUygspXY0VAZXR5ro0tVMT8jzvG9zOvc+8GXmo87oL1yKwTVnwve8aFbdc0U3 BD/CY6jY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=753 phishscore=0 lowpriorityscore=10
 spamscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 bulkscore=10
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505280048

One minor fix and one minor cleanup related to the tlb_flush tracepoint.

As an aside, include/trace/events/tlb.h isn't covered by MAINTAINERS,
along with other mm related files under include/trace/events/. Flagging
this since I see there's a recent effort to overhaul the mm MAINTAINERS
entries.

It's been a while since I've submitted patches to the mailing list --
please let me know if anything looks off. Thanks!

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Tal Zussman (2):
      x86/tlb/trace: Export the TLB_REMOTE_WRONG_CPU enum
      mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS

 include/linux/mm_types.h   | 1 -
 include/trace/events/tlb.h | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 200577f69f29a58c90c67c83a0df6d12850e1d09
change-id: 20250528-tlb-trace-fix-eb9b6fc7bb26

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

