Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECCD313273
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Dec 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532358; cv=none; b=rYY5U0joyud1peaygU4n2p4aNU4fGmy0nK62m3RzkNKU33/MHBqhpnCn16urfQmQsRn6TgY3GENFb6ahIzKQmRQm69/ZY9PrhHsWOQwYzJGoxm112YvHaovQc1xggaUN8vCV+iZ1zJi9PYkcLatU2usdhGufCV6XSjRNBVdFAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532358; c=relaxed/simple;
	bh=3RXsGKqukvEhsXy2ryEgjMGzkVB8QVOoAFGKjU+lkAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDKM5M+/TF5/Wh6niv5L6nwlRpY6QbevHfYUCYvbgMEmwiOfFvBTtikDwBVVlXKviMjwnjIV998wZYa9ADf/K+gEprghWpDtm+rUfCvPskdoVz5D49tuX5/azmPkoqaeQ3WbJ3sgDYsJdziHqc/pOUV+LI30Sbm/OvZ2jtJocJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=SUefY2h+; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="SUefY2h+"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BC90R522116906
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Dec 2025 04:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=s1cT
	Pmb/E3ED4jNPhT8P6htYkPi/ZEzeet04bZUSBAw=; b=SUefY2h+X+0yV5h9UDKf
	0L/P4l74lqkcaH0AfwtOqJvXh9ZG/pfMqujyu20Ftb4CVkk6J+1RC5lzd9o/25I7
	fafQTEqH0vIvoUHqBkOKBZOgxQSWiutsZbsGEEKnx3mWq2jPLYlqCkRceS1YyRQs
	6g+X+xm/foRjPN1An4/Lpo+e+BGfMfvGzU/WvYaNR55GBetwqVHOkFHWJL6C+L/i
	xIbtfsofl5qhY4V7kRx8weBnBodlUlQmyC1YbISzVWba6/k+IHT3+9DdGcUoVM84
	jAXmn+5ZSw1Q3dt6e0NbHq7BY6R6NB0whQVK70XDP1g3sMkwKKK2VeUN40FVUItt
	BQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4b0exhg76k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Dec 2025 04:13:55 -0500 (EST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29be4d2ef78so18872795ad.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Dec 2025 01:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765530835; x=1766135635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1cTPmb/E3ED4jNPhT8P6htYkPi/ZEzeet04bZUSBAw=;
        b=EFH5gXjUvwuLVRSlrDbZp5i/7s4ByIzus2E1ngnKsLZ6iGTGx5Lux4FLecVcB+jz+M
         MPJhq/aeZ5AH7onp286ioEZqPvsSlk6YlKWMKZZjlA1oEvM1cX6NhtC7w655kWV2QMNH
         6CHP2KcPmEAoh5kwNHc/tcY3o9FqPlVTkvokslgDrIJckRTXzFW6Fp2ugkoEtA2wYsVN
         PRjubD9tqtXY9z5q+sANUEoVYMqhJM8B5ycRnqwR6FfWv6a6jvFmkYcnzSjeGt4Z9Swq
         u7sGKGxfddIWWUS3VmAKYhQTGtEQpoN9R14kP9wBzPexxas2F0xnNn5d/7VR6ikrsT16
         PcRA==
X-Forwarded-Encrypted: i=1; AJvYcCXrCFA8/zirurOzjfcHK2rAFqtOclCel4sV1UQD7Mi4lpRt4vWqXSubuF6h3v3FgdjaDk2NVADKGSWoT6zQ6M7fvwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1yIz6k/2vAeybF/MdlqeYHY+ITW9UW/8Q+NeopsxGAr2QFBfg
	8H7s2VKW4hAADr7yt6/5UFN2cupYB6ztHJ2heoqOeNQayiEUov4i6dS5UABDSgyr2mhMT/a4JEg
	7/pGt1QEUut7UW5Ir/pLAZqs69PCFd1HY8zALHTwXIsuDEBgcEtr5WNW9mlHLWem0BU3jrA==
X-Gm-Gg: AY/fxX5xBsTE/ge1KBbrqtvzW4F0NGgpOVVPzj7TlY3g2nbxMwKiOhpsQjuPZIdhTsT
	XlO2X4LLbLoxQthZwvkef0HNXE2+g8EJGwa2ySamzsIUrwu6M9brHHK2hv8ZPggl+GlsLLGUbgn
	N68DgGUcMvDIEdg6A92dbmJfZe2mcF7kzTS9a+OlVoPBwK2dxxMHispkwp3e0jRekfZUn1xV2ix
	pxjgoLjBcGJG33rgM/cOozx3jd/L0Enqw6UJ0rcTRZT2IH39GRiTSLdOeJkCNIzzzZzz2JAO26Q
	PfTAFpz6wDbqQzqbpRmSDkZ32U+o5hpl5Ocf/fZ8j3pzgEyJSTpO9WksFp5o/G+/MUxMYI1193o
	bdCsKT4+34FF6GdGXBOIGbd1q7+LioRAsJZYmToCHx+vnbSJN28Qk3t6b
X-Received: by 2002:a17:902:e80f:b0:297:e66a:2065 with SMTP id d9443c01a7336-29f244bcf85mr18583035ad.56.1765530834989;
        Fri, 12 Dec 2025 01:13:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwvOAURq/suPyQQI1KUWuzlf+xBV7BfHZ9tWHXTmC5W67Xs98SEZvrSF3mE+NsgMan4KBjtg==
X-Received: by 2002:a17:902:e80f:b0:297:e66a:2065 with SMTP id d9443c01a7336-29f244bcf85mr18582605ad.56.1765530834512;
        Fri, 12 Dec 2025 01:13:54 -0800 (PST)
Received: from [127.0.1.1] (p99250-ipoefx.ipoe.ocn.ne.jp. [153.246.134.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016e57sm48497255ad.63.2025.12.12.01.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 01:13:54 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 12 Dec 2025 04:08:07 -0500
Subject: [PATCH v2 1/2] x86/tlb/trace: Export the TLB_REMOTE_WRONG_CPU enum
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-tlb-trace-fix-v2-1-d322e0ad9b69@columbia.edu>
References: <20251212-tlb-trace-fix-v2-0-d322e0ad9b69@columbia.edu>
In-Reply-To: <20251212-tlb-trace-fix-v2-0-d322e0ad9b69@columbia.edu>
To: Steven Rostedt <rostedt@goodmis.org>,
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
        David Hildenbrand <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>,
        David Hildenbrand <david@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765530499; l=1293;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=3RXsGKqukvEhsXy2ryEgjMGzkVB8QVOoAFGKjU+lkAo=;
 b=u8Ap52Jd1shp/j5YC1M4uPMvXwfjjDYnAsVA6o3090sKSZmF8nxXTd4XMzAAufSFFftag/Sds
 I9zmJSMnLejCrmyrOBBN0KHmXvL13pBcYyuqAhhaNXDrChF9WQe589R
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: MvvfZBMXv2XMLppotp4Gvui5aP63HHzq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDA2OSBTYWx0ZWRfX5irgXWNiKEuS
 tij0T0o1ohUYKomNpGpJ886PUKyZbTbxcQrG2JczImD7YL3wMn10PIZrCd32cNgGXOw0gT81eJD
 k6xnKD8YM3PejOduv/KVMtFprJj6uckvBmVmmjAAUIqL1wi1xVRTRZ4ZNXvssSf1DxFxQXAMk0J
 YlO3PO4f5E8vYEAJhrVDaZT1Cp33nS8fizzHXcpSa50wGYXoOMgig3awSyer+6VUZmWDRkEBB5h
 oNRXB2MXDpH/pZqQKM5tNvpfhW2aVbvAiW8FIPZzLNf8FTziKM/jj6xz0Nv+tNz3dRTfy4d8I8d
 f8TTgfoKnL3teYyMo71AHOMW8yC2Z2KN94QexkmtiDptLUz2y3rcemm9pwRbXTULBpEOROpImHn
 yFqMGfXb5Mfgnu8/462d3tqgvTT4RQ==
X-Authority-Analysis: v=2.4 cv=V/hwEOni c=1 sm=1 tr=0 ts=693bdcd3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=gC7H+NTNV8TiHuUi9Bl0tg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=20KFwNOVAAAA:8
 a=fwyzoN0nAAAA:8 a=tN_j7I10ly-BD7A3SNgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=2JgSa4NbpEOStq-L5dxp:22 a=Sc3RvPAMVtkGz6dGeUiH:22
X-Proofpoint-GUID: MvvfZBMXv2XMLppotp4Gvui5aP63HHzq
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11639
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 adultscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 clxscore=1011 bulkscore=10 phishscore=0 malwarescore=0
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512120069

When the TLB_REMOTE_WRONG_CPU enum was introduced for the tlb_flush
tracepoint, the enum was not exported to userspace. Add it to the
appropriate macro definition to enable parsing by userspace tools, as
per [0].

[0] Link: https://lore.kernel.org/all/20150403013802.220157513@goodmis.org

Fixes: 2815a56e4b72 ("x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU")
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/trace/events/tlb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/tlb.h b/include/trace/events/tlb.h
index b4d8e7dc38f8..725a75720a23 100644
--- a/include/trace/events/tlb.h
+++ b/include/trace/events/tlb.h
@@ -13,7 +13,8 @@
 	EM(  TLB_REMOTE_SHOOTDOWN,	"remote shootdown" )		\
 	EM(  TLB_LOCAL_SHOOTDOWN,	"local shootdown" )		\
 	EM(  TLB_LOCAL_MM_SHOOTDOWN,	"local mm shootdown" )		\
-	EMe( TLB_REMOTE_SEND_IPI,	"remote ipi send" )
+	EM(  TLB_REMOTE_SEND_IPI,	"remote ipi send" )		\
+	EMe( TLB_REMOTE_WRONG_CPU,	"remote wrong CPU" )
 
 /*
  * First define the enums in TLB_FLUSH_REASON to be exported to userspace

-- 
2.39.5

