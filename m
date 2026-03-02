Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4DD3559E1
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480866; cv=pass; b=Cmq5MXaZkKikZ8jPZFG7WPc0TXpaCpot7PTWNdKsVT94WlJYs9wf4eTWmaEkOvpPKzQE4RKctkUDBZZpfibWd/LdeaMAmlRW7NAeWPHY+8vqiavABuoYBYpdtaSRMJK7oGkjPYzdS+Ddj7BrBP8zzdgqhGGW8kFJ0CXpv3hAos8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480866; c=relaxed/simple;
	bh=BQOI3IT1gfyDdTRmHBfT+oKNSW+Q6XYt0vv7i4zTmkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQB5kRVvxwJY5hWXFtgUCzd6fpDIWfdkI8Y6kbcHvkFi/ooOpNq//dl4b2PjahqgAzLJLggG2XQ3VL81N3Af/MI9wa9dLcwMNojQTOn68sfaTDTm9p2wO1JHNWFWOX12xfTWmWuXZGc8iJ0HnrwqmhaVXRkX5jCv096MhIYinLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=y8F8Lj5D; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=KztfNn1b; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="y8F8Lj5D";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="KztfNn1b"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622GcWIh3112676
	for <linux-trace-kernel@vger.kernel.org>; Mon, 2 Mar 2026 19:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=BQOI3IT1gfyDdTRmHBfT+oKNSW+Q6XYt0vv7i4zTmkg=; b=y8F8
	Lj5D3bF5iO+P8RFraCe0t2YIMQoNvY+c0pE88AiZsop1YN3tWjQDRllderPGUxtv
	l8cZZ4cquqJJcqbjxIFeEIpmBgEdKHzIku9vB61q5NhVtVEUuEo53hEidNNAvbi0
	wp2YpaFckqCK5zmeWNCrvZPQOWm384VYOhF5+7Xop0NgRAuIZleitJOvbePwYfqt
	WMCcTO7IW25JkW0/mPxHBqscp4yZ1o6rH9Zu5XAQABMxplOxmfRP5nIcrfi1cjZB
	sFa728oYLlb0fLBNmHWvdFys0aD5Nbdd77ED5uEZOEEPu8K/si4ifZzbfCUbRkLh
	gKEWefTxYssmJRuhzA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cmbahnxw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 19:47:38 +0000 (GMT)
Received: from 04WPEXCH012.crowdstrike.sys (10.100.11.82) by
 04WPEXCH008.crowdstrike.sys (10.100.11.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 19:47:37 +0000
Received: from mail-yx1-f71.google.com (10.100.11.78) by
 04WPEXCH012.crowdstrike.sys (10.100.11.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Mar 2026 19:47:37 +0000
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64ad0e5cddbso5296068d50.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 11:47:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772480857; cv=none;
        d=google.com; s=arc-20240605;
        b=MNTQCMXeGRY4MbIwDGq7WwMiizTbhLEb/GGdV/sN73laFUvG6RrNjFcvgCL5YgW0tI
         YY3irHplg+K2KDfbPCJvRHNHLvpUfmPyayooTLzKPxEkrFedFsy5JtEpVBFwT96LFAnc
         AYtw0vyeJz7Imtus4ql0ueUW9DvoSldxK8k3zxBL7sTpfOYwt5hucB7tOhKF9/OWh4SB
         0vz0tK7g7MJAelIXZaNEroXeAfOuavP1Ph+ZVP/lBzSt4gpO9jc+KyQ8w1gJ6M6EOw4G
         iS7LYkVUFc7chVTrcN8qk1ZPvb2+5BYzrnaZsRSXQ9Chd5JiWEkTTn6ep+73WWe4eydW
         Z0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BQOI3IT1gfyDdTRmHBfT+oKNSW+Q6XYt0vv7i4zTmkg=;
        fh=ud1uxxsE5DYEFscigbK26Xo1m61OFU18cHtq56O9vA8=;
        b=LkaknJfGFIA4iL7q0hT2YV/FwReKWQnxrD8s6vyh5MNR+Eh4xK2GLH6EToycvlR3LV
         je3pXdzBMCvp++FU7Dm9dDh1ZrW1ny68wXtbRW4tonmuECihYZ37ibsxNgCk/W4XkJh+
         gmwuufs9R6ahcef7In6RegPWhtmxCecCEG7tIby0IymNrq5v1VV/TEBf1LOgnL5Yh98G
         zKqiU12v/uytvIMpndhLuV/BuJVBqDjrArYO08r09nTRisFj+X+NF7ChS3SoairgdnSe
         uFnwu+RLZsNtfHbGGtYMz1TKrVprvpFcLW/bZFItYbr543jBmsocgWtWXToUrYkwpRug
         Oj1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772480857; x=1773085657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQOI3IT1gfyDdTRmHBfT+oKNSW+Q6XYt0vv7i4zTmkg=;
        b=KztfNn1bSvwRRW7N6axUV4hRD+pMS8Z5cgOB/F9Rcmum5/9Qgs9dzg7CtHWCwwle4b
         8RdcXpc0eZlO1Td6ObOHkMDZBjXyhVsDukm3UbnLU6AlZ6kkiUmI0gegb0W/H9s8TOQ7
         YPb3NuN7VhjJNEHd2u/6+WqYV1Ln1UdhO8q2QxMZuDJVRqr0YtRYzcuIFgx1JyVLYXHx
         m6//jtXXpM6mduw73EKKqWIs0AJgDse75TfdwJFItMQeI0W5M7doukTijv9jnrc4jgqA
         1eAbh/Qa/8dkrX7cZsWfZvv7Sa54C8Q2Fm56f8PYXDGcF+IDwy/RabCLhLAsfAt4K98H
         Oa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772480857; x=1773085657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQOI3IT1gfyDdTRmHBfT+oKNSW+Q6XYt0vv7i4zTmkg=;
        b=edvtDS/bDRs70GJQW0dOoxx1UYqRBSTRgM5IpYLv3eNb48hkPlRCT/Gy9snssWIX24
         ZNz2txfcNQETEY30r21ouv1Dp8EvjOrj9ZQdpMV9IaXBk0aIr/sa5E5HMtdeswI/kdi6
         gmLnf/I8DxJevrbubclOtY9kG2Y5BIbZeHcoySh+A+hve3jod6+Z3NBIN4ng4JyfAiG6
         cymirAXmNs+D5l2NJcVL7ZITdziSFBb8QA644HsdlgVdS7eJrxqUrOVawdTWt9aq6wjJ
         B6aBf+I6KIGEhyPNcWl/EqIPJuF7FMRQP7fReBJgK4fWCREkqkfrfQ1Ca35ORaaF47PO
         b2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8jclUAB6NJrse3LS12W94ZJpbknPj5/gyJDJm4zsd/etaUl32X7RcqWZAbDEPLT7KTReaCuDmcz65HR1Ogj82oWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFn5GhfsogrqVZDp9jHbiOOJiq+/eo72xt8Qy40VvyZek7eoN
	fsDf+VfWiRA5dfQL1HkGTov7msU3U4wvhKZ543xGrc00uYkQ3DfNEd5DTz+3DWDVSv/409H2vu7
	yy+rWXRDnCiirUo4pXuFca4g6TGXwduBlyZo5gSoowZtUfPziGdKGGOlZhk+3CcrA8d7lo0XXXc
	Thak1uk45C3x99tcEMH5vfVLfJ3AIwmYOAFYDdKeiuQ/nuIwu6vXiVndWjVErmDl4=
X-Gm-Gg: ATEYQzxN+M+B9UfZhdVPNU7CTznFbg4VA6HdLhO8lBHitNpjv97/EFhdC3/ni+fHdDc
	ht69e0EAKUsWQC6ixBRNDv9FpX01edq0LMXG65/l7C0QApdIfLyQ0c8OXzyZleztx9xddiTyD3/
	rxxmj7PwN/uiTJDJtLkxresdqzjSFCCPjLMzdN0Sp1k+gAbVmj3a+w9lqW/LSKV56UqQ0E/zNKj
	cvM
X-Received: by 2002:a53:db52:0:b0:649:e501:21a6 with SMTP id 956f58d0204a3-64cc2081a47mr9408378d50.16.1772480856799;
        Mon, 02 Mar 2026 11:47:36 -0800 (PST)
X-Received: by 2002:a53:db52:0:b0:649:e501:21a6 with SMTP id
 956f58d0204a3-64cc2081a47mr9408361d50.16.1772480856249; Mon, 02 Mar 2026
 11:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
 <CAADnVQLrhkCkpE6UZbkPaNTFMYRoa_ZtyknhVM7FMmsH7Lvj5A@mail.gmail.com>
 <CAOu3gNhBcW-JQ_VQ00GnLd8iB6xu7Ew80Bs4VHoXOct5g-wr4g@mail.gmail.com> <87fr6idoek.fsf@cloudflare.com>
In-Reply-To: <87fr6idoek.fsf@cloudflare.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Mon, 2 Mar 2026 14:47:24 -0500
X-Gm-Features: AaiRm52SkEh1_o00QJw02Lqk_CSzYQ0FbvrjSRE53OE4AZmWdRltsfr4nc6CHYs
Message-ID: <CAOu3gNhZeV17LtmWePOtuwwkV=-P3va8dO7NCQEaEXiyvaieag@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next v3 0/3] Optimize
 kprobe.session attachment for exact function names
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE1MyBTYWx0ZWRfXzken7Rd4/C/j
 l86bp5M/iwzmy0IRGAyUZIAXwneIJ9UT5Sicd4tNFa/DaNwbZfyhy44sE/VNhDLlUFLnozku/nm
 0y/SRUeCG5HOcKCNSXl/zyeySGysAzC6lzpy/p4W9Lb07hwJAXEtKbir94m5A5li67b6PxuyA6c
 9+UdJm6kRIR//plY1VtE3MWnYUdOXvYcMgUz83qZhqQFbK/m1cd4+zuT16Mx9S53mEUIyqtW+KM
 iQjtxGr+ZfVfzUXLzlSezY8gfLhia6PKMQ8cgMRJwnIRGpoO01Sulm5cBWFXxOBFwy2OjetPnSy
 7FJahvLR8dpFUj/wJHIufY6MocSvpV7upuRiuAm5hMAJSaQ1wTI+2MGnYInjcalqsDEytl1lbSU
 L8Pvl2iMOe8aInHrMPI72edTq/rCdNujkc8/j1gxjXW3JtVzff64ejqqtjMiYJLsoRLQCwNVnaW
 fD6s1eUJUt+bR4FM5fQ==
X-Authority-Analysis: v=2.4 cv=UNbQ3Sfy c=1 sm=1 tr=0 ts=69a5e95a cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22
 a=EG7W4yiQAAAA:8 a=vSHqNH6RiTyX9nJUl_8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DB2pUmTqD48p1ZrJwWXaZ6uCgkXNxkx8
X-Proofpoint-ORIG-GUID: DB2pUmTqD48p1ZrJwWXaZ6uCgkXNxkx8
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020153

On Mon, Mar 2, 2026 at 2:25=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> On Fri, Feb 27, 2026 at 04:15 PM -05, Andrey Grodzovsky wrote:
> > Hey Alexei, just to be clear, do you mean drop the entire RFC letter or=
,
> > Drop the RFC prefix from the letter so the CI pipeline can be properly
> > triggered ?
>
> The prefix, not the cover letter.
>
> Although I think swapping the word order might also work ("PATCH RFC").
> I've seen CI run for my patch set when it was titled like that.
>
> Kind reminder to not top-post :-)

Yea, it actually did run for me anyway and your comment explains it.
Anyway, i am dropping the RFC prefix and sending V4 soon.

Andrey
