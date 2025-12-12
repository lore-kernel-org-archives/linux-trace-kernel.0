Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E726ED4C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Dec 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532297; cv=none; b=JAxA+YRkaeu+TUipIrvDuT51vxI4exO4GYEMpoY2E12NC0mE90E6H5sXPmopRqbFUR/dCtCR6gIb9pzeBzxMDTdgU8Hf4zdYkmGoMcNhOzJms8LuFFlsAVnDSx6QpA9Ap7O2cWoqKWqz9s1qRrAXejDREevv9gOVmK6SX3VL6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532297; c=relaxed/simple;
	bh=EmdTK/fRZopBGWpziuNMPd4s3SKCTzTlZFLJE/4064U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I9HPE93VNsAHzV3nG6mi7z3s29d3cZhA52FYn0mJycdYAwX/xgaFeLcLIBI7yibOITMe82mbjg+A1j1Uz4NZ6NLCgqBWnrb//6RIrMhlbla4u0a+1hpbbnMWEXJnBwxYd6zUQVUX5THxhODAHnbBX/cGZqoLGGKAgv3ImULTaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=GKPh8o1P; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="GKPh8o1P"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BC91ZQ31336999
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Dec 2025 04:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=avil
	WIry9gTxLFV5dzlklnHAwp0+Z25pb6ACZiTI8wE=; b=GKPh8o1P17lf0KKJKa9b
	Q5yu+41K5zsh7QbMxnvFsPzmmtTfVAoCBEmC6sjCjGByGvsEzk3/DMBEKAf0ZXIX
	Zb8wQnlthE3Op2+W4xfZ+fURt0FX+jOqmcOkgBxFf0h6ILh3m2uD4d3JnLLrinqv
	dGLeCrsHQFgqRtgdgmk1kn3Q7Yyq5M2S1LYhjbeT3W6AWWhlcB5tcaTXwiZmyTOo
	PjLyfN4w162BRPpXH8VPtnkJPcfY1tnnBm8mCT8d2CrCrXQIxo3N1mzDL4956LCw
	q5e9jRMy6e1wl2yPsS+7aeLHX+/FlKiHn/q2TeYWhW/sVPcXm3FR+lR+WOEUlfu1
	dQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4b08ugsh34-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Dec 2025 04:14:00 -0500 (EST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ab459c051so1899995a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Dec 2025 01:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765530840; x=1766135640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=avilWIry9gTxLFV5dzlklnHAwp0+Z25pb6ACZiTI8wE=;
        b=NCpWWBTtewLqojuBeFDLrBkqPNParJ0/TQ4PBGmwrlQcW3E+MEDhl2QrVRJJyfLWt0
         WPPRo03yCQZvvsXgrORf4U+UoKHjVzcDUoDPWzYVCumyTIsvWJ7PPX8rjpOQp2nb7W8p
         9h7DjA8VmlHti8Qw3XbzMqHgxJl+kYsPuMzBtNpbJDuVRHnUcqkyBRAl1jt/Jo/B8fLj
         PG6TGzewbl6lO4SlYDQGD5R7Rh2fybUbUVc9CT2rIdJc+8wHB4vaVnhnBC1pFk/JVz+r
         o3869nPKWQ2fOJ1uIqSQ/xt55l4wUOsdrHN8m7cpfQ1IbmYW1GO3p73F/k2apO5I6f2S
         flHw==
X-Forwarded-Encrypted: i=1; AJvYcCUtf1ZOUVXdd+7sJksDOqcm6CHfWgR4gYJDcTCFRsjbE+MC8t8/MUmyIgUEYyrgw1kKBjqVV2k01m3v8jlvNzssSjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIPe0kFsW84T+Nb+s2z9SfryLGFtmWGPbIDtgQ2iWJC/Bx1HPt
	KMdz5wp3hQMWs+Dbh7Q7LU/YMtDW48/mKB6zQ3QcjLqF+eEFX1quI+rHkO5cmKCnV0H5v0b6mik
	frjLvvCprqBDE/dir4LPkpp7P6ofma6d0IftoaKhqgFCMbax6JdshpfoSS928kq/wNTg4ow==
X-Gm-Gg: AY/fxX6scqVZZOQc3HCuJGxKmF1VIRsuOJocm0eCJXtinu8akkr/PLqoHkQJRneGxgh
	jL7YWTkS3YUygRo8YhpcZ5TI77w46kVUp/ftWzZiWGMU5YQobIMQVk6JZ1HQ+KNN2WjZ+lGXKMm
	dOeBRrJcsaXrQBLivY5DyS1x6idKKEa7Flpif8NpZYZOMaNVmRnsHE5fjhfDvk+3g46yoEpwBAr
	WhVGEEwsh4zbMI03nnTZknwGa4buaxZGK0KEr0smcP2NyJkuhIARckDEtsfCtuMrzpBYu7z9ptY
	RGb2VUyY5CaT1JdDSCyYmvlsmyCpA6zuVpJgTtTk7G/vtc+PzYQlrI3hyqEqPX6BCpG37njFCNG
	HYRB76YR//qpcVjoxdq15Im15qoNqAtuOgT7+yOv0DnirA4Inl7dfpeBA
X-Received: by 2002:a05:6a20:918d:b0:366:14ac:e1f7 with SMTP id adf61e73a8af0-369b07ab627mr1259545637.73.1765530840077;
        Fri, 12 Dec 2025 01:14:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELRX7SnPRiviMlTSgk/0tB6eCplpLNDZWHl3aivotSRf1ij/an8wIly2PXn4fRkPYXltl+Rg==
X-Received: by 2002:a05:6a20:918d:b0:366:14ac:e1f7 with SMTP id adf61e73a8af0-369b07ab627mr1259504637.73.1765530839512;
        Fri, 12 Dec 2025 01:13:59 -0800 (PST)
Received: from [127.0.1.1] (p99250-ipoefx.ipoe.ocn.ne.jp. [153.246.134.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016e57sm48497255ad.63.2025.12.12.01.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 01:13:59 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 12 Dec 2025 04:08:08 -0500
Subject: [PATCH v2 2/2] mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-tlb-trace-fix-v2-2-d322e0ad9b69@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765530499; l=689;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=EmdTK/fRZopBGWpziuNMPd4s3SKCTzTlZFLJE/4064U=;
 b=UsUA/XaWe7PQ81AUFd/Djoo4VpRjtMdRkW6w61JAXpaFzEpvAYddwkNn4lF34ddKsrIvtCT5K
 qasOL1ORuYzAbPIRlACXAmu8BfEbBJOoUBeMiE+Sy0LjYBxhUHo3KIn
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: lI7dA1B80x7VZGDfQJhfhh8KgAvQiAqG
X-Authority-Analysis: v=2.4 cv=MvpfKmae c=1 sm=1 tr=0 ts=693bdcd8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=gC7H+NTNV8TiHuUi9Bl0tg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=fwyzoN0nAAAA:8
 a=pHWCnKJda-1CI8IbBYIA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=Sc3RvPAMVtkGz6dGeUiH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDA2OSBTYWx0ZWRfX6ftUzzIlCO6P
 08MJscsEiZVEABN3bxdrY1jYSqzrrwUdiZ8iIhu2jNVepfJSJPwzMPrBQHF4yfHlsn+DAhcp3Bn
 wQTFFWoyG6CT5PK30PUIpKc+AI41VA2ajZoD1TZFsjNWe/K+EWLtjZPKuelYCu///ZwiyDWyM9d
 FDtNhQkFe14hJGqT6Ja4RMrauDwpyLvyc8WWlrnwTJUAgeq4NgHQYaPaZ0rNG1pN2wGqgrbhoVx
 QLJkGJpw9QB8xOHZhXF+anxymoFggIunI1Nmlk4y8TblBYOrTHwndOL+WUCw4ruC1AJDk2K58+s
 pGCugKLgPIADaDCHXNxfvjlAjYZy+Z4EkHP1Lx0HJlUVXBOP5R/1rXnqYbOsfKWr3+IfiRpMYKY
 GJUXPUv/fgm7mEdFBdIJk/dxenOX2A==
X-Proofpoint-ORIG-GUID: lI7dA1B80x7VZGDfQJhfhh8KgAvQiAqG
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11639
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=10 adultscore=0 impostorscore=10
 phishscore=0 priorityscore=1501 clxscore=1011 bulkscore=10 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512120069

This has been unused since it was added 11 years ago in commit
d17d8f9dedb9 ("x86/mm: Add tracepoints for TLB flushes").

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/mm_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9f6de068295d..42af2292951d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1631,7 +1631,6 @@ enum tlb_flush_reason {
 	TLB_LOCAL_MM_SHOOTDOWN,
 	TLB_REMOTE_SEND_IPI,
 	TLB_REMOTE_WRONG_CPU,
-	NR_TLB_FLUSH_REASONS,
 };
 
 /**

-- 
2.39.5

