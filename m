Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297082236EE
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Apr 2026 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573039; cv=none; b=Sn7k//7yWqRpckp5r1vtcUGD2u7LUuJpvDn4anhudVELIeGeiT7KShSiYx6lDiu/BrD780a3IzGr067dbJkdYmbz8kluXP3oY7ZVfYJLdDZ/+/Y1k4prwoyrZcLYXWo6r76eXO4QHVPWclIHMaCpGdAEJDfXRTt+mHWkzm5CQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573039; c=relaxed/simple;
	bh=Rg2L4nRM/rmCCsatjSqa4HCUG4hnfLEj0hiBmiJumio=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uv4qvpkT4y/JtRi1ia/lzp/BOwafva/ItzxIEN+QBzQdEqsxJx4rYFIlttdZiQOh0JnLlgTxd48+++892qc2Pn/7GV3bzWiO+4Ova5s00X79eXoY64RNbV2nXR2oeMBNVB53zSDBEmcIK9X6U5bUP4yam46WfbeN1paDxQtaZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ntLJzeLG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OG+wUWl/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ntLJzeLG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OG+wUWl/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637CcSTO2328037
	for <linux-trace-kernel@vger.kernel.org>; Tue, 7 Apr 2026 14:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	00NWTnAGV7yhJd8/Q9KklSPqk81RRr1EXW2S+gNTCtk=; b=ntLJzeLGPTvhrN8A
	KfnK88vXvr4V3kMaUnRyELTWksVqxFt3EwUdwALIin+rSWejoZTnq95Sx4yZFyXX
	cpaOAmTHXlUI6WnREw9WNERNS6Z/NMAk84stup2KAm/HLTkv89nJbeWFmm9nUgh2
	OCW1iKOpd/CkrbJMUDLUCXiisI/H19Yoi0vUWIIgJTwU1An1p16OWXWIjBMBlX9p
	QiqUwtilSvDjBiZ7PjFfSd5q12dWeWm/uEUDUkRO2YiC9LSXhlAs7Kisuky5hgFi
	Ybqq1YH/EgHwBTfKZNXxN0E2thJkfaPDC1UyWZNZNjlY7uxFJ7MshuAVhLhawdFH
	EBXfYQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcms4u5wp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Apr 2026 14:43:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35d99c2908cso4457264a91.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Apr 2026 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775573036; x=1776177836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00NWTnAGV7yhJd8/Q9KklSPqk81RRr1EXW2S+gNTCtk=;
        b=OG+wUWl/LLYgLglPLVNXvR0S0f3p78TPPVyq2GdlDCoMkUXEb1Ao6Ls/Bk1SFkg+yA
         ydoZ7irvihVDgj7A5PdEdbCPYE8GQ6+iSenQYrpZZ+ju4bFfnEsoVLxZTXHfpfLq1wX8
         8QCu6220ZoUr+OPqAff34b3GDKqcDe0/jCaUf8vYJItkka3LfY2RmhY9ld/jOPI5v+vq
         BdbBh8y7eVe2eQJQcWhF91gUaJwNMtNCMutepoIrZyamwRh25UCfLQXiR+CTF3To/E7V
         lVFCQkYFxpVlhzStejCrouALOzr2InWnLEuPvmM+laVfOcMV1z5zojWtHBYJJD8LVpOg
         ZAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573036; x=1776177836;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=00NWTnAGV7yhJd8/Q9KklSPqk81RRr1EXW2S+gNTCtk=;
        b=ZTFCld1ItkLvPw8DR7w85nb6v57htOKhiZ3n4//9IHgpzs/kZLIhwAwzv1fZOW+mce
         CzLwpBPJEEGiU66Ejopr0Tgkemjeynzzw6exNbq5NutU8F2YnrIx96Xs1tNcAxuKkaQs
         10Pu2OemgpOw38jPcjs7B34VPkTEwAYarwGYTLuW3bV03z3osV/uqAAWf4TxmpDFQI8L
         Z+EzygDuGqFQhH9R71jO17NPb8KXfMpGwvvILKxJHbiCaBMVwIgfhn4Psjsi7LwsSely
         LkP9GhgBa19VO/o0nFXU/1hEggKWZfim4bgT6ta14jd3RJ3C6dyZYoUiaXaOMPXr2clj
         1Z6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFy/TW0weHCqLR/yCnF+rKzi+Gqgcn+IPbdMd2svdp1REtIfkticQgQVEvqone1XTb+LNagRLy6oD8G30Ei8wybUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZj9Y2t5LYWX19o0dFkwk1MIcPQbqAXNpYboilyQUHZ6dqHGSB
	bQmYg4YzvVmarsQJ37SXyLfDexZwuXD8kRQTxAl2gz/GPwgowtJGU8SSZg5Xasf0zFNhp1pc22d
	uWV6JYlx3I/WWizwPXnCEjKVoEVvjqi83Vm7XuF6jd5AnYa+7vBX/MPYwaAPWczKNIY005huP/K
	4BNi2N5ug=
X-Gm-Gg: AeBDieuk/mEnekHvn8CRJiQI+1rO4eHuJzkVNQmhVIIa8thwyFMASWDb2FBqZHJOmSu
	9VZHS5CYLn9QbM/mg37piyfAU2Bi3uIvxdg74wGfwky3l3LzejeCSR2xd8P0VSBucWS/jApOi5w
	lIF47QtG0jPsrxpO0uD3csdM/Gh8J6JEzFia3WtTjmIWM1MAXr5ub1K5RZp0EKmhTot9eTNght8
	rJiJ254EMnj3yHUYfCA6q7SWIaRwoGrCKgCE5mfQMd15aYEBHunTPPSn3mfXWgSXz6El0TOdlhe
	aaXG9O/OAVGk/ptUnVl5KgzcqWwRM3+c9hGexUJZDDUPoA4khga25BA/EU2yJ93Ldu0S3Vml7GA
	QF3I//b+r/4ZAWzgaJwZ7
X-Received: by 2002:a17:90b:2b50:b0:35d:a559:5c1c with SMTP id 98e67ed59e1d1-35de660a07fmr15496008a91.0.1775573036235;
        Tue, 07 Apr 2026 07:43:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2b50:b0:35d:a559:5c1c with SMTP id 98e67ed59e1d1-35de660a07fmr15495973a91.0.1775573035680;
        Tue, 07 Apr 2026 07:43:55 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.133.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35e34f9sm17067098a91.1.2026.04.07.07.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:43:54 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com>
References: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5 0/3] PCI Controller event and LTSSM tracepoint
 support
Message-Id: <177557303192.289344.2616682402332241807.b4-ty@b4>
Date: Tue, 07 Apr 2026 20:13:51 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNCBTYWx0ZWRfX5V0rdVHfJdSz
 ktMA06IJ0UA+a5dePGJVKyZF/uOuvxSqYiTx7bh8pvz2dYv9jDZuVXRdCYdR6U242fH8eC6Zzrb
 bVtrM5XfP2o14A2JoL0po9wHIVhHAq8HUrhBLOZ3zP6w3P9NXqhWVGxTipl3LUK0ByK52BNKJcv
 cBOyOXYKW9vjWkm0l5m1nQ2Dx9w3E7V/MFlZdnIfYV7YB1DT9KgnnSKSm8kZHHurpa+LkoOr7NR
 7ZuWafbxxAkFZ+tLG0dSS3UJ6xO//rrpVBXHlG/UpTfyPUkEZoA2WhQ8lgy6XJ8tRkzpeg7hyu4
 5TaBzk2BqkZOqLBZZFykbCf5tTdl4XvZ2uYKbL3q0bPy5ok7ghf25saDa5uzwRPUABbMaUonxCm
 4PPsKrHdYenqHtJmQ/DbLRzKadJsDY2cg3YDsQENl4wlp/8OZxEGC5z/2/RZEocWw/bGytzPV35
 9DKHA7/OPvyCxQDWOmA==
X-Proofpoint-ORIG-GUID: lr_EzkjPFCvRsoqhFs5Xutt3RbK-Xmep
X-Authority-Analysis: v=2.4 cv=WNZPmHsR c=1 sm=1 tr=0 ts=69d5182d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=yDxY/ZQAnAaCL67VaoekCQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=QCXkDXtUJjd1gO50qw4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: lr_EzkjPFCvRsoqhFs5Xutt3RbK-Xmep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070134


On Wed, 25 Mar 2026 09:58:29 +0800, Shawn Lin wrote:
> This patch-set adds new pci controller event and LTSSM tracepoint used by host drivers
> which provide LTSSM trace functionality. The first user is pcie-dw-rockchip with a 256
> Bytes FIFO for recording LTSSM transition.
> 
> Testing
> =========
> 
> [...]

Applied, thanks!

[1/3] PCI: trace: Add PCI controller LTSSM transition tracepoint
      commit: d1b7add89c004295cd48d7cd49946ed5cb5cbb55
[2/3] Documentation: tracing: Add PCI controller event documentation
      commit: a3966a6f915ea7d1af0941ea26848d921e574c45
[3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition trace support
      commit: a276c0d802d8d2a22088b7919d9e82e936995cf4

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

