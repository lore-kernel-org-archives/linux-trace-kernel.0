Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139AD2DC354
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Dec 2025 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532237; cv=none; b=Zp46XaogrdQDgqOwMOvsgzWcVa4h7XswLv7lQblUcWjGB8A7slT9JyDdblr1MMlfK0jyoE+hF+ONXABEbnC9luvl/j/QibeuA6/TdNA5Dd3e7+vmg1Jodb/pr6FxyJc+po0p7mLuV3gVs+9Uup6Y2/t+Bx/aAPSZyp24X5yAmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532237; c=relaxed/simple;
	bh=RQs+Cr//EkA08UpbUBYAdwgnHf9vZ+MF64Ay7/KhotQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ts16UlVkqlTSwUJrVNpGst8MrkR3L0CKUyAw80l98+eQesKrmrL7dY+DJrHRX/g8jb1h3UlF1RMrDImwwIwsLJ9k6XxlB5Oyn71mf4pXuts4z+HIiQyJM8Q0UZRlrhob+ddOoSkzZhV3x3UQ4u/1uoz7JLZyfhnz9nKBt27m7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=uKg/GSQK; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="uKg/GSQK"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BC90lQD2433061
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Dec 2025 04:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=za3Z6nCogcC2rSrqJPImaYLaC5
	FD9fqlNIQmXXHpQIY=; b=uKg/GSQKP65HHIXIU/0QSpgmKz0ZJ4mRqkKK0wXo5X
	4p31jMkn0OhTgbSuRyvk+bMLxQmI/TdY8r9vZfeUc2AlUqm+gfU3otqXmISQCjOu
	ydBvK32hqIcxPh139Zy+AXkgKY9qjEtyEaWFwmHClh4bWfpZDlZQ4YYtXF++MeHu
	02LCDVqak3NcTydE2pt3knXB7DVFhmVf7oraRiG5vDoI44eQG2VLZREASUW46fXo
	j9dZReDVYy2mdV13vlmgY+55fRCWQzDz0KmEpPCZY4v4BfbvLaXjtxH9sZ1/DhsZ
	yUq+XbpvKtvgrWAWl7JMk8Pbl0wG5OmkUqJEcj2EukrQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4b023bwfud-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Dec 2025 04:13:50 -0500 (EST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297e1cf9aedso18860395ad.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Dec 2025 01:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765530830; x=1766135630;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za3Z6nCogcC2rSrqJPImaYLaC5FD9fqlNIQmXXHpQIY=;
        b=jS8gXen79kgnFpQqKmJ5Hcm2iYir+o52mg4aMq/ikGUCxpQ1k3b4tdlEZklqqERNGO
         qreQjOjW5mZKYrZ/Gv92xDjSj39ae8qfG3zbe3S7Rpci+9JjSfWZPVEfusXUKqBNPfI3
         98yZ3TXO5btHswN2gspVHvtYNM7I8Cecu3iPtDJ/Axvt//u2/rAY0rCFTqK6pGTpCSJl
         6hxhVnTkbt7N1GOXgggLf6zvvnbayhHNCehyuzRAFxtekYdiG0H96p7PIDPhzra+o+A0
         GGqGq33vzSMr7N1AExD7dw3otOQ5DvvifO4i/O6CXRsiSbeS75M67pxWry8ASE9Wkmsx
         p9XA==
X-Forwarded-Encrypted: i=1; AJvYcCXkg79MucjdSE+QzdKwATJMowl4C/Im2AIiRc1kU/GIRBmB4k/NUiUqmPB+d40mP2TF4vg+CTmZMq2b+q9/iGTCOJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3E0kbB98qAk2CYe1YXM7pvMu8+gNr3s+usurc5irnRM+UaQ/i
	RaXjFZHaaj9R+zKdw4MVt2yN1x3CLWwcApXwHbjKhn+ym2mNaPNaPD37WI3oV6pUN0RNEu6w1hb
	HBuIpi92HLc8YymKQyD559pcylhZkuvSl5ACUGweE2ECzdlxTh6D4nxAHCBQliBOwG0t/VQ==
X-Gm-Gg: AY/fxX5+v8xSjRUsetYaGSoQHgGxuhPsFMu+HE12srcjR1OkfglUBJ8avcbbmBWQNIZ
	5+7v8PX3mppuF66y+codu5lQZ3fIj9rMq+6hKZXk8sdDn+6hX0JI8kq3jedgI/byWXcfPTLws4g
	B0r421Afu9bxqrvr1TZOFhKhwdEfwx1vCtPa+QIy94zHt3vgABpC0C4xZbfkWIGSL00tcLFPKfF
	z+5cjgQbsNpPCE0G9/d8A6u21WECvr+tZWIDG+Rcfnjo6NWX00i3Z5fmKzdXR2Wl4Kx3/WupLgu
	GdMLhneYyvLDE3Y+QLKf9yr7LeUA1fUba9MakF0YpC/zNsTo+ZLly17YjLU9SjvYL7JxHAtSH+d
	e/IPkWJkobJGhO9ECYcp2u+IDwJgDFGat1uw7qFqrBXT3FWpttmyR7+RB
X-Received: by 2002:a17:902:da90:b0:298:68e:4057 with SMTP id d9443c01a7336-29f26f02492mr12993465ad.59.1765530830012;
        Fri, 12 Dec 2025 01:13:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6sKbsPSYsaMyhULdwVqz1JoQu+BSE8km39oGocnv1+kBEsKkLBQeMpkHcDjKtUuydOVQxbw==
X-Received: by 2002:a17:902:da90:b0:298:68e:4057 with SMTP id d9443c01a7336-29f26f02492mr12993135ad.59.1765530829488;
        Fri, 12 Dec 2025 01:13:49 -0800 (PST)
Received: from [127.0.1.1] (p99250-ipoefx.ipoe.ocn.ne.jp. [153.246.134.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016e57sm48497255ad.63.2025.12.12.01.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 01:13:49 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v2 0/2] x86, mm: minor tlb_flush tracepoint adjustments
Date: Fri, 12 Dec 2025 04:08:06 -0500
Message-Id: <20251212-tlb-trace-fix-v2-0-d322e0ad9b69@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbbO2kC/3WMQQ6CMBAAv0L27JrSUARP/sNwoO1WNkEwbWk0p
 H+3cvc4k8zsEMgzBbhWO3hKHHhdCshTBWYalwch28IghVRCyQ7jrDH60RA6fiPpXrfOXLSWLZT
 m5ano43cfCk8c4uo/xz7VP/vvlGoUKKlvjOpco4S9mXXenprHM9kNhpzzFzEpeemtAAAA
X-Change-ID: 20250528-tlb-trace-fix-eb9b6fc7bb26
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765530499; l=788;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=RQs+Cr//EkA08UpbUBYAdwgnHf9vZ+MF64Ay7/KhotQ=;
 b=HNx9jzUDiAP5JSX3noLQxFsehtAhFIOg4dMKrEKthREshjiRp5BImwVYJwMexc6sxNAWzyZPY
 sa/Ub59Y1T7D4+rjSgEPJvT53cMT2cdm+oFqczWFoehSiGm+14I70uS
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: GEcT6J3RvORnNr65mq_eCGvuYAkvQqSn
X-Authority-Analysis: v=2.4 cv=ca3fb3DM c=1 sm=1 tr=0 ts=693bdcce cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=gC7H+NTNV8TiHuUi9Bl0tg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=D63WkmDjCBH-idvp9jYA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: GEcT6J3RvORnNr65mq_eCGvuYAkvQqSn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDA2OSBTYWx0ZWRfX9kf+9Jj5hhXy
 JHyE4r+gywYsfkJgKxYJSOavoyAJD+DAGkivwLDh6O9Yn7vhu0kstCmTrj89T6QlYPlPIrDsM2Z
 xSQ2rFQXOK+E+cIkpr6P9HFN4QxIGGb7nk3I/oZe5KQ4Mzhhr+YR0bPmAAN0BaNV7IWigGYcapm
 GtyHC5+AvsFy+tfCCWPgkVntepKOlCzB3kDSVLJHmDnZQA+k77LJUJ021+Tw+rfN0iTUQe5hm27
 +oq4ya7/pbbEvrAwOtcSx3EdRtwEsVrWiZYnSySqj39zLDVV+kMRucqV820X37i+Edf4P+kniQN
 fwrDJ2vAc/DGckqA0bJUp+2AYbLGEZFpHdbyimyYxMedYIAx1/tWp1uBNCfOmLrWI4lNWNOsDj3
 W0X9h6mD/IdGLXOZWHITWAICK4BUAw==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11639
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=10 spamscore=0 clxscore=1011 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512120069

One minor fix and one minor cleanup related to the tlb_flush tracepoint.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Changes in v2:
- Propagated tags (thanks David, Rik, Steven!)
- Added MMU Gather maintainers to recipients
- Rebased on master
- Link to v1: https://lore.kernel.org/r/20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu

---
Tal Zussman (2):
      x86/tlb/trace: Export the TLB_REMOTE_WRONG_CPU enum
      mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS

 include/linux/mm_types.h   | 1 -
 include/trace/events/tlb.h | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: d358e5254674b70f34c847715ca509e46eb81e6f
change-id: 20250528-tlb-trace-fix-eb9b6fc7bb26

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

