Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F7382
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 06:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412367; cv=none; b=BcdUg7mtJSKjqwfxLYZc8CM0H9IUmtGb96HX2enedHRPwCnZl/UaNIXes8yF8OvwJV+HI4Sfg4xxWJJg8x+QtXrVv63uREvk2xOcAxdxR+5mUNxUjaTcqkjLhxps8fsROw/mWcBrBFhvjYQ04rU7GxUGoYkilPArc4DxLDozcR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412367; c=relaxed/simple;
	bh=u4GnJWVjLuTGqbXgtkf1x2zfHjnxuyVndV+7heCn/5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=exyaVlTRcSiYpNdLqv4hzO3rPBhe8LDYMwh8vU8hNvXSMjWHkj5oTmV3Mw1w7CtQ5bEYUuWNUr1kimtBr2cVKtVtMWtxptoZTsxKMT7+paR8tKg8JAHZrf12qC4fg5SaIvcONr74/ZnMStL3FBRavdw+MK90/MFjK8GRIdXhXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=NIAVSOt1; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="NIAVSOt1"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S4kTLk018575
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 01:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=fe1SF0gP7B1T3vG5mU/w/LphwhnjbUzeEhTplFhLHQw=;
 b=NIAVSOt1US8wy8tVfB4d//T4g+Ngd4zgAlyOn7Bjl86GRNzVyy/cdz0jn7PPTJONGCCv
 77EGAOXrbfes+dwvKUH05kGB0jONEvPKEQ2f3ZFF2s8pwqQyXu4ndGrfB38cUJ2O/Sjm
 3azPDmNcdC07qkbcLBW4FE85BiLJu1xSzUgc47E3fk0Nk4Z9k70AA1K73JEDAvlWv+tK
 ZQKVPbnf/v90Je0bCFqyjqlJKJipJQSAZscfvU0lXK+Bgthmo6rsgSK7qUxgTn9lQIqJ
 mqKJFdcJSAnpW2aeZHeK7SOUiml/SpF0Jqb2WOC5gfeXZ097aVPamAFXya/6unPdsSi4 mQ== 
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 46wmuqa7a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 01:35:56 -0400
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c92425a8b1so91045485a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 22:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748410555; x=1749015355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fe1SF0gP7B1T3vG5mU/w/LphwhnjbUzeEhTplFhLHQw=;
        b=puhXDrTgo7BV/Wbem5cUYRYkHcdIBz5LnyNd3RaH776h0Q5ggHmFHRXk8cWS5oZDh6
         aD9hrxMnxcQJxtajSprbTD4dBClwHwbQ6MAQSZEsmQFMEQb8+oJRkzYI55NfvXdr5nT7
         XlRyLo1zcq6iJfcXJrmHxU7eauQzyaWKXpUmJt/RVdcU7nlBkHDjbYhD4I/bWfztJ4li
         c5KQ4/B2wtSaUmOufLlUeNzeut+4Q79TC2hzTOERr5gwITED+HuTD+0oVDCnrJ/ZNvGO
         EH18yEa/FLEUSVU74Rgmdrp10BPri9IjGUvBpbylw/C5FaKYS44a+qpoUqmdH0bV1M3S
         X1mA==
X-Forwarded-Encrypted: i=1; AJvYcCUTfXfoSkIj1Ehzme/CufrwM7hpJihAMivpWc9lceSamgyp7tmYv/7S2omKifCS/wh9fRlrwBmeKtfDxrCgm29R8oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpWh9ncO7AtC0alw5ZiyHVkaNf6yWdLuwpG7t4HTJP9Zn0YtV
	gaRwt2Ysmi+1rHD5faXheQQafQQpq1VWPjpPJJI/numJ0ZC50Zb1xB7W8wKJsraGcdSgQZxVLxr
	/b+5GFbxXtG+Cx0Uff9zwtSyapKDX0AgWwfRTqCBlEjWxFZK0OWXoSc8LluiRYPUyQnbv8w==
X-Gm-Gg: ASbGncvv9utMUbs20eFnq059nURj0auUXIDBlSS1WjojUJY7eGxhvIXh/xPI+LCEVZQ
	n5EsP97PSiDGr9uw+/pmf83L1SkCbYHDpfbUlrL9YWH5BEyjjxGO6/Rc1IFVNMHWwsgoROqTzWu
	mdyTHAPvyMDyxH+psuQvv2xLLLlbAtlYioW+yvaUenbRJDUmhikx3noNsE7nuPuz2L5xru0UY9F
	zMk9dmQ7cvyrc2Py/6700YyP9OGaA+zxVhwtg9DdqNyTC6S0cU6UC8Sk7xGvlIMTIimIAEIEbwt
	HvkoyhVoAExONswMr0RRWl4XqdAHBve/Vuojqpd8/6R7HKVaL3n//ayrjQ==
X-Received: by 2002:a05:620a:2601:b0:7c9:65cb:6214 with SMTP id af79cd13be357-7cf06d5bd10mr469356685a.17.1748410555528;
        Tue, 27 May 2025 22:35:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF61pX8i34SIykQlgLDQcjKk6sMZRhh/Gcw6X2tklDh3wPlD4onZOxTChntHVEvJ2DiXPhjrw==
X-Received: by 2002:a05:620a:2601:b0:7c9:65cb:6214 with SMTP id af79cd13be357-7cf06d5bd10mr469355185a.17.1748410555126;
        Tue, 27 May 2025 22:35:55 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cfb82001f9sm32382585a.9.2025.05.27.22.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 22:35:54 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 28 May 2025 01:35:37 -0400
Subject: [PATCH 2/2] mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-tlb-trace-fix-v1-2-2e94c58f450d@columbia.edu>
References: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu>
In-Reply-To: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748410551; l=595;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=u4GnJWVjLuTGqbXgtkf1x2zfHjnxuyVndV+7heCn/5s=;
 b=/anNJxI6PBsPAb9nL8K3TkHBwTCNxPLHsxU3pP17HIP1qu0oXl7UIZoQn7VyX7NeJ/QtOr3oF
 /8zzLs/hG/8CmZIF6I/PcKL0dy4c9Ybfey2WxI3CEETNVmDEjA0IC3A
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA0OCBTYWx0ZWRfX8l66RauReM/u GCBhIjoVFXy3WEEVOzPKqeKM4icna4ds7SSfTMGhjPrMAF2263g/gfkpOKGW5lmL/+tTtCnjHry Z0c9Fz63cAewgevNtB7CLMLm/zeN7UEusPIqVsSEOPQ8ojXRBPf07m1n4HwoVFbLoXnwPW37+rR
 Gf7WWSOLMWm1y6zU/8DtyIAp1jyS+OlpzNDCAIVQRAPUEgqlBUszcuRx2RXRHy3cnQ2D4pIG7Ba TeFe1XxQSh1mnL1vgT0ePGVeahMA1O+5NNh5X2S3uiQ24VzGhLgrsB5h+7YYOXspl8t5Xte5htD o1j43vQK2BxFNxolyuPBKafmcvnpTyhsbQg78yNzelVc3CaeTSGxwvleTP8TuE4MnFP6KbelJRg baYkUMkG
X-Proofpoint-GUID: roahugDkza4DqPyIfw5uDI-yzUkpc4wj
X-Proofpoint-ORIG-GUID: roahugDkza4DqPyIfw5uDI-yzUkpc4wj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=752 spamscore=0
 mlxscore=0 bulkscore=10 lowpriorityscore=10 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 adultscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280048

This has been unused since it was added 11 years ago in commit
d17d8f9dedb9 ("x86/mm: Add tracepoints for TLB flushes").

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/mm_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3e934dc6057c..8b91362fcf8e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1539,7 +1539,6 @@ enum tlb_flush_reason {
 	TLB_LOCAL_MM_SHOOTDOWN,
 	TLB_REMOTE_SEND_IPI,
 	TLB_REMOTE_WRONG_CPU,
-	NR_TLB_FLUSH_REASONS,
 };
 
 /**

-- 
2.39.5

