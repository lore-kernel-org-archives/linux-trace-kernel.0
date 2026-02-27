Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E827B327
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772226924; cv=pass; b=uKNi3Y3Kdkw6Lnj+tGyUPbw2b+mzEccswywJb+sxfE2vE1fYylyspp6+KcXR1mfeop+HIEUKfnP2HtF2/7rrLEB6Aw7+CyXphIG2erjRhkoWlU75db5S1WzZeNcChpCXZ92dcF9qinT0Ln4FywHdhNouGPcU15nloFPVk0Ac2vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772226924; c=relaxed/simple;
	bh=1yvV4S40P07S6s7yMHiVnEnVC4FZeL25AgvTpsI9MGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clTAuLfoL4gLHpaNrrvy9s6TWK6YTkX4O0fhqgMxKIGkLSE0DffiUMWIEcPvQW0y6AY7PIIIVXxgaRm2uI2ccu+zZu3KPcpkejDkze1L4NIkf20QvW0XXVhSKCTPTOKVlGjxXXq7WFf5mmQxojDd/N2InakhBH1GPtCc2aNtnP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=kP2IkOF7; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=KO6k8bOm; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="kP2IkOF7";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="KO6k8bOm"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RJn8qX014067
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 21:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=1yvV4S40P07S6s7yMHiVnEnVC4FZeL25AgvTpsI9MGs=; b=kP2I
	kOF7dLWOZcJAMXMnLEpi6RKZNPgzD9Z7mcJCQe1iyzoagiIK8pUWqUbiQJTQcWof
	d0BoniW409J7WEwKksMGdoIYx8HwuxB0p/r2H8RM1Vb8IPoBDdBaumCpjM8Zlr/n
	np+xa9lbQiWfpb7BYdfzk2DfmV1prJEA3NucPsaoy3B6UwugUdL6zOr5PbKLEViq
	Vj1VC9mL4r9DSam7y8mL+442SiK98SRGsFCREthXGefszJAes5MdZyf+opHzL34l
	NBqwUbwk+Ieh84oN9tGW02gp4JsfyjmozFCVt3ZKTNRvOUsebLwECiEhRu2Qf0R0
	hfKEROGLx6Btz1wU4w==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cjyq2uwy9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 21:15:22 +0000 (GMT)
Received: from 04wpexch001.crowdstrike.sys (10.100.11.76) by
 04WPEXCH010.crowdstrike.sys (10.100.11.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 27 Feb 2026 21:15:21 +0000
Received: from 04WPEXCH016.crowdstrike.sys (10.100.11.68) by
 04wpexch001.crowdstrike.sys (10.100.11.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 27 Feb 2026 21:15:20 +0000
Received: from mail-yx1-f71.google.com (10.100.11.78) by
 04WPEXCH016.crowdstrike.sys (10.100.11.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 27 Feb 2026 21:15:20 +0000
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64ca09f2064so4118098d50.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 13:15:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772226920; cv=none;
        d=google.com; s=arc-20240605;
        b=T1WeT3rnt5eLvX02LvF/FIMdmnq2QU4XHLvS8AzBJbX53oywDRqV0XB1kfz8SN60UM
         CI+RAUz+W415G60GfeleZxiD8hhOfVfvJGp16Rv83+QTt5aZc+nf9V0PNDkGHnrGWuJO
         cx6n23qT/ZqmkdYgSsknY8eX9ogsB9E8VedreFLZHs/BR/m8M8Yq0p4INi1xmXNSjutP
         rz9Zws9YXy2Xa7jaWIQyGdzmWf77sL4C44iQLKeme9MXLz6mQP/pkhKrTvm0WF5GoZ92
         +8LiRfFCqgQVVjrd9MvXXTt/G1PrbOhhzaEJ6/NI95SsjocSJOqQidWv4NmVVT3PTuPQ
         1Vjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1yvV4S40P07S6s7yMHiVnEnVC4FZeL25AgvTpsI9MGs=;
        fh=nLB/SIBbWAPWlzUmsPUEBguMGG227+rgOduvtCE7Shk=;
        b=PIJlytrt6uZr3iSnTUGWeKAqrVmkLmCS+oz3zHXO3odxrYWaBqh5c6scYqnA5mv/Qw
         q7nWk3dUdJKZ/VFkjCAmSHHiuIhgZUzn5fga70u43HO1ispEBtJimOWlGyOpeWszeQw8
         v/t+7B6nw/XFhsFuQaLod9HLMaXIBKSydsY1CdJ5k6odo1aZy8TifnFiPSfnZQdhVVZp
         6lDtVDuv4DUBRnMJcbObqZ8lBVLSDKwjL/SwfI9dJPOYXxWafmZIMMLrt0tXiUYbkgww
         ImAY+dwMfnem0UIphGIV6bvwA2jSIs9CWl0d9AfgBBU8gOl8ZXWqNe7FF4MqCyAGSnS8
         g0TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772226920; x=1772831720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yvV4S40P07S6s7yMHiVnEnVC4FZeL25AgvTpsI9MGs=;
        b=KO6k8bOm04uYVCSopxf+GP94UWswqYja2OwPjddDTIrhrG85jNn2yqfLj8F0ZpMXHz
         B/e1kaQvntXC+4RbSnigwGbdpfGoKSf8431hWbSOIG/IRjtM9i7CuSztTAgfHI3BDtbj
         K3EZwiOhs7xdRSdxvWvkjwtD+ILmzY824NFJGXhZHAJGvsfDnx6Op54TTZ4C1SLYCpbc
         gmkBVCnKAIrLWICmB2yCD+bB8k5rBr89f8UudqjGMH2QMoQT1ZZMBC4FFAsWF4SqkDRe
         8GBq7WJEVG8bdp2FSjj7zJiW0BirflbPgKvLaWwfxaRpBV1J1Vjh/4L38h0reKmGMamM
         CSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772226920; x=1772831720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1yvV4S40P07S6s7yMHiVnEnVC4FZeL25AgvTpsI9MGs=;
        b=IZ4R20OaZNCe5HizrVornL+K8qS/CqFG3zTwg/zWWo6R5uJt2Al7qVZpxo+oL1neD+
         6cSJGlAoftT3IsiNdKaUuqlWFOh9560jvdhCD4vXP3ox45FI284fn96D4hwGzu9P+aC5
         yLU9H5iNOQRW1ciyWnYdF9QanW9vick7xAI6ZJj/K7w2hfGwjnaGEL8jDLr+H97S7vAv
         mJ/L5cKRia2XvlEvPbuDXMHtQV+yMEW+ODHNkbYbHoKQBWBuI1U5NzqRFR6YblOD7nx8
         uj+hG9V5qUXQQ0Fx9bjIO3i17v52FR1hABQ5BMDijy69CpLk41kXyjkMJt6i14fvkg7i
         m4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJGxDd0mawApVtncxi9v+8yRO15bZ2UnEcPHKsGRXEBXLjHvOepu5syswY0LP/Z6KxN0fVzZn3GMI640BumWnI+9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcsCckT2AwghBPewyDvuvXXejkAZ7/4Y8mSbexas+w0v17LB4K
	/s8XexuCqUGZtNHFWYvMdyQ1BsCVgv48HE9KOTwV3FesP1HR+ecgTpdp9YoQKePxcm+GcjXwb69
	xD8a43tXtoVZm0POTGbaXCRTZJ+ZrSp15LsYalswrfXyIBHVt4Nw/OVvYayuqZF/9e/PaLUvRfE
	ruLn7FLS8hMY8fJ89u+WZUUZyxSOevtTyJEehPN6gICh0n4TLRe9IcNeMUMw4G0pI=
X-Gm-Gg: ATEYQzwkjyCGXnAw++pLC9zCOO3x+giL6ER9sfM1hpiNCL2B53LFjv6NJRakdg53I1a
	XZi3DXqd9y1Glk+x3MdgMzv9YIIkm0j5uL05qO6+F9xIeb9CDjgvbqYGmgPQ1HWiund2fRNhVdi
	ECcb8ZuiOwxvVaOFEnlrk/KOjudYuCk/iPHDOJkHb6kf8xvBjT68Zk0LKuA1BxVvGpW6CvIzXVG
	olS
X-Received: by 2002:a53:acd4:0:10b0:64c:a0c0:96e with SMTP id 956f58d0204a3-64cc236e115mr3251517d50.89.1772226920084;
        Fri, 27 Feb 2026 13:15:20 -0800 (PST)
X-Received: by 2002:a53:acd4:0:10b0:64c:a0c0:96e with SMTP id
 956f58d0204a3-64cc236e115mr3251498d50.89.1772226919592; Fri, 27 Feb 2026
 13:15:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com> <CAADnVQLrhkCkpE6UZbkPaNTFMYRoa_ZtyknhVM7FMmsH7Lvj5A@mail.gmail.com>
In-Reply-To: <CAADnVQLrhkCkpE6UZbkPaNTFMYRoa_ZtyknhVM7FMmsH7Lvj5A@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Fri, 27 Feb 2026 16:15:07 -0500
X-Gm-Features: AaiRm50TrzWhq-x0h5445TfCiH-NK44oIyPX-1EDhdc5a9emZ1l1QCYw-7Yq50o
Message-ID: <CAOu3gNhBcW-JQ_VQ00GnLd8iB6xu7Ew80Bs4VHoXOct5g-wr4g@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next v3 0/3] Optimize
 kprobe.session attachment for exact function names
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4NyBTYWx0ZWRfX08L6wFJ44aSv
 1FqXu5KUBMnAa7025Cnn4Lgbg/DG0vLCYarUk7NsMdP4yJ6Ovzxl+KgklZ80wOPkBa6LQwsg6bE
 khOXtoTiBGSFukIXmwd7PaAKH4IxTzYB0M3nbuzgaz6wwHv7+wDNMsUU8Xmymsl1yYqcVdcpjsA
 E7yE6zfYCdRuYjnkt1LP7lkf9hB1ISciX+8zRbt4I6s1Aiv0HFmdCAsbqqXt2N4wnEAPe4MErwP
 Fr+lj7Cvct1jGUJeJGm4gQ575lw90nURLMjPlcK5JJNsUpcdfYQv342g0m3SLjdGoTSFeTkvyyX
 Sx7AdLXWDL+QcMysbs7f1+2+h6NfFFZNzxmffAuW05iQqwdCMh0ZRPNHtPnISgP708wkzRP+vX5
 CMa29pjP0cB7trhuUfKD1le8WBLUoGRVdqWhYR8EYmgLasTDzbWQ3A6XSN/48iLVWVjSs9Y7sg6
 WhUUTWlXvlpbGjTrmpA==
X-Proofpoint-GUID: x4_Dk7hb528zDzdk71izpkt_T5Qmv02_
X-Proofpoint-ORIG-GUID: x4_Dk7hb528zDzdk71izpkt_T5Qmv02_
X-Authority-Analysis: v=2.4 cv=B7O0EetM c=1 sm=1 tr=0 ts=69a2096a cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22
 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8 a=DfUOPM2WMsoQciiG4eQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270187

Hey Alexei, just to be clear, do you mean drop the entire RFC letter or,
Drop the RFC prefix from the letter so the CI pipeline can be properly
triggered ?

Thanks,
Andrey


On Fri, Feb 27, 2026 at 3:43=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 27, 2026 at 12:41=E2=80=AFPM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> >
> > Changes since v2 [2]:
> > - Use if/else-if instead of goto (Jiri Olsa)
> > - Use syms =3D &pattern directly (Jiri Olsa)
> > - Drop unneeded pattern =3D NULL (Jiri Olsa)
> > - Revert cosmetic rename in attach_kprobe_session (Jiri Olsa)
> > - Remove "module symbols" from ftrace comment (CI bot)
>
> RFC series are ignored by CI.
> If you want things to land, drop RFC.
